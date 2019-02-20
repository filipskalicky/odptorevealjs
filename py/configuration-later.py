#!/usr/bin/env python3

import sys
import json
import re


def toRegex(input):
    bad = ['+', '?', '\\']
    novy = "^"
    for i,x in enumerate(input):
        if x in bad:
            novy += "\\"
            novy += x
        else:
            novy += x
    novy += "$"
    return novy


if __name__ == '__main__':
    #print(sys.argv[1])

    with open(sys.argv[1]) as f:
        try:
            conf = json.load(f)
        except Exception as e:
            print("Chyba konfiguračního souboru")
            sys.exit(1)
            pass

    separator = "++++"
    if "presentation" in conf and "separator" in conf["presentation"]:
        separator = conf["presentation"]["separator"]

    separatorVertical = "----"
    if "presentation" in conf and "separator-vertical" in conf["presentation"]:
        separatorVertical = conf["presentation"]["separator-vertical"]


    conf["presentation"]["separator"] = separator
    conf["presentation"]["separator-vertical"] = separatorVertical

    conf["presentation"]["separator-regex"] = toRegex(separator)
    conf["presentation"]["separator-vertical-regex"] = toRegex(separatorVertical)

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


    tmpconf = dict()
    for x in conf:
        m = re.findall("^(-{0,1}\d*):(-{0,1}\d*)$", x)
        if len(m) == 1:
            n=[]
            n.append(0 if len(m[0][0])==0 else int(m[0][0]))
            n.append(len(strankymark) if len(m[0][1])==0 else int(m[0][1]))
            if n[0] < len(strankymark) and ( n[1] > 0 or n[1] in range(-len(strankymark)+1, 0) ):
                if n[0] < -len(strankymark):
                    n[0] = 0
                if n[0] < 0:
                    n[0] = len(strankymark) + n[0]
                if n[1] > len(strankymark):
                    n[1] = len(strankymark)
                if n[1] < 0:
                    n[1] = len(strankymark) + n[1]

                for i in range(n[0],n[1]):
                    if str(i) in tmpconf:
                        tmpconf[str(i)].update(conf[x])
                    else:
                        tmpconf[str(i)] = conf[x]
                continue
            #else:
                #print("špatné indexy -> ignoruju nastavení")
        #else:
            #print("není rozsah -> ignoruju")
        m = re.findall("^(\d+)(\,\s{0,1}\d+)*\,\s{0,1}(\d+)$", x)
        if len(m) >0:
            for y in m[0]:
                n = re.findall("\d+", y)
                if len(n) > 0:
                    n = int(n[0])
                    if str(n) in tmpconf:
                        j = conf[x]
                        pp = dict(tmpconf[str(n)])
                        pp.update(j)
                        tmpconf[str(n)] = pp

                    else:
                        tmpconf[str(n)] = conf[x]
            continue
        if x in tmpconf:
            j = conf[x]
            pp = dict(tmpconf[x])
            pp.update(j)
            tmpconf[x] = pp

        else:
            tmpconf[x] = conf[x]



    try:
        with open('tmp/convert.conf', 'w') as outfile:
            json.dump(tmpconf, outfile)
    except Exception as e:
        print("Chyba konfiguračního souboru")
        sys.exit(1)
        pass

    outfile.close()
    markdown.close()
    f.close()


