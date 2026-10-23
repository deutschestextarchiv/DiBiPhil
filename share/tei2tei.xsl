<?xml version="1.0" encoding="utf-8"?>
<!-- tei2tei.xsl -->
<!-- Version 1.0 -->
<!-- Andreas Nolda 2026-10-23 -->

<!-- This XSLT stylesheet adds a class code for the main text class, if missing. -->

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0">

<xsl:output method="xml"
            encoding="UTF-8"
            indent="yes"/>

<xsl:strip-space elements="*"/>

<xsl:preserve-space elements="tei:castItem
                              tei:head
                              tei:hi
                              tei:item
                              tei:l
                              tei:note
                              tei:p
                              tei:stage"/><!-- ... -->

<!-- parameters: -->

<!-- default main text class -->
<xsl:param name="text-class">Wissenschaft</xsl:param>

<!-- templates: -->

<!-- Copy elements by default. -->
<xsl:template match="*">
  <xsl:copy>
    <xsl:apply-templates select="* |
                                 @* |
                                 text()"/>
  </xsl:copy>
</xsl:template>

<!-- Copy attributes by default. -->
<xsl:template match="@*">
  <xsl:copy/>
</xsl:template>

<!-- Add class code for the main text class, if missing. -->
<xsl:template match="tei:textClass">
  <!-- preventing <xsl:copy> from copying namespaces to <availability> -->
  <xsl:element name="textClass"
               namespace="{namespace-uri()}">
    <xsl:apply-templates select="@*"/>
    <xsl:if test="not(tei:classCode[@scheme='http://www.deutschestextarchiv.de/doku/klassifikation#dwds1main'])">
      <!-- preventing <xsl:copy> from copying namespaces to <availability> -->
      <xsl:element name="classCode"
                   namespace="{namespace-uri()}">
        <xsl:attribute name="scheme">http://www.deutschestextarchiv.de/doku/klassifikation#dwds1main</xsl:attribute>
        <xsl:value-of select="$text-class"/>
      </xsl:element>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>
</xsl:stylesheet>
