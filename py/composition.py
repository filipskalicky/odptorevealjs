#!/usr/bin/env python3

import sys
import re
import json
from pathlib import Path

if __name__ == '__main__':

    with open("tmp/convert.conf") as f:
        try:
            conf = json.load(f)
            #print(conf)
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

    if len(tmp) > 0:
        strankymark.append(tmp)

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
    if len(tmp) > 0:
        strankyabsolute.append(tmp)

    stranky = []
    for i, stranka in enumerate(strankymark):
        if str(i) in conf:
            if "style" in conf[str(i)] and conf[str(i)]["style"] == False:
                withoutstyle = ""
                for line in iter(strankyabsolute[i].splitlines()):
                    line2 = re.sub(r'''<(.*?)style=".*?"''', r"<\1", line)
                    line3 = re.sub(r'''<(.*?)class=".*?"''', r"<\1", line2)
                    withoutstyle += re.sub(r'''`(.*?)`''', r"\1", line3)
                    withoutstyle += "\n"
                #print(withoutstyle)
                strankyabsolute[i] = withoutstyle

                withoutstyle = ""
                for line in iter(strankymark[i].splitlines()):
                    line2 = re.sub(r'''\`+(.+?)\`+<!-- {_class=".*?"} -->''', r"\1", line)
                    line4 = re.sub(r'''<!-- {_class=".*?"} -->''', r"", line2)
                    line5 = re.sub(r'''<span class="newline"> </span>''', r"", line4)
                    line6 = re.sub(r'''<span class=".*?nullstring.*?"> </span>''', r"", line5)
                    withoutstyle += re.sub(r'''<span class=".*?">(.*?)</span>''', r"\1", line6)
                    withoutstyle += "\n"
                    stranka = withoutstyle


            if "delete" in conf[str(i)] and conf[str(i)]["delete"] == True:
                #print("mažu")
                continue
            if "content" in conf[str(i)] and conf[str(i)]["content"] != False and isinstance(conf[str(i)]["content"], str):
                stranky.append(conf[str(i)]["content"])
                continue
            if "absolute" in conf[str(i)] and conf[str(i)]["absolute"] == True:
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
        output.write("\n")
        if i < len(stranky)-1:
            output.write(conf["presentation"]["separator"])
            output.write("\n\n")

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