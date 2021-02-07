<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="messaging-manifest">
<file name="AndroidManifest.xml">&lt;?xml version="1.0" encoding="utf-8"?&gt;

&lt;manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="<xsl:value-of select="$package"/>"
    android:versionCode="1"
    android:versionName="1.0"&gt;

    &lt;uses-sdk
        android:minSdkVersion="16"
        android:targetSdkVersion="16" /&gt;

    &lt;uses-permission android:name="android.permission.INTERNET" /&gt;
    &lt;uses-permission android:name="android.permission.GET_ACCOUNTS" /&gt;
    &lt;uses-permission android:name="android.permission.WAKE_LOCK" /&gt;
    &lt;uses-permission android:name="com.google.android.c2dm.permission.RECEIVE" /&gt;
    &lt;uses-permission android:name="<xsl:value-of select="$package"/>.permission.C2D_MESSAGE" /&gt;

    &lt;permission
        android:name="<xsl:value-of select="$package"/>.permission.C2D_MESSAGE"
        android:protectionLevel="signature" /&gt;

    &lt;application android:label="@string/app_name"&gt;
        &lt;activity
            android:name=".ChooseNicknameActivity"
            android:label="@string/app_name"
            android:screenOrientation="portrait"&gt;
            &lt;intent-filter&gt;
                &lt;action android:name="android.intent.action.MAIN" /&gt;
                &lt;category android:name="android.intent.category.LAUNCHER" /&gt;
            &lt;/intent-filter&gt;
        &lt;/activity&gt;

    &lt;receiver
        android:name=".PushReceiver"
        android:permission="com.google.android.c2dm.permission.SEND"&gt;
        &lt;intent-filter&gt;
            &lt;action android:name="com.google.android.c2dm.intent.RECEIVE" /&gt;
            &lt;action android:name="com.google.android.c2dm.intent.REGISTRATION" /&gt;

            &lt;category android:name="<xsl:value-of select="$package"/>" /&gt;
        &lt;/intent-filter&gt;
    &lt;/receiver&gt;

    &lt;activity android:name=".AcceptChatActivity" android:screenOrientation="portrait"/&gt;
    &lt;activity android:name=".ChatActivity" android:screenOrientation="portrait"/&gt;
    &lt;activity android:name=".SelectUserActivity" android:screenOrientation="portrait"/&gt;

    &lt;service android:name=".PushService" /&gt;
    &lt;/application&gt;
&lt;/manifest&gt;
</file>
    </xsl:template>

</xsl:stylesheet>