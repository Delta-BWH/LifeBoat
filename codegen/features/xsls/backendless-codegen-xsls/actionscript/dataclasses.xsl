<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->
    <xsl:param name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:param name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:param name="secretKey" select="backendless-codegen/application/secretKey"/>
    <xsl:param name="appVersionString" select="backendless-codegen/application/versionString"/>

    <xsl:include href="../util.xsl"/>

    <xsl:template match="/">
        <folder name="{$applicationName}-Data">
                        <folder path="backendless-codegen/data-service-classes/html-template"/>
                        <folder path="backendless-codegen/lib"/>
                        <folder name="src">
                            <folder name="com">
                                <xsl:variable name="appPackageName">
                                    <xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>
                                </xsl:variable>
                                <folder name="{$appPackageName}">
                                    <folder name="data">
                                        <file name="AppInit.as">package com.<xsl:value-of select="$appPackageName"/>.data
{
  import com.backendless.Backendless;

  public class AppInit
  {
    public static var initialized:Boolean = false;

    public static function initialize()
    {
      if( initialized )
        return;

      Backendless.SITE_URL = "https://api.backendless.com/";
      Backendless.initApp( "<xsl:value-of select="$applicationId"/>", "<xsl:value-of select="$secretKey"/>", "<xsl:value-of select="$appVersionString"/>" );

      // table to class mappings
      <xsl:text/>
                    <xsl:for-each select="backendless-codegen/application/tables/table[name != 'Users']">
      <xsl:text/>Backendless.Data.mapTableToClass( "<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>", <xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template> );
      <xsl:text/>
                    </xsl:for-each>
      initialized = true;
    }
  }
}</file>
                                        <xsl:for-each select="backendless-codegen/application/tables/table[name != 'Users']">
                                            <xsl:variable name="nameFirstCharUpper">
                                                <xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>
                                            </xsl:variable>
                                            <file name="{$nameFirstCharUpper}.as">package com.<xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>.data
{
  import com.backendless.Backendless;
  import com.backendless.BackendlessUser;
  import com.backendless.data.BackendlessCollection;

  import mx.collections.ArrayList;
  import mx.collections.IList;

  import mx.rpc.IResponder;
  import mx.rpc.Responder;
  import mx.rpc.events.FaultEvent;
  import mx.rpc.events.ResultEvent;

  public class <xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>
  {
    public var ___class = "<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>";
    public var __meta;

    <xsl:text/>

                                        <xsl:for-each select="columns">
    <xsl:text/>private var _<xsl:value-of select="name"/>:<xsl:call-template name="getActionScriptType"><xsl:with-param name="str" select="dataType"/></xsl:call-template>;
    <xsl:text/>
                                        </xsl:for-each>
                                        <xsl:for-each select="relations">
                                            <xsl:choose>
                                                <xsl:when test="relationshipType = 'ONE_TO_MANY'">
    <xsl:text/>private var _<xsl:value-of select="name"/>:BackendlessCollection;
    <xsl:text/>
                                                </xsl:when>
                                                <xsl:when test="relationshipType = 'ONE_TO_ONE'">
                                                    <xsl:variable name="id" select="relatedTable"/>
                                                    <xsl:variable name="relatedTableName" select="../../table[tableId = $id]/name"/>
                                                    <xsl:choose>
                                                        <xsl:when test="$relatedTableName = 'Users'">
    <xsl:text/>private var _<xsl:value-of select="name"/>:BackendlessUser;
    <xsl:text/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
    <xsl:text/>private var _<xsl:value-of select="name"/>:<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="$relatedTableName"/></xsl:call-template>;
    <xsl:text/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:when>
                                            </xsl:choose>
                                        </xsl:for-each>
    public function <xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>()
    {
      AppInit.initialize();
    }
                                        <xsl:for-each select="columns">
    public function get <xsl:value-of select="name"/>():<xsl:call-template name="getActionScriptType"><xsl:with-param name="str" select="dataType"/></xsl:call-template>
    {
      return _<xsl:value-of select="name"/>;
    }

    public function set <xsl:value-of select="name"/>( value:<xsl:call-template name="getActionScriptType"><xsl:with-param name="str" select="dataType"/></xsl:call-template> ):void
    {
      this._<xsl:value-of select="name"/> = value;
    }
                                        </xsl:for-each>
                                        <xsl:for-each select="relations">
                                            <xsl:choose>
                                                <xsl:when test="relationshipType = 'ONE_TO_MANY'">
    public function get <xsl:value-of select="name"/>():BackendlessCollection
    {
      return _<xsl:value-of select="name"/>;
    }

    public function set <xsl:value-of select="name"/>( value:* ):void
    {
      if( value is Array )
      {
        init<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Collection();
        _<xsl:value-of select="name"/>.currentPage.addAll( new ArrayList( value ) )
      }
      else if( value is BackendlessCollection )
      {
        this._<xsl:value-of select="name"/> = value;
      }
      else if( value is IList )
      {
        init<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Collection();
        _<xsl:value-of select="name"/>.currentPage.addAll( value );
      }
    }
                                                </xsl:when>
                                                <xsl:when test="relationshipType = 'ONE_TO_ONE'">
                                                    <xsl:variable name="id" select="relatedTable"/>
                                                    <xsl:variable name="relatedTableName" select="../../table[tableId = $id]/name"/>
                                                    <xsl:choose>
                                                        <xsl:when test="$relatedTableName = 'Users'">
    public function get <xsl:value-of select="name"/>():BackendlessUser
    {
      return _<xsl:value-of select="name"/>;
    }

    public function set <xsl:value-of select="name"/>( value:* ):void
    {
      if( value is BackendlessUser )
      {
        this._<xsl:value-of select="name"/> = value;
      }
      else
      {
        this._<xsl:value-of select="name"/> = new BackendlessUser();

        for( var prop:* in value )
          this._<xsl:value-of select="name"/>.setProperty( prop, value[ prop ] );
      }
    }
                                                        </xsl:when>
                                                        <xsl:otherwise>
    public function get <xsl:value-of select="name"/>():><xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="$relatedTableName"/></xsl:call-template>
    {
      return _<xsl:value-of select="name"/>;
    }

    public function set <xsl:value-of select="name"/>( value:<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="$relatedTableName"/></xsl:call-template> ):void
    {
      this._<xsl:value-of select="name"/> = value;
    }
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:when>
                                            </xsl:choose>
                                        </xsl:for-each>
                                        <xsl:for-each select="relations">
    public function load<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( responder:IResponder = null ):void
    {
      if( _<xsl:value-of select="name"/> == null )
        Backendless.Data.of( <xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="../name"/></xsl:call-template> ).loadRelations( this, [ "<xsl:value-of select="name"/>" ], responder );
    }
                                            <xsl:if test="relationshipType = 'ONE_TO_MANY'">
                                                <xsl:variable name="id" select="relatedTable"/>
                                                <xsl:variable name="relatedTableName" select="../../table[tableId = $id]/name"/>
                                                <xsl:choose>
                                                    <xsl:when test="$relatedTableName = 'Users'">
    public function init<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Collection():void
    {
      _<xsl:value-of select="name"/> = new BackendlessCollection();
      _<xsl:value-of select="name"/>.setEntityClass( <xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="../name"/></xsl:call-template> );
    }

    public function addItemTo<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( item:BackendlessUser ):void
    {
      if( _<xsl:value-of select="name"/> == null)
        init<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Collection();

      _<xsl:value-of select="name"/>.addItem( item );
    }

    public function removeItemFrom<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( item:BackendlessUser ):Boolean
    {
      if( _<xsl:value-of select="name"/> == null )
        return false;

      return _<xsl:value-of select="name"/>.removeItem( item );
    }
                                                    </xsl:when>
                                                    <xsl:otherwise>
    public function init<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Collection():void
    {
      _<xsl:value-of select="name"/> = new BackendlessCollection();
      _<xsl:value-of select="name"/>.setEntityClass( <xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="../name"/></xsl:call-template> );
    }

    public function addItemTo<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( item:<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="$relatedTableName"/></xsl:call-template> ):void
    {
      if( _<xsl:value-of select="name"/> == null)
        init<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>Collection();

      _<xsl:value-of select="name"/>.addItem( item );
    }

    public function removeItemFrom<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>( item:<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="$relatedTableName"/></xsl:call-template> ):Boolean
    {
      if( _<xsl:value-of select="name"/> == null )
        return false;

      return _<xsl:value-of select="name"/>.removeItem( item );
    }
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:if>
                                        </xsl:for-each>
    public function save( responder:IResponder = null ):void
    {
      Backendless.Data.of( <xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template> ).save( this, responder );
    }

    public function remove( responder:IResponder = null ):void
    {
      Backendless.Data.of( <xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template> ).remove( this, new Responder(
              function( evt:ResultEvent ):void
              {
                objectId = null;

                if( responder != null )
                  responder.result( evt );
              },
              function( evt:FaultEvent ):void
              {
                if( responder != null )
                  responder.fault( evt );
              }
      ));
    }
  }
}</file>
                                        </xsl:for-each>
                                    </folder>
                                </folder>
                            </folder>
                            <file name="AppHome.as">package
{
  import com.<xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>.data.AppInit;
  import flash.display.Sprite;
  import flash.text.TextField;

  public class AppHome extends Sprite
  {
    public function AppHome()
    {
      var textField:TextField = new TextField();
      textField.width = 500;
      textField.text = "Welcome to Backendless Codegen";
      addChild( textField );

      AppInit.initialize();
    }
  }
}</file>
                        </folder>
                        <file name="{$applicationName}-Data.iml">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;module type="Flex" version="4"&gt;
  &lt;component name="FlexBuildConfigurationManager" active="<xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>-data"&gt;
    &lt;configurations&gt;
      &lt;configuration name="<xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>-data" main-class="AppHome" output-file="<xsl:value-of select="$applicationName"/>-Data.swf" output-folder="$MODULE_DIR$/out/production/<xsl:value-of select="$applicationName"/>-Data" use-html-wrapper="true" wrapper-template-path="$MODULE_DIR$/html-template"&gt;
        &lt;dependencies target-player="12.0"&gt;
          &lt;entries&gt;
            &lt;entry library-id="cc66c27e-920c-47c7-ace0-5b1fa3ec0cf2"&gt;
              &lt;dependency linkage="Merged" /&gt;
            &lt;/entry&gt;
          &lt;/entries&gt;
          &lt;sdk name="flex4.12" /&gt;
        &lt;/dependencies&gt;
        &lt;compiler-options /&gt;
        &lt;packaging-air-desktop /&gt;
        &lt;packaging-android /&gt;
        &lt;packaging-ios /&gt;
      &lt;/configuration&gt;
    &lt;/configurations&gt;
    &lt;compiler-options /&gt;
  &lt;/component&gt;
  &lt;component name="NewModuleRootManager" inherit-compiler-output="true"&gt;
    &lt;exclude-output /&gt;
    &lt;content url="file://$MODULE_DIR$"&gt;
      &lt;sourceFolder url="file://$MODULE_DIR$/src" isTestSource="false" /&gt;
    &lt;/content&gt;
    &lt;orderEntry type="jdk" jdkName="flex4.12" jdkType="Flex SDK Type (new)" /&gt;
    &lt;orderEntry type="sourceFolder" forTests="false" /&gt;
    &lt;orderEntry type="module-library" exported=""&gt;
      &lt;library type="flex"&gt;
        &lt;properties id="cc66c27e-920c-47c7-ace0-5b1fa3ec0cf2" /&gt;
        &lt;CLASSES&gt;
          &lt;root url="file://$MODULE_DIR$/lib" /&gt;
        &lt;/CLASSES&gt;
        &lt;JAVADOC /&gt;
        &lt;SOURCES /&gt;
        &lt;jarDirectory url="file://$MODULE_DIR$/lib" recursive="false" /&gt;
      &lt;/library&gt;
    &lt;/orderEntry&gt;
  &lt;/component&gt;
&lt;/module&gt;</file>
                    </folder>
    </xsl:template>
</xsl:stylesheet>