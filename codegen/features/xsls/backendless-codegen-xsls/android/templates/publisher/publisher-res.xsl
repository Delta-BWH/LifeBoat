<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="publisher-res">

<folder name="res">
                            <folder path="VideoServicePublisher/res/drawable"/>
                            <folder path="VideoServicePublisher/res/drawable-hdpi"/>
                            <folder path="VideoServicePublisher/res/drawable-ldpi"/>
                            <folder path="VideoServicePublisher/res/drawable-mdpi"/>
                            <folder path="VideoServicePublisher/res/drawable-xhdpi"/>
                            <folder path="VideoServicePublisher/res/drawable-xxhdpi"/>
                            <folder path="VideoServicePublisher/res/layout"/>
                            <folder path="VideoServicePublisher/res/values-sw600dp"/>
                            <folder path="VideoServicePublisher/res/values-sw720dp-land"/>
                            <folder path="VideoServicePublisher/res/values-v11"/>
                            <folder path="VideoServicePublisher/res/values-v14"/>
                            <folder name="values">
                                <file path="VideoServicePublisher/res/values/dimens.xml"/>
                                <file path="VideoServicePublisher/res/values/styles.xml"/>
                                <file name="strings.xml">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;resources&gt;

    &lt;string name="app_name"&gt;<xsl:value-of select="$applicationName"/>-Publisher&lt;/string&gt;
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