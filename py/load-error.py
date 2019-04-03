#!/usr/bin/env python3

import re
import pprint
import os
import sys

import json
from pathlib import Path

if __name__ == '__main__':
    output = open("tmp/presentation-loaderror.md", "w")

    with open("tmp/convert.conf") as f:
        try:
            conf = json.load(f)
        except Exception as e:
            print("Chyba konfiguračního souboru")
            sys.exit(1)
            pass

    my_file = Path("tmp/errors.json")
    error = ""
    if my_file.is_file():
        error = open("tmp/errors.json", "r")
        error_json = json.load(error)
        error.close()
    else:
        error_json = {}

    error = open("tmp/errors.json", "w")

    tmp = ""
    slide = 1
    with open('tmp/presentation-unsorted.md', 'r') as markdown:
        for line in markdown:
            n = re.findall(conf["presentation"]["separator-regex"], line)
            if len(n) > 0:
                slide += 1
            m = re.findall('<!-- {_class="hide pozor" data-id="(.*?)" } -->', line)
            if len(m) > 0:
                line2 = re.sub(r'''<!-- {_class="hide pozor" data-id=".*?" } -->''', r"", line)
                if slide not in error_json:
                    error_json[slide] = []
                error_json[slide].append("zkontrolujte zda je text správně ("+ m[0]+")")
                output.write(line2)
            else:
                output.write(line)

    json.dump(error_json, error)
    error.close()
    output.close()