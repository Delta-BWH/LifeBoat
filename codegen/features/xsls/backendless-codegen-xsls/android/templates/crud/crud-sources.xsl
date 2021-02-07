<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="crud-sources">
        <folder name="com/examples/{$packageAppName}/data/crud">
            <folder name="common">
                <file name="DataApplication.java">
package <xsl:value-of select="$package"/>.common;

import android.app.Application;

public class DataApplication extends Application
{
  private String chosenTable;

  public String getChosenTable()
  {
    return chosenTable;
  }

  public void setChosenTable( String chosenTable )
  {
    this.chosenTable = chosenTable;
  }
}</file>

                <file name="DefaultCallback.java">
package <xsl:value-of select="$package"/>.common;

import android.app.ProgressDialog;
import android.content.Context;
import android.widget.Toast;
import com.backendless.async.callback.BackendlessCallback;
import com.backendless.exceptions.BackendlessFault;

public class DefaultCallback&lt;T&gt; extends BackendlessCallback&lt;T&gt;
{
  private Context context;
  private ProgressDialog progressDialog;

  public DefaultCallback( Context context )
  {
    this.context = context;
    progressDialog = ProgressDialog.show( context, "", "Loading...", true );
  }

  @Override
  public void handleResponse( T response )
  {
    progressDialog.cancel();
  }

  @Override
  public void handleFault( BackendlessFault fault )
  {
    progressDialog.cancel();
    Toast.makeText( context, fault.getMessage(), Toast.LENGTH_LONG ).show();
  }
}</file>

                <file name="SendEmailActivity.java">
package <xsl:value-of select="$package"/>.common;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
import com.backendless.Backendless;
import com.backendless.messaging.MessageStatus;
import <xsl:value-of select="$package"/>.R;

public class SendEmailActivity extends Activity
{
  private EditText emailEdit;
  private Button sendButton;

  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.send_email );

    initUI();
  }

  private void initUI()
  {
    emailEdit = (EditText) findViewById( R.id.emailAddressEdit );
    sendButton = (Button) findViewById( R.id.sendButton );

    sendButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View view )
      {
        onSendButtonClicked();
      }
    } );
  }

  private void onSendButtonClicked()
  {
    String email = emailEdit.getText().toString();
    String code = getIntent().getStringExtra( "code" );
    String method = getIntent().getStringExtra( "method" );
    String table = getIntent().getStringExtra( "table" );

    String subject = String.format( "Code generation sample for: %s in %s table", method, table );

    Backendless.Messaging.sendTextEmail( subject, code, email, new DefaultCallback&lt;MessageStatus&gt;( SendEmailActivity.this )
    {
      @Override
      public void handleResponse( MessageStatus response )
      {
        super.handleResponse( response );
        Toast.makeText( getBaseContext(), "Email sent.", Toast.LENGTH_SHORT ).show();
      }
    } );
  }
}
                </file>

                <file name="Defaults.java">
package <xsl:value-of select="$package"/>.common;

public class Defaults
{
    <xsl:call-template name="common-defaults"/>
}
                </file>

            </folder>

            <folder name="start">
                <file name="SelectTableActivity.java">
package <xsl:value-of select="$package"/>.start;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import com.backendless.Backendless;
import <xsl:value-of select="$classesPackage"/>.*;
import <xsl:value-of select="$package"/>.R;
import <xsl:value-of select="$package"/>.common.DataApplication;
import <xsl:value-of select="$package"/>.common.Defaults;

public class SelectTableActivity extends Activity
{
  private ListView tablesListView;

  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.select_table );

    Backendless.setUrl( Defaults.SERVER_URL );
    Backendless.initApp( this, Defaults.APPLICATION_ID, Defaults.API_KEY );
    <xsl:for-each select="$tables/table[name != 'Users']">Backendless.Data.mapTableToClass( "<xsl:if test="dataConnectorName"><xsl:value-of select="dataConnectorName"/>.</xsl:if><xsl:value-of select="name"/>", <xsl:value-of select="name"/>.class );
    </xsl:for-each>
    initUI();
  }

  private void initUI()
  {
    tablesListView = (ListView) findViewById( R.id.tablesList );

    String[] tables = new String[] { <xsl:for-each select="$tables/table[name != 'Users']"><xsl:if test="position() > 1" >, </xsl:if>"<xsl:value-of select="name"/>"</xsl:for-each> };

    ArrayAdapter adapter = new ArrayAdapter&lt;String&gt;( this, R.layout.list_item_with_arrow, R.id.itemName, tables );
    tablesListView.setAdapter( adapter );

    tablesListView.setOnItemClickListener( new AdapterView.OnItemClickListener()
    {
      @Override
      public void onItemClick( AdapterView&lt;?&gt; adapterView, View view, int i, long l )
      {
        TextView tableNameView = (TextView) view.findViewById( R.id.itemName );
        DataApplication dataApplication = (DataApplication) getApplication();
        dataApplication.setChosenTable( tableNameView.getText().toString() );

        startActivity( new Intent( SelectTableActivity.this, SelectTableOperationActivity.class ) );
      }
    } );
  }
}
                </file>

                <file name="SelectTableOperationActivity.java">
package <xsl:value-of select="$package"/>.start;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import <xsl:value-of select="$package"/>.R;
import <xsl:value-of select="$package"/>.common.DataApplication;
import <xsl:value-of select="$package"/>.create.CreateRecordActivity;
import <xsl:value-of select="$package"/>.delete.DeleteRecordActivity;
import <xsl:value-of select="$package"/>.retrieve.SelectRetrievalTypeActivity;
import <xsl:value-of select="$package"/>.update.UpdateRecordActivity;

public class SelectTableOperationActivity extends Activity
{
  private ListView tableOperationsView;
  private TextView titleView;

  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.select_table_operation );

    initUI();
  }

  private void initUI()
  {
    tableOperationsView = (ListView) findViewById( R.id.tableOperationsList );
    titleView = (TextView) findViewById( R.id.tableOperationsTitle );

    String titleTemplate = getResources().getString( R.string.table_operations_title_template );
    DataApplication dataApplication = (DataApplication) getApplication();
    titleView.setText( String.format( titleTemplate, dataApplication.getChosenTable() ) );

    String[] tableOperations = getResources().getStringArray( R.array.table_operations );
    ArrayAdapter adapter = new ArrayAdapter( this, R.layout.list_item_with_arrow, R.id.itemName, tableOperations );
    tableOperationsView.setAdapter( adapter );

    tableOperationsView.setOnItemClickListener( new AdapterView.OnItemClickListener()
    {
      @Override
      public void onItemClick( AdapterView&lt;?&gt; adapterView, View view, int i, long l )
      {
        TextView chosenOperationView = (TextView) view.findViewById( R.id.itemName );
        String chosenOperation = chosenOperationView.getText().toString();

        if( chosenOperation.equals( "Create" ) )
        {
          startActivity( new Intent( SelectTableOperationActivity.this, CreateRecordActivity.class ) );
        }
        else if( chosenOperation.equals( "Retrieve" ) )
        {
          startActivity( new Intent( SelectTableOperationActivity.this, SelectRetrievalTypeActivity.class ) );
        }
        else if( chosenOperation.equals( "Update" ) )
        {
          startActivity( new Intent( SelectTableOperationActivity.this, UpdateRecordActivity.class ) );
        }
        else if( chosenOperation.equals( "Delete" ) )
        {
          startActivity( new Intent( SelectTableOperationActivity.this, DeleteRecordActivity.class ) );
        }
      }
    } );
  }
}
                </file>
            </folder>

            <folder name="create">
                <file name="CreateRecordActivity.java">
package <xsl:value-of select="$package"/>.create;

import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
import <xsl:value-of select="$package"/>.R;
import <xsl:value-of select="$package"/>.common.DataApplication;
import <xsl:value-of select="$package"/>.common.DefaultCallback;
import <xsl:value-of select="$package"/>.common.SendEmailActivity;
import com.backendless.geo.GeoPoint;
import <xsl:value-of select="$classesPackage"/>.*;

import java.util.ArrayList;
import java.util.Collections;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

public class CreateRecordActivity extends Activity
{
  private TextView titleView;
  private EditText codeEdit;
  private Button runCodeButton, sendCodeButton;

  private String code;
  private String table;

                                    <xsl:for-each select="$tables/table[name != 'Users']">
  class Create<xsl:value-of select="name"/>RecordTask extends AsyncTask&lt;Void, Void, <xsl:value-of select="name"/>&gt;
  {
    <xsl:value-of select="name"/><xsl:text> </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="name"/></xsl:call-template> = new <xsl:value-of select="name"/>();

