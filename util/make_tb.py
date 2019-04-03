from argparse import ArgumentParser
import os 
from collections import namedtuple

class Port(namedtuple("Port", "name, dest, type")):
    pass

dest_types = ["in", "inout", "buffer", "out"]
#val_types = ["unsigned", "std_logic", "boolean", "std_vector"]
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
    print(file_path)    
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


replacement_functions = []

def replacer(token):
    def decorator(fn):
        replacement_functions.append((fn, token))
        return fn
    return decorator

def write_file():

    path = os.path.abspath(__file__)
    path_list = os.path.split(path)
    path = "" if len(path_list) == 0 else "/".join(path_list[:-1]) + "/"
    with open(path + "template.vhd") as template_file:
        template = template_file.read()


    for fn, token in replacement_functions:
        template = template.replace(token, fn(template, token))

    with open(opt.out_file_name, "w+") as out:
        out.write(template)

    
@replacer("$file_name")
def insert_file_name(template, token):
    return opt.out.split(".")[0]


@replacer("$entity_name")
def insert_entity_name(template, token):
    return opt.entity


@replacer("$ports")
def insert_ports(template, token):
    indent = get_indent_level(template, token)
    res = "" 
    for port in ports:
        prep = indent if port != ports[0] else ""
        res += prep + "{0} : {1} {2}".format(port.name, port.dest, port.type)
        if port != ports[-1]:
            res += ";\n"
    return res

@replacer("$declare_test_record")
def declare_test_record(template, token):
    indent = get_indent_level(template, token)
    res = "" 
    count = 0
    for port in ports:
        if port.name == "clk":
            continue
        prep = ";\n" + indent if count else ""
        res += prep + "{0} : {1}".format(port.name, port.type)
        count += 1
    return res


@replacer("$test_records")
def insert_test_records(template, token):
    indent = get_indent_level(template, token)
    names = [port.name for port in filter(lambda port: port.name != "clk", ports)]
    vals = ['X"0"']*(len(ports)-1)
    res = "-- {0}".format(", ".join(names)) + "\n"
    res += indent + "(" + ", ".join(vals) + ")"
    #print(res)
    return res


@replacer("$signals")
def insert_signals(template, token):
    indent = get_indent_level(template, token)
    res = "" 
    for port in ports:
        prep = indent if port != ports[0] else ""
        res += prep + "signal {0} : {1};\n".format(port.name, port.type)
    return res


@replacer("$initialize_component")
def initialize_component(template, token):
    indent = get_indent_level(template, token)
    res = ""
    for port in ports:
        prep = indent if port != ports[0] else ""
        res += prep + "{0} => {1}".format(port.name, port.name)
        if port != ports[-1]:
            res += ",\n" 
    return res

@replacer("$assign_input")
def assign_input(template, token):
    indent = get_indent_level(template, token)
    res = ""
    for port in filter(lambda port: port.dest == "in" and port.name != "clk", ports):
        res += "{0} <= test_records(i).{1}\n".format(port.name, port.name) + indent
    return res

@replacer("$check_output")
def check_output(template, token):
    #indent = get_indent_level(template, token) 
    filtered_ports = filter(lambda port: port.dest in ["buffer", "out"], ports)
    checks = ["({0} = test_records(i).{1})".format(port.name, port.name) for port in filtered_ports]
    res = " and ".join(checks)
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
    opt.file_name = os.path.split(opt.input_file)[1]
    if opt.entity == None:
        opt.entity = opt.file_name.split(".")[0]
    print(opt.entity)
    if opt.out == None:
        opt.out = opt.file_name.replace(".", "_tb.")

    if opt.input_file.find("/") == -1:
        opt.file_dir = os.getcwd()
    else:
        opt.file_dir = os.getcwd() + "/" + "/".join(opt.input_file.split('/')[:-1])
    opt.out_file_name = opt.file_dir + '/' + opt.out
    opt.file_path = opt.file_dir + "/" + opt.file_name
    parse(opt.file_path)
