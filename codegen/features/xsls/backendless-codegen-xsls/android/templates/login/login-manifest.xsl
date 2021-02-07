<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="login-manifest">
<file name="AndroidManifest.xml">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;manifest xmlns:android="http://schemas.android.com/apk/res/android"
		  package="<xsl:value-of select="$package"/>"&gt;

	&lt;uses-permission android:name="android.permission.INTERNET"/&gt;

	&lt;application
			android:allowBackup="true"
			android:icon="@mipmap/ic_launcher"
			android:label="@string/app_name"
			android:supportsRtl="true"
			android:theme="@style/AppTheme"&gt;

		&lt;activity android:name=".MainLogin"&gt;
			&lt;intent-filter&gt;
				&lt;action android:name="android.intent.action.MAIN"/&gt;
				&lt;category android:name="android.intent.category.LAUNCHER"/&gt;
			&lt;/intent-filter&gt;
		&lt;/activity&gt;

		<xsl:if test="$facebookLogin">
		&lt;!-- For Facebook login --&gt;
		&lt;meta-data
				android:name="com.facebook.sdk.ApplicationId"
				android:value="@string/facebook_app_id"/&gt;

		&lt;activity
				android:name="com.facebook.FacebookActivity"
				android:configChanges="keyboard|keyboardHidden|screenLayout|screenSize|orientation"
				android:label="@string/app_name"/&gt;
		&lt;activity
				android:name="com.facebook.CustomTabActivity"
				android:exported="true"&gt;
			&lt;intent-filter&gt;
				&lt;action android:name="android.intent.action.VIEW"/&gt;

				&lt;category android:name="android.intent.category.DEFAULT"/&gt;
				&lt;category android:name="android.intent.category.BROWSABLE"/&gt;

				&lt;data android:scheme="@string/fb_login_protocol_scheme"/&gt;
			&lt;/intent-filter&gt;
		&lt;/activity&gt;
		&lt;!-- end For Facebook login --&gt;
		</xsl:if>

		<xsl:if test="$backendlessLogin">
		&lt;activity android:name=".RestorePasswordActivity"&gt;
		&lt;/activity&gt;

		&lt;activity android:name=".RegisterActivity"&gt;
		&lt;/activity&gt;
		</xsl:if>

		&lt;activity android:name=".LoginResult"&gt;
		&lt;/activity&gt;
	&lt;/application&gt;

&lt;/manifest&gt;
</file>

    </xsl:template>
</xsl:stylesheet>