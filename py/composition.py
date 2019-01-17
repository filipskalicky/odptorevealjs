#!/usr/bin/env python3

import sys
import re
import json
from pathlib import Path

if __name__ == '__main__':

    with open("tmp/convert.conf") as f:
        try:
            conf = json.load(f)
        except Exception as e:
            print("Chyba konfiguračního souboru")
            sys.exit(1)
            pass


    try:
        output = open(conf["presentation"]["output"], "w")
    except Exception as e:
        print("Chyba konfiguračního souboru")
        sys.exit(1)
        pass

    strankymark = []
    tmp = ""
    with open('tmp/presentation.md', 'r') as markdown:
        for line in markdown:
            m = re.findall(conf["presentation"]["separator-regex"], line)
            if len(m) > 0:
                strankymark.append(tmp)
                tmp = ""
            else:
                tmp += line

    strankyabsolute = []
    tmp = ""
    with open('tmp/presentation-unsorted-absolute.md', 'r') as markdown:
        for line in markdown:
            m = re.findall(conf["presentation"]["separator-regex"], line)
            if len(m) > 0:
                strankyabsolute.append(tmp)
                tmp = ""
            else:
                tmp += line

    stranky = []
    for i, stranka in enumerate(strankymark):
        if str(i+1) in conf:
            if "delete" in conf[str(i+1)] and conf[str(i+1)]["delete"] == True:
                #print("mažu")
                continue
            if "content" in conf[str(i + 1)] and conf[str(i + 1)]["content"] != False and isinstance(conf[str(i + 1)]["content"], str):
                stranky.append(conf[str(i + 1)]["content"])
                continue
            if "absolute" in conf[str(i + 1)] and conf[str(i + 1)]["absolute"] == True:
                #print("absolute")
                stranky.append(strankyabsolute[i])
                continue
            else:
                stranky.append(stranka)
                continue
        else:
            stranky.append(stranka)

    for i, x in enumerate(stranky):
        output.write(x)
        output.write("\n\n")
        if i < len(stranky)-1:
            output.write(conf["presentation"]["separator"])
            output.write("\n")

    my_file = Path("index.html")
    tmp = ""
    if my_file.is_file():
        with open('index.html', 'r') as ind:
            for line in ind:
                line = re.sub(r"data-separator=.*? ", "data-separator=\"" + conf["presentation"]["separator-regex"] + "\" ", line)
                line = re.sub(r"data-separator-vertical=.*? ", "data-separator-vertical=\"" + conf["presentation"]["separator-vertical-regex"] + "\" ", line)

                tmp += line
        ind.close()
        try:
            output = open("index.html", "w")
            output.write(tmp)
        except Exception as e:
            pass


    markdown.close()
    f.close()
    output.close()