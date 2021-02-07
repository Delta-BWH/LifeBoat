<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
    <!-- @formatter:off -->
    
    <xsl:param name="language"/>
    
    <xsl:include href="filesObjC.xsl"/>
    <xsl:include href="filesSwift.xsl"/>
    
    <xsl:template match="/">
      <xsl:if test="$language = 'Objective-C'">
        <xsl:call-template name="filesObjC"/>
      </xsl:if>
      <xsl:if test="$language = 'Swift'">
        <xsl:call-template name="filesSwift"/>
      </xsl:if>
    </xsl:template>
</xsl:stylesheet>