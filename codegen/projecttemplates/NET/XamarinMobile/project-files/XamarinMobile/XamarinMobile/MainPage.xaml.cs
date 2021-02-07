using BackendlessAPI;
using BackendlessAPI.RT.Data;
using System;
using System.ComponentModel;
using Xamarin.Forms;


namespace XamarinMobile
{
  // Learn more about making custom code visible in the Xamarin.Forms previewer
  // by visiting https://aka.ms/xamarinforms-previewer
  [DesignTimeVisible( false )]
  public partial class MainPage : ContentPage
  {
    public MainPage()
    {
      InitializerAPI.InitializeAPI();
      InitializeComponent();
    }

    public async void LoadPerson( Object sender, EventArgs ea )
    {
      String personName = await DisplayPromptAsync( "Person name", "Enter the name of the person:" );
      if( !String.IsNullOrEmpty( personName ) )
      {
        try
        {
          Int32 personAge = Convert.ToInt32( await DisplayPromptAsync( "Person age", "Enter the age of the person:" ) );
          if( !( personAge == 0 ) )
            await Backendless.Data.Of<Person>().SaveAsync( new Person( personName, personAge ) );
        }
        catch( Exception e)
        {
          await DisplayAlert( "Exception", e.Message, "Ok" );
        }
      }
    }

    public void EnableRT( Object sender, EventArgs ea )
    {
      IEventHandler<Person> eventHandler = Backendless.Data.Of<Person>().RT();
      Boolean CheckObjectCreation = false;
      Backendless.RT.AddConnectListener( async () =>
      {
        if( !CheckObjectCreation )
        {
          await Backendless.Data.Of<Person>().SaveAsync( new Person( "Joe", 21 ) );
          CheckObjectCreation = true;
        }
      } );

      Backendless.RT.AddConnectErrorListener( ( fault ) =>
      {
        Device.BeginInvokeOnMainThread( async () =>
        {
          await DisplayAlert( "Error", "Connection cannot be established " + fault.Message, "Ok" );
        } );
      } );

      eventHandler.AddCreateListener( createdObject =>
      {
        Device.BeginInvokeOnMainThread( async () =>
        {
          await DisplayAlert( "Event", $"Person object has been created. Object id: {createdObject.ObjectId}", "Ok" );
        } );
      } );
      ambiguousButton.IsEnabled = false;
    }
  }
}
