<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->
    <xsl:param name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:param name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:param name="secretKey" select="backendless-codegen/application/secretKey"/>
    <xsl:param name="appVersionString" select="backendless-codegen/application/versionString"/>
    <xsl:param name="emailConfirmationRequired" select="backendless-codegen/application/emailConfirmation = 'true'"/>

    <xsl:include href="../util.xsl"/>

    <xsl:template match="/">
        <folder name="{$applicationName}-Login">
                        <folder path="backendless-codegen/user-service/html-template"/>
                        <folder path="backendless-codegen/lib"/>
                        <folder name="src">
                            <folder name="com">
                                <xsl:variable name="appPackageName">
                                    <xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>
                                </xsl:variable>
                                <folder name="backendless/{$appPackageName}/userservice">
                                            <file name="AppSettings.as">package com.backendless.<xsl:value-of select="$appPackageName"/>.userservice
{
  public class AppSettings
  {
    public static var appId:String = "<xsl:value-of select="$applicationId"/>";
    public static var secretKey:String = "<xsl:value-of select="$secretKey"/>";
    public static var version:String = "<xsl:value-of select="$appVersionString"/>";
  }
}</file>
                                            <file path="backendless-codegen/user-service/LoggedInScreen.mxml"/>
                                            <file name="LogInScreen.mxml">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;s:Group xmlns:fx="http://ns.adobe.com/mxml/2009"
		 xmlns:s="library://ns.adobe.com/flex/spark"
		 xmlns:mx="library://ns.adobe.com/flex/mx"&gt;
	&lt;fx:Metadata&gt;
		[Event("loggedIn")]
		[Event("registrationCalled")]
	&lt;/fx:Metadata&gt;

	&lt;fx:Script&gt;&lt;![CDATA[
		import com.backendless.Backendless;

		import mx.controls.Alert;
		import mx.managers.CursorManager;
		import mx.rpc.IResponder;
		import mx.rpc.Responder;
		import mx.rpc.events.FaultEvent;
		import mx.rpc.events.ResultEvent;


		private function onLoginClick( event:MouseEvent ):void
		{
			if( identityField.text == "" )
			{
				Alert.show( "<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="backendless-codegen/application/user-properties/property[identity = 'true']/name"/></xsl:call-template> cannot be empty" );
				return;
			}

			if( passwordField.text == "" )
			{
				Alert.show( "Password cannot be empty" );
				return;
			}

			beginBusy();
			var loginResponder:IResponder = new mx.rpc.Responder( loginSucceeded, loginFailed );<xsl:text/>
                                                <xsl:choose>
                                                    <xsl:when test="backendless-codegen/application/user-properties/property[identity = 'true']/dataType = 'INT'
                                                        or backendless-codegen/application/user-properties/property[identity = 'true']/dataType = 'AUTO_INCREMENT'
                                                        or backendless-codegen/application/user-properties/property[identity = 'true']/dataType = 'DOUBLE'">
            Backendless.UserService.login( Number( identityField.text ), passwordField.text, loginResponder );<xsl:text/>
                                                    </xsl:when>
                                                    <xsl:otherwise>
			Backendless.UserService.login( identityField.text, passwordField.text, loginResponder );<xsl:text/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
		}

		private function loginSucceeded( event:ResultEvent ):void
		{
			endBusy();
			dispatchEvent( new Event("loggedIn") );
		}

		private function loginFailed( fault:FaultEvent ):void
		{
			endBusy();
			Alert.show( fault.fault.faultString );
		}

		protected function onRegisterClick( event:MouseEvent ):void
		{
			dispatchEvent( new Event( 'registrationCalled' ) );
		}

		private function beginBusy():void
		{
			loginButton.enabled = false;
			CursorManager.setBusyCursor();
		}

		private function endBusy():void
		{
			loginButton.enabled = true;
			CursorManager.removeBusyCursor();
		}
	]]&gt;&lt;/fx:Script&gt;
	&lt;s:Form width="100%" height="100%"&gt;
		&lt;s:layout&gt;
			&lt;s:FormLayout verticalAlign="middle" horizontalAlign="center"/&gt;
		&lt;/s:layout&gt;
		&lt;s:FormHeading label="Login to <xsl:value-of select="$applicationName"/>" fontSize="25" /&gt;
		&lt;s:VGroup horizontalAlign="right" paddingTop="20"&gt;
			&lt;s:FormItem label="<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="backendless-codegen/application/user-properties/property[identity = 'true']/name"/></xsl:call-template>:" fontSize="14" &gt;
				&lt;s:TextInput id="identityField" width="200"/&gt;
			&lt;/s:FormItem&gt;
			&lt;s:FormItem label="Password:" fontSize="14" &gt;
				&lt;s:TextInput id="passwordField" width="200" displayAsPassword="true"/&gt;
			&lt;/s:FormItem&gt;
			&lt;s:FormItem &gt;
				&lt;s:HGroup width="200" gap="15" horizontalAlign="center" paddingTop="10" verticalAlign="middle"&gt;
					&lt;s:Button id="loginButton" label="Login" click="onLoginClick(event)"/&gt;
					&lt;s:Label text="or"/&gt;
					&lt;mx:LinkButton label="Register" click="onRegisterClick(event)"/&gt;
				&lt;/s:HGroup&gt;
			&lt;/s:FormItem&gt;
		&lt;/s:VGroup&gt;
	&lt;/s:Form&gt;

