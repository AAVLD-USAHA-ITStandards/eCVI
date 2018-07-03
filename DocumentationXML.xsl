<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:preserve-space elements="xs:documentation"/>
    <xsl:template match="/">
        <xsl:element name="ecvi2Documentation">
            <xsl:apply-templates select="//xs:documentation | //xs:enumeration"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="//xs:documentation">
        <xsl:element name="Item">
            <xsl:variable name="parent" select="name(../..)"/>
            <xsl:choose>
                <xsl:when test="contains($parent, 'xs:element')">
                    <xsl:element name="Element">
                        <xsl:value-of select="../../@name"/>
                    </xsl:element>
                </xsl:when>
                <xsl:when
                    test="contains($parent, 'xs:simpleType') or contains($parent, 'xs:complexType')">
                    <xsl:element name="Type">
                        <xsl:value-of select="../../@name"/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="contains($parent, 'xs:element')">
                    <xsl:element name="Element">
                        <xsl:value-of select="../../@name"/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="contains($parent, 'xs:attribute')">
                    <xsl:element name="Attribute">
                        <xsl:if test="../../../../@name">
                            <xsl:value-of select="../../../../@name"/>:</xsl:if>
                        <xsl:value-of select="../../@name"/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="contains($parent, 'xs:enumeration')">
                    <xsl:element name="Enumeration">
                        <xsl:value-of select="../../@value"/>
                    </xsl:element>
                </xsl:when>
            </xsl:choose>
            <xsl:element name="Description">
                <xsl:value-of select="."/>
            </xsl:element>
            <xsl:if
                test="../../xs:complexType/xs:sequence/xs:element[@ref] | ../../xs:complexType/xs:sequence/xs:element[@name]">
                <xsl:if test="contains($parent, 'xs:element')">
                    <xsl:element name="ChildElements">
                        <xsl:for-each
                            select="../../xs:complexType/xs:sequence/xs:element[@ref] | ../xs:complexType/xs:sequence/xs:element[@name]">
                            <xsl:element name="Child">
                                <xsl:attribute name="name">
                                    <xsl:value-of select="@ref"/>
                                    <xsl:value-of select="@name"/>
                                </xsl:attribute>
                                <xsl:attribute name="required">
                                    <xsl:choose>
                                        <xsl:when test="@minOccurs = '1'">Required</xsl:when>
                                        <xsl:otherwise>Optional</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                                <xsl:attribute name="repeat">
                                    <xsl:if test="@maxOccurs &gt; '1'">Repeats</xsl:if>
                                </xsl:attribute>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:if>
            </xsl:if>
            <xsl:if
                test="../../xs:complexType//xs:attribute ">
                <xsl:if test="contains($parent, 'xs:element')">
                    <xsl:element name="Attributes">
                        <xsl:for-each
                            select="../../xs:complexType/xs:attribute">
                            <xsl:element name="Attribute">
                                <xsl:attribute name="name">
                                    <xsl:value-of select="@ref"/>
                                    <xsl:value-of select="@name"/>
                                </xsl:attribute>
                                <xsl:attribute name="required">
                                    <xsl:choose>
                                        <xsl:when test="@use = 'required'">Required</xsl:when>
                                        <xsl:otherwise>Optional</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:if>
            </xsl:if>
            
            <!-- Complex Type is one less layer than Element -->
            <xsl:if
                test="../../xs:sequence/xs:element[@ref] or ../../xs:sequence/xs:element[@name]">
                <xsl:if test="contains($parent, 'xs:complexType')">
                    <xsl:element name="ChildElements">
                        <xsl:for-each
                            select="../../xs:sequence/xs:element[@name] | ../../xs:sequence/xs:element[@ref]">
                            <xsl:element name="Child">
                                <xsl:attribute name="name">
                                    <xsl:value-of select="@name"/>
                                    <xsl:value-of select="@ref"/>
                                </xsl:attribute>
                                <xsl:attribute name="required">
                                    <xsl:choose>
                                        <xsl:when test="@minOccurs = '1'">Required</xsl:when>
                                        <xsl:otherwise>Optional</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                                <xsl:attribute name="repeat">
                                    <xsl:if test="@maxOccurs &gt; '1'">Repeats</xsl:if>
                                </xsl:attribute>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:if>
            </xsl:if>
            <xsl:if
                test="../../xs:attribute ">
                <xsl:if test="contains($parent, 'xs:complexType')">
                    <xsl:element name="Attributes">
                        <xsl:for-each
                            select="../../xs:attribute">
                            <xsl:element name="Attribute">
                                <xsl:attribute name="name">
                                    <xsl:value-of select="@ref"/>
                                    <xsl:value-of select="@name"/>
                                </xsl:attribute>
                                <xsl:attribute name="required">
                                    <xsl:choose>
                                        <xsl:when test="@use = 'required'">Required</xsl:when>
                                        <xsl:otherwise>Optional</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:if>
            </xsl:if>
            
        </xsl:element>
    </xsl:template>



    <xsl:template match="xs:enumeration">
        <xsl:if test="not(./xs:annotation)">
            <xsl:element name="Item">
                <xsl:element name="Enumeration">
                    <xsl:value-of select="./@value"/>
                </xsl:element>
            </xsl:element>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
