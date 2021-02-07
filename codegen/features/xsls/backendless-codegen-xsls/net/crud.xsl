  <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
  <!-- @formatter:off -->
    
  <xsl:param name="language"/>
  
  <xsl:include href="crudXam.xsl"/>
  <xsl:include href="crudNET.xsl"/>

  <xsl:template match="/">
    <xsl:if test="$language = '.NET Core'">
      <xsl:call-template name="crudNET"/>
    </xsl:if>
    <xsl:if test="$language = 'Xamarin Forms'">
      <xsl:call-template name="crudXam"/>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>