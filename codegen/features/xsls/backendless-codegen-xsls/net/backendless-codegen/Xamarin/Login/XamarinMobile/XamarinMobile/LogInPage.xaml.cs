using System;
using System.Threading.Tasks;
using BackendlessAPI;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using XamarinMobile;

namespace LoginAndRegistration
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class LogInPage : ContentPage
    {
        public LogInPage(BackendlessUser user)
        {
            InitializeComponent();
            try
            {
                userInfo.Text = "ObjectId: " + user.ObjectId +
                                "\nEmail: " + user.Email +
                                "\n\nProperties:\n";
                foreach (var entry in user.Properties)
                {
                    if (entry.Key != "objectId" || entry.Key != "email")
                    {
                        userInfo.Text += "\t" + entry.Key + ": ";
                        userInfo.Text += entry.Value + "\n";
                    }
                }

                Device.InvokeOnMainThreadAsync(() => { Content = loginLayout; });
            }
            catch (Exception e)
            {
                Task.Run(async () =>
                {
                    await Device.InvokeOnMainThreadAsync(async () =>
                    {
                        await DisplayAlert("Error", e.Message, "Ok");
                    });
                });
            }
        }

        private async void LogoutFromBackendless(Object sender, EventArgs ea)
        {
            try
            {
                await Backendless.UserService.LogoutAsync();
                await Navigation.PushModalAsync(new MainPage());
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