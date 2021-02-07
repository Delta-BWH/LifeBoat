<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="file-sources">
        <folder name="com">
            <folder name="examples">
                <folder name="{$packageAppName}">
                    <folder name="file">

                        <file name="BrowseActivity.java">
package <xsl:value-of select="$package"/>;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.Toast;
import com.backendless.Backendless;
import com.backendless.async.callback.AsyncCallback;
import com.backendless.exceptions.BackendlessFault;
import com.backendless.persistence.DataQueryBuilder;

import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class BrowseActivity extends Activity
{
private static int itemWidth;
private static ImageAdapter imageAdapter;
private static int padding;

public void onCreate( Bundle savedInstanceState )
{
super.onCreate( savedInstanceState );
setContentView( R.layout.browse );

padding = (int) getResources().getDimension( R.dimen.micro_padding );
itemWidth = (getWindowManager().getDefaultDisplay().getWidth() - (2 * (int) getResources().getDimension( R.dimen.default_margin ))) / 3;

GridView gridView = (GridView) findViewById( R.id.gridView );
imageAdapter = new ImageAdapter( this );
gridView.setAdapter( imageAdapter );

Toast.makeText( BrowseActivity.this, "Downloading images...", Toast.LENGTH_SHORT ).show();

Backendless.Persistence.of( ImageEntity.class ).find( new AsyncCallback&lt;List&lt;ImageEntity&gt;&gt;()
{
@Override
public void handleResponse( final List&lt;ImageEntity&gt; response )
{
Toast.makeText( BrowseActivity.this, "Will add " + response.size() + " images", Toast.LENGTH_SHORT ).show();

new Thread()
{
@Override
public void run()
{
List&lt;ImageEntity&gt; imageEntities = response;

for( ImageEntity imageEntity : imageEntities )
{
Message message = new Message();
try
{
URL url = new URL( imageEntity.getUrl() );
HttpURLConnection connection = (HttpURLConnection) url.openConnection();
connection.setDoInput( true );
connection.connect();
InputStream input = connection.getInputStream();
message.obj = BitmapFactory.decodeStream( input );
}
catch( Exception e )
{
message.obj = e;
}

imagesHandler.sendMessage( message );
}
}
}.start();
}

@Override
public void handleFault( BackendlessFault fault )
{
Toast.makeText( BrowseActivity.this, "Make some upload first", Toast.LENGTH_SHORT ).show();
}
} );
}

private Handler imagesHandler = new Handler( new Handler.Callback()
{
@Override
public boolean handleMessage( Message message )
{
Object result = message.obj;

if( result instanceof Bitmap )
imageAdapter.add( (Bitmap) result );
else
Toast.makeText( BrowseActivity.this, ((Exception) result).getMessage(), Toast.LENGTH_SHORT ).show();

return true;
}
} );

private static class ImageAdapter extends BaseAdapter
{
private Context context;
private List&lt;Bitmap&gt; images = new ArrayList&lt;Bitmap&gt;();

public ImageAdapter( Context c )
{
context = c;
}

@Override
public int getCount()
{
return images.size();
}

public void add( Bitmap bitmap )
{
images.add( bitmap );
notifyDataSetChanged();
}

public Bitmap getItem( int position )
{
return images.get( position );
}

public long getItemId( int position )
{
return position;
}

public View getView( final int position, View convertView, ViewGroup parent )
{
ImageView imageView;
if( convertView == null )
{
imageView = new ImageView( context );
imageView.setLayoutParams( new GridView.LayoutParams( itemWidth, itemWidth ) );
imageView.setScaleType( ImageView.ScaleType.CENTER_CROP );
imageView.setPadding( padding, padding, padding, padding );
}
else
imageView = (ImageView) convertView;

imageView.setImageBitmap( getItem( position ) );

return imageView;
}
}
}
                        </file>


                        <file name="Defaults.java">
package <xsl:value-of select="$package"/>;

public class Defaults
{
  <xsl:call-template name="common-defaults"/>
  public static final int CAMERA_REQUEST = 101;
  public static final int URL_REQUEST = 102;
  public static final String DATA_TAG = "data";
  public static final String DEFAULT_PATH_ROOT = "fileservice_sample";
}
</file>

                        <file name="ImageEntity.java">
package <xsl:value-of select="$package"/>;

    public class ImageEntity
    {
    private long uploaded;
    private String url;

    public ImageEntity()
    {
    }

    public ImageEntity( long uploaded, String url )
    {
    this.uploaded = uploaded;
    this.url = url;
    }

    public long getUploaded()
    {
    return uploaded;
    }

    public void setUploaded( long uploaded )
    {
    this.uploaded = uploaded;
    }

    public String getUrl()
    {
    return url;
    }

    public void setUrl( String url )
    {
    this.url = url;
    }
    }
</file>

                        <file name="MainActivity.java">
