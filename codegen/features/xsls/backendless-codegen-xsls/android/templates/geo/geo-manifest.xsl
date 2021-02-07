<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="geo-manifest">

<file name="AndroidManifest.xml">&lt;?xml version="1.0" encoding="utf-8"?&gt;

&lt;manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="<xsl:value-of select="$package"/>"&gt;

    &lt;uses-sdk
        android:minSdkVersion="16"
        android:targetSdkVersion="16" /&gt;

    &lt;uses-feature
        android:glEsVersion="0x00020000"
        android:required="true" /&gt;

    &lt;uses-permission android:name="android.permission.INTERNET" /&gt;
    &lt;uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" /&gt;
    &lt;uses-permission android:name="com.google.android.providers.gsf.permission.READ_GSERVICES" /&gt;
    &lt;uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" /&gt;
    &lt;uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" /&gt;
    &lt;uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" /&gt;

    &lt;permission
        android:name="<xsl:value-of select="$package"/>.permission.MAPS_RECEIVE"
        android:protectionLevel="signature" /&gt;

    &lt;uses-permission
        android:name="<xsl:value-of select="$package"/>.permission.MAPS_RECEIVE"
        android:required="false" /&gt;

    &lt;application android:label="@string/app_name"&gt;
        &lt;meta-data
            android:name="com.google.android.gms.version"
            android:value="@integer/google_play_services_version" /&gt;

        &lt;activity android:name=".GeoCategoriesListActivity"&gt;
            &lt;intent-filter&gt;
                &lt;action android:name="android.intent.action.MAIN" /&gt;
                &lt;category android:name="android.intent.category.LAUNCHER" /&gt;
            &lt;/intent-filter&gt;
        &lt;/activity&gt;

        &lt;activity android:name=".MapShowActivity" /&gt;
        &lt;activity android:name=".QueryEditActivity" /&gt;
        &lt;activity android:name=".ShowGeoPointsTextActivity" /&gt;
        &lt;activity android:name=".FilterActivity" /&gt;

        &lt;service android:name="com.backendless.AndroidService" /&gt;

        &lt;meta-data
            android:name="com.google.android.geo.API_KEY"
            android:value="AIzaSyBLQ0pOj2wJMhvwtzFohMpiRUNJpvCNi1U" /&gt;
    &lt;/application&gt;
&lt;/manifest&gt;
                        </file>

    </xsl:template>

</xsl:stylesheet>