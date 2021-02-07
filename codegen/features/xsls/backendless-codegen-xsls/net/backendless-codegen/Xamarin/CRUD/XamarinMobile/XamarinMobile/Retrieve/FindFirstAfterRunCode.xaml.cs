using System;
using System.Collections.Generic;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace XamarinMobile
{
  [XamlCompilation( XamlCompilationOptions.Compile )]
  public partial class FindFirstAfterRunCode : ContentPage
  {
    public FindFirstAfterRunCode( Dictionary<String, Object> map )
    {
      InitializeComponent();

      foreach( KeyValuePair<String, Object> kvp in map )
      {
        Label label = new Label();
        label.Text = kvp.Key + ":\t" + kvp.Value;
        codeLog.Children.Add( label );
      }

      Content = mainStackLayout;
    }
  }
}