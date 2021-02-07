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
  public partial class FindSort : ContentPage
  {
    private String Alert;

    public FindSort( String alert )
    {
      InitializeComponent();
      Label textCode = new Label();
      textCode.Text = "await Task.Run(() =>\n" +
                      "{\n" +
                      $"\tBackendless.Data.Of(\"{Operations.TableName}\").Find(DataQueryBuilder.Create().AddSortBy( Alert ),new AsyncCallback<IList<Dictionary<String, Object>>>(\n" +
                      "\tasync response =>\n" +
                      "\t{\n" +
                      "\t\tIList<Dictionary<String, Object> obj = response;\n" +
                      "\t\tawait Device.InvokeOnMainThreadAsync( async ()=>\n" +
                      "\t\t{\n" +
                      "\t\t\tawait Navigation.PushModalAsync(new BasicFindResult(alert, obj));\n" +
                      "\t\t});\n" +
                      "\t},\n" +
                      "\tasync fault =>\n" +
                      "\t{\n" +
                      "\t\tawait Device.InvokeOnMainThreadAsync(async ()=>\n" +
                      "\t\t{\n" +
                      "\t\t\tawait DisplayAlert(\"Error\", fault.Message, \"Ok\");\n" +
                      "\t\t}\n" +
                      "\t}));\n" +
                      "});";
      codeLog.Children.Add( textCode );
      operationRetrieveScroll.Content = codeLog;
      Alert = alert;
    }

    public async void RunCode( Object sender, EventArgs ea )
    {
      await Task.Run( () =>
      {
        Backendless.Data.Of( $"{Operations.TableName}" ).Find( DataQueryBuilder.Create().AddSortBy( Alert ),
                                                      new AsyncCallback<IList<Dictionary<String, Object>>>(
        async response =>
        {
          IList<Dictionary<String, Object>> obj = response;
          await Device.InvokeOnMainThreadAsync( async () =>
          {
            await Navigation.PushModalAsync( new FindSortAfterRunCode( Alert, obj ) );
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