<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/"
  xmlns:f="http://github.com/kosek/gc/xslt"
  exclude-result-prefixes="xs math f"
  expand-text="yes"
  version="3.0">

  <!-- Regular expression for selecting specific columns from a code list -->
  <!-- If you want to show only specific columns use their IDs as a parameter, separated by | -->
  <!-- e.g. name|code|description -->
  <xsl:param name="columns">.*</xsl:param>
  
  <xsl:output method="text"/>
  
  <xsl:function name="f:normalize-value" as="xs:string?">
    <xsl:param name="text" as="xs:string?"/>
    
    <xsl:sequence select="normalize-space($text) => replace('\|', '&amp;#124;')"/>
  </xsl:function>
  
  <xsl:template match="/">
    <xsl:param name="cols" select="/gc:CodeList/ColumnSet/Column[matches(@Id, $columns)]"/>

    <xsl:text># </xsl:text>{f:normalize-value(/gc:CodeList/Identification/ShortName)}
    <xsl:text>&#xA;</xsl:text>     
   
    <xsl:for-each select="/gc:CodeList/Identification/LongName">
      <xsl:value-of select="f:normalize-value(.)"/>
      <xsl:text>&#xA;</xsl:text>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
        
    <xsl:for-each select="$cols">
      <xsl:text>|</xsl:text>
      <xsl:value-of select="f:normalize-value(ShortName)"/>
    </xsl:for-each>
    <xsl:text>|</xsl:text>
    <xsl:text>&#xA;</xsl:text>

    <xsl:for-each select="$cols">
      <xsl:text>|---</xsl:text>
    </xsl:for-each>
    <xsl:text>|</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    
    <xsl:for-each select="/gc:CodeList/SimpleCodeList/Row">
      <xsl:variable name="row" select="."/>
      <xsl:for-each select="$cols">
        <xsl:variable name="colId" select="@Id"/>
        <xsl:text>|</xsl:text>
        <xsl:value-of select="f:normalize-value($row/Value[@ColumnRef=$colId]/SimpleValue)"/>
      </xsl:for-each>
      <xsl:text>|</xsl:text>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>