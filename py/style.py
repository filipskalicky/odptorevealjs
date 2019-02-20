#!/usr/bin/env python3

import re
import pprint
import os

if __name__ == '__main__':

    with open('css/generated.css', 'r') as myfile:
        lst = myfile.readlines()
        lst = lst[0:-1]
        lst = ''.join(lst)
        lst = lst.replace('\n', ' ')
        myfile.close()

    css = lst
    m = re.findall('(.+?)\s?\{\s?(.+?)\s?\}', css)
    result = dict()
    for i in m:
        a = i[1].split(';')
        a = a[0:-1]
        d=[]
        for c in a:
            d.extend(c.split(':'))

        e = list()
        for c in d:
            e.append(c.lstrip())
        result[i[0].lstrip()] = dict(e[i:i+2] for i in range(0, len(e), 2))



    pp = pprint.PrettyPrinter(indent=4)
    #pp.pprint(result)

    #print(result[".P1"]["text-align"])


    poradi = list()
    zkontrolovat = list()
    with open('tmp/presentation-unsorted.md', 'r') as markdown:
        for line in markdown:
            clas = re.findall("{_class=\"(.*?)\"}", line)
            if len(clas) == 1:
                zkontrolovat.append(clas[0].split(' '))
            elif len(clas) > 1:
                clasa = iter(clas)
                next(clasa)
                probehle = list()
                for clen in clasa:
                    if clen not in probehle:
                        first = clas[0].split(' ')
                        probehle.append(clen)
                        first.extend(clen.split(' '))
                        if len(list(set([i for i in first if first.count(i) > 1]))) == 0:
                            zkontrolovat.append(first)
                        else:
                            zkontrolovat.append(clas[0].split(' '))
                            zkontrolovat.append(clen.split(' '))


    duplicate = zkontrolovat
    final_list = []
    for num in duplicate:
        if num not in final_list:
            final_list.append(num)

    zkontrolovat = final_list
    for i, el in enumerate(final_list):
        for j, el2 in enumerate(el):
            if len(final_list[i][j]) < 1:
                del zkontrolovat[i][j]
    for i, el in enumerate(final_list):
        if len(list(set([i for i in el if el.count(i) > 1]))) > 0:
            del zkontrolovat[i]
            continue

    if len(zkontrolovat) > 0:
        poradi = list(reversed(zkontrolovat[0]))
        iterator = iter(zkontrolovat)
        next(iterator)
        for pravidlo in iterator:
            ukazatel = len(poradi)
            for prvek in pravidlo:
                if prvek in poradi:
                    stary = ukazatel
                    ukazatel = poradi.index(prvek)
                    if stary < ukazatel:
                        presun = poradi[stary]
                        poradi = poradi[0:stary]+poradi[stary+1:]
                        poradi.insert(ukazatel, presun)
            if ukazatel == len(poradi):
                ukazatel = 0
            for prvek in reversed(pravidlo):
                if prvek not in poradi:
                    poradi.insert(ukazatel, prvek)
                    ukazatel+=1
                else:
                    ukazatel=(poradi.index(prvek))+1


    konecne = []
    with open('tmp/presentation-unsorted-absolute.md', 'r') as markdown:
        for line in markdown:
            clas = re.findall("class=\"(.*?)\"", line)
            #print(clas)
            if len(clas) > 0:
                for tridy in clas:
                    rozdeleny = tridy.split(" ")
                    for x in rozdeleny:
                        if len(x) > 0:
                            if x not in konecne:
                                konecne.append(x)

    konecne = list(set(konecne)-set(poradi))

    output = open("css/generated.css", "w")

    for el in reversed(konecne):
        if str("." + el.lstrip()) in result:
            if len(result[str("."+el.lstrip())]) > 0:
                output.write(str("." + el.lstrip()) + " {\n")
                for x in result[str("." + el.lstrip())]:
                    output.write("\t" + x + ": " + result[str("." + el.lstrip())][x] + ";\n")
                output.write("}\n\n")

    for el in reversed(poradi):
        if str("."+el.lstrip()) in result:
            output.write(str("."+el.lstrip()) + " {\n")
            for x in result[str("."+el.lstrip())]:
                output.write("\t"+ x + ": "+ result[str("."+el.lstrip())][x] +";\n")
            output.write("}\n\n")


    output.close()

