using BackendlessAPI;
using BackendlessAPI.RT.Messaging;
using System;
using System.ComponentModel;
using System.Threading;
using System.Threading.Tasks;
using LoginAndRegistration;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

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
      try
      {
        if (Backendless.UserService.LoggedInUserObjectId() != null)
          Navigation.PushModalAsync(new LogInPage(Backendless.Data.Of<BackendlessUser>()
              .FindById(Backendless.UserService.LoggedInUserObjectId())));
      }
      catch( Exception e )
      {
        Device.InvokeOnMainThreadAsync(() =>
        {
          DisplayAlert("Error", e.Message, "Ok");
        });
      }
    }

    private async void UserRegistration( Object sender, EventArgs ea )
    {
      try
      {
        await Navigation.PushModalAsync(new RegistrationPage());
      }
      catch( Exception e )
      {
        await DisplayAlert( "Error", e.Message, "Ok" );
      }
    }

    private async void RestoreUserPassword(Object sender, EventArgs ea)
    {
      try
      {
        await Navigation.PushModalAsync(new RestorePasswordPage());
      }
      catch (Exception e)
      {
        await DisplayAlert("Error", e.Message, "Ok");
      }
    }

    private async void LogIn(Object sender, EventArgs ea)
    {
      try
      {
        if (!(String.IsNullOrEmpty(loginEntry.Text) || String.IsNullOrEmpty(passwordEntry.Text)))
        {
          BackendlessUser user = await Backendless.UserService.LoginAsync(loginEntry.Text, passwordEntry.Text, checkBoxLogged.IsChecked);
          await Navigation.PushModalAsync(new LogInPage(user));
        }
        else
          await Task.Run(async () =>
          {
            await Device.InvokeOnMainThreadAsync(() =>
            {
              emptyFields.IsVisible = true;
              Content = mainLayout;
            });
            Thread.Sleep(5000);
            await Device.InvokeOnMainThreadAsync(() =>
            {
              emptyFields.IsVisible = false;
              Content = mainLayout;
            });
          });
      }
      catch (Exception e)
      {
        await Device.InvokeOnMainThreadAsync(async () =>
        {
          await DisplayAlert("Error", e.Message, "Ok");
        });
      }
    }
  }
}
