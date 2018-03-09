#!/bin/sh
pwd=$(pwd)
saxon -it:main f=$pwd/$1 -xsl:'/home/hanson/bin/workflowtools/edx-course-export-visualizer/edx-course-export-visualizer.xsl'
