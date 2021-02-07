<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->
    <xsl:include href="../util.xsl"/>

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="packageAppName">
        <xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="projectName"><xsl:value-of select="$applicationName"/>-Publisher</xsl:variable>
    <xsl:variable name="subPackage" select="'media'"/>
    <xsl:variable name="package">com.examples.<xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>.<xsl:value-of select="$subPackage"/></xsl:variable>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/ANDROID"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>

    <xsl:include href="android-util.xsl"/>

    <xsl:include href="templates/publisher/publisher-res.xsl"/>
    <xsl:include href="templates/publisher/publisher-sources.xsl"/>
    <xsl:include href="templates/publisher/publisher-manifest.xsl"/>


    <xsl:template match="/">
        <folder name="{$projectName}">

            <folder name="src">
                <folder name="main">
                    <folder name="java">
                        <xsl:call-template name="publisher-sources"/>
                    </folder>
                    <xsl:call-template name="publisher-res"/>
                    <xsl:call-template name="publisher-manifest"/>
                </folder>
            </folder>

            <xsl:call-template name="build-gradle"/>

        </folder>
    </xsl:template>
</xsl:stylesheet>