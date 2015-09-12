# Usage: python3 control_gen.py my_controls.csv mappings.csv control_mod_name xml|verilog

# The control signals csv file should have the format: 

# Inst,Opcode,[name of ctrl signal 1],[name of ctrl signal 2],...
# INST1,OPCODE1,val1a,val2a,...
# INST2,OPCODE2,val1b,val2b,...
# ...

# The mappings csv file should have the following format: 

# sig1,name1,name2,...
#     ,val1 ,val2 ,...

# Notes: 
# - Requires python3
# 
# - Mappings can be incomplete but should take values in a complete
# - range from 0 to something.
#
# - If a mapping is incomplete or non-existent, the minimal available
# - values will be chosen for the unmapped value names.  For example,
# - if the mapping for sig 1 above was just "val1a=0", then val1b
# - would automatically be assigned to mean "1"
# 
# - Do not map the value "x"
#
# - All "x" values should be specified as "x", rather than as "xxxx"
# - or "X" or similar
# 
# - Outputs either an xml module_type definition if arg3 == "xml" or
# - else the verilog module if arg3 == "verilog"
# 
# - If a control signal value is specified in binary, its value will
# - be preserved and the max length of such a value will be taken to
# - be the width of the control signal.  In particular, do not specify
# - a value in binary without ensuring it has the desired width

import sys
from csv import DictReader, reader
import re

binre = re.compile("^[10]+$")
r = DictReader(open(sys.argv[1],'r'))
ms = next(r)
signals = [x for x in ms.keys() if x != "Opcode" and x != "Inst" and x != ""]

mr = reader(open(sys.argv[2],'r'))
mappings = {s:{} for s in signals}
widths = {s:0 for s in signals}
for row in mr:
    keys = [k for k in row[1:] if k != ""]
    vals = [v for v in next(mr)[1:] if v != ""]
    sig = row[0]
    mappings[sig] = {keys[i]:vals[i] for i in range(len(keys))}
    widths[sig] = min([j for j in range(1,16) if 2**j >= len(keys)])

# Pull out the widths of anything not yet accounted for
for row in r:
    for sig in signals:
        if(widths[sig] == 0 and binre.match(row[sig])): widths[sig] = len(row[sig])

r = DictReader(open(sys.argv[1],'r'))

# print(mappings);

if(sys.argv[4] == "xml"):
    print("<module_type name=\"%s\">"%(sys.argv[3]))
    print("  <in name=\"inst\" width=\"16\" />")
    print("  <in name=\"state\" width=\"2\" />")
    print("\n".join(["  <out name=\"%s\" width=\"%s\" />"%(s,widths[s]) for s in signals]))
    print("</module_type>")

elif(sys.argv[4] == "verilog"):
    print("// Mappings: ")
    print("\n".join("// " + s + ":" + str(widths[s]) + " -- " + ",".join([v+"="+str(mappings[s][v]) for v in mappings[s].keys()]) for s in signals))
    print("module %s(inst,state,%s);"%(sys.argv[3],",".join(signals)))
    print("input [15:0] inst;")
    print("input [1:0] state;")
    print("\n".join(["output reg %s %s;"%("     " if widths[s] <= 1 else "[%d:0]"%(widths[s]-1), s) for s in signals]))
    print("always @(*)\nbegin\ncasex({inst,state})")
    print("\n".join(["//%s\n%d'b%s:\nbegin\n%s\nend\n"%(row["Inst"],
                                                        18,
                                                        row["Opcode"],
                                                        "\n".join([" %s = %d'b%s;"%(s,
                                                                                    widths[s],
                                                                                    "x"*widths[s] if row[s] == "x" or row[s] == '' else row[s] if binre.match(row[s]) else mappings[s][row[s]]
                                                                                    )
                                                                   for s in signals])
                                                        ) for row in r]))
    print("default: begin\n"+"\n".join([" %s = %d'b%s;"%(s,widths[s],"x"*widths[s]) for s in signals])+"\nend\n")
    print("endcase\nend\nendmodule\n")