    @Override
    protected void onPreExecute()
    {<xsl:text/>
                                          <xsl:for-each select="columns[(../../@type = 'internal' and name != 'created' and name != 'updated' and name != 'objectId' and name != 'ownerId') or (../../@type = 'external' and isPrimaryKey = 'false')]">
                                            <xsl:choose>
                                                <xsl:when test="dataType = 'DATETIME'"><xsl:text>
      </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new java.util.Date() );<xsl:text/>
                                                </xsl:when>
                                                <xsl:when test="dataType = 'BOOLEAN'"><xsl:text>
      </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new Random().nextBoolean() );<xsl:text/>
                                                </xsl:when>
                                                <xsl:when test="dataType = 'INT' or dataType = 'AUTO_INCREMENT'"><xsl:text>
      </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new Random().nextInt( (int) (Math.pow( 2, 29 ) / 2 - 1) ) );<xsl:text/>
                                                </xsl:when>
                                                <xsl:when test="dataType = 'DOUBLE'"><xsl:text>
      </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new Random().nextDouble() );<xsl:text/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:choose>
                                                        <xsl:when test="dataSize &lt; 36"><xsl:text>
      </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( UUID.randomUUID().toString().substring( 0, <xsl:value-of select="dataSize"/> ) );<xsl:text/>
                                                        </xsl:when>
                                                        <xsl:otherwise><xsl:text>
      </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( UUID.randomUUID().toString() );<xsl:text/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:for-each>
                                        <xsl:for-each select="relations">
                                            <xsl:if test="toTableName != 'Users'">
                                                <xsl:choose>
                                                    <xsl:when test="relationshipType = 'ONE_TO_MANY'"><xsl:text>
      </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new ArrayList&lt;<xsl:value-of select="toTableName"/>&gt;() );<xsl:text/>
                                                    </xsl:when>
                                                    <xsl:when test="relationshipType = 'ONE_TO_ONE'"><xsl:text>
      </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( null );<xsl:text/>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </xsl:if>
                                        </xsl:for-each>
                                        <xsl:for-each select="geoRelations">
                                                <xsl:choose>
                                                    <xsl:when test="relationshipType = 'ONE_TO_MANY'"><xsl:text>
      </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new ArrayList&lt;GeoPoint&gt;()
        {{
            add( new GeoPoint( 90 * new Random().nextDouble(), 180 * new Random().nextDouble() ) );
          }} );<xsl:text/>
                                                    </xsl:when>
                                                    <xsl:when test="relationshipType = 'ONE_TO_ONE'"><xsl:text>
      </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new GeoPoint( 90 * new Random().nextDouble(), 180 * new Random().nextDouble() ) );<xsl:text/>
                                                    </xsl:when>
                                                </xsl:choose>
                                        </xsl:for-each>
    }

    @Override
    protected <xsl:value-of select="name"/> doInBackground( Void... voids )
    {
      return <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="name"/></xsl:call-template>.save();
    }
  };
                                    </xsl:for-each>

  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.sample_code_template );

    DataApplication dataApplication = (DataApplication) getApplication();
    table = dataApplication.getChosenTable();

    initUI();
  }

  private void initUI()
  {
    titleView = (TextView) findViewById( R.id.sampleCodeTitle );
    codeEdit = (EditText) findViewById( R.id.sampleCodeEdit );
    runCodeButton = (Button) findViewById( R.id.runCodeButton );
    sendCodeButton = (Button) findViewById( R.id.sendCodeButton );

    String titleTemplate = getResources().getString( R.string.create_record_title_template );
    String title = String.format( titleTemplate, table );
    titleView.setText( title );

    <xsl:text/>
                                                        <xsl:for-each select="$tables/table[name != 'Users']">
                                                            <xsl:if test="position() > 1" >    else </xsl:if>
    <xsl:text/>if( table.equals( "<xsl:value-of select="name"/>" ) )
    {
      code = get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>CreationCode();
    }
<xsl:text/>
                                                        </xsl:for-each>
    codeEdit.setText( code );

    runCodeButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View view )
      {
        onRunCodeButtonClicked();
      }
    } );

    sendCodeButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View view )
      {
        onSendCodeButtonClicked();
      }
    } );
  }

  private void onRunCodeButtonClicked()
  {
    <xsl:text/>
                                                        <xsl:for-each select="$tables/table[name != 'Users']">
                                                            <xsl:if test="position() > 1">    else </xsl:if>
    <xsl:text/>if( table.equals( "<xsl:value-of select="name"/>" ) )
    {
      create<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record();
    }
<xsl:text/>
                                                        </xsl:for-each>
<xsl:text/>  }

  private void onSendCodeButtonClicked()
  {
    Intent nextIntent = new Intent( getBaseContext(), SendEmailActivity.class );
    nextIntent.putExtra( "code", code );
    nextIntent.putExtra( "table", table );
    nextIntent.putExtra( "method", "Create" );
    startActivity( nextIntent );
  }
<xsl:text/>
                                                        <xsl:for-each select="$tables/table[name != 'Users']">
  private String get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>CreationCode()
  {
    return "<xsl:value-of select="name"/><xsl:text> </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="name"/></xsl:call-template> = new <xsl:value-of select="name"/>();\n"<xsl:text/>
                                                            <xsl:for-each select="columns[(../../@type = 'internal' and name != 'created' and name != 'updated' and name != 'objectId' and name != 'ownerId' and dataType != 'GEO_POINT' and dataType != 'GEO_POINT_COLLECTION') or (../../@type = 'external')]">
                                                                    <xsl:choose>
                                                                        <xsl:when test="dataType = 'DATETIME'">
            + "<xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new java.util.Date() );\n"<xsl:text/>
                                                                        </xsl:when>
                                                                        <xsl:when test="dataType = 'BOOLEAN'">
            + "<xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new Random().nextBoolean() );\n"<xsl:text/>
                                                                        </xsl:when>
                                                                        <xsl:when test="dataType = 'INT' or dataType = 'AUTO_INCREMENT'">
            + "<xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new Random().nextInt( (int) (Math.pow( 2, 29 ) / 2 - 1) ) );\n"<xsl:text/>
                                                                        </xsl:when>
                                                                        <xsl:when test="dataType = 'DOUBLE'">
            + "<xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new Random().nextDouble() );\n"<xsl:text/>
                                                                        </xsl:when>
                                                                        <xsl:when test="dataType = 'STRING'">
                                                                            <xsl:choose>
                                                                                <xsl:when test="dataSize &lt; 36">
            + "<xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( UUID.randomUUID().toString().substring( 0, <xsl:value-of select="dataSize"/> ) );\n"<xsl:text/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
            + "<xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( UUID.randomUUID().toString() );\n"<xsl:text/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </xsl:when>
                                                                        <xsl:when test="dataType = 'TEXT' or dataType = 'UNKNOWN'">
            + "<xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( UUID.randomUUID().toString() );\n"<xsl:text/>
                                                                        </xsl:when>
                                                                    </xsl:choose>
                                                            </xsl:for-each>
            + "<xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="name"/></xsl:call-template>.saveAsync( new AsyncCallback&lt;<xsl:value-of select="name"/>&gt;()\n"
            + "{\n"
            + "  @Override\n"
            + "  public void handleResponse( <xsl:value-of select="name"/> saved<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template> )\n"
            + "  {\n"
            + "    <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="name"/></xsl:call-template> = saved<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>;\n"
            + "  }\n"
            + "  @Override\n"
            + "  public void handleFault( BackendlessFault fault )\n"
            + "  {\n"
            + "    Toast.makeText( getBaseContext(), fault.getMessage(), Toast.LENGTH_SHORT ).show();\n"
            + "  }\n"
            + "});";
  }

  private void create<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record()
  {
    <xsl:value-of select="name"/><xsl:text> </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="name"/></xsl:call-template> = null;

    try
    {
      <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="name"/></xsl:call-template> = new Create<xsl:value-of select="name"/>RecordTask().execute().get( 30, TimeUnit.SECONDS );
    }
    catch ( Exception e )
    {
      Toast.makeText( this, e.getMessage(), Toast.LENGTH_SHORT ).show();
      return;
    }

    Intent nextIntent = new Intent( CreateRecordActivity.this, CreateSuccessActivity.class );
    startActivity( nextIntent );
  }
<xsl:text/>
                                                        </xsl:for-each>
<xsl:text/>}</file>
                <file name="CreateSuccessActivity.java">
package <xsl:value-of select="$package"/>.create;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;
import <xsl:value-of select="$package"/>.R;

public class CreateSuccessActivity extends Activity
{
  private TextView successInfoView;
  private TextView operationInfoView;

  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.sample_success );

    initUI();
  }

  private void initUI()
  {
    successInfoView = (TextView) findViewById( R.id.successInfo );
    operationInfoView = (TextView) findViewById( R.id.operationInfo );

    String successInfoTemplate = getResources().getString( R.string.success_info_template );
    String successInfo = String.format( successInfoTemplate, "created" );
    successInfoView.setText( successInfo );
  }
}</file>
            </folder>

            <folder name="delete">
                <file name="DeleteRecordActivity.java">
package <xsl:value-of select="$package"/>.delete;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import <xsl:value-of select="$package"/>.R;
import <xsl:value-of select="$package"/>.common.DataApplication;
import <xsl:value-of select="$package"/>.common.DefaultCallback;
import <xsl:value-of select="$package"/>.common.SendEmailActivity;
import <xsl:value-of select="$classesPackage"/>.*;

public class DeleteRecordActivity extends Activity
{
  private TextView titleView;
  private EditText codeView;
  private Button runCodeButton, sendCodeButton;

