<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">
    <xsl:template match="/">
        <html>
            <body>
        <ul>
            <xsl:apply-templates select="//xs:documentation"/>
        </ul>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="//xs:documentation">
        <li>
            <xsl:choose>
                <xsl:when test="../../@name">
                    <xsl:if test="not(starts-with(../../@name, 'xs:'))">
                        <xsl:value-of select="../../@name"/> :
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="../../@value"/> :
                </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="."/>
        </li>
    </xsl:template>
</xsl:stylesheet>