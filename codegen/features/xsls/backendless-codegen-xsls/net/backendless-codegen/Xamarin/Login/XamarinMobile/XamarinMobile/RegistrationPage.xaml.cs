using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using BackendlessAPI;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace LoginAndRegistration
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class RegistrationPage : ContentPage
    {
        public RegistrationPage()
        {
            InitializeComponent();
        }

        private async void RegisterFormButtonLogic(Object sender, EventArgs ea)
        {
            try
            {
                if (!(String.IsNullOrEmpty(emailReg.Text) || String.IsNullOrEmpty(pasReg.Text)
                                                          || String.IsNullOrEmpty(nameReg.Text)))
                    await Task.Run(async () =>
                    {
                        BackendlessUser user = new BackendlessUser();
                        user.Email = emailReg.Text;
                        user.Password = pasReg.Text;
                        user.Properties["name"] = nameReg.Text;
                        await Backendless.UserService.RegisterAsync(user);
                        await Device.InvokeOnMainThreadAsync(async () =>
                        {
                            await DisplayAlert("Registration Successful",
                                "Your account has been successfully registered", "Ok");
                        });
                    });
                else
                    await Task.Run(async () =>
                    {
                        await Device.InvokeOnMainThreadAsync(() =>
                        {
                            emptyFields.IsVisible = true;
                            Content = regLayout;
                        });
                        Thread.Sleep(5000);
                        await Device.InvokeOnMainThreadAsync(() =>
                        {
                            emptyFields.IsVisible = false;
                            Content = regLayout;
                        });
                    });
            }
            catch (Exception e)
            {
                await Device.InvokeOnMainThreadAsync(async () => { await DisplayAlert("Error", e.Message, "Ok"); });
            }
        }
    }
}