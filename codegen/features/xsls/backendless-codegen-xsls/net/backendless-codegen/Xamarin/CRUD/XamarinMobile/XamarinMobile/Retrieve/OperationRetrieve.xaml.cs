using System;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace XamarinMobile
{
  [XamlCompilation( XamlCompilationOptions.Compile )]
  public partial class OperationRetrieve : ContentPage
  {
    public OperationRetrieve()
    {
      InitializeComponent();
    }

    public async void BasicFind( Object sender, EventArgs ea )
    {
      await Navigation.PushModalAsync( new FindBasic() );
    }

    public async void FindFirst( Object sender, EventArgs ea )
    {
      await Navigation.PushModalAsync( new FindFirst() );
    }

    public async void FindLast( Object sender, EventArgs ea )
    {
      await Navigation.PushModalAsync( new FindLast() );
    }

    public async void FindSort( Object sender, EventArgs ea )
    {
      String alert = await DisplayActionSheet( "Properties to sort by:", "Cancel", null,
        "objectId" );
      if( alert != "Cancel" && alert != null )
        await Navigation.PushModalAsync( new FindSort( alert ) );
    }
  }
}