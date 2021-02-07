<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="geo-sources">
        <folder name="com">
            <folder name="examples">
                <folder name="{$packageAppName}">
                    <folder name="{$subPackage}">
                        <file name="DefaultCallback.java">
package <xsl:value-of select="$package"/>;

import android.app.ProgressDialog;
import android.content.Context;
import android.widget.Toast;
import com.backendless.async.callback.BackendlessCallback;
import com.backendless.exceptions.BackendlessFault;

public class DefaultCallback&lt;T&gt; extends BackendlessCallback&lt;T&gt;
{
  Context context;
  ProgressDialog progressDialog;

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
}
                        </file>

                        <file name="Defaults.java">
package <xsl:value-of select="$package"/>;

public class Defaults
{
    <xsl:call-template name="common-defaults" />
}
                        </file>

                        <file name="FilterActivity.java">
package <xsl:value-of select="$package"/>;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.*;
import com.backendless.geo.Units;

public class FilterActivity extends Activity
{
  private TextView categoryTitle, queryText;
  private Spinner geoUnitsSpinner;
  private Button editQueryButton, applyButton, clearButton;

  @Override
  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.filter );

    initUI();
  }

  private void initUI()
  {
    categoryTitle = (TextView) findViewById( R.id.categoryTitle );
    queryText = (TextView) findViewById( R.id.queryText );
    editQueryButton = (Button) findViewById( R.id.queryEditButton );
    applyButton = (Button) findViewById( R.id.applyButton );
    clearButton = (Button) findViewById( R.id.clearButton );
    geoUnitsSpinner = (Spinner) findViewById( R.id.geoUnitsSpinner );

    String title = String.format( getResources().getString( R.string.browsing_category_page_title ), MapShowActivity.category );
    categoryTitle.setText( title );

    queryText.setText( MapShowActivity.whereClause );

    editQueryButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View v )
      {
        onEditQueryButtonClicked();
      }
    } );

    applyButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View v )
      {
        onApplyButtonClicked();
      }
    } );

    clearButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View v )
      {
        onClearButtonClicked();
      }
    } );

    ArrayAdapter&lt;CharSequence&gt; geoUnitsSpinnerAdapter = ArrayAdapter.createFromResource( this, R.array.geo_units, android.R.layout.simple_spinner_item );
    geoUnitsSpinnerAdapter.setDropDownViewResource( android.R.layout.simple_spinner_dropdown_item );
    geoUnitsSpinner.setAdapter( geoUnitsSpinnerAdapter );
  }

  private void onClearButtonClicked()
  {
    MapShowActivity.whereClause = "";
    MapShowActivity.searchInRadius = false;
    startActivity( new Intent( this, MapShowActivity.class ) );
    finish();
  }

  private void onApplyButtonClicked()
  {
    MapShowActivity.whereClause = queryText.getText().toString();
    RadioButton radiusRadio = (RadioButton) findViewById( R.id.radiusRadio );
    EditText radiusEdit = (EditText) findViewById( R.id.radiusEdit );
    if( radiusRadio.isChecked() )
    {
      MapShowActivity.searchInRadius = true;
      MapShowActivity.radius = Double.parseDouble( radiusEdit.getText().toString() );
      MapShowActivity.units = Units.valueOf( geoUnitsSpinner.getSelectedItem().toString() );
    }
    else
    {
      MapShowActivity.searchInRadius = false;
    }
    startActivity( new Intent( this, MapShowActivity.class ) );
    finish();
  }

  private void onEditQueryButtonClicked()
  {
    startActivity( new Intent( FilterActivity.this, QueryEditActivity.class ) );
    finish();
  }
}
                        </file>

                        <file name="GeoCategoriesListActivity.java">
package <xsl:value-of select="$package"/>;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.ActivityCompat;
import android.view.View;
import android.widget.*;
import com.backendless.Backendless;
import com.backendless.geo.GeoCategory;

import java.util.List;

public class GeoCategoriesListActivity extends Activity
{
  public static int REQUEST_ACCESS_COARSE_LOCATION = 1001;
  private ListView geoCategoriesListView;
  private List&lt;GeoCategory&gt; geoCategories;