  private String code;
  private String table;

  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.sample_code_template );

    DataApplication dataApplication = (DataApplication) getApplication();
    table = dataApplication.getChosenTable();

    initUI();
  }

  private void initUI()
  {
    titleView = (TextView) findViewById( R.id.sampleCodeTitle );
    codeView = (EditText) findViewById( R.id.sampleCodeEdit );
    runCodeButton = (Button) findViewById( R.id.runCodeButton );
    sendCodeButton = (Button) findViewById( R.id.sendCodeButton );

    String titleTemplate = getResources().getString( R.string.delete_title_template );
    String title = String.format( titleTemplate, table );
    titleView.setText( title );

    <xsl:text/>
                                                        <xsl:for-each select="$tables/table[name != 'Users']">
                                                            <xsl:if test="position() > 1">    else </xsl:if>
    <xsl:text/>if( table.equals( "<xsl:value-of select="name"/>" ) )
    {
      code = get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>DeletionCode();
    }
<xsl:text/>
                                                        </xsl:for-each>
    codeView.setText( code );

    runCodeButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View view )
      {
        onRunCodeButtonClicked();
      }
    } );

    sendCodeButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View view )
      {
        onSendCodeButtonClicked();
      }
    } );
  }

  private void onRunCodeButtonClicked()
  {
    <xsl:text/>
                                                        <xsl:for-each select="$tables/table[name != 'Users']">
                                                            <xsl:if test="position() > 1">    else </xsl:if>
    <xsl:text/>if( table.equals( "<xsl:value-of select="name"/>" ) )
    {
      delete<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record();
    }
<xsl:text/>
                                                        </xsl:for-each>
<xsl:text/>  }

  private void onSendCodeButtonClicked()
  {
    Intent nextIntent = new Intent( getBaseContext(), SendEmailActivity.class );
    nextIntent.putExtra( "code", code );
    nextIntent.putExtra( "table", table );
    nextIntent.putExtra( "method", "Delete" );
    startActivity( nextIntent );
  }
<xsl:text/>
                                                        <xsl:for-each select="$tables/table[name != 'Users']">
  private String get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>DeletionCode()
  {
    return "public void remove( <xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template><xsl:text> </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="name"/></xsl:call-template> )\n"
            + "{\n"
            + "  <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="name"/></xsl:call-template>.removeAsync( new AsyncCallback&lt;Long&gt;()\n"
            + "  {\n"
            + "    @Override\n"
            + "    public void handleResponse( Long deletionTime )\n"
            + "    {\n"
            + "      Toast.makeText( getBaseContext(), \"Deletion time: \" + new Date( deletionTime ).toString(), Toast.LENGTH_SHORT ).show();\n"
            + "    }\n"
            + "    @Override\n"
            + "    public void handleFault( BackendlessFault fault )\n"
            + "    {\n"
            + "      Toast.makeText( getBaseContext(), fault.getMessage(), Toast.LENGTH_SHORT ).show();\n"
            + "    }\n"
            + "  }\n"
            + "}";
  }

  private void delete<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record()
  {
    <xsl:value-of select="name"/>.findFirstAsync( new DefaultCallback&lt;<xsl:value-of select="name"/>&gt;( DeleteRecordActivity.this )
    {
      @Override
      public void handleResponse( <xsl:value-of select="name"/> response )
      {
        super.handleResponse( response );
        <xsl:value-of select="name"/> first<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template> = response;
        first<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>.removeAsync( new DefaultCallback&lt;Long&gt;( DeleteRecordActivity.this )
        {
          @Override
          public void handleResponse( Long response )
          {
            super.handleResponse( response );
            Intent nextIntent = new Intent( getBaseContext(), DeleteSuccessActivity.class );
            nextIntent.putExtra( "time", response );
            startActivity( nextIntent );
          }
        } );
      }
    } );
  }
<xsl:text/>
                                                        </xsl:for-each>
<xsl:text/>}</file>
                <file name="DeleteSuccessActivity.java">
package <xsl:value-of select="$package"/>.delete;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;
import <xsl:value-of select="$package"/>.R;

import java.util.Date;

public class DeleteSuccessActivity extends Activity
{
  private TextView successInfoView;
  private TextView operationInfoView;

  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.sample_success );

    initUI();
  }

  private void initUI()
  {
    successInfoView = (TextView) findViewById( R.id.successInfo );
    operationInfoView = (TextView) findViewById( R.id.operationInfo );

    String successInfoTemplate = getResources().getString( R.string.success_info_template );
    String successInfo = String.format( successInfoTemplate, "deleted" );
    successInfoView.setText( successInfo );

    Long time = getIntent().getLongExtra( "time", new Date().getTime() );
    Date deletion = new Date( time );
    operationInfoView.setText( "Deletion time: " + deletion.toString() );
  }
}
                                </file>
            </folder>

            <folder name="update">
                <file name="UpdateRecordActivity.java">
package <xsl:value-of select="$package"/>.update;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import <xsl:value-of select="$package"/>.R;
import <xsl:value-of select="$package"/>.common.DataApplication;
import <xsl:value-of select="$package"/>.common.DefaultCallback;
import <xsl:value-of select="$package"/>.common.SendEmailActivity;
import <xsl:value-of select="$classesPackage"/>.*;
import com.backendless.geo.GeoPoint;

import java.util.Collections;

import java.util.Random;
import java.util.UUID;

public class UpdateRecordActivity extends Activity
{
  private TextView titleView;
  private EditText codeView;
  private Button runCodeButton, sendCodeButton;

  private String code;
  private String table;

  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.sample_code_template );

    DataApplication dataApplication = (DataApplication) getApplication();
    table = dataApplication.getChosenTable();

    initUI();
  }

  private void initUI()
  {
    titleView = (TextView) findViewById( R.id.sampleCodeTitle );
    codeView = (EditText) findViewById( R.id.sampleCodeEdit );
    runCodeButton = (Button) findViewById( R.id.runCodeButton );
    sendCodeButton = (Button) findViewById( R.id.sendCodeButton );

    String titleTemplate = getResources().getString( R.string.update_title_template );
    String title = String.format( titleTemplate, table );

    titleView.setText( title );

    <xsl:text/>
                                                        <xsl:for-each select="$tables/table[name != 'Users']">
                                                            <xsl:if test="position() > 1">    else </xsl:if>
    <xsl:text/>if( table.equals( "<xsl:value-of select="name"/>" ) )
    {
      code = get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>UpdateCode();
    }
<xsl:text/>
                                                        </xsl:for-each>
    codeView.setText( code );

    runCodeButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View view )
      {
        onRunCodeButtonClicked();
      }
    } );

    sendCodeButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View view )
      {
        onSendCodeButtonClicked();
      }
    } );
  }

  private void onRunCodeButtonClicked()
  {
    <xsl:text/>
                                                        <xsl:for-each select="$tables/table[name != 'Users']">
                                                            <xsl:if test="position() > 1">    else </xsl:if>
    <xsl:text/>if( table.equals( "<xsl:value-of select="name"/>" ) )
    {
      update<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record();
    }
<xsl:text/>
                                                        </xsl:for-each>
<xsl:text/>  }

  private void onSendCodeButtonClicked()
  {
    Intent nextIntent = new Intent( getBaseContext(), SendEmailActivity.class );
    nextIntent.putExtra( "code", code );
    nextIntent.putExtra( "table", table );
    nextIntent.putExtra( "method", "Update" );
    startActivity( nextIntent );
  }
