 <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->
  <xsl:import href="../util.xsl"/>
  <xsl:template name="dataNET">
    <folder name="{backendless-codegen/application/name}">
      <file path="backendless-codegen/NETCore/Dataclasses/Dataclasses.sln"/>
      <folder path="backendless-codegen/NETCore/Dataclasses/Dataclasses"/>
      <file name="Dataclasses/InitializerAPI.cs">
using System;
using BackendlessAPI;

namespace CRUD
{
  public class InitializerAPI
  {
    internal const String APP_API_KEY = "<xsl:value-of select="backendless-codegen/application/id"/>";
    internal const String DOTNET_API_KEY = "<xsl:value-of select="backendless-codegen/application/apiKeys/WP"/>";
    internal const String BKNDLSS_URL = "<xsl:value-of select="backendless-codegen/application/serverURL"/>";
    public static void InitializeAPI()
    {
      Backendless.URL = BKNDLSS_URL;
      Backendless.InitApp( APP_API_KEY, DOTNET_API_KEY );
    }
  }
}
      </file>
      <xsl:for-each select="backendless-codegen/application/tables/table[name != 'Users']">
        <file name="Dataclasses/{name}.cs">using System;
using System.Text;
using System.Collections.Generic;
using BackendlessAPI.Persistence;

namespace Dataclasses
{
  public class <xsl:value-of select="name"/>
  {
    <xsl:for-each select="columns"><xsl:if test="not(expression)">public <xsl:call-template name="GetTypeNET"><xsl:with-param name="str" select="dataType"/></xsl:call-template><xsl:text> </xsl:text><xsl:value-of select="name"/>{ get; set; }
    </xsl:if></xsl:for-each>
    
    <xsl:for-each select="columns"><xsl:if test="(expression)">private <xsl:call-template name="GetTypeNET"><xsl:with-param name="str" select="dataType"/></xsl:call-template><xsl:text> </xsl:text><xsl:value-of select="name"/>{ get; set; }
    </xsl:if></xsl:for-each>

                  <xsl:for-each select="relations">
                    <xsl:variable name="toTableName" select="toTableName"/>
                      <xsl:choose>
                        <xsl:when test="relationshipType = 'ONE_TO_ONE'">
                          <xsl:choose>
                            <xsl:when test="$toTableName = 'Users'">
    public BackendlessUser <xsl:value-of select="name"/>{ get; set; } </xsl:when>
                            <xsl:otherwise>
    public <xsl:value-of select="$toTableName"/><xsl:text> </xsl:text><xsl:value-of select="name"/>{ get; set; }
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:when>
                        <xsl:when test="relationshipType = 'ONE_TO_MANY'">
    public [Any] <xsl:value-of select="name"/>{ get; set; }</xsl:when>
                    </xsl:choose>
                  </xsl:for-each>  
                  <xsl:for-each select="geoRelations">
                  <xsl:choose>
                    <xsl:when test="relationshipType = 'ONE_TO_ONE'">
    public  GeoPoint <xsl:value-of select="name"/>{ get; set; }</xsl:when>
                    <xsl:when test="relationshipType = 'ONE_TO_MANY'">
    public [Any] <xsl:value-of select="name"/>{ get; set; }</xsl:when>
                  </xsl:choose>
                </xsl:for-each>
  }
}
        </file>
      </xsl:for-each>
    </folder>
  </xsl:template>
</xsl:stylesheet>