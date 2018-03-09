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
1. prepare the input files (located in office365 as an example) so that they can be processed using xsl transformations. The files are prepared locating files with gnu find, and on each file using sed (stream editor) for search and replace

   ```cd office365```

   1. replace entities such as &amp;oslash; with proper characters such as ø

   ```edx-fix-entities-in-html-files.sh```

   2. some empty elements in html needs to be made self closing according to xml-rules

   ```edx-fix-entities-in-html-files.sh```

   3. some not well formed html fragments in html files needs to be made well-formed by wrapping a container html element around the contents

2. process the course export files (in the office365 folder), generating a flat xml

   ```edx-course-visualizer.sh office365 > office465.flat.xml```

3. visualizing this xml using html and SVG (not implemented yet)

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
