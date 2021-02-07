using BackendlessAPI;
using BackendlessAPI.Async;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace XamarinMobile
{
  [XamlCompilation( XamlCompilationOptions.Compile )]
  public partial class FindFirst : ContentPage
  {
    public FindFirst()
    {
      InitializeComponent();
      Label label = new Label();
      label.Text = "await Task.Run(() =>\n" +
                   "{\n" +
                   $"\tBackendless.Data.Of(\"{Operations.TableName}\").FindFirst(new AsyncCallback<Dictionary<String, Object>>(\n" +
                   "\tasync response =>\n" +
                   "\t{\n" +
                   "\t\tDictionary<String, Object> obj = response;\n" +
                   "\t\tawait Navigation.PushModalAsync(new FindFirstAfterRunCode( obj ) );\n" +
                   "\t},\n" +
                   "\tasync fault =>\n" +
                   "\t{\n" +
                   "\t\tawait DisplayAlert(\"Error\", fault.Message, \"Ok\");" +
                   "\t}));\n" +
                   "});";
      codeLog.Children.Add( label );
      operationRetrieveScroll.Content = codeLog;
    }

    public async void RunCode( Object sender, EventArgs ea )
    {
      await Task.Run( () =>
      {
        Backendless.Data.Of( $"{Operations.TableName}" ).FindFirst( new AsyncCallback<Dictionary<String, Object>>(
        async response =>
        {
          Dictionary<String, Object> obj = response;
          await Device.InvokeOnMainThreadAsync( async () =>
          {
            await Navigation.PushModalAsync( new FindFirstAfterRunCode( obj ) );
          } );
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
