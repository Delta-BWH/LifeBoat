using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using BackendlessAPI;
using BackendlessAPI.Async;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace XamarinMobile
{
  [XamlCompilation( XamlCompilationOptions.Compile )]
  public partial class OperationDelete : ContentPage
  {
    public OperationDelete()
    {
      InitializeComponent();
      Label textCode = new Label();
      textCode.Text = $"Backendless.Data.Of(\"{Operations.TableName}\").FindFirst( new AsyncCallback<Dictionary<String, Object>>(\n" +
                      "savedObj =>\n" +
                      "{\n" +
                      "\ttry\n" +
                      "\t{\n" +
                      $"Backendless.Data.Of(\"{Operations.TableName}\").Remove( savedObj );\n" +
                      "\t\tDevice.InvokeOnMainThreadAsync(() =>\n" +
                      "\t\t{\n" +
                      "\t\t\tDisplayAlert(\"Success\", \"The record has been updated\", \"Ok\");\n" +
                      "\t\t});\n" +
                      "\t}\n" +
                      "\tcatch (Exception e)\n" +
                      "\t{\n" +
                      "\t\tDevice.InvokeOnMainThreadAsync(() =>\n" +
                      "\t\t{\n" +
                      "\t\t\tDisplayAlert(\"Error\", e.Message, \"Ok\");\n" +
                      "\t\t});\n" +
                      "\t}\n" +
                      "},\n" +
                      "fault =>\n" +
                      "{\n" +
                      "\tDevice.InvokeOnMainThreadAsync(() =>\n" +
                      "\t{\n" +
                      "\t\tDisplayAlert(\"Error\", fault.Message, \"Ok\");\n" +
                      "\t});\n" +
                      "}));";
      codeLog.Children.Add( textCode );
      operationDeleteScroll.Content = codeLog;
    }

    public async void RunCode( Object sender, EventArgs ea )
    {
      await Task.Run( () =>
      {
        Backendless.Data.Of( $"{Operations.TableName}" ).FindFirst( new AsyncCallback<Dictionary<String, Object>>(
        async savedObj =>
        {
          try
          {
            Backendless.Data.Of( $"{Operations.TableName}" ).Remove( savedObj );
            await Device.InvokeOnMainThreadAsync( () =>
            {
              DisplayAlert( "Success", "The record has been deleted", "Ok" );
            } );
          }
          catch( Exception e )
          {
            await Device.InvokeOnMainThreadAsync( async () =>
            {
              await DisplayAlert( "Error", e.Message, "Ok" );
            } );
          }
        },
        async fault =>
        {
          await Device.InvokeOnMainThreadAsync( async () =>
          {
            await DisplayAlert( "Error", fault.Message, "Ok" );
          } );
        } ) );
      } );
    }
  }
}