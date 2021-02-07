<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="messaging-sources">
<folder name="com">
  <folder name="examples">
    <folder name="{$packageAppName}">
      <folder name="messaging">
        <xsl:call-template name="AcceptChatActivityTemplate" />
        <xsl:call-template name="ChatActivityTemplate" />
        <xsl:call-template name="ChatUserTemplate" />
        <xsl:call-template name="ChooseNicknameActivityTemplate" />
        <xsl:call-template name="DefaultCallbackTemplate" />
        <xsl:call-template name="SelectUserActivityTemplate" />




                                            <file name="DefaultMessages.java">
package <xsl:value-of select="$package"/>;

public class DefaultMessages
{
  public static String ACCEPT_CHAT_MESSAGE = "Companion accepted the invitation";
  public static String DECLINE_CHAT_MESSAGE = "Companion declined the invitation";
  public static String CONNECT_DEMAND = "User %s wants to chat with you";
}
                                            </file>
                                            <file name="Defaults.java">
package <xsl:value-of select="$package"/>;

public class Defaults
{
  <xsl:call-template name="common-defaults"/>
  //SET YOUR GOOGLE PROJECT ID BEFORE LAUNCH
  //ALSO YOU SHOULD SET GOOGLE API KEY IN BACKENDLESS CONSOLE
  public static final String GOOGLE_PROJECT_ID = "";

  public static final String DEFAULT_CHANNEL = "default";
}
                                            </file>
                                            <file name="PushService.java">
package <xsl:value-of select="$package"/>;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.support.v4.app.NotificationCompat;
import com.backendless.messaging.PublishOptions;
import com.backendless.push.BackendlessPushService;

public class PushService extends BackendlessPushService
{
  @Override
  public boolean onMessage( Context context, Intent intent )
  {
    CharSequence tickerText = intent.getStringExtra( PublishOptions.ANDROID_TICKER_TEXT_TAG );
    CharSequence contentTitle = intent.getStringExtra( PublishOptions.ANDROID_CONTENT_TITLE_TAG );
    CharSequence contentText = intent.getStringExtra( PublishOptions.ANDROID_CONTENT_TEXT_TAG );
    String subtopic = intent.getStringExtra( "message" );

    if( tickerText != null &amp;&amp; tickerText.length() > 0 )
    {
      int appIcon = context.getApplicationInfo().icon;
      if( appIcon == 0 )
      appIcon = android.R.drawable.sym_def_app_icon;

      Intent notificationIntent = new Intent( context, AcceptChatActivity.class );
      notificationIntent.putExtra( "subtopic", subtopic );
      PendingIntent contentIntent = PendingIntent.getActivity( context, 0, notificationIntent, PendingIntent.FLAG_CANCEL_CURRENT );

      NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder( context );
      notificationBuilder.setSmallIcon( appIcon );
      notificationBuilder.setTicker( tickerText );
      notificationBuilder.setWhen( System.currentTimeMillis() );
      notificationBuilder.setContentTitle( contentTitle );
      notificationBuilder.setContentText( contentText );
      notificationBuilder.setAutoCancel( true );
      notificationBuilder.setContentIntent( contentIntent );

      Notification notification = notificationBuilder.build();

      NotificationManager notificationManager = (NotificationManager) context.getSystemService( Context.NOTIFICATION_SERVICE );
      notificationManager.notify( 0, notification );
    }

    return false;
  }
}
                                            </file>
        <file name="PushReceiver.java">
package <xsl:value-of select="$package"/>;

import com.backendless.push.BackendlessBroadcastReceiver;
import com.backendless.push.BackendlessPushService;

public class PushReceiver extends BackendlessBroadcastReceiver
{
  @Override
  public Class&lt;? extends BackendlessPushService&gt; getServiceClass()
  {
    return PushService.class;
  }
}
        </file>
                                        </folder>
                                    </folder>
                                </folder>
                            </folder>

    </xsl:template>

</xsl:stylesheet>