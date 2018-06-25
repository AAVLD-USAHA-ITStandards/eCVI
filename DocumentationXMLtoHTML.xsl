<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output  method="html"/> 
    <xsl:template match="/">
        <html><head><Title>eCVI version 2 Standard Contents</Title></head><body>
            <h1>eCVI version 2 Standard Contents</h1>
            <xsl:apply-templates select="ecvi2Documentation"/>
        </body></html>
    </xsl:template>
    
    <xsl:template match="//ecvi2Documentation/Item/Element">
        <h2>Element: <xsl:value-of select="."/></h2>
    </xsl:template>
    <xsl:template match="//ecvi2Documentation/Item/Enumeration">
        <br/><b><xsl:value-of select="."/>: </b>
    </xsl:template>
    <xsl:template match="//ecvi2Documentation/Item/Attribute">
        <h3>Attribute: <xsl:value-of select="."/></h3>
    </xsl:template>
    <xsl:template match="Type">
        <h2>Type: <xsl:value-of select="."/></h2>
    </xsl:template>
    
 </xsl:stylesheet>