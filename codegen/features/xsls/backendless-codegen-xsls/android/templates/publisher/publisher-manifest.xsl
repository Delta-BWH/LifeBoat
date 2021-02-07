<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="publisher-manifest">

<file name="AndroidManifest.xml">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="<xsl:value-of select="$package"/>"
    android:versionCode="1"
    android:versionName="1.0" &gt;

    &lt;uses-sdk
        android:minSdkVersion="14"
        android:targetSdkVersion="22" /&gt;

    &lt;uses-feature
        android:name="android.hardware.camera"
        android:required="true" /&gt;
    &lt;uses-feature
        android:name="android.hardware.camera.autofocus"
        android:required="false" /&gt;

    &lt;uses-permission android:name="android.permission.INTERNET" /&gt;
    &lt;uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" /&gt;
    &lt;uses-permission android:name="android.permission.RECORD_AUDIO" /&gt;
    &lt;uses-permission android:name="android.permission.CAMERA" /&gt;
    &lt;uses-permission android:name="android.permission.WAKE_LOCK" /&gt;

    &lt;application
        android:allowBackup="true"
        android:icon="@drawable/ic_launcher"
        android:label="@string/app_name"
        android:largeHeap="true" &gt;
        &lt;activity
            android:name="<xsl:value-of select="$package"/>.PublisherActivity"
            android:label="@string/app_name"
            android:screenOrientation="landscape"
            android:theme="@android:style/Theme.DeviceDefault.Wallpaper.NoTitleBar"
            android:windowSoftInputMode="stateHidden" &gt;
            &lt;intent-filter&gt;
                &lt;action android:name="android.intent.action.MAIN" /&gt;

                &lt;category android:name="android.intent.category.LAUNCHER" /&gt;
            &lt;/intent-filter&gt;
        &lt;/activity&gt;

        &lt;service android:name="com.backendless.AndroidService" /&gt;
    &lt;/application&gt;

&lt;/manifest&gt;
</file>

    </xsl:template>

</xsl:stylesheet>