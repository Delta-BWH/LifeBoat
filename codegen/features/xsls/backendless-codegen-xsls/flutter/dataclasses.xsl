<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- @formatter:off -->

  <xsl:import href="../util.xsl"/>

  <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>

  <xsl:template match="/">
    <folder  hideContent="true" name="{$applicationName}-Data">
      <folder  hideContent="true" name="Classes">

        <xsl:for-each select="backendless-codegen/application/tables/table[name != 'Users']">
          <!-- .dart file for each table -->
          <file  hideContent="true" name="{name}.dart">
import 'package:backendless_sdk/backendless_sdk.dart';

class <xsl:value-of select="name"/> {

  <xsl:for-each select="columns"><xsl:if test="not(expression)"><xsl:call-template name="getDartType"><xsl:with-param name="str" select="dataType"/></xsl:call-template><xsl:text> </xsl:text><xsl:value-of select="name"/>;
  </xsl:if></xsl:for-each>

  <xsl:for-each select="relations">
    <xsl:variable name="toTableName" select="toTableName"/>
    <xsl:choose>
      <xsl:when test="relationshipType = 'ONE_TO_ONE'">
        <xsl:choose>
          <xsl:when test="$toTableName = 'Users'">
  BackendlessUser<xsl:text> </xsl:text><xsl:value-of select="name"/>;</xsl:when>
          <xsl:otherwise>
  <xsl:value-of select="$toTableName"/><xsl:text> </xsl:text><xsl:value-of select="name"/>;
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="relationshipType = 'ONE_TO_MANY'">
  List<xsl:text> </xsl:text><xsl:value-of select="name"/>;</xsl:when>
    </xsl:choose>
  </xsl:for-each>
  <xsl:for-each select="geoRelations">
    <xsl:choose>
      <xsl:when test="relationshipType = 'ONE_TO_ONE'">
  GeoPoint<xsl:text> </xsl:text><xsl:value-of select="name"/>;</xsl:when>
      <xsl:when test="relationshipType = 'ONE_TO_MANY'">
  List<xsl:text> </xsl:text><xsl:value-of select="name"/>;</xsl:when>
    </xsl:choose>
  </xsl:for-each>
}
          </file>
        </xsl:for-each>
      </folder>
    </folder>
  </xsl:template>
</xsl:stylesheet>