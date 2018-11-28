#!/usr/bin/env python3

import sys
import os
import shutil
from pathlib import Path




if __name__ == '__main__':

    presentation = "prezentace.odp"
    if len(sys.argv) == 2:
        presentation = sys.argv[1]
        my_file = Path(sys.argv[1])
        if not my_file.is_file():
            print("Soubor neexistuje")
            sys.exit(1)

    print("Start")


    try:
        os.remove("presentation.md")
    except OSError:
        pass

    try:
        shutil.rmtree("tmp")
    except Exception as e:
        pass



    shutil.copy2( presentation , 'prezentace.zip')
    print("Vytváření složky tmp")
    os.mkdir("tmp")

    print("Rozbalení prezentace")
    os.system("unzip -q prezentace.zip -d tmp/")

    print("Generování markdown")
    os.system("xsltproc -o presentation-unsorted.md xslt/presentation.xslt tmp/content.xml")
    os.system("sed -i -e 's/<\([^!]\)/\&lt;\1/g' presentation-unsorted.md")

    print("Generování stylu")
    os.system("xsltproc -o css/generated.css xslt/style.xslt tmp/content.xml")

    print("Řazení stylu")
    os.system("python3 py/style.py")

    print("Kontrola překrývání prvků")
    os.system("python3 py/position.py")

    print("Mazání dočasných souborů")
    try:
        shutil.rmtree("tmp")
    except Exception as e:
        pass

    try:
        os.remove("prezentace.zip")
    except OSError:
        pass

    try:
        os.remove("presentation-unsorted.md")
    except OSError:
        pass

    print("Konec")
