#!/usr/bin/env python3

import re

if __name__ == '__main__':
    output = open("tmp/presentation-characters.md", "w")
    space = False
    tmp = ""
    with open('tmp/presentation-span.md', 'r') as markdown:
        for line in markdown:
            line = re.sub('<([^!])',r'&lt;\1',line)
            line = re.sub('`+(.*?)`+<!-- {_class="(.*?)"} -->', r'<span class="\2">\1</span>', line)
            output.write(line)

    output.close()
    markdown.close()