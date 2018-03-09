#!/bin/sh
# surround content of html-files with <html>...</html> making them well-formed:
# find all .html files in the current directory (recursively) and execute sed (stream editor) on them, editing them in place
find . -type f -name '*.html' -exec sed -i \
-e "1s/^/<html>/" \
-e "\$a</html>" \
{} \;
