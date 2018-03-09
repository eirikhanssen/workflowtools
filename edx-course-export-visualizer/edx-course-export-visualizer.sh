#!/bin/sh
# note that the path tho the xsl-file needs to be updated to the path on your system
# note that you need a working java runtime environment
# note that saxon (xslt/xproc) processor needs to be installed and accessible in the path using a 'saxon' command
pwd=$(pwd)
saxon -it:main f=$pwd/$1 -xsl:'/home/hanson/bin/workflowtools/edx-course-export-visualizer/edx-course-export-visualizer.xsl'
