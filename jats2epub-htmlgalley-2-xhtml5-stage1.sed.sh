#!/bin/sh
sed '/<html>/,$!d' | \
sed -r 's!<html>!<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">!' | \
sed -r 's:(<img[^>]+[^/])>:\1 />:g' | \
sed -r 's:<meta[^>]+>:<meta charset="utf-8" />:' | \
sed '/<\/head>/ i\	<link rel="stylesheet" href="/styles/galley/htmlgalley.css" />' | \
# replace some character entities with utf-8 characters
sed 's/&nbsp;/ /' | \
sed 's/&oslash;/ø/' | \
sed 's/&Oslash;/Ø/' | \
sed 's/&aelig;/æ/' | \
sed 's/&Aelig;/Æ/' | \
sed 's/&aring;/å/' | \
sed 's/&Aring;/Å/'