<xsl:text/>
                                                        <xsl:for-each select="$tables/table[name != 'Users']">
  private String get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>UpdateCode()
  {
    return "public void update( <xsl:value-of select="name"/><xsl:text> </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="name"/></xsl:call-template> )\n"
            + "{\n"<xsl:text/>
                                                            <xsl:for-each select="columns[(../../@type = 'internal' and name != 'created' and name != 'updated' and name != 'objectId' and name != 'ownerId' and dataType != 'GEO_POINT' and dataType != 'GEO_POINT_COLLECTION') or (../../@type = 'external')]">
                                                                    <xsl:choose>
                                                                        <xsl:when test="dataType = 'DATETIME'">
            + "  <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new java.util.Date() );\n"<xsl:text/>
                                                                        </xsl:when>
                                                                        <xsl:when test="dataType = 'BOOLEAN'">
            + "  <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new Random().nextBoolean() );\n"<xsl:text/>
                                                                        </xsl:when>
                                                                        <xsl:when test="dataType = 'INT' or dataType = 'AUTO_INCREMENT'">
            + "  <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new Random().nextInt( (int) (Math.pow( 2, 29 ) / 2 - 1) ) );\n"<xsl:text/>
                                                                        </xsl:when>
                                                                        <xsl:when test="dataType = 'DOUBLE'">
            + "  <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new Random().nextDouble() );\n"<xsl:text/>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:choose>
                                                                                <xsl:when test="dataSize &lt; 36">
            + "  <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( UUID.randomUUID().toString().substring( 0, <xsl:value-of select="dataSize"/> ) );\n"<xsl:text/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
            + "  <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( UUID.randomUUID().toString() );\n"<xsl:text/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                            </xsl:for-each>
            + "  <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="name"/></xsl:call-template>.saveAsync( new AsyncCallback&lt;<xsl:value-of select="name"/>&gt;()\n"
            + "  {\n"
            + "    @Override\n"
            + "    public void handleResponse( <xsl:value-of select="name"/> updatedRecord )\n"
            + "    {\n"
            + "      //work with object\n"
            + "    }\n"
            + "    @Override\n"
            + "    public void handleFault( BackendlessFault fault )\n"
            + "    {\n"
            + "      Toast.makeText( getBaseContext(), fault.getMessage(), Toast.LENGTH_SHORT ).show();\n"
            + "    }\n"
            + "  }\n"
            + "}";
  }

  private void update<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record()
  {
    <xsl:value-of select="name"/>.findFirstAsync( new DefaultCallback&lt;<xsl:value-of select="name"/>&gt;( UpdateRecordActivity.this )
    {
      @Override
      public void handleResponse( <xsl:value-of select="name"/> response )
      {
        super.handleResponse( response );
        <xsl:value-of select="name"/><xsl:text> </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="name"/></xsl:call-template> = response;<xsl:text/>
                                                            <xsl:for-each select="columns[(../../@type = 'internal' and name != 'created' and name != 'updated' and name != 'objectId' and name != 'ownerId' and dataType != 'GEO_POINT' and dataType != 'GEO_POINT_COLLECTION') or (../../@type = 'external' and isPrimaryKey = 'false')]">
                                                                    <xsl:choose>
                                                                        <xsl:when test="dataType = 'DATETIME'"><xsl:text>
        </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new java.util.Date() );<xsl:text/>
                                                                        </xsl:when>
                                                                        <xsl:when test="dataType = 'BOOLEAN'"><xsl:text>
        </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new Random().nextBoolean() );<xsl:text/>
                                                                        </xsl:when>
                                                                        <xsl:when test="dataType = 'INT' or dataType = 'AUTO_INCREMENT'"><xsl:text>
        </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new Random().nextInt( (int) (Math.pow( 2, 29 ) / 2 - 1) ) );<xsl:text/>
                                                                        </xsl:when>
                                                                        <xsl:when test="dataType = 'DOUBLE'"><xsl:text>
        </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( new Random().nextDouble() );<xsl:text/>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:choose>
                                                                                <xsl:when test="dataSize &lt; 36"><xsl:text>
        </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( UUID.randomUUID().toString().substring( 0, <xsl:value-of select="dataSize"/> ) );<xsl:text/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise><xsl:text>
        </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( UUID.randomUUID().toString() );<xsl:text/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                            </xsl:for-each><xsl:text>

        </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="name"/></xsl:call-template>.saveAsync( new DefaultCallback&lt;<xsl:value-of select="name"/>&gt;( UpdateRecordActivity.this )
        {
          @Override
          public void handleResponse( <xsl:value-of select="name"/> response )
          {
            super.handleResponse( response );
            Intent nextIntent = new Intent( UpdateRecordActivity.this, UpdateSuccessActivity.class );
            startActivity( nextIntent );
          }
        } );
      }
    } );
  }
<xsl:text/>
                                                        </xsl:for-each>
<xsl:text/>}</file>
                <file name="UpdateSuccessActivity.java">
package <xsl:value-of select="$package"/>.update;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;
import <xsl:value-of select="$package"/>.R;

import java.util.Date;

public class UpdateSuccessActivity extends Activity
{
  private TextView successInfoView;
  private TextView operationInfoView;

  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.sample_success );

    initUI();
  }

  private void initUI()
  {
    successInfoView = (TextView) findViewById( R.id.successInfo );
    operationInfoView = (TextView) findViewById( R.id.operationInfo );

    String successInfoTemplate = getResources().getString( R.string.success_info_template );
    String successInfo = String.format( successInfoTemplate, "updated" );
    successInfoView.setText( successInfo );
  }
}</file>
            </folder>

            <folder name="retrieve">
                <file name="SelectRetrievalTypeActivity.java">
package <xsl:value-of select="$package"/>.retrieve;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import <xsl:value-of select="$package"/>.R;
import <xsl:value-of select="$package"/>.common.DataApplication;

import java.util.ArrayList;

public class SelectRetrievalTypeActivity extends Activity
{
  private TextView titleView;
  private ListView retrieveOptionsView;

  private String table;
  private String[] properties;
  private String[] relations;
  private String[] relatedTables;

  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.select_retrieval_type );

    DataApplication dataApplication = (DataApplication) getApplication();
    table = dataApplication.getChosenTable();

    initUI();
  }

  private void initUI()
  {
    titleView = (TextView) findViewById( R.id.retrieveTitle );
    retrieveOptionsView = (ListView) findViewById( R.id.retrieveOptionsList );

    String titleTemplate = getResources().getString( R.string.retrieve_title_template );
    String title = String.format( titleTemplate, table );
    titleView.setText( title );

    String[] retrieveOptions = getResources().getStringArray( R.array.retrieve_options );
    ArrayAdapter adapter = new ArrayAdapter( getBaseContext(), R.layout.list_item_with_arrow, R.id.itemName, retrieveOptions );
    retrieveOptionsView.setAdapter( adapter );

    retrieveOptionsView.setOnItemClickListener( new AdapterView.OnItemClickListener()
    {
      @Override
      public void onItemClick( AdapterView&lt;?&gt; adapterView, View view, int i, long l )
      {
        TextView selectedItemView = (TextView) view.findViewById( R.id.itemName );
        String option = selectedItemView.getText().toString();
        onOptionChosen( option );
      }
    } );
  }

  private void onOptionChosen( String option )
  {
    final Intent nextIntent = new Intent( this, RetrieveRecordActivity.class );
    nextIntent.putExtra( "type", option );

    if( option.equals( "Find with Sort" ) )
    {
      AlertDialog.Builder builder = new AlertDialog.Builder( this );
      builder.setTitle( "Properties to sort by:" );
      final ArrayList&lt;CharSequence&gt; selectedItems = new ArrayList&lt;CharSequence&gt;();

      <xsl:text/>
                                                        <xsl:for-each select="$tables/table[name != 'Users']">
                                                            <xsl:if test="position() > 1">      else </xsl:if>
      <xsl:text/>if( table.equals( "<xsl:value-of select="name"/>" ) )
      {
        properties = new String[] { <xsl:for-each select="columns"><xsl:if test="position() > 1">, </xsl:if>"<xsl:value-of select="name"/>"<xsl:text/></xsl:for-each> };
      }
<xsl:text/>
                                                        </xsl:for-each>
      builder.setMultiChoiceItems( properties, null, new DialogInterface.OnMultiChoiceClickListener()
      {
        @Override
        public void onClick( DialogInterface dialogInterface, int which, boolean isChecked )
        {
          if( isChecked )
          {
            selectedItems.add( properties[ which ] );
          }
          else if( selectedItems.contains( properties[ which ] ) )
          {
            selectedItems.remove( properties[ which ] );
          }
        }
      } );

      builder.setPositiveButton( "Find", new DialogInterface.OnClickListener()
      {
        @Override
        public void onClick( DialogInterface dialogInterface, int i )
        {
          nextIntent.putCharSequenceArrayListExtra( "selectedProperties", selectedItems );
          startActivity( nextIntent );
        }
      } );

      builder.create().show();
    }
    else if( option.equals( "Find with Relations" ) )
    {
      AlertDialog.Builder builder = new AlertDialog.Builder( this );
      builder.setTitle( "Relations to preload:" );
      final ArrayList&lt;CharSequence&gt; selectedRelations = new ArrayList&lt;CharSequence&gt;();
      final ArrayList&lt;CharSequence&gt; selectedRelatedTables = new ArrayList&lt;CharSequence&gt;();

      <xsl:text/>
                                                        <xsl:for-each select="$tables/table[name != 'Users']">
                                                            <xsl:if test="position() > 1">      else </xsl:if>
      <xsl:text/>if( table.equals( "<xsl:value-of select="name"/>" ) )
      {
        relations = new String[] { <xsl:for-each select="relations"><xsl:if test="position() > 1">, </xsl:if>"<xsl:value-of select="name"/>"</xsl:for-each><xsl:for-each select="geoRelations"><xsl:if test="../relations or position() > 1">, </xsl:if>"<xsl:value-of select="name"/>"</xsl:for-each> };
        relatedTables = new String[] { <xsl:for-each select="relations"><xsl:if test="position() > 1">, </xsl:if>"<xsl:value-of select="toTableName"/>"</xsl:for-each><xsl:for-each select="geoRelations"><xsl:if test="../relations or position() > 1">, </xsl:if>"GeoPoint"</xsl:for-each> };
      }
<xsl:text/>
                                                        </xsl:for-each>
      builder.setMultiChoiceItems( relations, null, new DialogInterface.OnMultiChoiceClickListener()
      {
        @Override
        public void onClick( DialogInterface dialogInterface, int which, boolean isChecked )
        {
          if( isChecked )
          {
            selectedRelations.add( relations[ which ] );
            selectedRelatedTables.add( relatedTables[ which ] );
          }
          else if( selectedRelations.contains( relations[ which ] ) )
          {
            selectedRelations.remove( relations[ which ] );
            selectedRelatedTables.remove( relatedTables[ which ] );
          }
        }
      } );

      builder.setPositiveButton( "Find", new DialogInterface.OnClickListener()
      {
        @Override
        public void onClick( DialogInterface dialogInterface, int i )
        {
          nextIntent.putCharSequenceArrayListExtra( "selectedRelations", selectedRelations );
          nextIntent.putCharSequenceArrayListExtra( "selectedRelatedTables", selectedRelatedTables );
          startActivity( nextIntent );
        }
      } );

      builder.create().show();
    }
    else
    {
      startActivity( nextIntent );
    }
  }
}</file>
                <file name="RetrieveRecordActivity.java">
