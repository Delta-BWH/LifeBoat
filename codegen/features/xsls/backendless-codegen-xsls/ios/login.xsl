 <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
    <!-- @formatter:off -->
    
    <xsl:param name="language"/>
    
    <xsl:include href="loginObjC.xsl"/>
    <xsl:include href="loginSwift.xsl"/>
    
    <xsl:template match="/">
      <xsl:if test="$language = 'Objective-C'">
        <xsl:call-template name="loginObjC"/>
      </xsl:if>
      <xsl:if test="$language = 'Swift'">
        <xsl:call-template name="loginSwift"/>
      </xsl:if>
    </xsl:template>
</xsl:stylesheet>