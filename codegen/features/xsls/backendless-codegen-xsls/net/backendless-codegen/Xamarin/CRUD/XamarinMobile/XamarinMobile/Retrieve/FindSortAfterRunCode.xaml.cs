using System;
using System.Collections.Generic;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace XamarinMobile
{
  [XamlCompilation( XamlCompilationOptions.Compile )]
  public partial class FindSortAfterRunCode : ContentPage
  {
    public FindSortAfterRunCode( String property, IList<Dictionary<String, Object>> listMaps )
    {
      InitializeComponent();
      field.Text = property + ": ";

      foreach( var entry in listMaps )
      {
        Label fieldValue = new Label();
        fieldValue.Text = entry[ property ].ToString();
        fieldValue.FontAttributes = FontAttributes.Italic;
        fieldValue.TextDecorations = TextDecorations.Underline;
        codeLog.Children.Add( fieldValue );
      }

      Content = mainStackLayout;
    }
  }
}