  @Override
  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.geo_categories_list );

    initUI();

    if( ActivityCompat.checkSelfPermission( this, android.Manifest.permission.ACCESS_FINE_LOCATION ) != PackageManager.PERMISSION_GRANTED &amp;&amp; ActivityCompat.checkSelfPermission( this, android.Manifest.permission.ACCESS_COARSE_LOCATION ) != PackageManager.PERMISSION_GRANTED )
    {
      ActivityCompat.requestPermissions( this, new String[] { android.Manifest.permission.ACCESS_FINE_LOCATION, android.Manifest.permission.ACCESS_COARSE_LOCATION}, REQUEST_ACCESS_COARSE_LOCATION );
    }

    Backendless.setUrl( Defaults.SERVER_URL );
    Backendless.initApp( this, Defaults.APPLICATION_ID, Defaults.API_KEY );

    Backendless.Geo.getCategories( new DefaultCallback&lt;List&lt;GeoCategory&gt;&gt;( this )
    {
      @Override
      public void handleResponse( List&lt;GeoCategory&gt; response )
      {
        geoCategories = response;

        String[] geoCategoriesStringArray = new String[ geoCategories.size() ];
        for( int i = 0; i &lt; geoCategories.size(); i++ )
        {
          geoCategoriesStringArray[ i ] = geoCategories.get( i ).getName();
        }

        ArrayAdapter adapter = new ArrayAdapter&lt;String&gt;( GeoCategoriesListActivity.this, R.layout.list_item_with_arrow, R.id.itemName, geoCategoriesStringArray );
        geoCategoriesListView.setAdapter( adapter );

        super.handleResponse( response );
      }
    } );
  }

  private void initUI()
  {
    geoCategoriesListView = (ListView) findViewById( R.id.geoCategoriesList );

    geoCategoriesListView.setOnItemClickListener( new AdapterView.OnItemClickListener()
    {
      @Override
      public void onItemClick( AdapterView&lt;?&gt; parent, View view, int position, long id )
      {
        TextView textView = (TextView) view.findViewById( R.id.itemName );
        String text = textView.getText().toString();

        Intent mapIntent = new Intent( GeoCategoriesListActivity.this, MapShowActivity.class );
        mapIntent.putExtra( "category", text );
        startActivity( mapIntent );
        finish();
      }
    } );
  }

  @Override
  public void onRequestPermissionsResult( int requestCode,
                                          @NonNull
                                                  String[] permissions,
                                          @NonNull
                                                  int[] grantResults )
  {
    super.onRequestPermissionsResult( requestCode, permissions, grantResults );
    Toast.makeText( this, "Permissions granted successfully", Toast.LENGTH_SHORT );
  }

}
                        </file>

                        <file name="MapShowActivity.java">
package <xsl:value-of select="$package"/>;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.location.Location;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;
import com.backendless.Backendless;
import com.backendless.geo.BackendlessGeoQuery;
import com.backendless.geo.GeoPoint;
import com.backendless.geo.Units;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.location.LocationListener;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapFragment;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

import java.util.ArrayList;
import java.util.List;

