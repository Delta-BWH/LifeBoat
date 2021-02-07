 <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <!-- @formatter:off -->
    
    <xsl:param name="language"/>
    
    <xsl:include href="dataclassesObjC.xsl"/>
    <xsl:include href="dataclassesSwift.xsl"/>

    <xsl:template match="/">
      <xsl:if test="$language = 'Objective-C'">
        <xsl:call-template name="dataclassesObjC"/>
      </xsl:if>
      <xsl:if test="$language = 'Swift'">
        <xsl:call-template name="dataclassesSwift"/>
      </xsl:if>
    </xsl:template>
</xsl:stylesheet>