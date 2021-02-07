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
  public partial class FindBasic : ContentPage
  {
    public FindBasic()
    {
      InitializeComponent();
      Label label = new Label();
      label.Text = "await Task.Run(() =>\n" +
                   "{\n" +
                   $"\tBackendless.Data.Of(\"{Operations.TableName}\").Find(new AsyncCallback<IList<Dictionary<String, Object>>>(\n" +
                   "\tasync response =>\n" +
                   "\t{\n" +
                   "\t\tIList<Dictionary<String, Object>> obj = response;\n" +
                   "\t\tString alert = await DisplayActionSheet(\"Property to show\", \"Cancel\", null,\n" +
                   "   \t\t\"objectId\");\n" +
                   "\t\tawait Navigation.PushModalAsync(new BasicFindResult(alert, firstPerson));\n" +
                   "\t},\n" +
                   "\tasync fault =>\n" +
                   "\t{\n" +
                   "\t\tawait DisplayAlert(\"Error\", fault.Message, \"Ok\");\n" +
                   "\t}));\n" +
                   "});";
      codeLog.Children.Add( label );
      operationRetrieveScroll.Content = codeLog;
    }

    public async void RunCode( Object sender, EventArgs ea )
    {
      await Task.Run( () =>
       {
         Backendless.Data.Of( $"{Operations.TableName}" ).Find( new AsyncCallback<IList<Dictionary<String, Object>>>(
           async response =>
           {
             IList<Dictionary<String, Object>> obj = response;
             String alert = "";
             await Device.InvokeOnMainThreadAsync( async () =>
             {
               alert = await DisplayActionSheet( "Property to show", "Cancel", null,
                 "objectId" );

               if( !String.IsNullOrEmpty( alert ) )
               {
                 await Navigation.PushModalAsync( new BasicFindResult( alert, obj ) );
               }
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