public class MapShowActivity extends Activity implements GoogleApiClient.ConnectionCallbacks, GoogleApiClient.OnConnectionFailedListener,
                                                         LocationListener, ActivityCompat.OnRequestPermissionsResultCallback
{
  private TextView categoryTitle;
  private Button showAsTextButton, filterButton;

  public static String whereClause = "";
  public static String category = "";
  public static GoogleApiClient mGoogleApiClient;
  public static boolean searchInRadius = false;
  public static double radius;
  public static Units units;

  @Override
  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.map_show );

    if( category.isEmpty() )
    {
      category = getIntent().getStringExtra( "category" );
    }

    if( mGoogleApiClient == null )
    {
      mGoogleApiClient = new GoogleApiClient.Builder( this )
              .addApi( LocationServices.API )
              .addConnectionCallbacks( this )
              .addOnConnectionFailedListener( this )
              .build();
      mGoogleApiClient.connect();
    }

    List&lt;String&gt; chosenCategories = new ArrayList&lt;String&gt;();
    chosenCategories.add( category );
    final BackendlessGeoQuery backendlessGeoQuery = new BackendlessGeoQuery();
    backendlessGeoQuery.setCategories( chosenCategories );
    if( !whereClause.isEmpty() )
    {
      backendlessGeoQuery.setWhereClause( whereClause );
    }
    if( searchInRadius )
    {
      if( mGoogleApiClient.isConnected() )
      {
        Location mCurrentLocation = MapShowActivity.getLastLocation(this);
        backendlessGeoQuery.setLatitude( mCurrentLocation.getLatitude() );
        backendlessGeoQuery.setLongitude( mCurrentLocation.getLongitude() );
        backendlessGeoQuery.setRadius( radius );
        backendlessGeoQuery.setUnits( units );
      }
      else
      {
        Toast.makeText( this, "Current location not available", Toast.LENGTH_SHORT ).show();
      }
    }

    initUI();

    Backendless.Geo.getPoints( backendlessGeoQuery, new DefaultCallback&lt;List&lt;GeoPoint&gt;&gt;( this )
    {
      @Override
      public void handleResponse( List&lt;GeoPoint&gt; response )
      {
        final List&lt;GeoPoint&gt; geoPoints = response;
        ((MapFragment) getFragmentManager().findFragmentById( R.id.map )).getMapAsync( new OnMapReadyCallback()
        {
          @Override
          public void onMapReady( GoogleMap googleMap )
          {
            googleMap.setMyLocationEnabled( true );

            for( GeoPoint geoPoint : geoPoints )
            {
              googleMap.addMarker( new MarkerOptions().position( new LatLng( geoPoint.getLatitude(), geoPoint.getLongitude() ) ).title( "ObjectId: " + geoPoint.getObjectId() ) );
            }
          }
        } );

        super.handleResponse( response );
      }
    } );
  }

  public static Location getLastLocation(Context ctx)
  {
    return LocationServices.FusedLocationApi.getLastLocation( mGoogleApiClient );
  }

  private void initUI()
  {
    categoryTitle = (TextView) findViewById( R.id.categoryTitle );
    showAsTextButton = (Button) findViewById( R.id.showAsTextButton );
    filterButton = (Button) findViewById( R.id.filterButton );

    String title = String.format( getResources().getString( R.string.browsing_category_page_title ), MapShowActivity.category );
    categoryTitle.setText( title );

    showAsTextButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View v )
      {
        startActivity( new Intent( MapShowActivity.this, ShowGeoPointsTextActivity.class ) );
      }
    } );

    filterButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View v )
      {
        startActivity( new Intent( MapShowActivity.this, FilterActivity.class ) );
      }
    } );
  }

  @Override
  public void onConnected( Bundle bundle )
  {
    LocationRequest mLocationRequest = new LocationRequest();
    LocationServices.FusedLocationApi.requestLocationUpdates( mGoogleApiClient, mLocationRequest, this );
  }

  @Override
  public void onConnectionSuspended( int i )
  {

  }

  @Override
  public void onConnectionFailed( ConnectionResult connectionResult )
  {

  }

  @Override
  public void onLocationChanged( Location location )
  {

  }
}
                        </file>

                        <file name="QueryEditActivity.java">
package <xsl:value-of select="$package"/>;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.inputmethod.EditorInfo;
import android.widget.EditText;
import android.widget.TextView;

public class QueryEditActivity extends Activity
{
  private EditText queryEdit;
  private TextView categoryTitle;

  @Override
  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.edit_query );

    initUI();
  }

  private void initUI()
  {
    categoryTitle = (TextView) findViewById( R.id.categoryTitle );
    queryEdit = (EditText) findViewById( R.id.queryEdit );

    String title = String.format( getResources().getString( R.string.browsing_category_page_title ), MapShowActivity.category );
    categoryTitle.setText( title );

    queryEdit.setText( MapShowActivity.whereClause );
    queryEdit.setOnEditorActionListener( new TextView.OnEditorActionListener()
    {
      @Override
      public boolean onEditorAction( TextView v, int actionId, KeyEvent event )
      {
        if( actionId == EditorInfo.IME_ACTION_DONE )
        {
          onDoneClicked();
        }
        return true;
      }
    } );
  }

  private void onDoneClicked()
  {
    MapShowActivity.whereClause = queryEdit.getText().toString();
    startActivity( new Intent( this, FilterActivity.class ) );
    finish();
  }
}
                        </file>

                        <file name="ShowGeoPointsTextActivity.java">
package <xsl:value-of select="$package"/>;

import android.app.Activity;
import android.content.Intent;
import android.location.Location;
import android.os.Bundle;
import android.view.View;
import android.widget.*;
import com.backendless.Backendless;
import com.backendless.geo.BackendlessGeoQuery;
import com.backendless.geo.GeoPoint;

import java.util.ArrayList;
import java.util.List;

public class ShowGeoPointsTextActivity extends Activity
{
  private ListView geoPointsList;
  private Button showAsMapButton, filterButton, previousPageButton, nextPageButton;
  private TextView categoryTitleTextView;

  private ArrayAdapter adapter;

  private List&lt;GeoPoint&gt; geoPointsCollection;
  private BackendlessGeoQuery geoQuery;
  private int totalPages;
  private int currentPageNumber;

