from argparse import ArgumentParser
import os 

dest_types = {"in", "inout", "buffer", "out"}
value_types = {"unsigned", "std_logic", "boolean", "std_vector"}

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
        print("\n".join(lines))
        is_ports = False
        for line in lines:
            line = line.lower()
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
            print(line)
            var_name = line.split(":")[0].strip()
            rest = line.split(":")[1].strip()
            dest_type = rest.split()[0]
            rest = rest.split(dest_type)[1].strip()
            if rest.find("(") != -1:
                pass
            print(var_name, dest_type, rest)



if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument("input_file", metavar="input-file", type=str, help="Which source file to make a testbench from.")
    parser.add_argument("--entity", type=str, help="The name of the entity in the source file.", default=None)
    parser.add_argument("--out", type=str, help="The name and/or path to the output file.", default=None)
    opt = parser.parse_args()
    if opt.entity == None:
        opt.entity = opt.input_file.split(".")[0]
    if opt.out == None:
        opt.out = opt.input_file.replace(".", "_tb.")
    opt.file_name = opt.input_file.split("/")[-1]

    if opt.input_file.find("/") == -1:
        opt.file_dir = os.getcwd()
    else:
        opt.file_dir = os.getcwd() + "/" + "/".join(opt.input_file.split('/')[:-1])

    opt.file_path = opt.file_dir + "/" + opt.file_name
    parse(opt.file_path)