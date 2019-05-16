"""
GUIDE:

python2 <code.cmm> <pm.out> <dm.out> 

"""

import httplib
import mimetypes
import json
import sys

BOTH = 0
ASSEMBLE = 1 
COMPILE = 2

request_mode = BOTH

input_file = sys.argv[1]
pm_name = sys.argv[2]
dm_name = sys.argv[3]
if len(sys.argv) > 4:
    request_mode = COMPILE if sys.argv[4] == "compile" else ASSEMBLE


def post_multipart(host, selector, fields, files):
    content_type, body = encode_multipart_formdata(fields, files)
    h = httplib.HTTP(host)
    h.putrequest('POST', selector)
    h.putheader('content-type', content_type)
    h.putheader('content-length', str(len(body)))
    h.endheaders()
    h.send(body)
    errcode, errmsg, headers = h.getreply()
    return h.file.read()

def encode_multipart_formdata(fields, files):
    LIMIT = '----------lImIt_of_THE_fIle_eW_$'
    CRLF = '\r\n'
    L = []
    for (key, value) in fields:
        L.append('--' + LIMIT)
        L.append('Content-Disposition: form-data; name="%s"' % key)
        L.append('')
        L.append(value)
    for (key, filename, value) in files:
        L.append('--' + LIMIT)
        L.append('Content-Disposition: form-data; name="%s"; filename="%s"' % (key, filename))
        L.append('Content-Type: %s' % get_content_type(filename))
        L.append('')
        L.append(value)
    L.append('--' + LIMIT + '--')
    L.append('')
    body = CRLF.join(L)
    content_type = 'multipart/form-data; boundary=%s' % LIMIT
    return content_type, body

def get_content_type(filename):
    return mimetypes.guess_type(filename)[0] or 'application/octet-stream'


def write_to_file(contents, file_path):
    file = open(file_path, "w")
    file.write(contents)
    file.close()

asm_contents = open("test.asm").read()
if request_mode == BOTH:
    route = "/build"
elif request_mode == ASSEMBLE:
    route = "/assemble"
else:
    route = "/compile"



res = post_multipart("46.101.140.189:8320", route , [
    ("name", "test.asm")
], [
    ("file", "test.asm", asm_contents)
])

res = json.loads(res)
print(res)
write_to_file(res["data"]["pm"], pm_name)
write_to_file(res["data"]["dm"], dm_name)
