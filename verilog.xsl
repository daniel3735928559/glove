<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="conn/text()">
    <xsl:value-of select="translate(string(.),' &#x9;&#xD;&#xA;', '')" />
  </xsl:template>

  <xsl:template match="module">
    <xsl:variable name="modname" select="@name" />
    <xsl:variable name="curtype" select="../@name" />
    <xsl:variable name="modtype" select="@type" />
    <xsl:variable name="modparam" select="@param" />
    <xsl:text>
    </xsl:text>
    <xsl:value-of select="@type" /><xsl:text> </xsl:text><xsl:if test="@param and @param!=''">#(<xsl:value-of select="@param" />)</xsl:if><xsl:text> </xsl:text>
    <xsl:value-of select="@name" />(
    <!--set up the input pins-->
    <xsl:text>//Inputs
    </xsl:text>
    <!--Iterate through connections - how are handling connections generated from <in> on the module tag?-->
    <xsl:for-each select="/chip/module_type[@name=$modtype]/in"><xsl:variable name="pinname" select="@name"/>.<xsl:value-of select="$pinname"/>(<xsl:for-each select="/chip/module_type[@name=$curtype]/module[@name=$modname]/conn[@target=$pinname]"><xsl:apply-templates/></xsl:for-each>)<xsl:text>,
    </xsl:text>
    </xsl:for-each>
    <!--set up the output pins-->
    <xsl:text>//Outputs
    </xsl:text>
    <xsl:for-each select="/chip/module_type[@name=$modtype]/out">.<xsl:value-of select="@name"/>(<xsl:value-of select="$modname"/>_<xsl:value-of select="@name"/>)<xsl:if test="position() != last()"><xsl:text>,
    </xsl:text></xsl:if></xsl:for-each>);
  </xsl:template>

  <xsl:template match="src">
    <xsl:variable name="mod" select="@mod"/><xsl:variable name="pin" select="@pin"/><xsl:if test="$mod != $pin"><xsl:value-of select="@mod"/>_</xsl:if><xsl:value-of select="@pin"/>
  </xsl:template>

  <xsl:template match="module_type">
    <xsl:variable name="name" select="@name" />
    <xsl:text>// ----</xsl:text><xsl:value-of select="@name" />.v----
    <xsl:text>module </xsl:text><xsl:value-of select="@name" />(<xsl:for-each select="./in"><xsl:value-of select="@name" />,</xsl:for-each><xsl:for-each select="./out"><xsl:value-of select="@name" /><xsl:if test="position() != last()">,</xsl:if></xsl:for-each>);
    <!--Generate the inputs-->
    <xsl:for-each select="./in">input <xsl:if test="@width != 1">[<xsl:variable name="w" select="@width" /><xsl:value-of select="$w - 1" />:0] </xsl:if><xsl:value-of select="@name" />;<xsl:text>
    </xsl:text></xsl:for-each>
    <!--Generate the outputs-->
    <xsl:for-each select="./out">output <xsl:if test="@width != 1">[<xsl:variable name="w" select="@width" /><xsl:value-of select="$w - 1" />:0] </xsl:if><xsl:value-of select="@name" />;<xsl:text>
    </xsl:text></xsl:for-each>
    <!--Generate the wires - iterating overall outputs of all modules and creating a wire-->
    <xsl:for-each select="/chip/module_type[@name=$name]/module"><xsl:variable name="daparam" select="@param"/><xsl:variable name="modname" select="@name"/><xsl:variable name="modtype" select="@type"/><xsl:for-each select="/chip/module_type[@name=$modtype]/out"><xsl:variable name="w"><xsl:choose><xsl:when test="@width='0'"><xsl:value-of select="$daparam"/></xsl:when><xsl:otherwise><xsl:value-of select="@width"/></xsl:otherwise></xsl:choose></xsl:variable>wire <xsl:if test="$w != 1">[<xsl:value-of select="$w - 1" />:0] </xsl:if><xsl:value-of select="$modname"/>_<xsl:value-of select="@name"/><xsl:text>;
    </xsl:text></xsl:for-each></xsl:for-each>

    <!--Generate the modules-->    
    <xsl:apply-templates select="module"/>
    <!--Handle Outputs-->
    <xsl:for-each select="./out">
      <xsl:variable name="outname" select="@name" />
    assign <xsl:value-of select="@name" /> = <xsl:for-each select="/chip/module_type[@name=$name]/out[@name=$outname]/conn"><xsl:apply-templates/></xsl:for-each>;</xsl:for-each>

    endmodule
  </xsl:template>

  <xsl:template match="chip">
    <xsl:apply-templates select="module_type"/>
  </xsl:template>


</xsl:stylesheet>
<!--<xsl:for-each select="/chip/module_type[@name=$name]/out[@name=$outname]/conn">÷<xsl:for-each select="src"><xsl:value-of select="@mod"/>_<xsl:value-of select="@pin"/></xsl:for-each></xsl:for-each>-->
