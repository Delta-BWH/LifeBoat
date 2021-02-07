<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="crud-manifest">

<file name="AndroidManifest.xml">&lt;?xml version="1.0" encoding="utf-8"?&gt;

&lt;manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="<xsl:value-of select="$package"/>"&gt;


    &lt;uses-permission android:name="android.permission.INTERNET"/&gt;
    &lt;application
            android:label="@string/app_name"
            android:name=".common.DataApplication"&gt;
        &lt;activity android:name=".start.SelectTableActivity"&gt;
            &lt;intent-filter&gt;
                &lt;action android:name="android.intent.action.MAIN"/&gt;
                &lt;category android:name="android.intent.category.LAUNCHER"/&gt;
            &lt;/intent-filter&gt;
        &lt;/activity&gt;
        &lt;activity android:name=".start.SelectTableOperationActivity"/&gt;
        &lt;activity android:name=".create.CreateRecordActivity"/&gt;
        &lt;activity android:name=".create.CreateSuccessActivity"/&gt;
        &lt;activity android:name=".common.SendEmailActivity"/&gt;
        &lt;activity android:name=".retrieve.SelectRetrievalTypeActivity"/&gt;
        &lt;activity android:name=".delete.DeleteRecordActivity"/&gt;
        &lt;activity android:name=".delete.DeleteSuccessActivity"/&gt;
        &lt;activity android:name=".update.UpdateRecordActivity"/&gt;
        &lt;activity android:name=".update.UpdateSuccessActivity"/&gt;
        &lt;activity android:name=".retrieve.ShowByPropertyActivity"/&gt;
        &lt;activity android:name=".retrieve.RetrieveRecordActivity"/&gt;
        &lt;activity android:name=".retrieve.ShowEntityActivity"/&gt;

        &lt;service android:name="com.backendless.AndroidService"/&gt;
    &lt;/application&gt;
&lt;/manifest&gt;
</file>

    </xsl:template>

</xsl:stylesheet>