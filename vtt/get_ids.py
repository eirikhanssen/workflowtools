import sys
import re
import string
#extract all symbol ids

f=open(sys.argv[1], 'r')
cuecounter = 1

symbol_search = re.compile("^\s*<symbol")
#get the contents of the id attribute in the symbol element
pattern = '(?<=id=")([^"]+)'
output = ''
for line in f:
    if symbol_search.match(line):
        output += re.search(pattern, line).group(0) + '\n'
f.close()
print(output)