#!/usr/bin/env python3

import re
import sys
import json

if __name__ == '__main__':
    output = open("tmp/presentation-rows.md", "w")
    space = False
    tmp = ""

    with open("tmp/convert.conf") as f:
        try:
            conf = json.load(f)
            #print(conf)
        except Exception as e:
            print("Chyba konfiguračního souboru")
            sys.exit(1)
            pass

    list = "-"
    heading1 = "#"
    heading2 = "##"
    if "characters" in conf and "list" in conf["characters"]:
        list = conf["characters"]["list"]
    if "characters" in conf and "heading1" in conf["characters"]:
        heading1 = conf["characters"]["heading1"]
    if "characters" in conf and "heading2" in conf["characters"]:
        heading2 = conf["characters"]["heading2"]

    with open('tmp/presentation-characters.md', 'r') as markdown:
        for line in markdown:
            dalsi = False
            m = re.findall('^##(\s.*)', line)
            if len(m) > 0 and dalsi == False:
                line = re.sub('^##(\s.*)', heading2 + r'\1', line)
                dalsi = True
            m = re.findall('^#(\s.*)', line)
            if len(m)>0 and dalsi==False:
                line = re.sub('^#(\s.*)', heading1+r'\1', line)
                dalsi = True
            m = re.findall('^(\s*?)-(\s.*)', line)
            if len(m) > 0 and dalsi==False:
                line = re.sub('^(\s*?)-(\s.*)', r'\1' + list + r'\2', line)
                dalsi = True

            output.write(line)

    f.close()
    markdown.close()
    output.close()
