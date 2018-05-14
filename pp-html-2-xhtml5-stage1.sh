#!/bin/sh
sed '/<html>/,$!d' | \
sed -r 's!<html>!<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">!' | \
sed -r 's:(<img[^>]+[^/])>:\1 />:g' | \
sed -r 's:<meta[^>]+>:<meta charset="utf-8" />:' | \
sed '/<\/head>/ i\	<link rel="stylesheet" href="/styles/galley/pp-xhtml5-galley.css" />' | \
sed -r 's/<body[^>]+>/<body>/' | \
sed 's/&nbsp;/ /g' | \
sed 's/&oslash;/ø/g' | \
sed 's/&Oslash;/Ø/g' | \
sed 's/&aelig;/æ/g' | \
sed 's/&Aelig;/Æ/g' | \
sed 's/&aring;/å/g' | \
sed 's/&Aring;/Å/g'
