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
    print(sys.argv[1])

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





    try:
        with open('tmp/convert.conf', 'w') as outfile:
            json.dump(conf, outfile)
    except Exception as e:
        print("Chyba konfiguračního souboru")
        sys.exit(1)
        pass

    outfile.close()
    f.close()


