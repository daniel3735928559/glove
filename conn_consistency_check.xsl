<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



  <xsl:template match="src">
    <xsl:variable name="modname" select="@mod" />
    <xsl:variable name="pinname" select="@pin" />
    <xsl:variable name="modtype" select="../../../module[@name=$modname]/@type" />
    <xsl:if test="count(../../../module[@name=$modname])+count(../../../../module_type[@type=$modtype]/out[@name=$pinname])=0">
      <xsl:if test="count(../../../in[@name=$modname and
		  @name=$pinname])=0">
	Hello <xsl:value-of select="$modtype" />.<xsl:value-of select="$modname" />.<xsl:value-of
	select="$pinname" /> in <xsl:value-of select="../../../@name" />.<xsl:value-of select="../../@name" />.<xsl:value-of select="../@target" />
	A <xsl:value-of select="count(../../../module[@name=$modname]/@name)" /> B <xsl:value-of select="count(../../../../module_type[@name=$modtype]/out[@name=$pinname])" />
	C <xsl:value-of select="count(../../../in[@name=$modname and @name=$pinname])" />
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates select="//src"/>
  </xsl:template>


</xsl:stylesheet>
<!--<xsl:for-each select="/chip/module_type[@name=$name]/out[@name=$outname]/conn">÷<xsl:for-each select="src"><xsl:value-of select="@mod"/>_<xsl:value-of select="@pin"/></xsl:for-each></xsl:for-each>-->