&lt;/s:Group&gt;</file>
                                            <file name="RegisteredScreen.mxml">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;s:Group xmlns:fx="http://ns.adobe.com/mxml/2009"
         xmlns:s="library://ns.adobe.com/flex/spark"
         width="400" height="300"&gt;
	&lt;fx:Metadata&gt;
		[Event("homeCalled")]
	&lt;/fx:Metadata&gt;
    &lt;fx:Script&gt;&lt;![CDATA[
        protected function onHomeClick( event:MouseEvent ):void
        {
            dispatchEvent( new Event( 'homeCalled' ) );
        }
        ]]&gt;
	&lt;/fx:Script&gt;

	&lt;s:Form width="100%" height="100%"&gt;
		&lt;s:layout&gt;
			&lt;s:FormLayout verticalAlign="middle" horizontalAlign="center"/&gt;
		&lt;/s:layout&gt;
		&lt;s:FormItem&gt;
			&lt;s:Button label="Home" click="onHomeClick(event)"/&gt;
                                                <xsl:choose>
                                                    <xsl:when test="$emailConfirmationRequired">
			&lt;s:Label paddingTop="30"
					 text="Thank you for registering!&#xd;Please check your email and &#xd;follow the link in the message we sent to you."/&gt;
                                                    </xsl:when>
                                                    <xsl:otherwise>
			&lt;s:Label paddingTop="30" text="Thank you for registering!&#xd;You can login to the application now."/&gt;
                                                    </xsl:otherwise>
                                                </xsl:choose>
		&lt;/s:FormItem&gt;
	&lt;/s:Form&gt;

