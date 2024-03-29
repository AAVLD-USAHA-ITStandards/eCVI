<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <xsl:apply-templates select="//xs:element[@name = 'eCVI']"/>
    </xsl:template>

    <xsl:template match="//xs:element[@name = 'eCVI']">
        <html>
            <head>
                <Title>eCVI Version 2 Standard Contents</Title>
            </head>
            <body>
                <h1>eCVI Version 2 Standard Contents</h1>
                <xsl:apply-templates select="../xs:annotation/xs:documentation"/>
                <h1>eCVI Document Element</h1>
                <xsl:apply-templates select="./xs:annotation/xs:documentation"/>
                <h2>Attributes</h2>
                <ul>
                    <xsl:for-each select="./xs:complexType/xs:attribute">
                        <li>
                            <b>
                                <xsl:value-of select="@ref"/>
                                <xsl:value-of select="@name"/>
                            </b>
                            <xsl:choose>
                                <xsl:when test="@use = 'required'">: Required</xsl:when>
                                <xsl:otherwise>: Optional</xsl:otherwise>
                            </xsl:choose>
                        </li>
                        <xsl:apply-templates select="./xs:annotation/xs:documentation"/>
                    </xsl:for-each>
                </ul>
                <h2>Child Elements</h2>
                <ul>
                    <xsl:for-each select="./xs:complexType/xs:sequence/xs:element">
                        <li>
                            <b>
                                <xsl:value-of select="@ref"/>
                                <xsl:value-of select="@name"/>
                            </b>
                            <xsl:choose>
                                <xsl:when test="@minOccurs = '0'">: Optional</xsl:when>
                                <xsl:otherwise>: Required</xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="@maxOccurs &gt; '1'">, may repeat</xsl:if>
                        </li>
                    </xsl:for-each>
                    <li><b>At least one of: </b></li>
                    <ul>
                    <xsl:for-each select="./xs:complexType/xs:sequence/xs:choice/xs:element">
                        <li>
                            <b>
                                <xsl:value-of select="@ref"/>
                                <xsl:value-of select="@name"/>
                            </b>
                        </li>
                    </xsl:for-each>
                    </ul>
                    
                </ul>
                <xsl:for-each select="./xs:complexType/xs:sequence/xs:choice/xs:element">
                    <xsl:call-template name="elementDetails">
                        <xsl:with-param name="el" select="."/>
                    </xsl:call-template>
                </xsl:for-each>
                <xsl:for-each select="./xs:complexType/xs:sequence/xs:element">
                    <xsl:call-template name="elementDetails">
                        <xsl:with-param name="el" select="."/>
                    </xsl:call-template>
                </xsl:for-each>
                 <h2>Defined Types:</h2>
                <xsl:for-each select="/xs:schema/xs:complexType">
                    <xsl:apply-templates select="."/>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template name="elementDetails">
        <xsl:param name="el"/>
        <xsl:choose>
            <xsl:when test="$el/@ref">
                <xsl:variable name="elementRef" select="$el/@ref"/>
                <xsl:choose>
                    <xsl:when test="not(preceding::xs:element[@name=$elementRef])"> 
                        <xsl:apply-templates select="//xs:element[@name = $elementRef]"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <b>See: </b> <i><xsl:value-of select="$elementRef"/></i><br/>
                    </xsl:otherwise>
                </xsl:choose> 
            </xsl:when>
            <xsl:when test="$el/@type">
                <xsl:variable name="elementType" select="$el/@type"/>
                <xsl:choose>
                    <xsl:when test="not(preceding::xs:complexType[@name=$elementType])">
                        <xsl:apply-templates select="//xs:complexType[@name = $elementType]"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <b>See: </b> <i><xsl:value-of select="$elementType"/></i><br/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
       
    </xsl:template>
    
    <xsl:template match="xs:choice">
        <xsl:apply-templates select="./xs:element"/>
    </xsl:template>

    <xsl:template match="xs:element">
        <xsl:choose>
            <xsl:when test="./@name='Animal' or ./@name='GroupLot' or ./name='Product'">
                <h2>
                    <xsl:value-of select="./@name"/>
                </h2>
            </xsl:when>
            <xsl:otherwise>
                <h3>
                    <xsl:value-of select="./@name"/>
                </h3>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="./xs:annotation/xs:documentation"/>
        <xsl:if test="./@type and not(starts-with(./@type, 'xs:'))">
            <ul><li>See: <i> <xsl:value-of select="./@type"/></i></li></ul>
        </xsl:if>
        <xsl:if test="./xs:complexType/xs:attribute">
            <h4><i>Attributes</i></h4>
            <ul>
                <xsl:for-each select="./xs:complexType/xs:attribute">
                    <li>
                        <b>
                            <xsl:value-of select="@ref"/>
                            <xsl:value-of select="@name"/>
                        </b>
                        <xsl:choose>
                            <xsl:when test="@use = 'required'">: Required</xsl:when>
                            <xsl:otherwise>: Optional</xsl:otherwise>
                        </xsl:choose>
                        <xsl:variable name="varType" select="./@type"/>
                        <xsl:apply-templates select="//xs:simpleType[@name=$varType]"></xsl:apply-templates>
                        <xsl:apply-templates select="./xs:simpleType"/>
                    </li>
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="./xs:simpleType">
            <xsl:apply-templates select="./xs:simpleType"/>
        </xsl:if>
        <xsl:if
            test="
                ./xs:complexType/xs:sequence/xs:element[@name] or
                ./xs:complexType/xs:sequence/xs:element[@ref] or
                ./xs:complexType/xs:sequence/xs:choice">
            <h4><i>Child Elements</i></h4>
            <ul>
                <xsl:for-each
                    select="./xs:complexType/xs:sequence/xs:element | ./xs:complexType/xs:sequence/xs:choice">
                    <li>
                        <xsl:choose>
                            <xsl:when test="./@ref or ./@name">
                                <b>
                                    <xsl:value-of select="@ref"/>
                                    <xsl:value-of select="@name"/>
                                </b>
                                <xsl:choose>
                                    <xsl:when test="@minOccurs = '0'">: Optional</xsl:when>
                                    <xsl:otherwise>: Required</xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="@maxOccurs &gt; '1'">, may repeat</xsl:if>
                                <xsl:variable name="varType" select="./@type"/>
                                <xsl:apply-templates select="//xs:simpleType[@name=$varType]"></xsl:apply-templates>
                                <xsl:apply-templates select="./xs:simpleType"/>
                            </xsl:when>
                            <xsl:otherwise> Either: <ul>
                                    <xsl:for-each select="./xs:element">
                                        <li>
                                            <b><xsl:value-of select="@ref"/>
                                                <xsl:value-of select="@name"/></b>
                                            <xsl:choose>
                                                <xsl:when test="@minOccurs = '0'">: Optional</xsl:when>
                                                <xsl:otherwise>: Required</xsl:otherwise>
                                            </xsl:choose>
                                            <xsl:if test="@maxOccurs &gt; '1'">, may repeat</xsl:if>
                                        </li>
                                    </xsl:for-each>
                                </ul>
                            </xsl:otherwise>
                        </xsl:choose>
                    </li>
                </xsl:for-each>
            </ul>
            <xsl:for-each
                select="./xs:complexType/xs:sequence/xs:element | ./xs:complexType/xs:sequence/xs:choice/xs:element">
                <xsl:choose>
                    <xsl:when test="./@ref">
                        <xsl:variable name="elementRef" select="./@ref"/>
                        <xsl:choose>
                            <xsl:when test="not(preceding::xs:element[@name=$elementRef])"> 
                                <xsl:apply-templates select="//xs:element[@name = $elementRef]"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <b>See: </b> <i><xsl:value-of select="$elementRef"/></i><br/>
                            </xsl:otherwise>
                        </xsl:choose> 
                    </xsl:when>
                    <xsl:when test="./@type">
                        <xsl:variable name="elementType" select="./@type"/>
                        <xsl:choose>
                            <xsl:when test="not(preceding::xs:complexType[@name=$elementType])">
                                <xsl:apply-templates select="//xs:complexType[@name = $elementType]"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <b>See: </b> <i><xsl:value-of select="$elementType"/></i><br/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                </xsl:choose>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="xs:complexType">
        <h3>
            <xsl:value-of select="./@name"/>
        </h3>
        <xsl:apply-templates select="./xs:annotation/xs:documentation"/>
        <xsl:if test="./xs:attribute">
            <h4><i>Attributes</i></h4>
            <ul>
                <xsl:for-each select="./xs:attribute">
                    <li>
                        <b>
                            <xsl:value-of select="@ref"/>
                            <xsl:value-of select="@name"/>
                        </b>
                        <xsl:choose>
                            <xsl:when test="@use = 'required'">: Required</xsl:when>
                            <xsl:otherwise>: Optional</xsl:otherwise>
                        </xsl:choose>
                        <xsl:apply-templates select="./xs:annotation/xs:documentation"/>
                        <xsl:variable name="varType" select="./@type"/>
                        <xsl:apply-templates select="//xs:simpleType[@name=$varType]"></xsl:apply-templates>
                        <xsl:apply-templates select="./xs:simpleType"/>
                    </li>
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if
            test="
            ./xs:sequence/xs:element[@name] or
            ./xs:sequence/xs:element[@ref] or
            ./xs:sequence/xs:choice">
            <h4><i>Child Elements</i></h4>
            <ul>
                <xsl:for-each
                    select="./xs:sequence/xs:element | ./xs:sequence/xs:choice">
                    <li>
                        <xsl:choose>
                            <xsl:when test="./@ref or ./@name">
                                <b>
                                    <xsl:value-of select="@ref"/>
                                    <xsl:value-of select="@name"/>
                                </b>
                                <xsl:choose>
                                    <xsl:when test="@minOccurs = '0'">: Optional</xsl:when>
                                    <xsl:otherwise>: Required</xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="@maxOccurs &gt; '1'">, may repeat</xsl:if>
                                <xsl:variable name="varType" select="./@type"/>
                                <xsl:apply-templates select="//xs:simpleType[@name=$varType]"></xsl:apply-templates>
                                <xsl:apply-templates select="./xs:simpleType"/>
                            </xsl:when>
                            <xsl:otherwise> Either: <ul>
                                <xsl:for-each select="./xs:element">
                                    <li>
                                        <b><xsl:value-of select="@ref"/>
                                            <xsl:value-of select="@name"/></b>
                                        <xsl:choose>
                                            <xsl:when test="@minOccurs = '0'">: Optional</xsl:when>
                                            <xsl:otherwise>: Required</xsl:otherwise>
                                        </xsl:choose>
                                        <xsl:if test="@maxOccurs &gt; '1'">, may repeat</xsl:if>
                                    </li>
                                </xsl:for-each>
                            </ul>
                            </xsl:otherwise>
                        </xsl:choose>
                    </li>
                </xsl:for-each>
            </ul>
            <xsl:for-each
                select="./xs:sequence/xs:element | ./xs:sequence/xs:choice/xs:element">
                     <xsl:choose>
                        <xsl:when test="./@ref">
                            <xsl:variable name="elementRef" select="./@ref"/>
                                     <xsl:apply-templates select="//xs:element[@name = $elementRef]"/>
                        </xsl:when>
                        <xsl:when test="./@type">
                            <xsl:variable name="elementType" select="./@type"/>
                            <xsl:choose>
                                <xsl:when test="not(preceding::xs:complexType[@name=$elementType])">
                                    <xsl:apply-templates select="//xs:complexType[@name = $elementType]"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <b>See: </b> <i><xsl:value-of select="$elementType"/></i><br/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                    </xsl:choose>
            </xsl:for-each>
         </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="xs:simpleType">
        <br/><i><xsl:value-of select="./@name"/></i> 
        <xsl:apply-templates select="./xs:annotation/xs:documentation"/>
        <xsl:if test="./xs:restriction/xs:enumeration">
            Values:<ul>
                <xsl:for-each select="./xs:restriction/xs:enumeration">
                    <li>
                        <xsl:value-of select="./@value"/>
                        (<xsl:value-of select="./xs:annotation/xs:documentation"/>)
                    </li>
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="./xs:restriction/xs:pattern">
            Pattern(s):<ul>
                <xsl:for-each select="./xs:restriction/xs:pattern">
                    <li>
                        <xsl:value-of select="./@value"/>
                        <xsl:if test="./xs:annotation/xs:documentation">
                            (<xsl:value-of select="./xs:annotation/xs:documentation"/>)
                        </xsl:if>
                    </li>
                </xsl:for-each>
            </ul>
        </xsl:if>
    </xsl:template>

    <xsl:template match="xs:documentation">
        <blockquote>
            <xsl:value-of select="."/>
        </blockquote>
    </xsl:template>

</xsl:stylesheet>
