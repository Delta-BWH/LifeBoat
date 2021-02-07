  <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->

  <xsl:template name="sfmXam">
    <folder name="{backendless-codegen/application/name}-SFM">
      <file path="backendless-codegen/Xamarin/SFM/SampleFileManager.sln"/>
      <folder name="SampleFileManager">
        <folder path="backendless-codegen/Xamarin/SFM/SampleFileManager/SampleFileManager"/>
        <folder path="backendless-codegen/Xamarin/SFM/SampleFileManager/SampleFileManager.Android"/>
        <folder path="backendless-codegen/Xamarin/SFM/SampleFileManager/SampleFileManager.iOS"/>
        <folder path="backendless-codegen/Xamarin/SFM/SampleFileManager/Backendless.NET.Standard20"/>
        <file name="SampleFileManager/InitializerAPI.cs">
using System;
using BackendlessAPI;

namespace SampleFileManager
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
    </folder>
  </xsl:template>
</xsl:stylesheet>