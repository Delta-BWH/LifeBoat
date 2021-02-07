using Android.App;
using Android.Content.PM;
using Android.Runtime;
using Android.OS;

namespace XamarinMobile.Droid
{
  [Activity( Label = "XamarinMobile", Icon = "@mipmap/icon", Theme = "@style/MainTheme", MainLauncher = true, ConfigurationChanges = ConfigChanges.ScreenSize | ConfigChanges.Orientation )]
  public class MainActivity : global::Xamarin.Forms.Platform.Android.FormsAppCompatActivity
  {
    //public void CheckAppPermission()
    //{
    //  if( (Int32) Build.VERSION.SdkInt < 23 )
    //  {
    //    return;
    //  }

    //  if( ContextCompat.CheckSelfPermission( this, Manifest.Permission.WriteExternalStorage ) != (Int32) Permission.Granted )
    //  {
    //    ActivityCompat.RequestPermissions( this, new String[] { Manifest.Permission.WriteExternalStorage }, 0 );
    //  }

    //  if( ContextCompat.CheckSelfPermission( this, Manifest.Permission.ReadExternalStorage ) != (Int32) Permission.Granted )
    //  {
    //    ActivityCompat.RequestPermissions( this, new String[] { Manifest.Permission.ReadExternalStorage }, 0 );
    //  }
    //}
    protected override void OnCreate( Bundle savedInstanceState )
    {
      TabLayoutResource = Resource.Layout.Tabbar;
      ToolbarResource = Resource.Layout.Toolbar;

      base.OnCreate( savedInstanceState );

      Xamarin.Essentials.Platform.Init( this, savedInstanceState );
      global::Xamarin.Forms.Forms.Init( this, savedInstanceState );
      //CheckAppPermission();
      LoadApplication( new App() );
    }
    public override void OnRequestPermissionsResult( int requestCode, string[] permissions, [GeneratedEnum] Android.Content.PM.Permission[] grantResults )
    {
      Xamarin.Essentials.Platform.OnRequestPermissionsResult( requestCode, permissions, grantResults );

      base.OnRequestPermissionsResult( requestCode, permissions, grantResults );
    }
  }
}