<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->
  <xsl:variable name="tableNames" select="backendless-codegen/application/tables/name"/>
  <xsl:variable name="tables" select="backendless-codegen/application/tables"/>
  
  <xsl:template name="crudXam">
    <folder name="{backendless-codegen/application/name}-CRUD">
      <file path="backendless-codegen/Xamarin/CRUD/CRUD.sln"/>
      <folder name="XamarinMobile">
        <folder path="backendless-codegen/Xamarin/CRUD/XamarinMobile/XamarinMobile"/>
        <folder path="backendless-codegen/Xamarin/CRUD/XamarinMobile/XamarinMobile.Android"/>
        <folder path="backendless-codegen/Xamarin/CRUD/XamarinMobile/XamarinMobile.iOS"/>
        <folder path="backendless-codegen/Xamarin/CRUD/XamarinMobile/Backendless.NET.Standard20"/>
        <file name="XamarinMobile/InitializerAPI.cs">
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
        <file name="XamarinMobile/MainPage.xaml">&lt;?xml version="1.0" encoding="utf-8" ?&gt;
&lt;ContentPage xmlns="http://xamarin.com/schemas/2014/forms"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             xmlns:d="http://xamarin.com/schemas/2014/forms/design"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
             mc:Ignorable="d"
             x:Class="XamarinMobile.MainPage"&gt;
    &lt;ContentPage.Content&gt;
        &lt;StackLayout Padding="12,40,12,12"&gt;
            <!-- Place new controls here -->
            &lt;Label Text="Choose Table" 
               FontSize="24"
               FontAttributes="Bold"
               HorizontalOptions="Center"
               TextColor="Green"/&gt;
            &lt;ScrollView&gt;
                &lt;StackLayout x:Name="StackInScroll"/&gt;
            &lt;/ScrollView&gt;
        &lt;/StackLayout&gt;
    &lt;/ContentPage.Content&gt;
&lt;/ContentPage&gt;
        </file>
        <file name="XamarinMobile/MainPage.xaml.cs">
using System;
using System.ComponentModel;
using System.Linq;
using Xamarin.Forms;

namespace XamarinMobile
{
  [DesignTimeVisible( false )]
  public partial class MainPage : ContentPage
  {
    public MainPage()
    {
      InitializerAPI.InitializeAPI();
      InitializeComponent();

      String[] tables = new String[]{ <xsl:for-each select="$tables/table[name != 'Users']"><xsl:if test="position() > 1" >, </xsl:if>"<xsl:value-of select="name"/>"</xsl:for-each> };

      for( int i = 0; i &lt; tables.ToList().Count; i++ )
      {
        Button buttonWithTableName = new Button
        {
          Text = tables[ i ]
        };
        buttonWithTableName.Clicked += async ( sender, args ) =&gt; await Navigation.PushModalAsync( new Operations( buttonWithTableName.Text ) );

        StackInScroll.Children.Add( buttonWithTableName );
      }
    }
  }
}
        </file>
      </folder>
    </folder>
  </xsl:template>
</xsl:stylesheet>