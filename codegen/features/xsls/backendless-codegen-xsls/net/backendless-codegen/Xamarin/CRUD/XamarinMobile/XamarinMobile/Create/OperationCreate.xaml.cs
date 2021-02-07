using System;
using BackendlessAPI;
using System.Collections.Generic;
using System.Threading.Tasks;
using BackendlessAPI.Async;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace XamarinMobile
{
  [XamlCompilation( XamlCompilationOptions.Compile )]
  public partial class OperationCreate : ContentPage
  {
    public OperationCreate()
    {
      InitializeComponent();
      Label label = new Label();
      label.Text = "Dictionary<String, Object> obj = new Dictionary<String, Object>();\n" +
                   "obj[\"Age\"] = new Random().Next(2,50);\n" +
                   "obj[\"Name\"] = HelperCRUD.RandomString(new Random().Next(3, 16));\n" +
                   $"Backendless.Data.Of(\"{Operations.TableName}\").Save(obj, new AsyncCallback<Dictionary<String, Object>>(\n" +
                   "    savedObj =>\n" +
                   "    {\n" +
                   "        obj = savedObj;\n" +
                   "    },\n" +
                   "    fault =>\n" +
                   "    {\n" +
                   "        DisplayAlert(\"Error\", fault.Message, \"Ok\");\n" +
                   "    }));\n";
      codeLog.Children.Add( label );
      operationCreateScroll.Content = codeLog;
    }

    public async void RunCode( Object sender, EventArgs ea )
    {
      await Task.Run( () =>
      {
        Dictionary<String, Object> obj = new Dictionary<String, Object>();
        obj[ "Age" ] = new Random().Next( 2, 50 );
        obj[ "Name" ] = HelperCRUD.RandomString( new Random().Next( 3, 16 ) );

        Backendless.Data.Of( $"{Operations.TableName}" ).Save( obj, new AsyncCallback<Dictionary<String, Object>>(
            savedObj =>
            {
              obj = savedObj;
              Device.InvokeOnMainThreadAsync( () =>
              {
                DisplayAlert( "Success", "The record has been created", "Ok" );
              } );
            },
            async fault =>
            {
              await DisplayAlert( "Error", fault.Message, "Ok" );
            } ) );
      } );
    }
  }
}