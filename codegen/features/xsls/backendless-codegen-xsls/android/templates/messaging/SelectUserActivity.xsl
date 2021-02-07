<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="SelectUserActivityTemplate">
                                            <file name="SelectUserActivity.java">
package <xsl:value-of select="$package"/>;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.*;
import com.backendless.Backendless;
import com.backendless.messaging.*;
import com.backendless.persistence.DataQueryBuilder;

import java.util.ArrayList;
import java.util.List;

public class SelectUserActivity extends Activity
{
  private Button previousPageButton, nextPageButton;
  private ListView usersList;

  private ArrayAdapter adapter;

  private List&lt;ChatUser&gt; users;
  private DataQueryBuilder queryBuilder = DataQueryBuilder.create();
  private ChatUser companion;
  private int totalPages;
  private int currentPageNumber;

  @Override
  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.select_user );

    currentPageNumber = 1;

    initUI();

    Backendless.Persistence.of( ChatUser.class ).find( new DefaultCallback&lt;List&lt;ChatUser&gt;&gt;( this, "Getting chat users" )
    {
      @Override
      public void handleResponse( final List&lt;ChatUser&gt; response )
      {
        super.handleResponse( response );
        Backendless.Persistence.of( ChatUser.class ).getObjectCount(new DefaultCallback&lt;Integer&gt;( SelectUserActivity.this )
        {
          @Override
          public void handleResponse( Integer totalCount )
          {
            super.handleResponse( totalCount );
            totalPages = (int) Math.ceil( (double) totalCount / response.size() );
            initList( response );
            initButtons();
          }
        });
      }
    } );
  }

  private void initUI()
  {
    usersList = (ListView) findViewById( R.id.usersList );
    previousPageButton = (Button) findViewById( R.id.previousButton );
    nextPageButton = (Button) findViewById( R.id.nextButton );

    usersList.setOnItemClickListener( new AdapterView.OnItemClickListener()
    {
      @Override
      public void onItemClick( AdapterView&lt;?&gt; parent, View view, int position, long id )
      {
        onListItemClick( position );
      }
    } );

    previousPageButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View v )
      {
        queryBuilder.preparePreviousPage();
        Backendless.Persistence.find( ChatUser.class, queryBuilder, new DefaultCallback&lt;List&lt;ChatUser&gt;&gt;( SelectUserActivity.this )
        {
          @Override
          public void handleResponse( List&lt;ChatUser&gt; response )
          {
            super.handleResponse( response );
            initList( response );
            currentPageNumber--;
            initButtons();
          }
        } );
      }
    } );

    nextPageButton.setOnClickListener( new View.OnClickListener()
    {
        @Override
        public void onClick( View v )
        {
          queryBuilder.prepareNextPage();
          Backendless.Persistence.find( ChatUser.class, queryBuilder, new DefaultCallback&lt;List&lt;ChatUser&gt;&gt;( SelectUserActivity.this )
          {
            @Override
            public void handleResponse( List&lt;ChatUser&gt; response )
            {
              super.handleResponse( response );
              initList( response );
              currentPageNumber++;
              initButtons();
            }
          } );
        }
    } );
  }

  private void onListItemClick( int position )
  {
    String companionNickname = usersList.getItemAtPosition( position ).toString();
    String whereClause = "nickname = '".concat( companionNickname ).concat( "'" );

    DataQueryBuilder queryBuilder = DataQueryBuilder.create().setWhereClause( whereClause );
    Backendless.Persistence.of( ChatUser.class ).find( queryBuilder, new DefaultCallback&lt;List&lt;ChatUser&gt;&gt;( this )
    {
      @Override
      public void handleResponse( List&lt;ChatUser&gt; response )
      {
        super.handleResponse( response );
        companion = response.iterator().next();
        onCompanionFound();
      }
    } );
  }

  private void onCompanionFound()
  {
    PublishOptions publishOptions = new PublishOptions();
    publishOptions.putHeader( PublishOptions.ANDROID_TICKER_TEXT_TAG, String.format( DefaultMessages.CONNECT_DEMAND, ChatUser.currentUser().getNickname() ) );
    publishOptions.putHeader( PublishOptions.ANDROID_CONTENT_TITLE_TAG, getResources().getString( R.string.app_name ) );
    publishOptions.putHeader( PublishOptions.ANDROID_CONTENT_TEXT_TAG, String.format( DefaultMessages.CONNECT_DEMAND, ChatUser.currentUser().getNickname() ) );
    DeliveryOptions deliveryOptions = new DeliveryOptions();
    deliveryOptions.setPublishPolicy( PublishPolicyEnum.PUSH );
    deliveryOptions.getPushSinglecast().add ( companion.getDeviceId() );

    final String message_subtopic = ChatUser.currentUser().getNickname().concat( "_with_" ).concat( companion.getNickname() );

    Backendless.Messaging.publish( Defaults.DEFAULT_CHANNEL, message_subtopic, publishOptions, deliveryOptions, new DefaultCallback&lt;MessageStatus&gt;( this, "Sending push message" )
    {
      @Override
      public void handleResponse( MessageStatus response )
      {
        super.handleResponse( response );

        PublishStatusEnum messageStatus = response.getStatus();

        if( messageStatus == PublishStatusEnum.SCHEDULED )
        {
          Intent chatIntent = new Intent( SelectUserActivity.this, ChatActivity.class );
          chatIntent.putExtra( "owner", true );
          chatIntent.putExtra( "subtopic", message_subtopic );
          chatIntent.putExtra( "companionNickname", companion.getNickname() );
          startActivity( chatIntent );
          finish();
        }
        else
        {
          Toast.makeText( SelectUserActivity.this, "Message status: " + messageStatus.toString(), Toast.LENGTH_SHORT ).show();
        }
      }
    } );
  }

  private void initList( List&lt;ChatUser&gt; response )
  {
    users = response;

    String[] usersArray = removeNulls( response );
    adapter = new ArrayAdapter&lt;String&gt;( this, R.layout.list_item_with_arrow, R.id.itemName, usersArray );
    usersList.setAdapter( adapter );
  }

  private void initButtons()
  {
    previousPageButton.setEnabled( currentPageNumber != 1 );
    nextPageButton.setEnabled( currentPageNumber != totalPages );
  }

  private String[] removeNulls( List&lt;ChatUser&gt; users )
  {
    List&lt;String&gt; result = new ArrayList&lt;String&gt;();
    for( int i = 0; i &lt; users.size(); i++ )
    {
      ChatUser chatUser = users.get( i );
      if( chatUser.getNickname() != null &amp;&amp; chatUser.getDeviceId() != null &amp;&amp; !chatUser.getDeviceId().isEmpty() &amp;&amp; !chatUser.getNickname().isEmpty() )
      {
        result.add( chatUser.getNickname() );
      }
    }

    return result.toArray( new String[ result.size() ] );
  }
}

                                            </file>
    </xsl:template>

</xsl:stylesheet>