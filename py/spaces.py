#!/usr/bin/env python3

import re
import pprint
import os

if __name__ == '__main__':
    output = open("tmp/presentation-span.md", "w")
    space = False
    tmp = ""
    with open('tmp/presentation-spaces.md', 'r') as markdown:
        for line in markdown:
            m = re.findall('^!--(.*)--!$', line)
            if len(m) > 0:
                space = True
                tmp = line
            else:
                if space == True:
                    space = False
                    vysledek = ""
                    text = tmp[3:-4]
                    words = text.split(" ")
                    words = [x for x in words if x]
                    #print(words)
                    zacatek = re.findall('(.*?)`', line)
                    m = re.findall('(`+)(.*?)`+(<!-- {_class=\".*?\"} -->)', line)
                    #print(m)
                    if len(m) <= 0:
                        output.write("\n")
                        output.write("" + line)
                    else:
                        if len(zacatek) > 0:
                            vysledek += zacatek[0]

                        i = 0
                        itisk = 0
                        j = 0
                        word = ""
                        apos = ""
                        chyba = 0

                        while i < len(m) or j < len(words):
                            if len(apos) == 0:
                                if len(m) <= i:
                                    apos += ""
                                    chyba += 1
                                    if chyba > 4:
                                        i = len(m)+2
                                        j = len(words)+2
                                else:
                                    apos += m[i][1].strip()
                                i += 1
                            if len(word) > len(apos):
                                while i > itisk:
                                    if len(m) <= itisk:
                                        apos += ""
                                        chyba += 1
                                        if chyba > 4:
                                            i = len(m) + 2
                                            j = len(words) + 2
                                    else:
                                        vysledek += m[itisk][0] + m[itisk][1] + m[itisk][0] + m[itisk][2]
                                    itisk += 1
                                word = word[len(apos):]
                                apos = ""
                            elif len(word) == len(apos):
                                while i > itisk:
                                    if len(m) <= itisk:
                                        apos += ""
                                        chyba += 1
                                        if chyba > 4:
                                            i = len(m) + 2
                                            j = len(words) + 2
                                    else:
                                        vysledek += m[itisk][0] + m[itisk][1] + m[itisk][0] + m[itisk][2] + " "
                                    itisk += 1
                                apos = ""
                                word = ""
                            else:
                                if len(word)>0:
                                    word += " "
                                if len(words) <= j:
                                    word += ""
                                    chyba += 1
                                    if chyba > 4:
                                        i = len(m) + 2
                                        j = len(words) + 2
                                else:
                                    word += words[j]
                                j += 1

                            #print(apos)

                        if chyba > 4:
                            output.write(line)
                            #print(line)
                        else:
                            if len(m) <= itisk:
                                apos += ""
                            else:
                                vysledek += m[itisk][0] + m[itisk][1] + m[itisk][0] + m[itisk][2] + " "
                            output.write("" + vysledek)
                            output.write("\n")
                        tmp = ""
                else:
                    output.write(line)




    output.close()