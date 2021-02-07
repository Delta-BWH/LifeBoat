<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="viewer-res">

<folder name="res">
                            <folder path="VideoServicePlayback/res/drawable"/>
                            <folder path="VideoServicePlayback/res/drawable-hdpi"/>
                            <folder path="VideoServicePlayback/res/drawable-ldpi"/>
                            <folder path="VideoServicePlayback/res/drawable-mdpi"/>
                            <folder path="VideoServicePlayback/res/drawable-xhdpi"/>
                            <folder path="VideoServicePlayback/res/drawable-xxhdpi"/>
                            <folder path="VideoServicePlayback/res/layout"/>
                            <folder path="VideoServicePlayback/res/values-sw600dp"/>
                            <folder path="VideoServicePlayback/res/values-sw720dp-land"/>
                            <folder path="VideoServicePlayback/res/values-v11"/>
                            <folder path="VideoServicePlayback/res/values-v14"/>
                            <folder name="values">
                                <file path="VideoServicePlayback/res/values/dimens.xml"/>
                                <file path="VideoServicePlayback/res/values/styles.xml"/>
                                <file name="strings.xml">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;resources&gt;

    &lt;string name="app_name"&gt;<xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>-Viewer&lt;/string&gt;
    &lt;string name="start"&gt;Start/Stop Streaming&lt;/string&gt;
    &lt;string name="flash"&gt;Flash&lt;/string&gt;
    &lt;string name="camera"&gt;Camera&lt;/string&gt;
    &lt;string name="video"&gt;Video Settings&lt;/string&gt;
    &lt;string name="save"&gt;OK&lt;/string&gt;
    &lt;string name="password_hint"&gt;Leave empty if not needed&lt;/string&gt;
    &lt;string name="username_hint"&gt;Leave empty if not needed&lt;/string&gt;
    &lt;string name="default_bitrate"&gt;0 kbps&lt;/string&gt;
    &lt;string name="broadcast"&gt;Broadcast&lt;/string&gt;

&lt;/resources&gt;
</file>
                            </folder>
                        </folder>

    </xsl:template>

</xsl:stylesheet>