package <xsl:value-of select="$package"/>;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import com.backendless.Backendless;

    public class MainActivity extends Activity
    {
    private TextView welcomeTextField;
    private TextView urlField;
    private Button takePhotoButton;

    @Override
    public void onCreate( Bundle savedInstanceState )
    {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.main );

    if( Defaults.APPLICATION_ID.equals( "" ) || Defaults.API_KEY.equals( "" ) )
    {
    showAlert( this, "Missing application ID and secret key arguments. Login to Backendless Console, select your app and get the ID and key from the Manage - App Settings screen. Copy/paste the values into the Backendless.initApp call" );
    return;
    }
    Backendless.setUrl( Defaults.SERVER_URL );
    Backendless.initApp( this, Defaults.APPLICATION_ID, Defaults.API_KEY );

    welcomeTextField = (TextView) findViewById( R.id.welcomeTextField );
    urlField = (TextView) findViewById( R.id.urlField );
    takePhotoButton = (Button) findViewById( R.id.takePhotoButton );
    takePhotoButton.setOnClickListener( new View.OnClickListener()
    {
    @Override
    public void onClick( View view )
    {
    Intent cameraIntent = new Intent( android.provider.MediaStore.ACTION_IMAGE_CAPTURE );
    startActivityForResult( cameraIntent, Defaults.CAMERA_REQUEST );
    }
    } );
    findViewById( R.id.browseUploadedButton ).setOnClickListener( new View.OnClickListener()
    {
    @Override
    public void onClick( View view )
    {
    Intent intent = new Intent( MainActivity.this, BrowseActivity.class );
    startActivity( intent );
    }
    } );
    }

    @Override
    public void onActivityResult( int requestCode, int resultCode, Intent data )
    {
    if( resultCode != RESULT_OK )
    return;

    switch( requestCode )
    {
    case Defaults.CAMERA_REQUEST:
    data.setClass( getBaseContext(), UploadingActivity.class );
    startActivityForResult( data, Defaults.URL_REQUEST );
    break;

    case Defaults.URL_REQUEST:
    welcomeTextField.setText( getResources().getText( R.string.welcome_text ) );
    urlField.setText( (String) data.getExtras().get( Defaults.DATA_TAG ) );
    takePhotoButton.setText( getResources().getText( R.string.takeAnotherPhoto ) );
    }
    }

    public static void showAlert( final Activity context, String message )
    {
    new AlertDialog.Builder( context ).setTitle( "An error occurred" ).setMessage( message ).setPositiveButton( "OK", new DialogInterface.OnClickListener()
    {
    @Override
    public void onClick( DialogInterface dialogInterface, int i )
    {
    context.finish();
    }
    } ).show();
    }
    }
 </file>

                        <file name="UploadingActivity.java">
package <xsl:value-of select="$package"/>;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.widget.LinearLayout;
import android.widget.Toast;
import com.backendless.Backendless;
import com.backendless.async.callback.AsyncCallback;
import com.backendless.async.callback.BackendlessCallback;
import com.backendless.exceptions.BackendlessFault;
import com.backendless.files.BackendlessFile;

import java.util.UUID;

    public class UploadingActivity extends Activity
    {
    @Override
    public void onCreate( Bundle savedInstanceState )
    {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.uploading );

    LinearLayout imageContainer = (LinearLayout) findViewById( R.id.imageContainer );
    Bitmap photo = (Bitmap) getIntent().getExtras().get( Defaults.DATA_TAG );
    if( photo == null )
    {
    finishActivity( RESULT_CANCELED );
    return;
    }

    Drawable drawable = new BitmapDrawable( photo );
    drawable.setAlpha( 50 );
    imageContainer.setBackgroundDrawable( drawable );

    String name = UUID.randomUUID().toString() + ".png";

    Backendless.Files.Android.upload( photo, Bitmap.CompressFormat.PNG, 100, name, Defaults.DEFAULT_PATH_ROOT, new AsyncCallback&lt;BackendlessFile&gt;()
    {
    @Override
    public void handleResponse( final BackendlessFile backendlessFile )
    {
    ImageEntity entity = new ImageEntity( System.currentTimeMillis(), backendlessFile.getFileURL() );
    Backendless.Persistence.save( entity, new BackendlessCallback&lt;ImageEntity&gt;()
    {
    @Override
    public void handleResponse( ImageEntity imageEntity )
    {
    Intent data = new Intent();
    data.putExtra( Defaults.DATA_TAG, imageEntity.getUrl() );
    setResult( RESULT_OK, data );
    finish();
    }
    } );
    }

    @Override
    public void handleFault( BackendlessFault backendlessFault )
    {
    Toast.makeText( UploadingActivity.this, backendlessFault.toString(), Toast.LENGTH_SHORT ).show();
    }
    } );
    }
    }
</file>
                                        </folder>
                                    </folder>
                                </folder>
                            </folder>


    </xsl:template>

</xsl:stylesheet>