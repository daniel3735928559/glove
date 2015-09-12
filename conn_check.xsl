<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="module | in">
    <xsl:variable name="curtype" select="../@name" />
    <xsl:variable name="mytype" select="@type" />
    <xsl:variable name="myname" select="@name" />
    <xsl:for-each select="//module_type[@name=$mytype]/out">
      <xsl:variable name="outname" select="@name" />
      <xsl:if test="count(//module_type[@name=$curtype]//src[@mod=$myname and @pin=$outname])=0">
	Dangling output: <xsl:value-of select="$mytype" />.<xsl:value-of select="$myname" />.<xsl:value-of select="@name" />
      </xsl:if>
    </xsl:for-each>
    <xsl:for-each select="//module_type[@name=$mytype]/in">
      <xsl:variable name="inname" select="@name" />
      <!--<xsl:value-of select="$inname" />-->

      <xsl:if test="count(//module_type[@name=$curtype]/module[@name=$myname]/conn[@target=$inname])=0">
	Dangling input: <xsl:value-of select="$curtype" />.<xsl:value-of select="$myname" />.<xsl:value-of select="@name" />
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates select="//module | //in"/>
  </xsl:template>


</xsl:stylesheet>
<!--<xsl:for-each select="/chip/module_type[@name=$name]/out[@name=$outname]/conn">÷<xsl:for-each select="src"><xsl:value-of select="@mod"/>_<xsl:value-of select="@pin"/></xsl:for-each></xsl:for-each>-->