&lt;/s:Group&gt;</file>
                                            <file name="RegistrationScreen.mxml">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;s:Group xmlns:fx="http://ns.adobe.com/mxml/2009"
		 xmlns:s="library://ns.adobe.com/flex/spark"
		 xmlns:mx="library://ns.adobe.com/flex/mx"
         percentHeight="100"&gt;
	&lt;fx:Metadata&gt;
		[Event("onRegistered")]
		[Event("homeCalled")]
	&lt;/fx:Metadata&gt;
	&lt;fx:Script&gt;&lt;![CDATA[
		import com.backendless.Backendless;
		import com.backendless.BackendlessUser;

		import mx.controls.Alert;
		import mx.managers.CursorManager;
		import mx.rpc.IResponder;
		import mx.rpc.Responder;
		import mx.rpc.events.FaultEvent;
		import mx.rpc.events.ResultEvent;
        <xsl:text/>
                                                <xsl:for-each select="backendless-codegen/application/user-properties/property"><xsl:text/>
        private static const <xsl:call-template name="toUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>_KEY:String = "<xsl:value-of select="name"/>";<xsl:text/>
                                                </xsl:for-each>

		private function onRegisterClick( event:MouseEvent ):void
		{
			if( <xsl:value-of select="backendless-codegen/application/user-properties/property[identity = 'true']/name"/>Field.text == "" )
			{
				Alert.show( "<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="backendless-codegen/application/user-properties/property[identity = 'true']/name"/></xsl:call-template> cannot be empty" );
				return;
			}

			if( passwordField.text == "" )
			{
				Alert.show( "Password cannot be empty" );
				return;
			}

			if( passwordField.text != verifyPasswordField.text )
			{
				Alert.show( "Passwords does not match" );
				return;
			}
                                                <xsl:for-each select="backendless-codegen/application/user-properties/property[required = 'true' and identity = 'false' and name != 'password']">
                                                    <xsl:choose>
                                                        <xsl:when test="dataType = 'BOOLEAN'">
            if( <xsl:value-of select="name"/>RadioGroup.selection == null )
            {
                Alert.show( "Please make a selection for the <xsl:value-of select="name"/> property" );
                return;
            }
                                                        </xsl:when>
                                                        <xsl:when test="dataType = 'DATETIME'">
            if( <xsl:value-of select="name"/>Field.text == "" )
            {
                Alert.show( "Please select a value for the <xsl:value-of select="name"/> property" );
                return;
            }
                                                        </xsl:when>
                                                        <xsl:otherwise>
            if( <xsl:value-of select="name"/>Field.text == "" )
            {
                Alert.show( "<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template> cannot be empty" );
                return;
            }
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:for-each>
			var candidate:BackendlessUser = new BackendlessUser();
                                                <xsl:for-each select="backendless-codegen/application/user-properties/property">
                                                    <xsl:choose>
                                                        <xsl:when test="dataType = 'BOOLEAN'">
            if( <xsl:value-of select="name"/>RadioGroup.selection != null )
            {
                candidate.setProperty( <xsl:call-template name="toUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>_KEY, <xsl:value-of select="name"/>RadioGroup.selectedValue == "1" );
            }
                                                        </xsl:when>
                                                        <xsl:when test="dataType = 'DATETIME'">
            if( <xsl:value-of select="name"/>Field.text != "" )
            {
                candidate.setProperty( <xsl:call-template name="toUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>_KEY, <xsl:value-of select="name"/>Field.value );
            }
                                                        </xsl:when>
                                                        <xsl:when test="dataType = 'INT' or dataType = 'DOUBLE' or dataType = 'AUTO_INCREMENT'">
            if( <xsl:value-of select="name"/>Field.text != "" )
            {
                candidate.setProperty( <xsl:call-template name="toUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>_KEY, new Number( <xsl:value-of select="name"/>Field.text ) );
            }
                                                        </xsl:when>
                                                        <xsl:otherwise>
            if( <xsl:value-of select="name"/>Field.text != "" )
            {
                candidate.setProperty( <xsl:call-template name="toUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>_KEY, <xsl:value-of select="name"/>Field.text );
            }
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:for-each>
			registerButton.enabled = false;
			CursorManager.setBusyCursor();

			var registerResponder:IResponder = new mx.rpc.Responder( registrationSucceeded, registrationFailed );
			Backendless.UserService.register( candidate, registerResponder );
		}

		private function registrationSucceeded( event:ResultEvent ):void
		{
			registerButton.enabled = true;
			CursorManager.removeBusyCursor();

			dispatchEvent( new Event( 'onRegistered' ) );
		}

		private function registrationFailed( fault:FaultEvent ):void
		{
			registerButton.enabled = true;
			CursorManager.removeBusyCursor();

			Alert.show( fault.fault.faultString );
		}

		protected function onCancelClick( event:MouseEvent ):void
		{
			dispatchEvent( new Event( 'homeCalled' ) );
		}
	]]&gt;&lt;/fx:Script&gt;
	&lt;fx:Declarations&gt;
                                                <xsl:for-each select="backendless-codegen/application/user-properties/property[dataType = 'BOOLEAN']">
        &lt;s:RadioButtonGroup id="<xsl:value-of select="name"/>RadioGroup"/&gt;
                                                </xsl:for-each>
	&lt;/fx:Declarations&gt;
    &lt;s:Scroller percentWidth="100" percentHeight="50"&gt;
        &lt;s:viewport&gt;
            &lt;s:VGroup verticalAlign="middle"&gt;
                &lt;s:Form width="100%" height="100%"&gt;
                    &lt;s:layout&gt;
                        &lt;s:FormLayout verticalAlign="middle" horizontalAlign="center"/&gt;
                    &lt;/s:layout&gt;
                    &lt;s:FormHeading label="Register for <xsl:value-of select="$applicationName"/>" fontSize="25" /&gt;
                    &lt;s:VGroup horizontalAlign="right" paddingTop="20"&gt;
                        &lt;s:FormItem label="<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="backendless-codegen/application/user-properties/property[identity = 'true']/name"/></xsl:call-template>:" fontSize="14"&gt;
                            &lt;s:TextInput id="<xsl:value-of select="backendless-codegen/application/user-properties/property[identity = 'true']/name"/>Field" width="200"/&gt;
                        &lt;/s:FormItem&gt;
                        &lt;s:FormItem label="Password:" fontSize="14"&gt;
                            &lt;s:TextInput id="passwordField" width="200" displayAsPassword="true"/&gt;
                        &lt;/s:FormItem&gt;
                        &lt;s:FormItem label="Verify Password:" fontSize="14"&gt;
                            &lt;s:TextInput id="verifyPasswordField" width="200" displayAsPassword="true"/&gt;
                        &lt;/s:FormItem&gt;
                                                            <xsl:for-each select="backendless-codegen/application/user-properties/property[identity = 'false' and name != 'password']">
                                                                <xsl:choose>
                                                                    <xsl:when test="dataType = 'BOOLEAN'">
                        &lt;s:FormItem label="<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>:" fontSize="14"&gt;
                                &lt;s:HGroup width="200" gap="20" horizontalAlign="center" verticalAlign="justify"&gt;
                                    &lt;s:RadioButton label="Y" groupName="<xsl:value-of select="name"/>RadioGroup" value="1"/&gt;
                                    &lt;s:RadioButton label="N" groupName="<xsl:value-of select="name"/>RadioGroup" value="0"/&gt;
                                &lt;/s:HGroup&gt;
                        &lt;/s:FormItem&gt;
                                                                    </xsl:when>
                                                                    <xsl:when test="dataType = 'DATETIME'">
                        &lt;s:FormItem label="<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>:" fontSize="14"&gt;
                            &lt;mx:DateField id="<xsl:value-of select="name"/>Field" width="200"/&gt;
                        &lt;/s:FormItem&gt;
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                        &lt;s:FormItem label="<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>:" fontSize="14"&gt;
                            &lt;s:TextInput id="<xsl:value-of select="name"/>Field" width="200"/&gt;
                        &lt;/s:FormItem&gt;
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:for-each>
                    &lt;/s:VGroup&gt;
                    &lt;s:HGroup horizontalAlign="right" width="500" paddingTop="20"&gt;
                        &lt;s:Button label="Register" id="registerButton" click="onRegisterClick(event)"/&gt;
                        &lt;s:Button label="Cancel" click="onCancelClick(event)"/&gt;
                    &lt;/s:HGroup&gt;
                &lt;/s:Form&gt;
            &lt;/s:VGroup&gt;
        &lt;/s:viewport&gt;
    &lt;/s:Scroller&gt;

&lt;/s:Group&gt;</file>
                                </folder>
                            </folder>
                            <file name="Main.mxml">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;s:Application xmlns:fx="http://ns.adobe.com/mxml/2009"
               xmlns:s="library://ns.adobe.com/flex/spark"
               xmlns:login="com.backendless.<xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>.userservice.*"
               applicationComplete="onInitialize(event)"&gt;
	&lt;fx:Script&gt;
		&lt;![CDATA[
			import com.backendless.Backendless;
            import com.backendless.<xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>.userservice.AppSettings;
           import mx.events.FlexEvent;

			private function onInitialize( event:FlexEvent ):void
			{
                Backendless.SITE_URL = "https://api.backendless.com/";
                Backendless.initApp( AppSettings.appId, AppSettings.secretKey, AppSettings.version );
                currentState = "LoginScreenState";
            }

			private function onLoggedInScreenCalled():void
			{
				currentState = 'LoggedInState';
			}

			private function onRegistrationScreenCalled():void
			{
				currentState = "RegistrationScreenState";
			}

			private function onHomeScreenCalled():void
			{
				currentState = 'LoginScreenState';
			}

			private function onRegisteredScreenCalled():void
			{
				currentState = 'RegisteredState';
			}
		]]&gt;
	&lt;/fx:Script&gt;
	&lt;s:layout&gt;
		&lt;s:VerticalLayout horizontalAlign="center" paddingLeft="5" paddingRight="5" verticalAlign="middle"/&gt;
	&lt;/s:layout&gt;

	&lt;s:states&gt;
		&lt;s:State name="LoginScreenState"/&gt;
		&lt;s:State name="LoggedInState"/&gt;
		&lt;s:State name="RegistrationScreenState"/&gt;
		&lt;s:State name="RegisteredState"/&gt;
	&lt;/s:states&gt;

	&lt;login:LogInScreen includeIn="LoginScreenState"
					  loggedIn="onLoggedInScreenCalled()" registrationCalled="onRegistrationScreenCalled()"/&gt;
	&lt;login:LoggedInScreen includeIn="LoggedInState"
						 loggedOut="onHomeScreenCalled()"/&gt;
	&lt;login:RegistrationScreen includeIn="RegistrationScreenState"
							 onRegistered="onRegisteredScreenCalled()" homeCalled="onHomeScreenCalled()"/&gt;
	&lt;login:RegisteredScreen includeIn="RegisteredState"
						   homeCalled="onHomeScreenCalled()"/&gt;
&lt;/s:Application&gt;</file>
                            <file path="backendless-codegen/user-service/Main-app.xml"/>
                        </folder>
                        <file name="{$applicationName}-Login.iml">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;module type="Flex" version="4"&gt;
  &lt;component name="FlexBuildConfigurationManager" active="<xsl:value-of select="$applicationName"/>-Login"&gt;
    &lt;configurations&gt;
      &lt;configuration name="<xsl:value-of select="$applicationName"/>-Login" main-class="Main" output-file="<xsl:value-of select="$applicationName"/>-Login.swf" output-folder="$MODULE_DIR$/../out/production/<xsl:value-of select="$applicationName"/>-Login" use-html-wrapper="true" wrapper-template-path="$MODULE_DIR$/html-template"&gt;
        &lt;dependencies target-player="12.0"&gt;
          &lt;entries&gt;
            &lt;entry library-id="eb4bd644-7d32-4ec3-b2d7-8a2f2996b48b"&gt;
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
        &lt;properties id="eb4bd644-7d32-4ec3-b2d7-8a2f2996b48b" /&gt;
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
        <file name="{$applicationName}-Codegen.ipr">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;project version="4"&gt;
  &lt;component name="BuildJarProjectSettings"&gt;
    &lt;option name="BUILD_JARS_ON_MAKE" value="false" /&gt;
  &lt;/component&gt;
  &lt;component name="CodeStyleSettingsManager"&gt;
    &lt;option name="PER_PROJECT_SETTINGS" /&gt;
    &lt;option name="USE_PER_PROJECT_SETTINGS" value="false" /&gt;
  &lt;/component&gt;
  &lt;component name="CompilerConfiguration"&gt;
    &lt;option name="DEFAULT_COMPILER" value="Javac" /&gt;
    &lt;resourceExtensions&gt;
      &lt;entry name=".+\.(properties|xml|html|dtd|tld)" /&gt;
      &lt;entry name=".+\.(gif|png|jpeg|jpg)" /&gt;
    &lt;/resourceExtensions&gt;
    &lt;wildcardResourcePatterns&gt;
      &lt;entry name="?*.properties" /&gt;
      &lt;entry name="?*.xml" /&gt;
      &lt;entry name="?*.gif" /&gt;
      &lt;entry name="?*.png" /&gt;
      &lt;entry name="?*.jpeg" /&gt;
      &lt;entry name="?*.jpg" /&gt;
      &lt;entry name="?*.html" /&gt;
      &lt;entry name="?*.dtd" /&gt;
      &lt;entry name="?*.tld" /&gt;
      &lt;entry name="?*.ftl" /&gt;
    &lt;/wildcardResourcePatterns&gt;
    &lt;annotationProcessing&gt;
      &lt;profile default="true" name="Default" enabled="false"&gt;
        &lt;processorPath useClasspath="true" /&gt;
      &lt;/profile&gt;
    &lt;/annotationProcessing&gt;
  &lt;/component&gt;
  &lt;component name="CopyrightManager" default="" /&gt;
  &lt;component name="DependencyValidationManager"&gt;
    &lt;option name="SKIP_IMPORT_STATEMENTS" value="false" /&gt;
  &lt;/component&gt;
  &lt;component name="Encoding" useUTFGuessing="true" native2AsciiForPropertiesFiles="false" /&gt;
  &lt;component name="IdProvider" IDEtalkID="B1980F702256F402C9E02654E08EFB3A" /&gt;
  &lt;component name="JavadocGenerationManager"&gt;
    &lt;option name="OUTPUT_DIRECTORY" /&gt;
    &lt;option name="OPTION_SCOPE" value="protected" /&gt;
    &lt;option name="OPTION_HIERARCHY" value="true" /&gt;
    &lt;option name="OPTION_NAVIGATOR" value="true" /&gt;
    &lt;option name="OPTION_INDEX" value="true" /&gt;
    &lt;option name="OPTION_SEPARATE_INDEX" value="true" /&gt;
    &lt;option name="OPTION_DOCUMENT_TAG_USE" value="false" /&gt;
    &lt;option name="OPTION_DOCUMENT_TAG_AUTHOR" value="false" /&gt;
    &lt;option name="OPTION_DOCUMENT_TAG_VERSION" value="false" /&gt;
    &lt;option name="OPTION_DOCUMENT_TAG_DEPRECATED" value="true" /&gt;
    &lt;option name="OPTION_DEPRECATED_LIST" value="true" /&gt;
    &lt;option name="OTHER_OPTIONS" value="" /&gt;
    &lt;option name="HEAP_SIZE" /&gt;
    &lt;option name="LOCALE" /&gt;
    &lt;option name="OPEN_IN_BROWSER" value="true" /&gt;
  &lt;/component&gt;
  &lt;component name="ModuleEditorState"&gt;
    &lt;option name="LAST_EDITED_MODULE_NAME" /&gt;
    &lt;option name="LAST_EDITED_TAB_NAME" /&gt;
  &lt;/component&gt;
  &lt;component name="Palette2"&gt;
    &lt;group name="Swing"&gt;
      &lt;item class="com.intellij.uiDesigner.HSpacer" tooltip-text="Horizontal Spacer" icon="/com/intellij/uiDesigner/icons/hspacer.png" removable="false" auto-create-binding="false" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="1" hsize-policy="6" anchor="0" fill="1" /&gt;
      &lt;/item&gt;
      &lt;item class="com.intellij.uiDesigner.VSpacer" tooltip-text="Vertical Spacer" icon="/com/intellij/uiDesigner/icons/vspacer.png" removable="false" auto-create-binding="false" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="6" hsize-policy="1" anchor="0" fill="2" /&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JPanel" icon="/com/intellij/uiDesigner/icons/panel.png" removable="false" auto-create-binding="false" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="3" hsize-policy="3" anchor="0" fill="3" /&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JScrollPane" icon="/com/intellij/uiDesigner/icons/scrollPane.png" removable="false" auto-create-binding="false" can-attach-label="true"&gt;
        &lt;default-constraints vsize-policy="7" hsize-policy="7" anchor="0" fill="3" /&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JButton" icon="/com/intellij/uiDesigner/icons/button.png" removable="false" auto-create-binding="true" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="0" hsize-policy="3" anchor="0" fill="1" /&gt;
        &lt;initial-values&gt;
          &lt;property name="text" value="Button" /&gt;
        &lt;/initial-values&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JRadioButton" icon="/com/intellij/uiDesigner/icons/radioButton.png" removable="false" auto-create-binding="true" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="0" hsize-policy="3" anchor="8" fill="0" /&gt;
        &lt;initial-values&gt;
          &lt;property name="text" value="RadioButton" /&gt;
        &lt;/initial-values&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JCheckBox" icon="/com/intellij/uiDesigner/icons/checkBox.png" removable="false" auto-create-binding="true" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="0" hsize-policy="3" anchor="8" fill="0" /&gt;
        &lt;initial-values&gt;
          &lt;property name="text" value="CheckBox" /&gt;
        &lt;/initial-values&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JLabel" icon="/com/intellij/uiDesigner/icons/label.png" removable="false" auto-create-binding="false" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="0" hsize-policy="0" anchor="8" fill="0" /&gt;
        &lt;initial-values&gt;
          &lt;property name="text" value="Label" /&gt;
        &lt;/initial-values&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JTextField" icon="/com/intellij/uiDesigner/icons/textField.png" removable="false" auto-create-binding="true" can-attach-label="true"&gt;
        &lt;default-constraints vsize-policy="0" hsize-policy="6" anchor="8" fill="1"&gt;
          &lt;preferred-size width="150" height="-1" /&gt;
        &lt;/default-constraints&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JPasswordField" icon="/com/intellij/uiDesigner/icons/passwordField.png" removable="false" auto-create-binding="true" can-attach-label="true"&gt;
        &lt;default-constraints vsize-policy="0" hsize-policy="6" anchor="8" fill="1"&gt;
          &lt;preferred-size width="150" height="-1" /&gt;
        &lt;/default-constraints&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JFormattedTextField" icon="/com/intellij/uiDesigner/icons/formattedTextField.png" removable="false" auto-create-binding="true" can-attach-label="true"&gt;
        &lt;default-constraints vsize-policy="0" hsize-policy="6" anchor="8" fill="1"&gt;
          &lt;preferred-size width="150" height="-1" /&gt;
        &lt;/default-constraints&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JTextArea" icon="/com/intellij/uiDesigner/icons/textArea.png" removable="false" auto-create-binding="true" can-attach-label="true"&gt;
        &lt;default-constraints vsize-policy="6" hsize-policy="6" anchor="0" fill="3"&gt;
          &lt;preferred-size width="150" height="50" /&gt;
        &lt;/default-constraints&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JTextPane" icon="/com/intellij/uiDesigner/icons/textPane.png" removable="false" auto-create-binding="true" can-attach-label="true"&gt;
        &lt;default-constraints vsize-policy="6" hsize-policy="6" anchor="0" fill="3"&gt;
          &lt;preferred-size width="150" height="50" /&gt;
        &lt;/default-constraints&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JEditorPane" icon="/com/intellij/uiDesigner/icons/editorPane.png" removable="false" auto-create-binding="true" can-attach-label="true"&gt;
        &lt;default-constraints vsize-policy="6" hsize-policy="6" anchor="0" fill="3"&gt;
          &lt;preferred-size width="150" height="50" /&gt;
        &lt;/default-constraints&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JComboBox" icon="/com/intellij/uiDesigner/icons/comboBox.png" removable="false" auto-create-binding="true" can-attach-label="true"&gt;
        &lt;default-constraints vsize-policy="0" hsize-policy="2" anchor="8" fill="1" /&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JTable" icon="/com/intellij/uiDesigner/icons/table.png" removable="false" auto-create-binding="true" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="6" hsize-policy="6" anchor="0" fill="3"&gt;
          &lt;preferred-size width="150" height="50" /&gt;
        &lt;/default-constraints&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JList" icon="/com/intellij/uiDesigner/icons/list.png" removable="false" auto-create-binding="true" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="6" hsize-policy="2" anchor="0" fill="3"&gt;
          &lt;preferred-size width="150" height="50" /&gt;
        &lt;/default-constraints&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JTree" icon="/com/intellij/uiDesigner/icons/tree.png" removable="false" auto-create-binding="true" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="6" hsize-policy="6" anchor="0" fill="3"&gt;
          &lt;preferred-size width="150" height="50" /&gt;
        &lt;/default-constraints&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JTabbedPane" icon="/com/intellij/uiDesigner/icons/tabbedPane.png" removable="false" auto-create-binding="true" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="3" hsize-policy="3" anchor="0" fill="3"&gt;
          &lt;preferred-size width="200" height="200" /&gt;
        &lt;/default-constraints&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JSplitPane" icon="/com/intellij/uiDesigner/icons/splitPane.png" removable="false" auto-create-binding="false" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="3" hsize-policy="3" anchor="0" fill="3"&gt;
          &lt;preferred-size width="200" height="200" /&gt;
        &lt;/default-constraints&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JSpinner" icon="/com/intellij/uiDesigner/icons/spinner.png" removable="false" auto-create-binding="true" can-attach-label="true"&gt;
        &lt;default-constraints vsize-policy="0" hsize-policy="6" anchor="8" fill="1" /&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JSlider" icon="/com/intellij/uiDesigner/icons/slider.png" removable="false" auto-create-binding="true" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="0" hsize-policy="6" anchor="8" fill="1" /&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JSeparator" icon="/com/intellij/uiDesigner/icons/separator.png" removable="false" auto-create-binding="false" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="6" hsize-policy="6" anchor="0" fill="3" /&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JProgressBar" icon="/com/intellij/uiDesigner/icons/progressbar.png" removable="false" auto-create-binding="true" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="0" hsize-policy="6" anchor="0" fill="1" /&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JToolBar" icon="/com/intellij/uiDesigner/icons/toolbar.png" removable="false" auto-create-binding="false" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="0" hsize-policy="6" anchor="0" fill="1"&gt;
          &lt;preferred-size width="-1" height="20" /&gt;
        &lt;/default-constraints&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JToolBar$Separator" icon="/com/intellij/uiDesigner/icons/toolbarSeparator.png" removable="false" auto-create-binding="false" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="0" hsize-policy="0" anchor="0" fill="1" /&gt;
      &lt;/item&gt;
      &lt;item class="javax.swing.JScrollBar" icon="/com/intellij/uiDesigner/icons/scrollbar.png" removable="false" auto-create-binding="true" can-attach-label="false"&gt;
        &lt;default-constraints vsize-policy="6" hsize-policy="0" anchor="0" fill="2" /&gt;
      &lt;/item&gt;
    &lt;/group&gt;
  &lt;/component&gt;
  &lt;component name="ProjectInspectionProfilesVisibleTreeState"&gt;
    &lt;entry key="Project Default"&gt;
      &lt;profile-state /&gt;
    &lt;/entry&gt;
  &lt;/component&gt;
  &lt;component name="ProjectKey"&gt;
    &lt;option name="state" value="project://default" /&gt;
  &lt;/component&gt;
  &lt;component name="ProjectModuleManager"&gt;
    &lt;modules&gt;
      &lt;module fileurl="file://$PROJECT_DIR$/<xsl:value-of select="$applicationName"/>-Login/<xsl:value-of select="$applicationName"/>-Login.iml" filepath="$PROJECT_DIR$/<xsl:value-of select="$applicationName"/>-Login/<xsl:value-of select="$applicationName"/>-Login.iml" /&gt;
    &lt;/modules&gt;
  &lt;/component&gt;
  &lt;component name="ProjectRootManager" version="2" languageLevel="JDK_1_5" assert-keyword="true" jdk-15="true" project-jdk-name="flex4.12" project-jdk-type="Flex SDK Type (new)"&gt;
    &lt;output url="file://$PROJECT_DIR$/out" /&gt;
  &lt;/component&gt;
  &lt;component name="ResourceManagerContainer"&gt;
    &lt;option name="myResourceBundles"&gt;
      &lt;value&gt;
        &lt;list size="0" /&gt;
      &lt;/value&gt;
    &lt;/option&gt;
  &lt;/component&gt;
  &lt;component name="SvnConfiguration"&gt;
    &lt;configuration&gt;$USER_HOME$/.subversion&lt;/configuration&gt;
  &lt;/component&gt;
  &lt;component name="VcsDirectoryMappings"&gt;
    &lt;mapping directory="" vcs="" /&gt;
  &lt;/component&gt;
  &lt;component name="XPathView.XPathProjectComponent"&gt;
    &lt;history /&gt;
    &lt;find-history /&gt;
  &lt;/component&gt;
&lt;/project&gt;</file>
    </xsl:template>
</xsl:stylesheet>