<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->

  <xsl:template name="crudNET">
    <folder name="{backendless-codegen/application/name}">
      <file path="backendless-codegen/NETCore/CRUD/CRUD.sln"/>
      <folder path="backendless-codegen/NETCore/CRUD/CRUD"/>
      <file name="CRUD/InitializerAPI.cs">
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
    </folder>
  </xsl:template>
</xsl:stylesheet>