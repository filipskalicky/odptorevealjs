# odptorevealjs

Nástroj pro převod prezentace ve formátu .odp do reveal.js

Autor: Filip Skalický

Email: xskali16@stud.fit.vutbr.cz

Licence: GPL3

## Instalace

1. Stáhněte si aktulání verzi z [github.com](https://github.com/filipskalicky/odptorevealjs)
2. Nastavte konfigurační soubor
3. Spusťe převod pomocí convert.py
4. Otevřete index.html (pokud chcete prohlížet lokálně, je nutné pouštět službu z lokálního webového serveru)



## Konfigurační soubor

Je soubor ve formátu json. Minimálně musí obsahovat cestu ke vstupní prezentaci a výstupní soubor.
```json
{
  "presentation":{
    "input": "cesta/prezentace.odp",
    "output": "cesta/presentation.md",
    "separator": "++++",
    "separator-vertical": "----"
  }
}

```

#### Nastavení prezentace

input

- povinný parametr
- musí obsahovat validní cestu k souboru .odp

output

- povinný parametr
- obsahuje cestu kde bude uložený výsledný Markdown

separator

- volitelný parametr
- jednořádkový řetězec kterým budou ve výsledném Markdown odděleny horizontální slidy
- defaultní hodnota je "++++"

separator-vertical

- volitelný parametr
- jednořádkový řetězec kterým budou ve výsledném Markdown odděleny vertikální slidy
- defaultní hodnota je "----"

#### Nastavení konkrétního slidu

Konfigurační soubor může obsahovat nastavení převodu jednotlivých slidů ze vstupní prezentace.

```json
{
    "0":{
        "delete": false,
        "content": false,
        "absolute": false,
        "style": true
    }
}
```  

číslo slidu

- slidy ve vstupní prezentaci se číslují od 0 
- nastavení slidu, který není v prezentaci nebo nemá správný identifikátor (může obsahovat pouze celá čísla) se ignoruje
- lze využít záporný index pro indexování od posledního slidu prezentace
- pro nastavení více slidů současně lze oddělit čísla slidů čárkou
- pro nastavení rozmezí více slidů lze definovat číslem prvního a posledního slidu oddělených dvojtečkou (vynechání čísla značí začátek/konec slidů)
- způsoby nastavení více slidů a rozmezí slidů nejde kombinovat
 
 ```json
{
    "0":{
        "content": false
    },
    "-2":{
        "content": false
    },
    "0, -1, 2":{
        "content": false
    },
    ":2":{
        "content": false
    },
    "1:-1":{
        "content": false
    },
    ":":{
        "content": false
    }
}
```

 ``` text

První prvek rozmezí od zadu:        -6  -5  -4  -3  -2  -1
První prvek rozmezí od předu:        0   1   2   3   4   5
                                    +---+---+---+---+---+---+
                                    | a | b | c | d | e | f |
                                    +---+---+---+---+---+---+
Poslední prvek rozmezí ze předu:   :   1   2   3   4   5   :
Poslední prvek rozmezí od zadu:    :  -5  -4  -3  -2  -1   :                               

```    

delete

- volitelný parametr
- defaultní hodnota je "false"
- daný slide bude z výsledného Markdown smazán
- ostatní nastavení slidu se neprojeví
- pro smazání dané stránky je potřeba nastavit hodnotu "true"
```json
{
    "0":{
            "delete": true
    }
}
```

content

- volitelný parametr
- defaultní hodnota je "false"
- přepíše obsah daného slidu 
- pro přepsání obsahu je nutné aby hodnota byla řetezec
```json
{
    "0":{
            "content": ""
    },
    "1":{
            "content": "Nový obsah"
    }
}
```

absolute

- volitelný parametr
- defaultní hodnota je "false"
- danou stránku nepřevádí do Markdown ale do HTML
- pro aktivaci převedení dané stránky je potřeba nastavit hodnotu "true"
```json
{
    "0":{
            "absolute": true
    }
}
```

style

- volitelný parametr
- defaultní hodnota je "true"
- zda daná stránka obsahuje parametry "class" pro stylování pomocí css
- pro smazání stylů dané stránky je potřeba nastavit hodnotu "false"
- smazání stylů může odstranit znak zalomení řádku 
```json
{
    "0":{
            "style": false
    }
}
```

#### Nastavení značek Markdown

Konfigurační soubor může obsahovat nastavení jednotlivých prvků (nadpisy, seznam) v markdown.

```json
{
    "characters":{
        "list": "-",
        "heading1": "#",
        "heading2": "##"
    }
}
```

list

- volitelný parametr
- defaultní hodnota je "-"
- každý prvek seznamu v prezentaci bude začínat tímto znakem

heading1

- volitelný parametr
- defaultní hodnota je "#"
- každý nadpis první úrovně v prezentaci bude začínat tímto znakem

heading2

- volitelný parametr
- defaultní hodnota je "##"
- každý nadpis druhé úrovně v prezentaci bude začínat tímto znakem

## Spuštění převodu

Převod zajišťuje script convert.py

- python v3
- jedinný a volitelný parametr je cesta ke konfiguračnímu souboru 
- defaultní hodnota je convert.conf

Spuštění převodu

```bash
    python3 convert.py 
```   
```bash
    python3 convert.py cesta/convert.conf
```

Vypsání nápovědy

```bash
    python3 convert.py --help
``` 

#### Vygenerované soubory

1. Markdown s obsahem prezentace. Umístění podle konfiguračního souboru.
2. CSS soubor umístěný v "css/generated.css". Obsahuje nastavení stylů z prezentace
3. Obrázky využité v prezentaci umístěné v "Pictures/"
