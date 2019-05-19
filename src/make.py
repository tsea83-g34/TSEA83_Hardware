"""
GUIDE:

python2 <code.cmm> <pm.out> <dm.out> 

"""

import httplib
import mimetypes
import json
import base64
import sys

BOTH = 0
ASSEMBLE = 1 
COMPILE = 2

request_mode = BOTH

input_file = sys.argv[1]
pm_name = sys.argv[2]
dm_name = sys.argv[3]
if len(sys.argv) > 4:
    if sys.argv[4] == "compile":
      request_mode = COMPILE
    elif sys.argv[4] == "assemble":
      request_mode = ASSEMBLE


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

contents = open(input_file).read()
if request_mode == BOTH:
    route = "/build"
elif request_mode == ASSEMBLE:
    route = "/assemble"
else:
    route = "/compile"



res = post_multipart("46.101.140.189:8320", route , [
    ("name", input_file)
], [
    ("file", input_file, contents)
])

res = json.loads(res)
if res["status"] != 200:
    print("Error with file request:")
    print(res["message"])
    print(res["data"]["error"])
    exit()

file_path = input_file.split(".")[:-1]  
file_path = "".join(file_path)

if "uart" in res["data"]:
  base64_data = res["data"]["uart"]
  uart_res = base64.b64decode(base64_data)
  uart_file = open(file_path + ".bin", "wb")
  uart_file.write(uart_res)
  uart_file.close()

if request_mode == COMPILE:
    write_to_file(res["data"]["asm"], file_path + ".asm")
else:
    write_to_file(res["data"]["pm"], pm_name)
    write_to_file(res["data"]["dm"], dm_name)





