<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="data-manifest">

<file name="AndroidManifest.xml">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="<xsl:value-of select="$package"/>"&gt;

&lt;/manifest&gt;</file>

    </xsl:template>

</xsl:stylesheet>