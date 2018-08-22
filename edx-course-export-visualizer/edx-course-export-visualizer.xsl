<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    
    
    <xsl:output method="xml" indent="yes"></xsl:output>

    <!-- A micro-pipeline in XSLT using <xsl:variable> and modes
         to build a flat xml-structure from xml-documents 
         scattered over many files and folders 
         in this case from an extracted edx-course export archive

         - load a xml-file, store in a variable
         - then process the files this xml document references (in another mode) 
         - then add them as children of this node and store in a variable
         - repeat until all levels of files have been processed and merged into one flat xml tree -->

    <!-- This micro-pipeline has been written to work with a known xml-structure.
         It works as intended with the edx course export. 
         It could possibly be re-written more generic using recursive templates/functions -->
    
    <!-- This stylesheet is intended of being called with an initial template, and the folder as a string parameter.
         The empty string will be supplied as a default a default folder parameter, 
         indicating to look for the starting course.xml in the current folder -->

    <!-- Example calling this stylesheet with saxon xslt/xquery processor:

         saxon -it:main f=/relative/path/to/edx-export-folder -xsl:'/full/path/to/edx-course-export-visualizer.xsl'

         saxon -it:main -xsl:'/full/path/to/edx-course-export-visualizer.xsl 

         -it:main specifies the initial template

         f=office365 would specify that the edx-course-export is in the relative path office365. 

         If the f-parameter is dropped, the stylesheet will simply look for the initial course.xml file in the current folder you are issuing the command from.

         -xsl:path speficies where this xsl-stylesheet is located in the filesystem
    -->

   <!-- Written by Eirik Hanssen, OsloMet – Oslo Metropolitan University -->

   <!-- License: Gnu GPLv3 -->

    <xsl:param name="f" as="xs:string" select="''"/>
    
    <!-- folders in the extracted edx course export -->

    <xsl:variable name="f_root" select="$f"/>
    <xsl:variable name="input" select="doc(concat($f_root,'/course.xml'))"/>
    <xsl:variable name="f_chapter" select="concat($f_root, '/chapter/')"/>
    <xsl:variable name="f_sequential" select="concat($f_root, '/sequential/')"/>
    <xsl:variable name="f_vertical" select="concat($f_root, '/vertical/')"/>
    <xsl:variable name="f_html" select="concat($f_root, '/html/')"/>
    <xsl:variable name="f_video" select="concat($f_root, '/video/')"/>

<xsl:variable name="html_doctype_entities_local">
<!--  Define some entities that are used in html files. This might need to be expanded later -->
    <xsl:text><![CDATA[<!DOCTYPE html [ 
<!ENTITY nbsp "&#160;">
<!ENTITY aring "å">
<!ENTITY Aring "Å">
<!ENTITY oslash "ø">
<!ENTITY Oslash "Ø">
<!ENTITY aelig "æ">
<!ENTITY AElig "Æ">
<!ENTITY lsquo "‘">
<!ENTITY rsquo "’">
<!ENTITY mdash "—">
<!ENTITY ndash "–">
<!ENTITY ldquo "“">
<!ENTITY rdquo "”">
<!ENTITY laquo "«">
<!ENTITY raquo "»">
<!ENTITY eacute "é">
<!ENTITY Eacute "É">
]>]]></xsl:text>
</xsl:variable>
    
