from argparse import ArgumentParser
import os 
from collections import namedtuple

class Port(namedtuple("Port", "name, dest, type")):
    pass

dest_types = {"in", "inout", "buffer", "out"}
#val_types = {"unsigned", "std_logic", "boolean", "std_vector"}
ports = []


def remove_comments_and_whitespace(lines):
    res = []
    for line in lines:
        line = line.strip()
        if line.find("--") != -1:
            line = line[:line.find("--")]
        if len(line) == 0:
            continue
        res.append(line)
    return res 

def parse(file_path):
    port_lines = []
    with open(file_path) as file:
        lines = file.readlines()
        lines = remove_comments_and_whitespace(lines)
        is_ports = False
        for line in lines:
            if line.find("port") != -1:
                is_ports = True 
                line = line.replace("port", "")
            if is_ports:
                if line.find(")") != -1 and line.find("(") == -1:
                    break 
                port_lines.append(line)
        
    get_ports(port_lines)

def get_ports(port_lines):
    #print("".join(port_lines))
    for line in port_lines:
        line = line.strip()
        if sum([dest_type in line for dest_type in dest_types]):
            var_name = line.split(":")[0].strip()
            rest = line.split(":")[1].strip()
            dest_type = rest.split()[0]
            val_type = rest.split(dest_type)[1].strip()
            val_type = val_type.replace(";", "")
            p = Port(var_name, dest_type, val_type)
            ports.append(p)
    write_file()


def write_file():
    with open("tb_template.vhd") as template_file:
        template = template_file.read()

    template = template.replace("$file_name", insert_file_name())
    template = template.replace("$entity_name", insert_entity_name())
    template = template.replace("$ports_mapping", insert_ports_mapping(template, "$ports_mapping"))
    template = template.replace("$ports", insert_ports(template, "$ports"))
    template = template.replace("$signals", insert_signals(template, "$signals"))

    with open(opt.out_file_name, "w+") as out:
        out.write(template)
    

def insert_file_name():
    return opt.out.split(".")[0]


def insert_entity_name():
    return opt.entity


def insert_ports(template, token):
    indent = get_indent_level(template, token)
    print(indent)
    res = "" 
    for port in ports:
        prep = indent if port != ports[0] else ""
        res += prep + "{} : {} {}".format(port.name, port.dest, port.type)
        if port != ports[-1]:
            res += ";\n"
    return res


def insert_signals(template, token):
    indent = get_indent_level(template, token)
    res = "" 
    for port in ports:
        prep = indent if port != ports[0] else ""
        res += prep + "signal {} : {} {};\n".format(port.name, port.dest, port.type)
    return res


def insert_ports_mapping(template, token):
    indent = get_indent_level(template, token)
    res = ""
    for port in ports:
        prep = indent if port != ports[0] else ""
        res += prep + "{} => {}".format(port.name, port.name)
        if port != ports[-1]:
            res += ",\n" 
    return res

def get_indent_level(template, token):
    i = template.find(token)
    while template[i] != '\n':
        i -= 1
    return template[i+1:template.find(token)]
    



if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument("input_file", metavar="input-file", type=str, help="Which source file to make a testbench from.")
    parser.add_argument("--entity", type=str, help="The name of the entity in the source file.", default=None)
    parser.add_argument("--out", type=str, help="The name and/or path to the output file.", default=None)
    opt = parser.parse_args()
    if opt.entity == None:
        opt.entity = opt.input_file.split(".")[0]
    opt.file_name = opt.input_file.split("/")[-1]
    if opt.out == None:
        opt.out = opt.file_name.replace(".", "_tb.")

    if opt.input_file.find("/") == -1:
        opt.file_dir = os.getcwd()
    else:
        opt.file_dir = os.getcwd() + "/" + "/".join(opt.input_file.split('/')[:-1])
    opt.out_file_name = opt.file_dir + '/' + opt.out
    opt.file_path = opt.file_dir + "/" + opt.file_name
    parse(opt.file_path)