package <xsl:value-of select="$package"/>.retrieve;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import <xsl:value-of select="$package"/>.R;
import <xsl:value-of select="$package"/>.common.DataApplication;
import <xsl:value-of select="$package"/>.common.DefaultCallback;
import <xsl:value-of select="$package"/>.common.SendEmailActivity;
import <xsl:value-of select="$classesPackage"/>.*;
import com.backendless.persistence.DataQueryBuilder;

import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class RetrieveRecordActivity extends Activity
{
  private TextView titleView;
  private EditText codeView;
  private Button runCodeButton, sendCodeButton;

  private String code;
  private String table;
  private String type;

  private static List resultCollection;
  private static Object resultObject;
  public static DataQueryBuilder queryBuilder;
  public static Class entityClass;

  private String selectedProperty;
  private String selectedRelatedTable;
  private String selectedRelatedProperty;
  private String relation;
  private String[] relatedProperties;

  public static List getResultCollection()
  {
    return resultCollection;
  }

  public static Object getResultObject()
  {
    return resultObject;
  }

  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.sample_code_template );

    DataApplication dataApplication = (DataApplication) getApplication();
    table = dataApplication.getChosenTable();

    type = getIntent().getStringExtra( "type" );

    initUI();
  }

  private void initUI()
  {
    titleView = (TextView) findViewById( R.id.sampleCodeTitle );
    codeView = (EditText) findViewById( R.id.sampleCodeEdit );
    runCodeButton = (Button) findViewById( R.id.runCodeButton );
    sendCodeButton = (Button) findViewById( R.id.sendCodeButton );

    String titleTemplate = getResources().getString( R.string.retrieve_title_template );
    String title = String.format( titleTemplate, table );
    titleView.setText( title );
    <xsl:text/>
                                                        <xsl:for-each select="$tables/table[name != 'Users']">
                                                            <xsl:if test="position() > 1">    else </xsl:if>
    <xsl:text/>if( table.equals( "<xsl:value-of select="name"/>" ) )
    {
      code = get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>RetrievalCode();
    }
<xsl:text/>
                                                        </xsl:for-each>
    codeView.setText( code );

    runCodeButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View view )
      {
        onRunCodeButtonClicked();
      }
    } );

    sendCodeButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View view )
      {
        onSendCodeButtonClicked();
      }
    } );
  }

  private void onRunCodeButtonClicked()
  {
    <xsl:text/>
                                                        <xsl:for-each select="$tables/table[name != 'Users']">
                                                            <xsl:if test="position() > 1">    else </xsl:if>
    <xsl:text/>if( table.equals( "<xsl:value-of select="name"/>" ) )
    {
      retrieve<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record();
    }
<xsl:text/>
                                                        </xsl:for-each>
<xsl:text/>  }

  private void onSendCodeButtonClicked()
  {
    Intent nextIntent = new Intent( getBaseContext(), SendEmailActivity.class );
    nextIntent.putExtra( "code", code );
    nextIntent.putExtra( "table", table );
    nextIntent.putExtra( "method", type );
    startActivity( nextIntent );
  }
                                                        <xsl:for-each select="$tables/table[name != 'Users']">
  private String get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>RetrievalCode()
  {
    if( type.equals( "Basic Find" ) )
    {
      return getBasic<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>RetrievalCode();
    }
    else if( type.equals( "Find First" ) )
    {
      return getFirst<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>RetrievalCode();
    }
    else if( type.equals( "Find Last" ) )
    {
      return getLast<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>RetrievalCode();
    }
    else if( type.equals( "Find with Sort" ) )
    {
      return getSorted<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>RetrievalCode();
    }
    else if( type.equals( "Find with Relations" ) )
    {
      return getRelated<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>RetrievalCode();
    }
    return null;
  }

  private void retrieve<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record()
  {
    if( type.equals( "Basic Find" ) )
    {
      retrieveBasic<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record();
    }
    else if( type.equals( "Find First" ) )
    {
      retrieveFirst<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record();
    }
    else if( type.equals( "Find Last" ) )
    {
      retrieveLast<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record();
    }
    else if( type.equals( "Find with Sort" ) )
    {
      retrieveSorted<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record();
    }
    else if( type.equals( "Find with Relations" ) )
    {
      retrieveRelated<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record();
    }
  }

  private String getBasic<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>RetrievalCode()
  {
    return "BackendlessDataQuery query = new BackendlessDataQuery();\n"
            + "<xsl:value-of select="name"/>.findAsync( query, new AsyncCallback&lt;List&lt;<xsl:value-of select="name"/>&gt;&gt;()\n"
            + "{\n"
            + "  @Override\n"
            + "  public void handleResponse( List&lt;<xsl:value-of select="name"/>&gt; response )\n"
            + "  {\n"
            + "    <xsl:value-of select="name"/> first<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template> = response.get( 0 );\n"
            + "  }\n"
            + "  @Override\n"
            + "  public void handleFault( BackendlessFault fault )\n"
            + "  {\n"
            + "    Toast.makeText( getBaseContext(), fault.getMessage(), Toast.LENGTH_SHORT ).show();\n"
            + "  }\n"
            + "} );";
  }

  private void retrieveBasic<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record()
  {
    queryBuilder = DataQueryBuilder.create();
    entityClass = <xsl:value-of select="name"/>.class;
    <xsl:value-of select="name"/>.findAsync( queryBuilder, new DefaultCallback&lt;List&lt;<xsl:value-of select="name"/>&gt;&gt;( RetrieveRecordActivity.this )
    {
      @Override
      public void handleResponse( List&lt;<xsl:value-of select="name"/>&gt; response )
      {
        super.handleResponse( response );

        resultCollection = response;

        AlertDialog.Builder builder = new AlertDialog.Builder( RetrieveRecordActivity.this );
        builder.setTitle( "Property to show:" );
        final String[] properties = { <xsl:for-each select="columns"><xsl:if test="position() > 1">, </xsl:if>"<xsl:value-of select="name"/>"</xsl:for-each> };
        builder.setItems( properties, new DialogInterface.OnClickListener()
        {
          @Override
          public void onClick( DialogInterface dialogInterface, int i )
          {
            Intent nextIntent = new Intent( RetrieveRecordActivity.this, ShowByPropertyActivity.class );
            nextIntent.putExtra( "type", type );
            nextIntent.putExtra( "property", properties[ i ] );
            startActivity( nextIntent );
            dialogInterface.cancel();
          }
        } );
        builder.create().show();
      }
    } );
  }

  private String getFirst<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>RetrievalCode()
  {
    return "<xsl:value-of select="name"/>.findFirstAsync( new AsyncCallback&lt;<xsl:value-of select="name"/>&gt;()\n"
            + "{\n"
            + "  @Override\n"
            + "  public void handleResponse( <xsl:value-of select="name"/> object )\n"
            + "  {\n"
            + "    //work with the object\n"
            + "  }\n"
            + "  @Override\n"
            + "  public void handleFault( BackendlessFault fault )\n"
            + "  {\n"
            + "    Toast.makeText( getBaseContext(), fault.getMessage(), Toast.LENGTH_SHORT ).show();\n"
            + "  }\n"
            + "} );";
  }

  private void retrieveFirst<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record()
  {
    <xsl:value-of select="name"/>.findFirstAsync( new DefaultCallback&lt;<xsl:value-of select="name"/>&gt;( RetrieveRecordActivity.this )
    {
      @Override
      public void handleResponse( <xsl:value-of select="name"/> response )
      {
        super.handleResponse( response );
        resultObject = response;
        Intent nextIntent = new Intent( RetrieveRecordActivity.this, ShowEntityActivity.class );
        nextIntent.putExtra( "type", type );
        startActivity( nextIntent );
      }
    } );
  }

  private String getLast<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>RetrievalCode()
  {
    return "<xsl:value-of select="name"/>.findLastAsync( new AsyncCallback&lt;<xsl:value-of select="name"/>&gt;()\n"
            + "{\n"
            + "  @Override\n"
            + "  public void handleResponse( <xsl:value-of select="name"/> object )\n"
            + "  {\n"
            + "    //work with the object\n"
            + "  }\n"
            + "  @Override\n"
            + "  public void handleFault( BackendlessFault fault )\n"
            + "  {\n"
            + "    Toast.makeText( getBaseContext(), fault.getMessage(), Toast.LENGTH_SHORT ).show();\n"
            + "  }\n"
            + "} );";
  }

  private void retrieveLast<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record()
  {
    <xsl:value-of select="name"/>.findLastAsync( new DefaultCallback&lt;<xsl:value-of select="name"/>&gt;( RetrieveRecordActivity.this )
    {
      @Override
      public void handleResponse( <xsl:value-of select="name"/> response )
      {
        super.handleResponse( response );
        resultObject = response;
        Intent nextIntent = new Intent( RetrieveRecordActivity.this, ShowEntityActivity.class );
        nextIntent.putExtra( "type", type );
        startActivity( nextIntent );
      }
    } );
  }

  private String getSorted<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>RetrievalCode()
  {
    return "QueryOptions queryOptions = new QueryOptions();\n"
            + "List&lt;String&gt; sortByProperties = new ArrayList&lt;String&gt;();\n"
            + "sortByProperties.add( \"someProperty\" );\n"
            + "queryOptions.setSortBy( sortByProperties );\n"
            + "BackendlessDataQuery query = new BackendlessDataQuery(  );\n"
            + "query.setQueryOptions( queryOptions );\n"
            + "<xsl:value-of select="name"/>.findAsync( query, new AsyncCallback&lt;List&lt;<xsl:value-of select="name"/>&gt;&gt;()\n"
            + "{\n"
            + "  @Override\n"
            + "  public void handleResponse( List&lt;<xsl:value-of select="name"/>&gt; response )\n"
            + "  {\n"
            + "    <xsl:value-of select="name"/> firstSorted<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template> = response.get( 0 );\n"
            + "  }\n"
            + "  @Override\n"
            + "  public void handleFault( BackendlessFault fault )\n"
            + "  {\n"
            + "    Toast.makeText( getBaseContext(), fault.getMessage(), Toast.LENGTH_SHORT ).show();\n"
            + "  }\n"
            + "} );";
  }

  private void retrieveSorted<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record()
  {
    List&lt;CharSequence&gt; selectedItems = getIntent().getCharSequenceArrayListExtra( "selectedProperties" );
    List&lt;String&gt; sortByProperties = Arrays.asList( selectedItems.toArray( new String[ selectedItems.size() ] ) );
    queryBuilder = DataQueryBuilder.create().setSortBy( sortByProperties );
    entityClass = <xsl:value-of select="name"/>.class;

    <xsl:value-of select="name"/>.findAsync( queryBuilder, new DefaultCallback&lt;List&lt;<xsl:value-of select="name"/>&gt;&gt;( RetrieveRecordActivity.this )
    {
      @Override
      public void handleResponse( List&lt;<xsl:value-of select="name"/>&gt; response )
      {
        super.handleResponse( response );

        resultCollection = response;

        AlertDialog.Builder builder = new AlertDialog.Builder( RetrieveRecordActivity.this );
        builder.setTitle( "Property to show:" );
        final String[] properties = { <xsl:for-each select="columns"><xsl:if test="position() > 1">, </xsl:if>"<xsl:value-of select="name"/>"</xsl:for-each> };
        builder.setItems( properties, new DialogInterface.OnClickListener()
        {
          @Override
          public void onClick( DialogInterface dialogInterface, int i )
          {
            Intent nextIntent = new Intent( RetrieveRecordActivity.this, ShowByPropertyActivity.class );
            nextIntent.putExtra( "type", type );
            nextIntent.putExtra( "property", properties[ i ] );
            startActivity( nextIntent );
            dialogInterface.cancel();
          }
        } );
        builder.create().show();
      }
    } );
  }

  private String getRelated<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>RetrievalCode()
  {
    return "QueryOptions queryOptions = new QueryOptions();\n"
            + "List&lt;String&gt; relationsToFind = new ArrayList&lt;String&gt;();\n"<xsl:text/>
                                                            <xsl:for-each select="relations">
            + "relationsToFind.add( \"<xsl:value-of select="name"/>\" )\n"<xsl:text/>
                                                            </xsl:for-each>
                                                            <xsl:for-each select="geoRelations">
            + "relationsToFind.add( \"<xsl:value-of select="name"/>\" )\n"<xsl:text/>
                                                            </xsl:for-each>
            + "queryOptions.setRelated( relationsToFind );\n"
            + "BackendlessDataQuery query = new BackendlessDataQuery();\n"
            + "query.setQueryOptions( queryOptions );\n"
            + "<xsl:value-of select="name"/>.findAsync( query, new AsyncCallback&lt;List&lt;<xsl:value-of select="name"/>&gt;&gt;()\n"
            + "{\n"
            + "  @Override\n"
            + "  public void handleResponse( List&lt;<xsl:value-of select="name"/>&gt; collection )\n"
            + "  {\n"
            + "    //work with objects\n"
            + "  }\n"
            + "  public void handleFault( BackendlessFault fault )\n"
            + "  {\n"
            + "    Toast.makeText( getBaseContext(), fault.getMessage(), Toast.LENGTH_SHORT ).show();\n"
            + "  }\n"
            + "}";
  }

  private void retrieveRelated<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Record()
  {
    final List&lt;CharSequence&gt; selectedRelations = getIntent().getCharSequenceArrayListExtra( "selectedRelations" );
    final List&lt;CharSequence&gt; selectedRelatedTables = getIntent().getCharSequenceArrayListExtra( "selectedRelatedTables" );
    final String[] selectedRelationsArray = selectedRelations.toArray( new String[ selectedRelations.size() ] );
    final String[] selectedRelatedTablesArray = selectedRelatedTables.toArray( new String[ selectedRelatedTables.size() ] );

    List&lt;String&gt; relationsToFind = Arrays.asList( selectedRelationsArray );
    queryBuilder = DataQueryBuilder.create().setRelated( relationsToFind );
    entityClass = <xsl:value-of select="name"/>.class;

    <xsl:value-of select="name"/>.findAsync( queryBuilder, new DefaultCallback&lt;List&lt;<xsl:value-of select="name"/>&gt;&gt;( RetrieveRecordActivity.this )
    {
      @Override
      public void handleResponse( List&lt;<xsl:value-of select="name"/>&gt; response )
      {
        super.handleResponse( response );
        resultCollection = response;

        AlertDialog.Builder builder = new AlertDialog.Builder( RetrieveRecordActivity.this );
        builder.setTitle( "Property to show:" );
        final String[] properties = { <xsl:for-each select="columns"><xsl:if test="position() > 1">, </xsl:if>"<xsl:value-of select="name"/>"</xsl:for-each> };
        builder.setItems( properties, new DialogInterface.OnClickListener()
        {
          @Override
          public void onClick( DialogInterface dialogInterface, int i )
          {
            selectedProperty = properties[ i ];

            AlertDialog.Builder builder = new AlertDialog.Builder( RetrieveRecordActivity.this );
            builder.setTitle( "Related table to show:" );
            builder.setItems( selectedRelatedTablesArray, new DialogInterface.OnClickListener()
            {
              @Override
              public void onClick( DialogInterface dialogInterface, int i )
              {
                selectedRelatedTable = selectedRelatedTablesArray[ i ];
                relation = selectedRelationsArray[ i ];
                if( selectedRelatedTable.equals( "GeoPoint" ) )
                {
                  relatedProperties = new String[] { "Latitude", "Longitude", "Metadata" };
                }
                dialogInterface.cancel();

                AlertDialog.Builder builder = new AlertDialog.Builder( RetrieveRecordActivity.this );
                builder.setTitle( "Related property to show:" );
                <xsl:text/>
                                                            <xsl:for-each select="../table[name != 'Users']">
                                                                    <xsl:if test="position() > 1">                else </xsl:if>
                <xsl:text/>if( selectedRelatedTable.equals( "<xsl:value-of select="name"/>" ) )
                {
                  relatedProperties = new String[] { <xsl:for-each select="columns"><xsl:if test="position() > 1">, </xsl:if>"<xsl:value-of select="name"/>"</xsl:for-each> };
                }
<xsl:text/>
                                                            </xsl:for-each>
                builder.setItems( relatedProperties, new DialogInterface.OnClickListener()
                {
                  @Override
                  public void onClick( DialogInterface dialogInterface, int i )
                  {
                    selectedRelatedProperty = relatedProperties[ i ];
                    dialogInterface.cancel();
                    Intent nextIntent = new Intent( RetrieveRecordActivity.this, ShowEntityActivity.class );
                    nextIntent.putExtra( "type", type );
                    nextIntent.putExtra( "property", selectedProperty );
                    nextIntent.putExtra( "relation", relation );
                    nextIntent.putExtra( "relatedTable", selectedRelatedTable );
                    nextIntent.putExtra( "relatedProperty", selectedRelatedProperty );
                    startActivity( nextIntent );
                    dialogInterface.cancel();
                  }
                } );
                builder.create().show();
              }
            } );
            builder.create().show();
          }
        } );
        builder.create().show();
      }
    } );
  }
