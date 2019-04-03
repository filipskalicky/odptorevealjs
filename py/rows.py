#!/usr/bin/env python3

import re
import sys
import json

if __name__ == '__main__':
    output = open("tmp/presentation.md", "w")
    space = False
    tmp = ""


    with open('tmp/presentation-rows.md', 'r') as markdown:
        for line in markdown:
            m = re.findall('^\s*$', line)
            if len(m) <= 0:
                output.write(line)

    markdown.close()
    output.close()