using BackendlessAPI;
using BackendlessAPI.Async;
using BackendlessAPI.File;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Threading.Tasks;
using Xamarin.Forms;
using Plugin.Media;
using Plugin.Media.Abstractions;

namespace SampleFileManager
{
  [DesignTimeVisible( false )]
  public partial class MainPage : ContentPage
  {
    Image img = new Image
    {
      MinimumWidthRequest = 300,
      MinimumHeightRequest = 200,
      WidthRequest = 300,
      HeightRequest = 200
    };
    public MainPage()
    {
      InitializerAPI.InitializeAPI();
      InitializeComponent();
      try
      {

      }
      catch( Exception e )
      {
        DisplayAlert( "Error", e.Message, "Ok" );
      }
    }

    public async void TakePhotoAndUploadIt( Object sender, EventArgs ea )
    {
      try
      {
        if( CrossMedia.Current.IsPickPhotoSupported && CrossMedia.Current.IsCameraAvailable )
        {
          MediaFile photo = await CrossMedia.Current.TakePhotoAsync( new StoreCameraMediaOptions
          {
            SaveToAlbum = true,
            Directory = "Sample",
            Name = $"{DateTime.Now.ToString( "dd.MM.yyyy_hh.mm.ss" )}.jpg"
          } ).ConfigureAwait( false );

          if( photo == null )
            return;

          img.Source = ImageSource.FromFile( photo.Path );
          AsyncCallback<BackendlessFile> callback = new AsyncCallback<BackendlessFile>(
          async result =>
          {
            await Device.InvokeOnMainThreadAsync( () =>
            {
              layoutForImage.Children.Add( img );
              Content = mainLayout;
            } );
          },
          async fault =>
          {
            await Device.InvokeOnMainThreadAsync( async () =>
            {
              await DisplayAlert( "Error", fault.Message, "Ok" );
            } );
          } );
          FileStream fs = new FileStream( photo.Path, FileMode.Open, FileAccess.Read );
          Backendless.Files.Upload( fs, "fileservice_sample", callback );
        }
      }
      catch( Exception e )
      {
        await Device.InvokeOnMainThreadAsync( async () =>
        {
          await DisplayAlert( "Error", e.Message, "Ok" );
        } );
      }
    }

    public async void BrowseUploaded( Object sender, EventArgs ea )
    {
      try
      {
        await Task.Run( async () =>
        {
          List<BackendlessAPI.File.FileInfo> listJpgImages = (List<BackendlessAPI.File.FileInfo>) Backendless.Files.Listing( "/fileservice_sample", "*.jpg", false );

          foreach( var entry in listJpgImages )
          {
            Image stackImage = new Image
            {
              MinimumWidthRequest = 300,
              MinimumHeightRequest = 200,
              WidthRequest = 300,
              HeightRequest = 200
            };

            stackImage.Source = ImageSource.FromUri( new Uri( entry.PublicURL ) );
            await Device.InvokeOnMainThreadAsync( () =>
            {
              allPhotos.Children.Add( stackImage );
            } );
          }

          await Device.InvokeOnMainThreadAsync( () =>
          {
            Content = mainLayout;
          } );
        } );
      }
      catch( Exception e )
      {
        await Device.InvokeOnMainThreadAsync( async () =>
        {
          await DisplayAlert( "Error", e.Message, "Ok" );
        } );
      }
    }
  }
}
