<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output  method="xml" indent="yes"/> 
    <xsl:template match="/">
        <xsl:element name="ecvi2Documentation">
            <xsl:apply-templates select="//xs:documentation"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="//xs:documentation">
        <xsl:element name="Item">
                    <xsl:variable name="parent" select="name(../..)"/>
            <xsl:choose>
                    <xsl:when test="contains($parent,'xs:element')">
                        <xsl:element name="Element">
                            <xsl:value-of select="../../@name"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="contains($parent,'xs:simpleType') or contains($parent,'xs:complexType')">
                        <xsl:element name="Type">
                            <xsl:value-of select="../../@name"/>
                        </xsl:element>
                    </xsl:when>
                <xsl:when test="contains($parent,'xs:element')">
                    <xsl:element name="Element">
                        <xsl:value-of select="../../@name"/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="contains($parent,'xs:attribute')">
                    <xsl:element name="Attribute">
                        <xsl:if test="../../../../@name"><xsl:value-of select="../../../../@name"/>:</xsl:if>
                        <xsl:value-of select="../../@name"/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="contains($parent,'xs:enumeration')">
                    <xsl:element name="Enumeration">
                        <xsl:value-of select="../../@value"/>
                    </xsl:element>
                </xsl:when>
            </xsl:choose>
            <xsl:element name="Description">
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:element> 
    </xsl:template>
</xsl:stylesheet>