#!/bin/sh
cat $1 | pp-html-2-xhtml5-stage1.sh | pp-html-2-xhtml5-stage2.sh | pp-html-2-xhtml5-stage3.sh
