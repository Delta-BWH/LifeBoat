<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="data-sources">
        <xsl:param name="subPackage"/>
        <xsl:param name="package"/>
        <folder name="com/examples/{$packageAppName}/{$subPackage}">

            <!--Generate java class for operations with Views-->
            <file name="{$applicationName}Views.java">
package <xsl:value-of select="$package"/>;

import com.backendless.Backendless;
import com.backendless.async.callback.AsyncCallback;

import java.util.Map;
import java.util.List;


public class <xsl:value-of select="$applicationName"/>Views
{
<xsl:for-each select="$views/view">  public List&lt;Map&lt;String, Object&gt;&gt; <xsl:value-of
    select="name"/>()
  {
    return Backendless.Data.getView( "<xsl:value-of select="name"/>", null );
  }

  public List&lt;Map&lt;String, Object&gt;&gt; <xsl:value-of
    select="name"/>( DataQueryBuilder queryBuilder )
  {
    return Backendless.Data.getView( "<xsl:value-of select="name"/>", queryBuilder );
  }

  public void <xsl:value-of select="name"/>( AsyncCallback&lt;Map&lt;String, Object&gt;&gt; responder )
  {
    Backendless.Data.getView( "<xsl:value-of select="name"/>", null, responder );
  }

  public void <xsl:value-of select="name"/>( DataQueryBuilder queryBuilder, AsyncCallback&lt;Map&lt;String, Object&gt;&gt; responder )
  {
    Backendless.Data.getView( "<xsl:value-of select="name"/>", queryBuilder, responder );
  }

</xsl:for-each>}</file>

            <!--Generate java class for operations with StoredProcedures-->
            <file name="{$applicationName}StoredProcedures.java">
package <xsl:value-of select="$package"/>;

import com.backendless.Backendless;
import com.backendless.async.callback.AsyncCallback;

import java.util.Map;
import java.util.List;
import java.util.HashMap;

public class <xsl:value-of select="$applicationName"/>StoredProcedures
{
<xsl:for-each select="$procedures/procedure">  public List&lt;Map&gt; <xsl:value-of select="name"/>( <xsl:for-each select="args">
    <xsl:call-template name="getJavaType"><xsl:with-param name="str" select="dataType"/></xsl:call-template> <xsl:text> </xsl:text> <xsl:value-of select="name"/>_ <xsl:if test="position() &lt; last()"> <xsl:text>, </xsl:text> </xsl:if>
    </xsl:for-each> )
    {
    Map&lt;String, Object&gt; arguments = new HashMap&lt;&gt;();
    <xsl:for-each select="args">arguments.put( "<xsl:value-of select="name"/>", <xsl:value-of select="name"/>_ );</xsl:for-each>
    return Backendless.Data.callStoredProcedure( "<xsl:value-of select="name"/>", arguments );
    }

  public void <xsl:value-of select="name"/>( <xsl:for-each select="args">
        <xsl:call-template name="getJavaType"><xsl:with-param name="str" select="dataType"/></xsl:call-template><xsl:text> </xsl:text><xsl:value-of select="name"/>_<xsl:text>, </xsl:text>
    </xsl:for-each>AsyncCallback&lt;Map&gt; responder )
  {
    Map&lt;String, Object&gt; arguments = new HashMap&lt;&gt;();
    <xsl:for-each select="args">arguments.put( "<xsl:value-of select="name"/>", <xsl:value-of select="name"/>_ );</xsl:for-each>
    Backendless.Data.callStoredProcedure( "<xsl:value-of select="name"/>", arguments, responder );
  }

</xsl:for-each>}
            </file>

            <!-- for each table create java file -->
            <xsl:for-each select="$tables/table[name != 'Users']">
                <file name="{name}.java">
package <xsl:value-of select="$package"/>;

import com.backendless.Backendless;
import com.backendless.BackendlessUser;
import com.backendless.async.callback.AsyncCallback;
import com.backendless.persistence.*;
import com.backendless.geo.GeoPoint;

import java.util.List;
import java.util.Date;