  @Override
  public void onCreate( Bundle savedInstanceState )
  {
    super.onCreate( savedInstanceState );
    setContentView( R.layout.geopoints_text );

    currentPageNumber = 0;

    List&lt;String&gt; chosenCategories = new ArrayList&lt;String&gt;();
    chosenCategories.add( MapShowActivity.category );
    geoQuery = new BackendlessGeoQuery();
    geoQuery.setCategories( chosenCategories );
    if( !MapShowActivity.whereClause.isEmpty() )
    {
      geoQuery.setWhereClause( MapShowActivity.whereClause );
    }
    if( MapShowActivity.searchInRadius )
    {
      if( MapShowActivity.mGoogleApiClient.isConnected() )
      {
        Location mCurrentLocation = MapShowActivity.getLastLocation(this);
        geoQuery.setLatitude( mCurrentLocation.getLatitude() );
        geoQuery.setLongitude( mCurrentLocation.getLongitude() );
        geoQuery.setRadius( MapShowActivity.radius );
        geoQuery.setUnits( MapShowActivity.units );
      }
      else
      {
        Toast.makeText( this, "Current location not available", Toast.LENGTH_LONG ).show();
      }
    }

    Backendless.Geo.getPoints( geoQuery, new DefaultCallback&lt;List&lt;GeoPoint&gt;&gt;( this )
    {
      @Override
      public void handleResponse( final List&lt;GeoPoint&gt; response )
      {
        Backendless.Geo.getGeopointCount(geoQuery, new DefaultCallback&lt;Integer&gt;( ShowGeoPointsTextActivity.this )
        {
          @Override
          public void handleResponse( final Integer totalPoints )
          {
            totalPages = (int) Math.ceil( (double) totalPoints / response.size() );
            initList( response );
            initButtons();
            super.handleResponse( totalPoints );
          }
        });
        super.handleResponse( response );
      }
    } );

    initUI();
  }

  private void initUI()
  {
    geoPointsList = (ListView) findViewById( R.id.geoPointsList );
    showAsMapButton = (Button) findViewById( R.id.showAsMapButton );
    filterButton = (Button) findViewById( R.id.filterButton );
    previousPageButton = (Button) findViewById( R.id.previousPageButton );
    nextPageButton = (Button) findViewById( R.id.nextPageButton );
    categoryTitleTextView = (TextView) findViewById( R.id.categoryTitle );

    String title = String.format( getResources().getString( R.string.browsing_category_page_title ), MapShowActivity.category );
    categoryTitleTextView.setText( title );

    showAsMapButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View v )
      {
        startActivity( new Intent( ShowGeoPointsTextActivity.this, MapShowActivity.class ) );
        finish();
      }
    } );

    filterButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View v )
      {
        startActivity( new Intent( ShowGeoPointsTextActivity.this, FilterActivity.class ) );
        finish();
      }
    } );

    previousPageButton.setOnClickListener( new View.OnClickListener()
    {
      @Override
      public void onClick( View view )
      {
        geoQuery.prepareForPreviousPage();
        Backendless.Geo.getPoints( geoQuery, new DefaultCallback&lt;List&lt;GeoPoint&gt;&gt;( ShowGeoPointsTextActivity.this )
        {
          @Override
          public void handleResponse( List&lt;GeoPoint&gt; response )
          {
            currentPageNumber--;
            initList( response );
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
        geoQuery.prepareForNextPage();
        Backendless.Geo.getPoints( geoQuery, new DefaultCallback&lt;List&lt;GeoPoint&gt;&gt;( ShowGeoPointsTextActivity.this )
        {
          @Override
          public void handleResponse( List&lt;GeoPoint&gt; response )
          {
            currentPageNumber++;
            initList( response );
            initButtons();

           super.handleResponse( response );
          }
        } );
      }
    } );
  }

  private void initList( List&lt;GeoPoint&gt; response )
  {
    geoPointsCollection = response;

    String[] geoPointsStringArray = new String[ geoPointsCollection.size() ];
    for( int i = 0; i &lt; geoPointsCollection.size(); i++ )
    {
      GeoPoint geoPoint = geoPointsCollection.get( i );
      geoPointsStringArray[ i ] = String.format( getResources().getString( R.string.geo_points_text_list_item_template ), i + 1, geoPoint.getLatitude().toString(), geoPoint.getLongitude().toString() );
    }

    adapter = new ArrayAdapter&lt;String&gt;( this, android.R.layout.simple_list_item_1, geoPointsStringArray );
    geoPointsList.setAdapter( adapter );
  }

  private void initButtons()
  {
    previousPageButton.setEnabled( currentPageNumber &gt; 0 );
    nextPageButton.setEnabled( currentPageNumber &lt; totalPages );
  }
}
                        </file>
                    </folder>
                </folder>
            </folder>
        </folder>

    </xsl:template>

</xsl:stylesheet>