using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BackendlessAPI;
using BackendlessAPI.Async;
using BackendlessAPI.Persistence;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace XamarinMobile
{
  [XamlCompilation( XamlCompilationOptions.Compile )]
  public partial class OperationUpdate : ContentPage
  {
    public OperationUpdate()
    {
      InitializeComponent();
      Label textCode = new Label();
      textCode.Text = $"Backendless.Data.Of(\"{Operations.TableName}\").FindFirst( new AsyncCallback<Dictionary<String, Object>>(\n" +
                      "savedObj =>\n" +
                      "{\n" +
                      "\tDictionary<String, Object> obj = savedObj;\n" +
                      "\tobj[\"Age\"] = new Random().Next( 2, 2000 );\n" +
                      "\tobj[\"Name\"] = HelperCRUD.RandomString(new Random().Next(3, 16));\n" +
                      "\ttry\n" +
                      "\t{\n" +
                      $"\t\tBackendless.Data.Of(\"{Operations.TableName}\").Save( obj );\n" +
                      "\t\tDisplayAlert(\"Success\", \"The record has been updated\", \"Ok\");\n" +
                      "\t} );\n" +
                      "\tcatch (Exception e)\n" +
                      "\t{\n" +
                      "\t\tDevice.InvokeOnMainThreadAsync(() => { DisplayAlert(\"Error\", e.Message, \"Ok\"); });\n" +
                      "\t}\n" +
                      "},\n" +
                      "fault =>\n" +
                      "{\n" +
                      "\tDevice.InvokeOnMainThreadAsync(() => { DisplayAlert(\"Error\", fault.Message, \"Ok\"); });\n" +
                      "}));";
      codeLog.Children.Add( textCode );
      operationUpdateScroll.Content = codeLog;
    }

    public void RunCode( Object sender, EventArgs ea )
    {
      Backendless.Data.Of( $"{Operations.TableName}" ).FindFirst( new AsyncCallback<Dictionary<String, Object>>(
      savedObj =>
      {
        Dictionary<String, Object> obj = savedObj;
        obj[ "Age" ] = new Random().Next( 2, 2000 );
        obj[ "Name" ] = HelperCRUD.RandomString( new Random().Next( 3, 16 ) );
        try
        {
          Backendless.Data.Of( $"{Operations.TableName}" ).Save( obj );
          Device.InvokeOnMainThreadAsync( () =>
          {
            DisplayAlert( "Success", "The record has been updated", "Ok" );
          } );
        }
        catch( Exception e )
        {
          Device.InvokeOnMainThreadAsync( () => { DisplayAlert( "Error", e.Message, "Ok" ); } );
        }
      },
      fault =>
      {
        Device.InvokeOnMainThreadAsync( () => { DisplayAlert( "Error", fault.Message, "Ok" ); } );
      } ) );
    }
  }
}