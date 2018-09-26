#!/bin/sh
# this command will run an xsl stylesheet that will take the edx course export and create a flattend xml from it
# this will be sendt to standard output
# if you wish to have it in a file, it must be redirected.
# example:
# edx-course-export-visualizer.sh > flattened_course_export.xml
#
# note that the path to the xsl-file needs to be updated to the path on your system
# note that you need a working java runtime environment
# note that saxon (xslt/xproc) processor needs to be installed and accessible in the path using a 'saxon' command
#
# -it		initial template. Since no xml-document is passed to the stylesheet, provide the starting template to begin processing
# f=$pwd/$1	the parameter "f" will be a folder. If we just call the command edx-course_export-visualizer.sh, then it will be the current folder
# 		if we supply a child folder to the script: e.a. edx-course-export-visualizer.sh FOLDER, then that folder will be used as a parameter
# -xsl:		The full path to the stylesheet doing the transformation
#
# given a folder as a parameter, the xsl-stylesheet will look for the "course.xml" file in the folder and will try to open that file to begin processing, so this file doesn't need to be specified
pwd=$(pwd)
saxon -it:main f=$pwd/$1 -xsl:'/home/hanson/bin/workflowtools/edx-course-export-visualizer/edx-course-export-visualizer.xsl'
