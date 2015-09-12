<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:key name="sID" match="src" use="concat(@mod,'_',@pin)" />

  <xsl:template name="create_reg">
    <xsl:param name="name" />
    <xsl:param name="pos" />
    <xsl:param name="w" />
    <in width="{$w}" x="100" y="{50*$pos+250}" name="{$name}_in" />
    <xsl:text>
    </xsl:text>
    <module type="pipeline_reg" name="{$name}_reg" y="{50*$pos+250}" x="300" param="{$w}">
      <conn target="stall"><src mod="stall" pin="stall" /></conn>
      <conn target="flush"><src mod="flush" pin="flush" /></conn>
      <conn target="clk"><src mod="clk" pin="clk" /></conn>
      <conn target="rst"><src mod="rst" pin="rst" /></conn>
      <conn target="d"><src mod="{$name}_in" pin="{$name}_in" /></conn>
    </module>
    <xsl:text>
    </xsl:text>
    <out width="{$w}" x="500" y="{50*$pos+250}" name="{$name}_out"><conn target="{$name}_out"><src pin="q" mod="{$name}_reg" /></conn></out>
    <xsl:text>
    </xsl:text>
  </xsl:template>
  

  <xsl:template match="src">
    <xsl:choose>
      <xsl:when test="../../../@name='Chip' and ../../@name!='fetch0' and @pin!='clk' and @pin!='rst'">
	<xsl:variable name="mn" select="../../@name" />
	<xsl:variable name="damod" select="@mod" />
	<xsl:choose>
	  <xsl:when test="count(../../../module[@name=$mn]/preceding-sibling::module[@name=$damod]) != 0">
	    <src mod="{../../../module[@name=$mn]/preceding-sibling::module[1]/@name}_bank0" pin="{@pin}_out" />
	  </xsl:when>
	  <xsl:otherwise>
	    <src mod="{@mod}_bank0" pin="{@pin}_out" />
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:when>
      <xsl:otherwise><xsl:copy><xsl:apply-templates select="@*|node()" /></xsl:copy></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="module_type">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
      <xsl:if test="@name='Chip'">
	<xsl:for-each select="module">
	  <xsl:variable name="curtype" select="@type" />
	  <xsl:variable name="curmod" select="@name" />
	  <module type="{@name}_bank" name="{@name}_bank0" x="{position()*200+200}" y="200">
	    <!--Connect clk and rst-->
	    <conn target="clk"><src mod="clk" pin="clk" /></conn>
	    <conn target="rst"><src mod="rst" pin="rst" /></conn>
	    <!--Connect up the outputs of this module to the inputs of the bank-->
	    <xsl:for-each select="/chip/module_type[@name=$curtype]/out">
	      <conn target="{@name}_in"><src mod="{$curmod}" pin="{@name}" /></conn>
	    </xsl:for-each>
	    <!--Now connect any regs that span this bank-->
	    <xsl:for-each select="preceding-sibling::module">
	      <xsl:variable name="pn" select="@name" />
	      <xsl:for-each select="../module[@name=$curmod]/following-sibling::module//src[@mod=$pn]">
		<xsl:if test="generate-id(.)=generate-id(key('sID',concat(@mod,'_',@pin))[last()])">
		  <conn target="{@pin}_in">
		    <src mod="{../../../module[@name=$curmod]/preceding-sibling::module[1]/@name}_bank0" pin="{@pin}_out" />
		  </conn>
		  <xsl:value-of select="concat($curmod,',p=',$pn,',n=',../../@name,': ',@mod,'_',@pin,' ')" />
		</xsl:if>
	      </xsl:for-each>
	    </xsl:for-each>

	  </module>
	</xsl:for-each>
      </xsl:if>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="chip">
    <chip>
      <module_type name="pipeline_reg">
	<in name="stall" width="1" x="100" y="150" />
	<in name="flush" width="1" x="100" y="200" />
	<in name="clk" width="1" x="100" y="250" />
	<in name="rst" width="1" x="100" y="300" />
	<in name="d" width="0" x="100" y="350" />
	<out name="q" width="0" x="500" y="150" />
      </module_type>
    <!--For every module in Chip, create an egreess pipeline register bank module type with one register per output-->
    <!--pipeline_reg #(WIDTH) (stall, flush, d, q, clk, rst)-->
    <xsl:for-each select="module_type[@name='Chip']/module">
      <xsl:variable name="curmod"><xsl:value-of select="@name" /></xsl:variable>
      <xsl:variable name="curtype"><xsl:value-of select="@type" /></xsl:variable>
      <xsl:text>
      </xsl:text>
      <module_type name="{@name}_bank">
	<in name="clk" width="1" x="100" y="150" />
	<in name="rst" width="1" x="100" y="200" />
	<in name="stall" width="1" x="100" y="250" />
	<in name="flush" width="1" x="100" y="250" />
	<!--For each output of this stage, create a pipeline register-->
	<xsl:for-each select="/chip/module_type[@name=$curtype]/out">
	  <xsl:call-template name="create_reg" >
	    <xsl:with-param name="pos" select="position()" />
	    <xsl:with-param name="name" select="@name" />
	    <xsl:with-param name="w" select="@width" />
	  </xsl:call-template>
	</xsl:for-each>
	<xsl:text>
	</xsl:text>
	<!--Now for any connection that properly spans this stage,
	    create a pipeline register for it as well called
	    {$key}_reg, taking care to avoid duplicates using the key
	    function-->
	<xsl:for-each select="preceding-sibling::module">
	  <xsl:variable name="pn" select="@name" />
	  <xsl:variable name="pt" select="@type" />
	  <xsl:for-each select="../module[@name=$curmod]/following-sibling::module//src[@mod=$pn]">
	    <xsl:if test="generate-id(.)=generate-id(key('sID',concat(@mod,'_',@pin))[last()])">
	      <xsl:variable name="spin" select="@pin" />
	      <!--<xsl:value-of select="concat($curmod,',p=',$pn,',n=',../../@name,': ',@mod,'_',@pin,'  ')" />-->
	      <xsl:call-template name="create_reg" >
		<xsl:with-param name="pos" select="position()" />
		<xsl:with-param name="name" select="@pin" />
		<xsl:with-param name="w" select="/chip/module_type[@name=$pt]/out[@name=$spin]/@width" />
	      </xsl:call-template>
	    </xsl:if>
	  </xsl:for-each>
	</xsl:for-each>
      <xsl:text>
      </xsl:text>
      </module_type>
    </xsl:for-each>
    <xsl:apply-templates />
    </chip>
  </xsl:template>

  <xsl:template match="@*|node()"><xsl:copy><xsl:apply-templates select="@*|node()"/></xsl:copy></xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates />
  </xsl:template>

</xsl:stylesheet>
