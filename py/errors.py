#!/usr/bin/env python3

import re
import pprint
import os
import json

if __name__ == '__main__':
    tmp = ""
    with open('tmp/errors.json', 'r') as json_file:
        data = json.load(json_file)
        for key in range(1,len(data)+1):
            if str(key) not in data:
                value = []
            else:
                value = data[str(key)]

            if len(value) > 0:
                print("\tslide " + str(key) + " - WARNING")
                myset = set(value)
                for i in myset:
                    print("\t\t"+i)

            else:
                print("\tslide " + str(key) + " - OK")
    json_file.close()