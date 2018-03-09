#!/bin/sh
# fix files with html-fragments to make them well-formed xml to be processed by xslt
# replace some entities with the actual characters
# source: https://www.w3.org/wiki/Common_HTML_entities_used_for_typography
# find all .html files in the current directory (recursively) and execute sed (stream editor) on them, editing them in place
find . -type f -name '*.html' -exec sed -i -r \
-e "s/&nbsp;/ /g" \
-e "s/&aring;/å/g" \
-e "s/&Aring;/Å/g" \
-e "s/&oslash;/ø/g" \
-e "s/&Oslash;/Ø/g" \
-e "s/&aelig;/æ/g" \
-e "s/&AElig;/Æ/g" \
-e "s/&lsquo;/‘/g" \
-e "s/&rsquo;/’/g" \
-e "s/&mdash;/—/g" \
-e "s/&ndash;/–/g" \
-e "s/&ldquo;/“/g" \
-e "s/&rdquo;/”/g" \
-e "s/&laquo;/«/g" \
-e "s/&raquo;/»/g" \
-e "s/&eacute;/é/g" \
-e "s/&Eacute;/É/g"  \
-e "s#<(/)?o:p>#<\1p>#g" \
-e "s#<p></p>##g" \
{} \;
