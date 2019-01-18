#!/usr/bin/env python3

import sys
import os
import shutil
from pathlib import Path
import json
import re



if __name__ == '__main__':

    config = "convert.conf"
    if len(sys.argv) > 2:
        print("Špatné argumenty")
        sys.exit(1)

    if len(sys.argv) == 2:
        if (sys.argv[1] == "--help"):
            print("ODPTOREVEALJS")
            print("Autor: Filip Skalický")
            print("Email: xskali16@stud.fit.vutbr.cz")
            print("Licence: GPL3")
            print("Rok: 2019")
            print("\nspuštění:")
            print("\tpython3 convert.py [convert.conf]")
            print("\nvíce o konfiguraci v README.md")
            sys.exit(0)

        config = sys.argv[1]
        my_file = Path(sys.argv[1])
        if not my_file.is_file():
            print("Konfigurační soubor neexistuje")
            sys.exit(1)

    with open(config) as f:
        try:
            conf = json.load(f)
        except Exception as e:
            print("Chyba konfiguračního souboru")
            sys.exit(1)
            pass

    if "presentation" not in conf:
        print("Chyba konfiguračního souboru - presentation")
        sys.exit(1)
    if "input" not in conf["presentation"]:
        print("Chyba konfiguračního souboru - input")
        sys.exit(1)
    if "output" not in conf["presentation"]:
        print("Chyba konfiguračního souboru - output")
        sys.exit(1)

    presentation = Path(conf["presentation"]["input"])
    if not presentation.is_file():
        print("Chyba konfiguračního souboru - input")
        sys.exit(1)

    separator = "++++"
    if "presentation" in conf and "separator" in conf["presentation"]:
        separator = conf["presentation"]["separator"]
    m = re.findall('\s', separator)
    if len(m) > 0:
        print("Chyba konfiguračního souboru - separator")
        sys.exit(1)

    separatorVertical = "----"
    if "presentation" in conf and "separator-vertical" in conf["presentation"]:
        separatorVertical = conf["presentation"]["separator-vertical"]
    m = re.findall('\s', separatorVertical)
    if len(m) > 0:
        print("Chyba konfiguračního souboru - separator-vertical")
        sys.exit(1)

    print("Start")

    try:
        shutil.rmtree("tmp")
    except Exception as e:
        pass

    try:
        os.remove(conf["presentation"]["output"])
    except Exception:
        pass

    try:
        shutil.rmtree("Pictures")
    except Exception as e:
        pass



    shutil.copy2(str(presentation) , 'prezentace.zip')
    print("Vytváření složky tmp")
    os.mkdir("tmp")

    print("Rozbalení prezentace")
    os.system("unzip -q prezentace.zip -d tmp/")



    os.system("python3 py/configuration.py " + config)


    print("Generování markdown")


    os.system("xsltproc --stringparam oddelovac '\n" + separator + "\n' -o tmp/presentation-unsorted.md xslt/presentation-new.xslt tmp/content.xml")
    os.system("xsltproc --stringparam oddelovac '\n" + separator + "\n' -o tmp/presentation-unsorted-absolute.md xslt/presentation-new-absolute.xslt tmp/content.xml")

    os.system("python3 py/table.py")

    print("Generování stylu")
    os.system("xsltproc -o css/generated.css xslt/style.xslt tmp/content.xml")

    print("Řazení stylu")
    os.system("python3 py/style.py")

    print("Kopírování obrázků")
    try:
        shutil.copytree('tmp/Pictures/', 'Pictures/')
    except Exception as e:
        pass

    print("Kontrola překrývání prvků")
    os.system("python3 py/position.py")
    os.system("python3 py/spaces.py")


    try:
        os.remove("prezentace.zip")
    except OSError:
        pass

    os.system("python3 py/composition.py")


    print("Mazání dočasných souborů")
    try:
        shutil.rmtree("tmp")
    except Exception as e:
        pass



    print("Konec")
