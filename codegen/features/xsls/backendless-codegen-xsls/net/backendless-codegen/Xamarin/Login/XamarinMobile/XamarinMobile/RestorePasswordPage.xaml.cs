using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BackendlessAPI;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace LoginAndRegistration
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class RestorePasswordPage : ContentPage
    {
        public RestorePasswordPage()
        {
            InitializeComponent();
        }

        private async void RestoreUserPassword(Object sender, EventArgs ea)
        {
            try
            {
                await Backendless.UserService.RestorePasswordAsync(userEmail.Text);
                await Device.InvokeOnMainThreadAsync(async () =>
                {
                    await DisplayAlert("Password Recovery", "We sent an email to your email address" +
                                                            " with a link to a password change page." +
                                                            " Please check your email and follow the " +
                                                            "link to further instructions.", "Ok");
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