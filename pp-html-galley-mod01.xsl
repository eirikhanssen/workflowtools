<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:ncx="http://www.daisy.org/z3986/2005/ncx/"
    xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs xhtml ncx mml">
    <xsl:output 
        method="xml"
        indent="yes"
        omit-xml-declaration="yes"
        undeclare-prefixes="no"/>
    
    <xsl:variable name="author">
        <xsl:variable name="authorstring" select="//xhtml:h2[@class='author']/text()"/>
        <ul class="authors" itemscope="itemscope" itemtype="https://schema.org/Person">
            <xsl:for-each select="tokenize($authorstring, ',|&amp;|and')">
                <li itemprop="author"><xsl:value-of select="."/></li>
            </xsl:for-each>
        </ul>
    </xsl:variable>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"></xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="xhtml:h2[@class='author']"/>
    
    <xsl:template match="xhtml:h1[1]">
        <h1><xsl:apply-templates select="@*|node()"/></h1><xsl:text>
</xsl:text><xsl:sequence select="$author"></xsl:sequence>
    </xsl:template>
    
    <xsl:template match="xhtml:div[@class='blockquote']">
        <blockquote><xsl:apply-templates select="@*|node()"/></blockquote>
    </xsl:template>
    
    <xsl:template match="xhtml:div[@class='section']">
        <section><xsl:apply-templates select="node()"/></section>
    </xsl:template>
    
    <xsl:template match="xhtml:div[@class='footer']">
        <footer>
            <xsl:sequence select="@id"></xsl:sequence>
            <xsl:apply-templates select="node()"/>
        </footer>
    </xsl:template>

    <xsl:template match="xhtml:div[@class='abstract']">
        <section>
            <xsl:apply-templates select="@*"/>
            <h2>Abstract</h2>
            <xsl:apply-templates select="node()"/>
        </section>
    </xsl:template>

    <xsl:template match="@class[.='main-title']"/>
    <xsl:template match="xhtml:p/@id"/>
    
    <!-- 
        Keywords: http://schema.org/keywords
        
        section > h2 "introduction"
    -->
    
</xsl:stylesheet>