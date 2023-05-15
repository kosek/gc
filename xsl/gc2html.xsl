<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/"
  exclude-result-prefixes="xs math"
  expand-text="yes"
  version="3.0">

  <!-- Regular expression for selecting specific columns from a code list -->
  <!-- If you want to show only specific columns use their IDs as a parameter, separated by | -->
  <!-- e.g. name|code|description -->
  <xsl:param name="columns">.*</xsl:param>
  
  <xsl:template match="/">
    <xsl:param name="cols" select="/gc:CodeList/ColumnSet/Column[matches(@Id, $columns)]"/>

    <html>
      <head>
        <title>{/gc:CodeList/Identification/ShortName}</title>
      </head>
      <body>
        <h1>{/gc:CodeList/Identification/ShortName}</h1>
        
        <xsl:for-each select="/gc:CodeList/Identification/LongName">
          <p>{.}</p>  
        </xsl:for-each>
        
        <table border="1">
          <thead>
            <tr>
              <xsl:for-each select="$cols">
                <th title="{LongName}">
                  {ShortName}
                </th>
              </xsl:for-each>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="/gc:CodeList/SimpleCodeList/Row">
              <xsl:variable name="row" select="."/>
              <tr>
                <xsl:for-each select="$cols">
                  <xsl:variable name="colId" select="@Id"/>
                  <td>
                    <xsl:value-of select="$row/Value[@ColumnRef=$colId]/SimpleValue"/>
                  </td>
                </xsl:for-each>
              </tr>
            </xsl:for-each>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>
  
</xsl:stylesheet>