public class <xsl:value-of select="name"/>
{<xsl:text/>
                                                    <!-- for each column create a field-->
                                                    <xsl:for-each select="columns">
  private <xsl:call-template name="getJavaType"><xsl:with-param name="str" select="dataType"/></xsl:call-template><xsl:text> </xsl:text><xsl:value-of select="name"/>;<xsl:text/>
                                                    </xsl:for-each>
                                                    <!-- for each relation create a field-->
                                                    <xsl:for-each select="relations">
                                                        <xsl:variable name="toTableName" select="toTableName"/>
                                                        <!-- if relation is a ONE_TO_MANY create a List field -->
                                                        <xsl:choose>
                                                            <xsl:when test="relationshipType = 'ONE_TO_MANY'">
                                                                <xsl:choose>
                                                                    <xsl:when test="$toTableName = 'Users'">
  private List&lt;BackendlessUser&gt; <xsl:value-of select="name"/>;<xsl:text/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
  private List&lt;<xsl:value-of select="$toTableName"/>&gt; <xsl:value-of select="name"/>;<xsl:text/>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:when>
                                                            <xsl:when test="relationshipType = 'ONE_TO_ONE'">
                                                                <xsl:choose>
                                                                    <xsl:when test="$toTableName = 'Users'">
  private BackendlessUser <xsl:value-of select="name"/>;<xsl:text/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
  private <xsl:value-of select="$toTableName"/><xsl:text> </xsl:text><xsl:value-of select="name"/>;<xsl:text/>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:when>
                                                        </xsl:choose>
                                                    </xsl:for-each>
                                                    <!-- for each geo relation create a field -->
                                                    <xsl:for-each select="geoRelations">
                                                        <!-- if relation is a ONE_TO_MANY create a List field -->
                                                        <xsl:choose>
                                                            <xsl:when test="relationshipType = 'ONE_TO_MANY'">
  private List&lt;GeoPoint&gt; <xsl:value-of select="name"/>;<xsl:text/>
                                                            </xsl:when>
                                                            <xsl:when test="relationshipType = 'ONE_TO_ONE'">
  private GeoPoint <xsl:value-of select="name"/>;<xsl:text/>
                                                            </xsl:when>
                                                        </xsl:choose>
                                                    </xsl:for-each>
                                                    <!-- for each column create getter and setter -->
                                                    <xsl:for-each select="columns">
  public <xsl:call-template name="getJavaType"><xsl:with-param name="str" select="dataType"/></xsl:call-template> get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>()
  {
    return <xsl:value-of select="name"/>;
  }
<xsl:text/>
                                                            <xsl:if test="(../../@type='internal' and name != 'created' and name != 'updated' and name != 'objectId' and name != 'ownerId') or (../../@type='external')">
  public void set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( <xsl:call-template name="getJavaType"><xsl:with-param name="str" select="dataType"/></xsl:call-template> <xsl:text> </xsl:text> <xsl:value-of select="name"/> )
  {
    this.<xsl:value-of select="name"/> = <xsl:value-of select="name"/>;
  }
<xsl:text/>
                                                            </xsl:if>
                                                    </xsl:for-each>
                                                    <!-- for each relation create getter and setter -->
                                                    <xsl:for-each select="relations">
                                                        <xsl:variable name="toTableName" select="toTableName"/>
                                                        <!-- if relation is a ONE_TO_MANY create a List field -->
                                                        <xsl:choose>
                                                            <xsl:when test="relationshipType = 'ONE_TO_MANY'">
                                                                <xsl:choose>
                                                                    <xsl:when test="$toTableName = 'Users'">
  public List&lt;BackendlessUser&gt; get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>()
  {
    return <xsl:value-of select="name"/>;
  }

  public void set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( List&lt;BackendlessUser&gt; <xsl:value-of select="name"/> )
  {
    this.<xsl:value-of select="name"/> = <xsl:value-of select="name"/>;
  }
<xsl:text/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
  public List&lt;<xsl:value-of select="$toTableName"/>&gt; get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>()
  {
    return <xsl:value-of select="name"/>;
  }

  public void set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( List&lt;<xsl:value-of select="$toTableName"/>&gt; <xsl:value-of select="name"/> )
  {
    this.<xsl:value-of select="name"/> = <xsl:value-of select="name"/>;
  }
<xsl:text/>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:choose>
                                                                    <xsl:when test="$toTableName = 'Users'">
  public BackendlessUser get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>()
  {
    return <xsl:value-of select="name"/>;
  }

