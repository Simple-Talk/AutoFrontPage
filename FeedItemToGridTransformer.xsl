<?xml version="1.0"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:template match="Object">
    <div class="span4" style="margin-right: 10px;">
      <div class="item-box">
        <xsl:apply-templates select="Property[@Name='Feed']" />
        <xsl:apply-templates select="Property[@Name='Title']" />
        <xsl:apply-templates select="Property[@Name='Description']" />
        <xsl:apply-templates select="Property[@Name='author']" />
        <xsl:apply-templates select="Property[@Name='PubDate']" />
      </div>
    </div>
  </xsl:template>

  <xsl:template match="Property[@Name='Feed']">
    <div class="item-header-bar">
      <xsl:value-of select="." disable-output-escaping="yes"/>
    </div>
  </xsl:template>

  <xsl:template match="Property[@Name='Title']">
    <div class="item-title">
      <a>
        <xsl:attribute name="href">
          <xsl:value-of select="../Property[@Name='link']"  disable-output-escaping="yes"/>
        </xsl:attribute>
        <xsl:value-of select="." />
      </a>
    </div>
  </xsl:template>

  <xsl:template match="Property[@Name='Description']">
    <div class="item-content">
      <xsl:value-of select="substring(.,0,150)" disable-output-escaping="yes" /> ...
    </div>
  </xsl:template>

  <xsl:template match="Property[@Name='author']">
    <xsl:if test=". != ''">
      <div class="item-author">
        by <xsl:value-of select="." disable-output-escaping="yes" />
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="Property[@Name='PubDate']">
    <div class="item-date">
      <xsl:value-of select="." disable-output-escaping="yes" />
    </div>
  </xsl:template>
  
</xsl:stylesheet>