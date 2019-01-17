#!/usr/bin/env python3

import re
import pprint
import os

if __name__ == '__main__':
    output = open("tmp/presentation-table.md", "w")
    table = False
    tmp = ""
    with open('tmp/presentation-unsorted.md', 'r') as markdown:
        for line in markdown:
            m = re.findall('^\|( --- \|)+$', line)
            if len(m) > 0:
                table = True
                tmp = line
            else:
                output.write(line)
                if table == True:
                    output.write(tmp)
                    tmp=""
                    table = False

    output.close()