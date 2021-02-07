using System;
using System.Collections.Generic;
using System.Linq;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace XamarinMobile
{
  [XamlCompilation( XamlCompilationOptions.Compile )]
  public partial class Operations : ContentPage
  {
    public static String TableName { get; set; } 
    public Operations( String tableName )
    {
      TableName = tableName;
      InitializeComponent();
      mainLabel.Text = $"{TableName} table operations";
    }
    
    public Operations()
    {
      InitializeComponent();
    }

    public async void OperationCreate( Object sender, EventArgs ea )
    {
      await Navigation.PushModalAsync( new OperationCreate() );
    }

    public async void OperationRetrieve( Object sender, EventArgs ea )
    {
      await Navigation.PushModalAsync( new OperationRetrieve() );
    }

    public async void OperationUpdate( Object sender, EventArgs ea )
    {
      await Navigation.PushModalAsync( new OperationUpdate() );
    }

    public async void OperationDelete( Object sender, EventArgs ea )
    {
      await Navigation.PushModalAsync( new OperationDelete() );
    }
  }
}