  public void set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( BackendlessUser <xsl:value-of select="name"/> )
  {
    this.<xsl:value-of select="name"/> = <xsl:value-of select="name"/>;
  }
<xsl:text/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
  public <xsl:value-of select="$toTableName"/> get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>()
  {
    return <xsl:value-of select="name"/>;
  }

  public void set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( <xsl:value-of select="$toTableName"/><xsl:text> </xsl:text><xsl:value-of select="name"/> )
  {
    this.<xsl:value-of select="name"/> = <xsl:value-of select="name"/>;
  }
<xsl:text/>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:for-each>
                                                    <!-- for each relation create getter and setter -->
                                                    <xsl:for-each select="geoRelations">
                                                        <!-- if relation is ONE_TO_MANY use List -->
                                                        <xsl:choose>
                                                            <xsl:when test="relationshipType = 'ONE_TO_MANY'">
  public List&lt;GeoPoint&gt; get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>()
  {
    return <xsl:value-of select="name"/>;
  }

  public void set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( List&lt;GeoPoint&gt; <xsl:value-of select="name"/> )
  {
    this.<xsl:value-of select="name"/> = <xsl:value-of select="name"/>;
  }
<xsl:text/>
                                                            </xsl:when>
                                                            <xsl:when test="relationshipType = 'ONE_TO_ONE'">
  public GeoPoint get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>()
  {
    return <xsl:value-of select="name"/>;
  }

  public void set<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( GeoPoint <xsl:value-of select="name"/> )
  {
    this.<xsl:value-of select="name"/> = <xsl:value-of select="name"/>;
  }
<xsl:text/>
                                                            </xsl:when>
                                                        </xsl:choose>
                                                    </xsl:for-each>
                                                    <!-- create single method save() -->
  public <xsl:value-of select="name"/> save()
  {
    return Backendless.Data.of( <xsl:value-of select="name"/>.class ).save( this );
  }

  public void saveAsync( AsyncCallback&lt;<xsl:value-of select="name"/>&gt; callback )
  {
    Backendless.Data.of( <xsl:value-of select="name"/>.class ).save( this, callback );
  }

  public Long remove()
  {
    return Backendless.Data.of( <xsl:value-of select="name"/>.class ).remove( this );
  }

  public void removeAsync( AsyncCallback&lt;Long&gt; callback )
  {
    Backendless.Data.of( <xsl:value-of select="name"/>.class ).remove( this, callback );
  }

  public static <xsl:value-of select="name"/> findById( String id )
  {
    return Backendless.Data.of( <xsl:value-of select="name"/>.class ).findById( id );
  }

  public static void findByIdAsync( String id, AsyncCallback&lt;<xsl:value-of select="name"/>&gt; callback )
  {
    Backendless.Data.of( <xsl:value-of select="name"/>.class ).findById( id, callback );
  }

  public static <xsl:value-of select="name"/> findFirst()
  {
    return Backendless.Data.of( <xsl:value-of select="name"/>.class ).findFirst();
  }

  public static void findFirstAsync( AsyncCallback&lt;<xsl:value-of select="name"/>&gt; callback )
  {
    Backendless.Data.of( <xsl:value-of select="name"/>.class ).findFirst( callback );
  }

  public static <xsl:value-of select="name"/> findLast()
  {
    return Backendless.Data.of( <xsl:value-of select="name"/>.class ).findLast();
  }

  public static void findLastAsync( AsyncCallback&lt;<xsl:value-of select="name"/>&gt; callback )
  {
    Backendless.Data.of( <xsl:value-of select="name"/>.class ).findLast( callback );
  }

  public static List&lt;<xsl:value-of select="name"/>&gt; find( DataQueryBuilder queryBuilder )
  {
    return Backendless.Data.of( <xsl:value-of select="name"/>.class ).find( queryBuilder );
  }

  public static void findAsync( DataQueryBuilder queryBuilder, AsyncCallback&lt;List&lt;<xsl:value-of select="name"/>&gt;&gt; callback )
  {
    Backendless.Data.of( <xsl:value-of select="name"/>.class ).find( queryBuilder, callback );
  }
}</file>
            </xsl:for-each>
        </folder>

    </xsl:template>

</xsl:stylesheet>