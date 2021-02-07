<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="file-manifest">

<file name="AndroidManifest.xml">&lt;?xml version="1.0" encoding="utf-8"?&gt;

&lt;manifest xmlns:android="http://schemas.android.com/apk/res/android"
package="<xsl:value-of select="$package"/>"&gt;

&lt;uses-permission android:name="android.permission.INTERNET"/&gt;
&lt;uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" /&gt;
&lt;uses-feature android:name="android.hardware.camera"/&gt;

&lt;application android:label="@string/app_name"&gt;
&lt;activity android:name=".MainActivity"
android:label="@string/app_name"&gt;
&lt;intent-filter&gt;
&lt;action android:name="android.intent.action.MAIN"/&gt;
&lt;category android:name="android.intent.category.LAUNCHER"/&gt;
&lt;/intent-filter&gt;
&lt;/activity&gt;
&lt;activity android:name=".UploadingActivity" android:screenOrientation="portrait"/&gt;
&lt;activity android:name=".BrowseActivity"/&gt;

&lt;service android:name="com.backendless.AndroidService"/&gt;
&lt;/application&gt;
&lt;/manifest&gt;
</file>

    </xsl:template>

</xsl:stylesheet>