<xsl:variable name="html_doctype_entities_w3c">
<!--  it would be wise to use a local entity resolver instead of fetching these entities over the internet: how do we do this? -->
<xsl:text><![CDATA[<!DOCTYPE html [
  <!ENTITY % w3centities-f PUBLIC "-//W3C//ENTITIES Combined Set//EN//XML"
      "http://www.w3.org/2003/entities/2007/w3centities-f.ent">
  %w3centities-f;
]>]]></xsl:text>
</xsl:variable>
    

    <!-- this identity template will by default copy elements with all attributes and nodes unchanged unless a more specific template is invoked -->
    <!-- mode="#all" for the <xsl:template> will make this identity template the default template in all modes -->
    <!-- mode="#current" for the <xsl:apply-templates> will make sure children are processed in the same mode this template was called from.
         This is important for the micro-pipeline to function as intended. -->

    <xsl:template match="@*|node()" mode="#all">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
   <!-- phase-0 -->

    <xsl:template match="course" mode="phase-0">
        <course>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="node()" mode="#current"/>
        </course>
    </xsl:template>
    

    <!-- phase-1 -->
    
    <xsl:template match="course" mode="phase-1">
        <xsl:variable name="course-doc" select="doc(concat($f_root,'/course/' , @url_name , '.xml'))"/>
        <course>
            <xsl:apply-templates select="@*"/>
            <xsl:sequence select="$course-doc/*/@*"/>
            <xsl:apply-templates select="node()" mode="#current"/>
            <xsl:sequence select="$course-doc/*/node()"/>
        </course>
    </xsl:template>
    
    <xsl:template match="chapter" mode="phase-2">
        <xsl:variable name="chapter-doc" select="doc(concat($f_chapter,@url_name,'.xml'))"/>
        <chapter>
            <xsl:apply-templates select="@*"/>
            <xsl:sequence select="$chapter-doc/*/(@*|node())"/>
        </chapter>
    </xsl:template>    

    <!-- phase-2 -->
    
    <xsl:template match="sequential" mode="phase-3">
        <xsl:variable name="sequential-doc" select="doc(concat($f_sequential,@url_name,'.xml'))"/>
        <sequential>
            <xsl:apply-templates select="@*"/>
            <xsl:sequence select="$sequential-doc/*/(@*|node())"/>
        </sequential>
    </xsl:template>

    <!-- phase-3 -->
    
    <xsl:template match="vertical" mode="phase-4">
        <xsl:variable name="vertical-doc" select="doc(concat($f_vertical,@url_name,'.xml'))"/>
        <vertical>
            <xsl:apply-templates select="@*"/>
            <xsl:sequence select="$vertical-doc/*/(@*|node())"/>
        </vertical>
    </xsl:template>
    
    <!-- phase-4 -->
    
    <xsl:template match="html" mode="phase-5">
        <xsl:variable name="html-doc" select="doc(concat($f_html,@url_name,'.xml'))"/>
        <html>
            <xsl:apply-templates select="@*"/>
            <xsl:sequence select="$html-doc/*/(@*|node())"/>
        </html>
    </xsl:template>
    
    <xsl:template match="video" mode="phase-5">
        <xsl:variable name="video-doc" select="doc(concat($f_video,@url_name,'.xml'))"/>
        <video>
            <xsl:apply-templates select="@*"/>
            <xsl:sequence select="$video-doc/*/(@*|node())"/>
        </video>
    </xsl:template>
    
    <!-- phase-5 -->
    
    <xsl:template match="html" mode="phase-6">
        <xsl:variable name="html-doc" select="unparsed-text(concat($f_html,@url_name,'.html'))"/>
        
        <!-- prepend a entities doctype before html element, to define html entities -->
        <xsl:variable name="rooted-html-doc-string" select="concat($html_doctype_entities_local,'&lt;html>',$html-doc,'&lt;/html>')"/>
<!--        <xsl:variable name="rooted-html-doc-string" select="concat($html_doctype_entities_w3c,'&lt;html>',$html-doc,'&lt;/html>')"/>-->
        <xsl:variable name="rooted-html-doc-xml" select="parse-xml($rooted-html-doc-string)"/>
        <html>
            <xsl:apply-templates select="@*"/>
            <xsl:sequence select="$rooted-html-doc-xml/*/(@*|node())"/>
        </html>
        
    </xsl:template>

    <xsl:template name="main">
        
        <xsl:variable name="phase-0-output">
            <xsl:apply-templates select="$input" mode="phase-0"/>
        </xsl:variable>
        
        <xsl:variable name="phase-1-output">
            <xsl:apply-templates select="$phase-0-output" mode="phase-1"/>
        </xsl:variable>
        
        <xsl:variable name="phase-2-output">
            <xsl:apply-templates select="$phase-1-output" mode="phase-2"/>
        </xsl:variable>
        
        <xsl:variable name="phase-3-output">
            <xsl:apply-templates select="$phase-2-output" mode="phase-3"/>
        </xsl:variable>
        
        <xsl:variable name="phase-4-output">
            <xsl:apply-templates select="$phase-3-output" mode="phase-4"/>
        </xsl:variable>
        
        <xsl:variable name="phase-5-output">
            <xsl:apply-templates select="$phase-4-output" mode="phase-5"/>
        </xsl:variable>
        
        <xsl:variable name="phase-6-output">
            <xsl:apply-templates select="$phase-5-output" mode="phase-6"/>
        </xsl:variable>
        
        <xsl:result-document>
            <xsl:sequence select="$phase-6-output"/>
        </xsl:result-document>

    </xsl:template>
    
</xsl:stylesheet>