<xsl:text/>
                                                        </xsl:for-each>
<xsl:text/>}</file>
                <file name="ShowByPropertyActivity.java">
package <xsl:value-of select="$package"/>.retrieve;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.*;
import com.backendless.Backendless;
import <xsl:value-of select="$package"/>.R;
import <xsl:value-of select="$package"/>.common.DataApplication;
import <xsl:value-of select="$package"/>.common.DefaultCallback;
import <xsl:value-of select="$classesPackage"/>.*;

import java.util.List;

public class ShowByPropertyActivity extends Activity
{
  private TextView titleView;
  private TextView propertyView;
  private ListView entitiesView;
  private Button nextPageButton, previousPageButton;

  private String type;
  private String table;
  private String property;
  private List collection;
  private String[] items;

  private int currentPage;
  private int totalPages;

  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.show_by_property );

    DataApplication dataApplication = (DataApplication) getApplication();
    table = dataApplication.getChosenTable();

    Backendless.Data.of( RetrieveRecordActivity.entityClass ).getObjectCount( RetrieveRecordActivity.queryBuilder,
      new DefaultCallback&lt;Integer&gt;( ShowByPropertyActivity.this )
      {
        @Override
        public void handleResponse( Integer response )
        {
          collection = RetrieveRecordActivity.getResultCollection();
          currentPage = 1;
          totalPages = (int) Math.ceil( ((double) response) / collection.size() );
          initUI();
          initList();
          initButtons();
          super.handleResponse( response );
        }
      });
  }

  private void initUI()
  {
    titleView = (TextView) findViewById( R.id.showByPropertyTitle );
    propertyView = (TextView) findViewById( R.id.propertyName );
    entitiesView = (ListView) findViewById( R.id.entitiesList );
    previousPageButton = (Button) findViewById( R.id.previousPageButton );
    nextPageButton = (Button) findViewById( R.id.nextPageButton );

    Intent intent = getIntent();
    type = intent.getStringExtra( "type" );
    property = intent.getStringExtra( "property" );

    if( type.equals( "Basic Find" ) )
    {
      titleView.setText( "Basic Find" );
    }
    else if( type.equals( "Find with Sort" ) )
    {
      titleView.setText( "Sorted Find" );
    }
    propertyView.setText( property + ":" );

    previousPageButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View view )
      {
        Backendless.Data.of( RetrieveRecordActivity.entityClass ).find( RetrieveRecordActivity.queryBuilder.preparePreviousPage(),
                    new DefaultCallback&lt;List&gt;( ShowByPropertyActivity.this )
        {
          @Override
          public void handleResponse( List response )
          {
            currentPage--;
            collection = response;
            initList();
            initButtons();
            super.handleResponse( response );
          }
        } );
      }
    } );

    nextPageButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View view )
      {
        Backendless.Data.of( RetrieveRecordActivity.entityClass ).find( RetrieveRecordActivity.queryBuilder.prepareNextPage(),
                    new DefaultCallback&lt;List&gt;( ShowByPropertyActivity.this )
        {
          @Override
          public void handleResponse( List response )
          {
            currentPage++;
            collection = response;
            initList();
            initButtons();
            super.handleResponse( response );
          }
        } );
      }
    } );
  }

  private void initList()
  {
    items = new String[ collection.size() ];

    <xsl:text/>
                                                        <xsl:for-each select="$tables/table[name != 'Users']">
                                                                        <xsl:if test="position() > 1">    else </xsl:if>
    <xsl:text/>if( table.equals( "<xsl:value-of select="name"/>" ) )
    {
      <xsl:text/>
                                                            <xsl:for-each select="columns">
                                                                <xsl:if test="position() > 1">      else </xsl:if>
      <xsl:text/>if( property.equals( "<xsl:value-of select="name"/>" ) )
      {
        for( int i = 0; i &lt; collection.size(); i++ )
        {
          items[ i ] = String.valueOf( ((<xsl:value-of select="../name"/>) collection.get( i )).get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>() );
        }
      }
<xsl:text/>
                                                            </xsl:for-each>
<xsl:text/>    }
<xsl:text/>
                                                        </xsl:for-each>
    ListAdapter adapter = new ArrayAdapter( this, android.R.layout.simple_list_item_1, items );
    entitiesView.setAdapter( adapter );
  }

  private void initButtons()
  {
    previousPageButton.setEnabled( currentPage != 1 );
    nextPageButton.setEnabled( currentPage != totalPages );
  }
}</file>
                <file name="ShowEntityActivity.java">
