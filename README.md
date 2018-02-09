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

### html 4 loose conversion to xhtml5 on already published html-galley files
1. Find all html-galleys of journal articles that were published during old workflow using html 4 loose dtd
2. For each of these files, if they are a candidate to convert, convert these to xhtml5:
   1. remove the doctype
   2. change the meta charset in the <head> seciton
   3. make sure empty tags will be converted to proper empty xml-elements
3. Make some structural changes
4. Insert reference to new stylesheet and javascript
5. Insert the <!DOCTYPE html> declaration to the beginning of the html document

### VTT text processing
- Process plain vtt-files to create vtt-files with markup and html-code based on the vtt-file contents

### Audio transcoding
- automate audio transcoding into several formats
