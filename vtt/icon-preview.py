import sys
import re
import string

# extract all symbol ids

f = open(sys.argv[1], 'r')
cuecounter = 1

symbol_search = re.compile("^\s*<symbol")
# get the contents of the id attribute in the symbol element
pattern = '(?<=id=")([^"]+)'

head = """
<!doctype html>
<html>
    <head>
        <title>icon test</title>
        <link rel="stylesheet" href="icontest.css" media="all"/>
    </head>
    <body id="body">

        <nav class="activities">

            <ul>
"""

foot = """
            </ul>

        </nav>

    </body>
<html>
"""

def svgLi(lvl, id):
    indent = " "*lvl*4
    output = """
%(indent)s    <li role="presentation">
%(indent)s        <a href="#body">
%(indent)s            <div class="iconholder"><svg class="icon %(id)s"><use xlink:href="naturfag-icons.svg#%(id)s"></use></svg></div>
%(indent)s            <span class="link-desc">%(id)s</span>
%(indent)s        </a>
%(indent)s    </li>
    """ % {'id': id,'indent':indent}
    return output


output = head;
for line in f:
    if symbol_search.match(line):
        id = re.search(pattern, line).group(0)
        output += svgLi(3,id)
f.close()
output += foot
print(output)