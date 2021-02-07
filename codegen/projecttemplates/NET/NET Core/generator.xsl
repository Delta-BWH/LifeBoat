<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->

  <xsl:template match="/">
    <folder name="{backendless-codegen/application/name}">
      <folder path="project-files/Comand Prompt .NET Standard 2.0"/>
      <file path="project-files/Comand Prompt .NET Standard 2.0.sln"/>
      <file name="Comand Prompt .NET Standard 2.0/InitializerAPI.cs">
using System;
using BackendlessAPI;

namespace Comand_Prompt_.NET_Standard_2._0
{
  internal static class InitializerAPI
  {
    public const String BKNDLSS_URL = "<xsl:value-of select="backendless-codegen/application/serverURL"/>";
    public const String APP_API_KEY = "<xsl:value-of select="backendless-codegen/application/id"/>";
    public const String DOTNET_API_KEY = "<xsl:value-of select="backendless-codegen/application/apiKeys/WP"/>";

    public static void InitAPI()
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