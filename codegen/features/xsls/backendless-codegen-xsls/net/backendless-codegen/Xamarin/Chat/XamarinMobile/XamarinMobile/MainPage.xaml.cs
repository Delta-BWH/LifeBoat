using BackendlessAPI;
using BackendlessAPI.RT.Messaging;
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
    public String Nickname { get; set; }
    public MainPage()
    {
      InitializerAPI.InitializeAPI();
      InitializeComponent();
      try
      {
        IChannel channel = Backendless.Messaging.Subscribe( "chat" );
        MessageReceived<String> messageListener = async ( message ) =>
        {
          await Device.InvokeOnMainThreadAsync( () =>
          {
            View label = new Label
            {
              TextColor = Color.Green,
              Text = message
            };
            stackLayout.Children.Add(label);
            scroll.Content = stackLayout;
          } );
        };

        channel.AddMessageListener( messageListener );
      }
      catch( Exception e )
      {
        DisplayAlert( "Error", e.Message, "Ok" );
      }
    }

    public async void StartChat( Object sender, EventArgs ea )
    {
      try
      {
        await Device.InvokeOnMainThreadAsync( () =>
        {
          if( mainController.Placeholder == "Enter your name..." )
          {
            Nickname = ( (InputView) sender ).Text;
            Backendless.Messaging.Publish( Nickname + " joined", "chat" );
            mainController.Text = "";
            mainController.Placeholder = $"{Nickname}, enter your message";
          }
          else
          {
            Backendless.Messaging.Publish( Nickname + ": " + ( (InputView) sender ).Text, "chat" );
            mainController.Text = "";
          }
        } );
      }
      catch( Exception e )
      {
        await DisplayAlert( "Error", e.Message, "Ok" );
      }
    }
  }
}
