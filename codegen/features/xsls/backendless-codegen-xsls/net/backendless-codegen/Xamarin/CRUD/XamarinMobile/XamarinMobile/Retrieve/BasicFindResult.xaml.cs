using System;
using System.Collections.Generic;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace XamarinMobile
{
  [XamlCompilation( XamlCompilationOptions.Compile )]
  public partial class BasicFindResult : ContentPage
  {
    public BasicFindResult( String visibleField, IList<Dictionary<String, Object>> objects )
    {
      InitializeComponent();

      foreach( var entry in objects )
      {
        Label fieldLabel = new Label();
        fieldLabel.Text = "\t" + entry[ visibleField ].ToString();
        fieldLabel.FontAttributes = FontAttributes.Italic;
        fieldLabel.TextDecorations = TextDecorations.Underline;
        codeLog.Children.Add( fieldLabel );
      }
      field.Text = visibleField + ": ";
      Content = mainStackLayout;
    }
  }
}