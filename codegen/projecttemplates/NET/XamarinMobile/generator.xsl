<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->
  <xsl:template match="/">
    <folder name="{backendless-codegen/application/name}">
      <folder path="project-files/Backendless"/>
      <folder path="project-files/XamarinMobile"/>
      <file path="project-files/XamarinMobile.sln"/>
      <file name="XamarinMobile/XamarinMobile/InitializerAPI.cs">
using System;
using BackendlessAPI;
namespace XamarinMobile
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