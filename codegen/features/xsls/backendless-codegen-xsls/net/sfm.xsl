  <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <!-- @formatter:off -->
    
    <xsl:param name="language"/>
    
    <xsl:include href="sfmXam.xsl"/>

    <xsl:template match="/">
      <xsl:if test="$language = 'Xamarin Forms'">
        <xsl:call-template name="sfmXam"/>
      </xsl:if>
    </xsl:template>
</xsl:stylesheet>