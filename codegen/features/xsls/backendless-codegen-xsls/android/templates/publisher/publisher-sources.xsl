<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="publisher-sources">

    <folder name="com">
        <folder name="examples">

            <folder name="{$packageAppName}">
                <folder name="{$subPackage}">

                    <file name="PublisherActivity.java">
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
import android.widget.RadioGroup.OnCheckedChangeListener;
import com.backendless.Backendless;
import com.backendless.media.DisplayOrientation;
import com.backendless.media.Session;
import com.backendless.media.gl.SurfaceView;
import com.backendless.media.rtsp.RtspClient;
import com.backendless.media.StreamVideoQuality;


public class PublisherActivity extends Activity implements OnClickListener, RtspClient.Callback, Session.Callback,
                                                      SurfaceHolder.Callback, OnCheckedChangeListener
{
  <xsl:call-template name="common-defaults"/>

  public final static String TAG = "PublisherActivity";

  private ImageButton mButtonRecord;
  private ImageButton mButtonCamera;
  private ImageButton mButtonSettings;
  private RadioGroup mRadioGroup;
  private FrameLayout mLayoutVideoSettings;
  private SurfaceView mSurfaceView;
  private TextView mTextBitrate;
  private ProgressBar mProgressBar;
  private Switch broadcast;
  private EditText mEditTextStreamName;

  private SurfaceHolder vidHolder;
  private boolean isLive;

  @Override
  protected void onCreate( Bundle savedInstanceState )
  {
    getWindow().addFlags( WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON );
    requestWindowFeature( Window.FEATURE_NO_TITLE );

    super.onCreate( savedInstanceState );
    setContentView( R.layout.main );

    mButtonRecord = (ImageButton) findViewById( R.id.record );
    mButtonCamera = (ImageButton) findViewById( R.id.camera );
    mButtonSettings = (ImageButton) findViewById( R.id.settings );
    mTextBitrate = (TextView) findViewById( R.id.bitrate );
    mLayoutVideoSettings = (FrameLayout) findViewById( R.id.video_layout );
    mRadioGroup = (RadioGroup) findViewById( R.id.radio );
    mProgressBar = (ProgressBar) findViewById( R.id.progress_bar );

    mRadioGroup.setOnCheckedChangeListener( this );
    mRadioGroup.setOnClickListener( this );

    mButtonRecord.setOnClickListener( this );
    mButtonCamera.setOnClickListener( this );
    mButtonSettings.setOnClickListener( this );

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
        Toast.makeText( PublisherActivity.this, (isLive) ? "Broadcast Live stream" : "Broadcast Record stream", Toast.LENGTH_SHORT ).show();
      }
    } );

    // Init backendless application
    Backendless.setUrl( SERVER_URL );
    Backendless.initApp( PublisherActivity.this, APPLICATION_ID, API_KEY );
  }

  @Override
  public void onCheckedChanged( RadioGroup group, int checkedId )
  {
    mLayoutVideoSettings.setVisibility( View.GONE );
    selectQuality();
  }

  @Override
  public void onClick( View v )
  {
    mProgressBar.setVisibility( View.VISIBLE );
    String streamName = mEditTextStreamName.getText().toString();
    switch( v.getId() )
    {
      case R.id.record:
        if( isLive )
        {
          if( Backendless.Media.isPublishing() )
					{
					   Backendless.Media.stopPublishing();
					}
					   else
					{
					   Backendless.Media.broadcastLiveVideo( "SomeTube", streamName );
					}
        }
        else
        {
          if( Backendless.Media.isPublishing() )
					{
					    Backendless.Media.stopPublishing();
					}
					    else
					{
					    Backendless.Media.recordVideo( "SomeTube", streamName );
					}
        }
        break;
      case R.id.camera:
        Backendless.Media.switchCamera();
        break;
      case R.id.settings:
        mLayoutVideoSettings.setVisibility( (mLayoutVideoSettings.getVisibility() == View.GONE) ? View.VISIBLE : View.GONE );
        break;
    }
  }

  @Override
  public void onDestroy()
  {
    super.onDestroy();
    Backendless.Media.releaseClient();
    Backendless.Media.releaseSession();
    mSurfaceView.getHolder().removeCallback( this );
  }

  private void selectQuality()
  {
    int id = mRadioGroup.getCheckedRadioButtonId();
    RadioButton button = (RadioButton) findViewById( id );
    if( button == null )
      return;

    String text = button.getText().toString();
    Backendless.Media.setVideoQuality( StreamVideoQuality.getFromString( text ) );
    Toast.makeText( this, ((RadioButton) findViewById( id )).getText(), Toast.LENGTH_SHORT ).show();

    Log.d( TAG, "Selected quality: " + text );
  }

  private void enableUI()
  {
    mButtonRecord.setEnabled( true );
    mButtonCamera.setEnabled( true );
  }

  private void logError( final String msg )
  {
    // Displays a popup to report the error to the user
    AlertDialog.Builder builder = new AlertDialog.Builder( PublisherActivity.this );
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
  public void onBitrateUpdate( long bitrate )
  {
    mTextBitrate.setText( "" + bitrate / 1000 + " kbps" );
  }

  @Override
  public void onPreviewStarted()
  {
  }

  @Override
  public void onSessionConfigured()
  {
  }

  @Override
  public void onSessionStarted()
  {
    enableUI();
    mButtonRecord.setImageResource( R.drawable.ic_switch_video_active );
    mProgressBar.setVisibility( View.GONE );
  }

  @Override
  public void onSessionStopped()
  {
    enableUI();
    mButtonRecord.setImageResource( R.drawable.ic_switch_video );
    mProgressBar.setVisibility( View.GONE );
  }

  @Override
  public void onSessionError( int reason, int streamType, Exception e )
  {
    mProgressBar.setVisibility( View.GONE );
    switch( reason )
    {
      case Session.ERROR_CAMERA_ALREADY_IN_USE:
        break;
      case Session.ERROR_INVALID_SURFACE:
        break;
      case Session.ERROR_STORAGE_NOT_READY:
        break;
      case Session.ERROR_CONFIGURATION_NOT_SUPPORTED:
        StreamVideoQuality quality = Backendless.Media.getStreamQuality();
        logError( "The following settings are not supported on this phone: " + quality.toString() + " " + "(" + e.getMessage() + ")" );
        e.printStackTrace();
        return;
      case Session.ERROR_OTHER:
        break;
    }

    if( e != null )
    {
      logError( e.getMessage() );
      e.printStackTrace();
    }
  }

  @Override
  public void onRtspUpdate( int message, Exception e )
  {
    switch( message )
    {
      case RtspClient.ERROR_CONNECTION_FAILED:
      case RtspClient.ERROR_WRONG_CREDENTIALS:
        mProgressBar.setVisibility( View.GONE );
        enableUI();
        logError( e.getMessage() );
        e.printStackTrace();
        break;
    }
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
    Backendless.Media.configureForPublish( PublisherActivity.this, mSurfaceView, DisplayOrientation.LEFT_LANDSCAPE );
    Backendless.Media.startPreview();
    selectQuality();
  }

  @Override
  public void surfaceDestroyed( SurfaceHolder holder )
  {
    Backendless.Media.releaseClient();
  }
}
</file>
                                        </folder>
                                    </folder>
                                </folder>
                            </folder>

    </xsl:template>

</xsl:stylesheet>