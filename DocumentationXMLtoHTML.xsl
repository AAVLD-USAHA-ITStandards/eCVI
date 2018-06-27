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
        <xsl:value-of select="../Description"/>
        <xsl:if test="../Attributes">
            <h3>Attributes</h3>
            <ul>
                <xsl:for-each select="../Attributes/Attribute">
                    <li>
                        <b><xsl:value-of select="./@name"/></b>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="./@required"/>
                    </li>
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="../ChildElements">
            <h3>Child Elements</h3>
            <ul>
                <xsl:for-each select="../ChildElements/Child">
                    <li>
                        <b><xsl:value-of select="./@name"/></b>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="./@required"/>
                        <xsl:if test="./@repeats='Repeats'"> Repeats</xsl:if>
                    </li>
                </xsl:for-each>
            </ul>
        </xsl:if>
    </xsl:template>

    <xsl:template match="//ecvi2Documentation/Item/Enumeration">
        <br/><b><xsl:value-of select="."/>: </b>
        <xsl:value-of select="../Description"/>
    </xsl:template>

    <xsl:template match="//ecvi2Documentation/Item/Attribute">
        <h3>Attribute: <xsl:value-of select="."/></h3>
        <xsl:value-of select="../Description"/>
    </xsl:template>

    <xsl:template match="Type">
        <h2>Type: <xsl:value-of select="."/></h2>
        <xsl:value-of select="../Description"/>
    </xsl:template>
    
    <xsl:template match="Description">
        <!-- Do nothing already output -->
    </xsl:template>
    <xsl:template match="ChildElements">
        <!-- Do nothing already output -->
    </xsl:template>
    
 </xsl:stylesheet>