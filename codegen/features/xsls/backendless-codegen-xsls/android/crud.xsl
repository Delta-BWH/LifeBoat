<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->
    <xsl:include href="../util.xsl"/>

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="packageAppName">
        <xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="projectName"><xsl:value-of select="$applicationName"/>-CRUD</xsl:variable>
    <xsl:variable name="subPackage" select="'data.crud'"/>
    <xsl:variable name="classesSubPackage" select="'data'"/>
    <xsl:variable name="classesPackage">com.examples.<xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>.<xsl:value-of select="$classesSubPackage"/></xsl:variable>
    <xsl:variable name="package">com.examples.<xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>.<xsl:value-of select="$subPackage"/></xsl:variable>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/ANDROID"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>

    <xsl:variable name="tables" select="backendless-codegen/application/tables"/>
    <xsl:variable name="views" select="backendless-codegen/application/views"/>
    <xsl:variable name="procedures" select="backendless-codegen/application/procedures"/>

    <xsl:include href="android-util.xsl"/>

    <xsl:include href="templates/crud/crud-res.xsl"/>
    <xsl:include href="templates/crud/crud-sources.xsl"/>
    <xsl:include href="templates/crud/crud-manifest.xsl"/>
    <xsl:include href="templates/data/data-sources.xsl"/>


    <xsl:template match="/">
        <folder name="{$projectName}">

            <folder name="src">
                <folder name="main">
                    <folder name="java">
                        <xsl:call-template name="crud-sources"/>

                        <xsl:call-template name="data-sources">
                            <xsl:with-param name="subPackage" select="'data'"/>
                            <xsl:with-param name="package">com.examples.<xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>.<xsl:value-of select="'data'"/></xsl:with-param>
                        </xsl:call-template>
                    </folder>
                    <xsl:call-template name="crud-res"/>
                    <xsl:call-template name="crud-manifest"/>
                </folder>
            </folder>

            <xsl:call-template name="build-gradle"/>

        </folder>
    </xsl:template>
</xsl:stylesheet>