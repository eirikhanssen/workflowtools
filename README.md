# workflowtools
A collection of time saving scripts and snippets for performing workflow-related tasks in a Gnu/Linux or similar environment
- commandline text processing
- document conversions
- transcoding

## Tools/languages used
Will over time include useful scripts written with:
- bash
- sed
- regex
- ffmpeg
- python
- XSLT
- XQuery
- XProc
- awk

## Sample worflow-related problems

### Edx course export visualizer
A course export from the edx platform consists of an archive with many xml and xml-like files scattered over several folders.

The purpose of this tool is to quickly get an overview of the course contents, how many modules, how deep, how many images, videos, outline etc.

As a first step, this tool will 'flatten' all of these xml and html files into a single xml file (already implemented).
As a second step, this could be visualized using html and svg (not implemented yet).

Later I plan to create a website where you can upload an archive, and get the visualized result as well as the flattened xml.

#### To flatten the course export into a single xml file
1. First, we need to unpack the edx course export archive and give it a sensible name. Here I am assuming that you already have the the archive in the current folder. In this case the extracted archive contained the folder called 'course'.

   ```tar -xvzf digital_ll_course.d7QpTx.tar.gz
   mv course digital-ii-course```

2. process the course export files (in the digital-ii-course folder), generating a flat xml and redirecting to file.

   ```edx-course-visualizer.sh digital-ii-course > digital-ii-course.xml```

3. visualizing this xml using html and SVG (not implemented yet)

#### Requirements
- a terminal client to run commands
- java runtime environment (required by saxon)
- the saxon xsl processor (supporing xsl version 3) needs to be in the PATH accessible from the command "saxon"
- a symlink pointing to edx-course-export-visualizer.sh needs to be in a folder that is in the PATH
- the references to the edx-course-export-visualizer.xsl stylesheet in edx-course-export-visualizer.xsl needs to be updated to match the full path on your system 

### html 4 loose conversion to xhtml5 on already published html-galley files
1. Find all html-galleys of journal articles that were published during old workflow using html 4 loose dtd
2. For each of these files, if they are a candidate to convert, convert these to xhtml5:
   1. remove the doctype
   2. change the meta charset in the <head> seciton
   3. make sure empty tags will be converted to proper empty xml-elements
3. Make some structural changes
4. Insert reference to new stylesheet and javascript
5. Insert the <!DOCTYPE html> declaration to the beginning of the html document

#### Running an example, first replacements with sed, then xml-conversion, and displaying the results with less
```
cd samples
cat sample02-multiple-authors-401-loose.html | jats2epub-htmlgalley-2-xhtml5-stage1.sed.sh | saxon - ../pp-html-galley-mod01.xsl | less
```

### VTT text processing
- Process plain vtt-files to create vtt-files with markup and html-code based on the vtt-file contents

### Audio transcoding
- automate audio transcoding into several formats
