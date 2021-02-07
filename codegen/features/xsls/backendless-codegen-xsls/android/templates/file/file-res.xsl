<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

        <xsl:template name="file-res">
                            <folder name="res">
                            <folder path="fileservice/res/layout-nodpi"/>
                            <folder name="values">
                                <file path="fileservice/res/values/dimens.xml"/>
                                <!--file path="fileservice/res/values/string_arrays.xml"/-->
                                <file name="strings.xml">&lt;?xml version="1.0" encoding="utf-8"?&gt;

&lt;resources&gt;
    &lt;string name="app_name"&gt;<xsl:value-of select="$projectName"/>&lt;/string&gt;
&lt;string name="service_name"&gt;Backendless Files&lt;/string&gt;
&lt;string name="welcome_text"&gt;This example demonstrates file (image) upload and sharing.&lt;/string&gt;
&lt;string name="uploaded_text"&gt;The image has been uploaded. The file is available at the following URL:&lt;/string&gt;
&lt;string name="takeNewPhoto"&gt;Take a photo&lt;/string&gt;
&lt;string name="takeAnotherPhoto"&gt;Take another photo&lt;/string&gt;
&lt;/resources&gt;
                                </file>
                            </folder>
                        </folder>

        </xsl:template>

</xsl:stylesheet>