package <xsl:value-of select="$package"/>.retrieve;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.*;
import com.backendless.BackendlessUser;
import com.backendless.geo.GeoPoint;
import <xsl:value-of select="$package"/>.R;
import <xsl:value-of select="$package"/>.common.DataApplication;
import <xsl:value-of select="$classesPackage"/>.*;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ShowEntityActivity extends Activity
{
  private TextView titleView, propertyView, valueView;
  private ListView propertiesView;

  private String type;
  private String table;
  private String property;
  private String relation;
  private String relatedTable;
  private String relatedProperty;

  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.entity_properties );

    Intent intent = getIntent();
    type = intent.getStringExtra( "type" );
    property = intent.getStringExtra( "property" );
    relation = intent.getStringExtra( "relation" );
    relatedTable = intent.getStringExtra( "relatedTable" );
    relatedProperty = intent.getStringExtra( "relatedProperty" );

    DataApplication dataApplication = (DataApplication) getApplication();
    table = dataApplication.getChosenTable();

    initUI();
  }

  private void initUI()
  {
    titleView = (TextView) findViewById( R.id.title );
    propertyView = (TextView) findViewById( R.id.propertyHint );
    valueView = (TextView) findViewById( R.id.valueHint );
    propertiesView = (ListView) findViewById( R.id.propertiesList );

    if( type.equals( "Find First" ) )
    {
      titleView.setText( "First " + table );
      initList();
    }
    else if( type.equals( "Find Last" ) )
    {
      titleView.setText( "Last " + table );
      initList();
    }
    else if( type.equals( "Find with Relations" ) )
    {
      titleView.setText( "Find with Relations" );
      propertyView.setText( table + "." + property );
      if( relatedProperty == null )
        valueView.setText( relatedTable );
      else
        valueView.setText( relatedTable + "." + relatedProperty );
      initRelationList();
    }
  }

  private void initList()
  {
    List&lt;HashMap&lt;String, String&gt;&gt; properties = new ArrayList&lt;HashMap&lt;String, String&gt;&gt;();
    <xsl:text/>
                                                        <xsl:for-each select="$tables/table[name != 'Users']">
                                                                        <xsl:if test="position() > 1">    else </xsl:if>
    <xsl:text/>if( table.equals( "<xsl:value-of select="name"/>" ) )
    {
      <xsl:value-of select="name"/><xsl:text> </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="name"/></xsl:call-template> = (<xsl:value-of select="name"/>) RetrieveRecordActivity.getResultObject();
      HashMap&lt;String, String&gt; property;<xsl:text/>
                                                            <xsl:for-each select="columns">
      property = new HashMap&lt;String, String&gt;();
      property.put( "property", "<xsl:value-of select="name"/>" );
      property.put( "value", String.valueOf( <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="../name"/></xsl:call-template>.get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>() ) );
      properties.add( property );
                                                            </xsl:for-each>
                                                            <xsl:for-each select="relations">
      property = new HashMap&lt;String, String&gt;();
      property.put( "property", "<xsl:value-of select="name"/>" );
      property.put( "value", "Related <xsl:value-of select="toTableName"/>" );
      properties.add( property );<xsl:text/>
                                                            </xsl:for-each>
                                                            <xsl:for-each select="geoRelations">
      property = new HashMap&lt;String, String&gt;();
      property.put( "property", "<xsl:value-of select="name"/>" );
      property.put( "value", "Related GeoPoint" );
      properties.add( property );<xsl:text/>
                                                            </xsl:for-each>
<xsl:text/>    }
<xsl:text/>
                                                        </xsl:for-each>
    ListAdapter adapter = new SimpleAdapter( this, properties, R.layout.property_row, new String[] { "property", "value" }, new int[] { R.id.property, R.id.value } );
    propertiesView.setAdapter( adapter );
  }

  private void initRelationList()
  {
    List&lt;HashMap&lt;String, String&gt;&gt; rows = new ArrayList&lt;HashMap&lt;String, String&gt;&gt;();
    List collection = RetrieveRecordActivity.getResultCollection();

    for( Object object : collection )
    {
      <xsl:text/>
                                                        <xsl:for-each select="$tables/table[name != 'Users']">
                                                                <xsl:variable name="table" select="name"/>
                                                                <xsl:if test="position() > 1" >      else </xsl:if>
      <xsl:text/>if( table.equals( "<xsl:value-of select="name"/>" ) )
      {
        <xsl:value-of select="name"/><xsl:text> </xsl:text><xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="name"/></xsl:call-template> = (<xsl:value-of select="name"/>) object;
        String propertyValue = "";
        String getterMethodName = "get".concat( property.substring( 0, 1 ).toUpperCase().concat( property.substring( 1 ) ) );
        try
        {
          propertyValue = String.valueOf( <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="name"/></xsl:call-template>.getClass().getDeclaredMethod( getterMethodName ).invoke( <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="name"/></xsl:call-template> ) );
        }
        catch( InvocationTargetException e )
        {
          Toast.makeText( this, e.getMessage(), Toast.LENGTH_LONG );
        }
        catch( NoSuchMethodException e )
        {
          Toast.makeText( this, e.getMessage(), Toast.LENGTH_LONG );
        }
        catch( IllegalAccessException e )
        {
          Toast.makeText( this, e.getMessage(), Toast.LENGTH_LONG );
        }
        <xsl:text/>
                                                            <xsl:for-each select="relations">
                                                                <xsl:variable name="relation" select="name"/>

                                                                <xsl:choose>
                                                                    <xsl:when test="relationshipType = 'ONE_TO_ONE'">
                                                                        <xsl:if test="position() > 1">        else </xsl:if>
        <xsl:text/>if( relation.equals( "<xsl:value-of select="name"/>" ) )
                                                                        <xsl:choose>
                                                                            <xsl:when test="toTableName = 'Users'">
        {
          <xsl:text/>
                                                                        <xsl:for-each select="columns">
                                                                            <xsl:if test="position() > 1">          else </xsl:if>
          <xsl:text/>if( relatedProperty.equals( "<xsl:value-of select="name"/>" ) )
          {
            HashMap&lt;String, String&gt; row = new HashMap&lt;String, String&gt;();
            row.put( "property", propertyValue );
            BackendlessUser <xsl:value-of select="$relation"/>Relation = <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="$table"/></xsl:call-template>.get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="$relation"/></xsl:call-template>();
            row.put( "value", String.valueOf( <xsl:value-of select="$relation"/>Relation == null ? "No relation" : <xsl:value-of select="$relation"/>Relation.getProperty( "<xsl:value-of select="name"/>" ) ) );
            rows.add( row );
          }
<xsl:text/>
                                                                        </xsl:for-each>
        }
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
        {
          <xsl:text/>
                                                                        <xsl:for-each select="columns">
                                                                            <xsl:if test="position() > 1">        else </xsl:if>
          <xsl:text/>if( relatedProperty.equals( "<xsl:value-of select="name"/>" ) )
          {
            HashMap&lt;String, String&gt; row = new HashMap&lt;String, String&gt;();
            row.put( "property", propertyValue );
            <xsl:value-of select="toTableName"/><xsl:text> </xsl:text><xsl:value-of select="$relation"/>Relation = <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="$table"/></xsl:call-template>.get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="$relation"/></xsl:call-template>();
            row.put( "value", String.valueOf( <xsl:value-of select="$relation"/>Relation == null ? "No relation" : <xsl:value-of select="$relation"/>Relation.get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>() ) );
            rows.add( row );
          }
<xsl:text/>
                                                                        </xsl:for-each>
        }
<xsl:text/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </xsl:when>

                                                                    <xsl:when test="relationshipType = 'ONE_TO_MANY'">
                                                                        <xsl:if test="position() > 1">      else </xsl:if>
        <xsl:text/>if( relation.equals( "<xsl:value-of select="name"/>" ) )

                                                                                <xsl:choose>
                                                                                    <xsl:when test="toTableName = 'Users'">
        {
          <xsl:text/>
                                                                                        <xsl:for-each select="columns">
                                                                                            <xsl:if test="position() > 1">        else </xsl:if>
          <xsl:text/>if( relatedProperty.equals( "<xsl:value-of select="name"/>" ) )
          {
            HashMap&lt;String, String&gt; row = new HashMap&lt;String, String&gt;();
            row.put( "property", propertyValue );
            List&lt;BackendlessUser&gt; <xsl:value-of select="$relation"/>Relation = <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="$table"/></xsl:call-template>.get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="$relation"/></xsl:call-template>();
            row.put( "value", String.valueOf( <xsl:value-of select="$relation"/>Relation.isEmpty() ? "No relation" : <xsl:value-of select="$relation"/>Relation.get( 0 ).getProperty( "<xsl:value-of select="name"/>" ) ) );
            rows.add( row );
          }
<xsl:text/>
                                                                                        </xsl:for-each>
        }
                                                                                    </xsl:when>
                                                                                    <xsl:otherwise>
        {
          <xsl:text/>
                                                                                        <xsl:for-each select="columns">
                                                                                            <xsl:if test="position() > 1">          else </xsl:if>
          <xsl:text/>if( relatedProperty.equals( "<xsl:value-of select="name"/>" ) )
          {
            List&lt;<xsl:value-of select="toTableName"/>&gt; <xsl:value-of select="$relation"/>Relation = <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="$table"/></xsl:call-template>.get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="$relation"/></xsl:call-template>();
            if( <xsl:value-of select="$relation"/>Relation.isEmpty() )
            {
              HashMap&lt;String, String&gt; row = new HashMap&lt;String, String&gt;();
              row.put( "property", propertyValue );
              row.put( "value", "No relation" );
              rows.add( row );
            }
            else
            {
              for( <xsl:value-of select="toTableName"/> item : <xsl:value-of select="$relation"/>Relation )
              {
                HashMap&lt;String, String&gt; row = new HashMap&lt;String, String&gt;();
                row.put( "property", propertyValue );
                row.put( "value", String.valueOf( item.get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>() ) );
                rows.add( row );
              }
            }
          }
<xsl:text/>
                                                                                        </xsl:for-each>
        }
<xsl:text/>
                                                                                    </xsl:otherwise>
                                                                                </xsl:choose>

                                                                    </xsl:when>
                                                                </xsl:choose>
                                                            </xsl:for-each>
                                                            <xsl:for-each select="geoRelations">
                                                                <xsl:variable name="relation" select="name"/>
                                                                <xsl:choose>
                                                                    <xsl:when test="relationshipType = 'ONE_TO_ONE'">
                                                                        <xsl:if test="../relations or position() > 1">        else </xsl:if>
        <xsl:text/>if( relation.equals( "<xsl:value-of select="name"/>" ) )
        {
          HashMap&lt;String, String&gt; row = new HashMap&lt;String, String&gt;();
          row.put( "property", propertyValue );
          GeoPoint <xsl:value-of select="$relation"/>Relation = <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="$table"/></xsl:call-template>.get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="$relation"/></xsl:call-template>();
          getterMethodName = "get".concat( relatedProperty.substring( 0, 1 ).toUpperCase().concat( relatedProperty.substring( 1 ) ) );
          try
          {
            propertyValue = String.valueOf( <xsl:value-of select="$relation"/>Relation.getClass().getMethod( getterMethodName ).invoke( <xsl:value-of select="$relation"/>Relation ) );
          }
          catch( InvocationTargetException e )
          {
            Toast.makeText( this, e.getMessage(), Toast.LENGTH_LONG );
          }
            catch( NoSuchMethodException e )
          {
            Toast.makeText( this, e.getMessage(), Toast.LENGTH_LONG );
          }
          catch( IllegalAccessException e )
          {
            Toast.makeText( this, e.getMessage(), Toast.LENGTH_LONG );
          }
          row.put( "value", String.valueOf( <xsl:value-of select="$relation"/>Relation == null ? "No relation" : relatedProperty + ": " + propertyValue ) );
          rows.add( row );
        }
<xsl:text/>
                                                                    </xsl:when>
                                                                    <xsl:when test="relationshipType = 'ONE_TO_MANY'">
                                                                        <xsl:if test="../relations or position() > 1">      else </xsl:if>
        <xsl:text/>if( relation.equals( "<xsl:value-of select="name"/>" ) )
        {
          List&lt;GeoPoint&gt; <xsl:value-of select="$relation"/>Relation = <xsl:call-template name="firstCharToLowerCase"><xsl:with-param name="str" select="$table"/></xsl:call-template>.get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="$relation"/></xsl:call-template>();
          if( <xsl:value-of select="$relation"/>Relation.isEmpty() )
          {
            HashMap&lt;String, String&gt; row = new HashMap&lt;String, String&gt;();
            row.put( "property", propertyValue );
            row.put( "value", "No relation" );
            rows.add( row );
          }
          else
          {
            for( GeoPoint item : <xsl:value-of select="$relation"/>Relation )
            {
              HashMap&lt;String, String&gt; row = new HashMap&lt;String, String&gt;();
              row.put( "property", propertyValue );
              String relPropValue = "";
              getterMethodName = "get".concat( relatedProperty.substring( 0, 1 ).toUpperCase().concat( relatedProperty.substring( 1 ) ) );
              try
              {
                relPropValue = String.valueOf( item.getClass().getMethod( getterMethodName ).invoke( item ) );
              }
              catch( InvocationTargetException e )
              {
                Toast.makeText( this, e.getMessage(), Toast.LENGTH_LONG );
              }
              catch( NoSuchMethodException e )
              {
                Toast.makeText( this, e.getMessage(), Toast.LENGTH_LONG );
              }
              catch( IllegalAccessException e )
              {
                Toast.makeText( this, e.getMessage(), Toast.LENGTH_LONG );
              }
              row.put( "value", String.valueOf( <xsl:value-of select="$relation"/>Relation == null ? "No relation" : relatedProperty + ": " + relPropValue ) );
              rows.add( row );
            }
          }
        }
<xsl:text/>
                                                                    </xsl:when>
                                                                </xsl:choose>
                                                            </xsl:for-each>
      }
<xsl:text/>
                                                        </xsl:for-each>
    }
    ListAdapter adapter = new SimpleAdapter( this, rows, R.layout.property_row, new String[] { "property", "value" }, new int[] { R.id.property, R.id.value } );
    propertiesView.setAdapter( adapter );
}
}<xsl:text/>
                                                    </file>
            </folder>
        </folder>
    </xsl:template>

</xsl:stylesheet>