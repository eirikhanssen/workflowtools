#!/bin/sh
# fix files with html-fragments to make them well-formed xml to be processed by xslt
# replace some entities with the actual characters
# find all .html files in the current directory (recursively) and execute sed (stream editor) on them, editing them in place
find . -type f -name '*.html' -exec sed -i \
-r 's:(<img[^>]+[^/])>:\1 />:g' \
{} \;
