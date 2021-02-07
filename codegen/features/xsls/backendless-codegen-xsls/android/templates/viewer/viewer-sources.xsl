<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="viewer-sources">
        <folder name="com">
            <folder name="examples">
                <folder name="{$packageAppName}">
                    <folder name="{$subPackage}">
                        <file name="ViewerActivity.java">
package <xsl:value-of select="$package"/>;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.util.Log;
import android.view.SurfaceHolder;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.view.WindowManager;
import android.widget.*;
import com.backendless.Backendless;
import com.backendless.media.StreamProtocolType;
import com.backendless.media.gl.SurfaceView;

public class ViewerActivity extends Activity implements OnClickListener, SurfaceHolder.Callback
{
  <xsl:call-template name="common-defaults"/>

  public final static String TAG = "ViewerActivity";

  private ImageButton mButtonPlay;
  private SurfaceView mSurfaceView;
  private EditText mEditTextStreamName;
  private Switch broadcast;

  private SurfaceHolder vidHolder;
  private boolean isLive;

  @Override
  protected void onCreate( Bundle savedInstanceState )
  {
    getWindow().addFlags( WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON );
    requestWindowFeature( Window.FEATURE_NO_TITLE );

    super.onCreate( savedInstanceState );
    setContentView( R.layout.main );

    mButtonPlay = (ImageButton) findViewById( R.id.play );

    mButtonPlay.setOnClickListener( this );
    mButtonPlay.setTag( "off" );

    mEditTextStreamName = (EditText) findViewById( R.id.streamName );

    mSurfaceView = (SurfaceView) findViewById( R.id.surface );
    vidHolder = mSurfaceView.getHolder();
    vidHolder.addCallback( this );

    broadcast = (Switch) findViewById( R.id.broadcast );
    broadcast.setOnCheckedChangeListener( new android.widget.CompoundButton.OnCheckedChangeListener()
    {
      public void onCheckedChanged( CompoundButton buttonView, boolean isChecked )
      {
        isLive = isChecked;
        Toast.makeText( ViewerActivity.this, (isLive) ? "Broadcast Live stream" : "Broadcast Record stream", Toast.LENGTH_SHORT ).show();
      }
    } );

    // Init backendless application
    Backendless.setUrl( SERVER_URL );
    Backendless.initApp( ViewerActivity.this, APPLICATION_ID, API_KEY );
  }

  @Override
  public void onClick( View v )
  {
    String streamName = mEditTextStreamName.getText().toString();
    switch( v.getId() )
    {
      case R.id.play:
        try
        {
          if( isLive )
          {
            if( Backendless.Media.isMediaPlayerBusy() )
						{
						    Backendless.Media.stopVideoPlayback();
						}
						else
						{
						    Backendless.Media.playLiveVideo( "SomeTube", streamName );
						}
          }
          else
          {
            if( Backendless.Media.isMediaPlayerBusy() )
						{
						    Backendless.Media.stopVideoPlayback();
						}
						else
						{
						    Backendless.Media.playOnDemandVideo( "SomeTube", streamName );
						}
          }
        }
        catch( Exception e )
        {
          String error = (e.getMessage() == null) ? "Can't play video" : e.getMessage();
          Log.e( TAG, error );
          logError( error );
        }

        break;
    }
  }

  @Override
  public void onDestroy()
  {
    super.onDestroy();
  }

  private void logError( final String msg )
  {
    // Displays a popup to report the error to the user
    AlertDialog.Builder builder = new AlertDialog.Builder( ViewerActivity.this );
    builder.setMessage( msg ).setPositiveButton( "OK", new DialogInterface.OnClickListener()
    {
      public void onClick( DialogInterface dialog, int id )
      {
      }
    } );
    AlertDialog dialog = builder.create();
    dialog.show();
  }

  @Override
  public void surfaceChanged( SurfaceHolder holder, int format, int width, int height )
  {
    Log.d( TAG, "Surface changed" );
  }

  @Override
  public void surfaceCreated( SurfaceHolder holder )
  {
    // Set stream configurations
    Backendless.Media.configureForPlay( vidHolder, StreamProtocolType.RTSP );
  }

  @Override
  public void surfaceDestroyed( SurfaceHolder holder )
  {
  }
}
                        </file>

                    </folder>
                </folder>
            </folder>
        </folder>

    </xsl:template>

</xsl:stylesheet>