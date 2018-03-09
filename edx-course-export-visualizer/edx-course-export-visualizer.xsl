<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="xml" indent="yes"></xsl:output>
    
    <!-- supply the folder as a parameter, the current folder as a default parameter66666666666 -->
    <xsl:param name="f" as="xs:string" select="''"/>
    
    <!-- folders in edx-extract -->
    <!-- the root folder should be given as a parameter and not hard coded -->
    <xsl:variable name="f_root" select="$f"/>
    <xsl:variable name="input" select="doc(concat($f_root,'/course.xml'))"/>
    <xsl:variable name="f_chapter" select="concat($f_root, '/chapter/')"/>
    <xsl:variable name="f_sequential" select="concat($f_root, '/sequential/')"/>
    <xsl:variable name="f_vertical" select="concat($f_root, '/vertical/')"/>
    <xsl:variable name="f_html" select="concat($f_root, '/html/')"/>
    <xsl:variable name="f_video" select="concat($f_root, '/video/')"/>

    <!-- identity transform -->    
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
        <xsl:variable name="html-doc" select="doc(concat($f_html,@url_name,'.html'))"/>
        <html>
            <xsl:apply-templates select="@*"/>
            <xsl:sequence select="$html-doc/*/(@*|node())"/>
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
