#!/usr/bin/env python3

import re
import sys
import json
from pathlib import Path


error_json = {}

def getKey(item):
    return item[0][3]

def kontrola(sor, slide):
    ok = True
    for i,el in enumerate(sor[1:]):
        if sor[i][0][3] + sor[i][0][1] > el[0][3]:
            ok = False
            if ((sor[i][0][2] <= el[0][2]) and (sor[i][0][2] + sor[i][0][0] <= el[0][2])) or ( (el[0][2] <= sor[i][0][2])  and (el[0][2] + el[0][0] <= sor[i][0][2])):
                #print("\n\t\t" + str(i + 1) + ". a " + str(i+2) + ". prvek jsou vedle sebe", end='')
                if (str(slide-1)) not in error_json:
                    error_json[str(slide-1)] = []
                error_json[str(slide-1)].append(str(i + 1) + ". a " + str(i+2) + ". prvek jsou vedle sebe")
            else:
                #print("\n\t\t" + str(i + 1) + ". a " + str(i+2) + ". prvek se překrývají", end='')
                if (str(slide-1)) not in error_json:
                    error_json[str(slide-1)] = []
                error_json[str(slide-1)].append(str(i + 1) + ". a " + str(i + 2) + ". prvek se překrývají")
    if ok == True:
        #print(" - OK", end='')
        if (str(slide-1)) not in error_json:
            error_json[str(slide-1)] = []

    return 0

if __name__ == '__main__':
    with open("tmp/convert.conf") as f:
        try:
            conf = json.load(f)
        except Exception as e:
            print("Chyba konfiguračního souboru")
            sys.exit(1)
            pass

    slide = 1

    my_file = Path("tmp/errors.json")
    error = ""
    if my_file.is_file():
        error = open("tmp/errors.json", "r")
        error_json = json.load(error)
        error.close()
    else:
        error_json = {}

    error = open("tmp/errors.json", "w")

    output = open("tmp/presentation-spaces.md", "w")
    with open('tmp/presentation-table.md', 'r') as markdown:
        obsah = ""
        stranka = []
        #print("\tslide " + str(slide), end='')
        slide += 1
        for line in markdown:
            m = re.findall(conf["presentation"]["separator-regex"], line)
            if len(m)>0:
                if len(stranka) != 0:
                    n = re.findall('^\n{2,}$', obsah)
                    if len(n) > 0:
                        #print("-------------------------------------------------------", n, obsah, stranka[len(stranka) - 1])
                        del stranka[len(stranka) - 1]
                    else:
                        stranka[len(stranka) - 1].append(obsah)
                obsah = ""
                obsah_sorted = sorted(stranka, key=getKey)
                for item in obsah_sorted:
                    output.write(item[1])
                output.write("\n"+m[0])
                kontrola(obsah_sorted, slide)
                stranka = []
                #print("\n\tslide " + str(slide), end='')
                slide+=1
            else:
                m = re.findall('rozmery <!-- {_class=\"hide rozmery\" width=\"([0-9]+\.{0,1}[0-9]*).{0,3}\" height=\"([0-9]+\.{0,1}[0-9]*).{0,3}\" x=\"([0-9]+\.{0,1}[0-9]*).{0,3}\" y=\"([0-9]+\.{0,1}[0-9]*).{0,3}\" }', line)
                if len(m)>0:
                    if len(stranka) != 0:
                        n = re.findall('^\n{2,}$', obsah)
                        if len(n) > 0:
                            del stranka[len(stranka) - 1]
                        else:
                            stranka[len(stranka) - 1].append(obsah)
                    obsah = ""
                    x=[]
                    mnew = []
                    for i in m[0]:
                        mnew.append(float(i))
                    x.append(list(mnew))
                    stranka.append(list(x))
                else:
                    m = re.findall('<!-- {_class="(.*?)"} -->', line)
                    if len(m)>0:
                        for i in m:
                            neww = re.sub("\s+", " ", i)
                            line = re.sub('<!-- {_class="'+i+'"} -->', '<!-- {_class="'+neww+'"} -->', line)

                    m = re.findall('^\s+([^-].*)',line)
                    if len(m) > 0:
                        obsah = obsah[:-1]
                        obsah += m[0]
                        obsah +="\n"
                    else:
                        obsah += line

        if len(stranka) != 0:
            n = re.findall('^\n{2,}$', obsah)
            if len(n) > 0:
                del stranka[len(stranka) - 1]
            else:
                stranka[len(stranka) - 1].append(obsah)
        obsah = ""
        obsah_sorted = sorted(stranka, key=getKey)
        for item in obsah_sorted:
            output.write(item[1])
        kontrola(obsah_sorted, slide)
        stranka = []

    json.dump(error_json, error)
    error.close()
    output.close()
    markdown.close()
    f.close()