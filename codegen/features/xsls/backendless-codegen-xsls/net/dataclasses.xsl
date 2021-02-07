   <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <!-- @formatter:off -->
    
    <xsl:param name="language"/>
    
    <xsl:include href="dataNET.xsl"/>

    <xsl:template match="/">
      <xsl:if test="$language = '.NET Core'">
        <xsl:call-template name="dataNET"/>
      </xsl:if>
    </xsl:template>
</xsl:stylesheet>