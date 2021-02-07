<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->
    <xsl:include href="../util.xsl"/>

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="packageAppName">
        <xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="projectName"><xsl:value-of select="$applicationName"/>-PushNotifications</xsl:variable>
    <xsl:variable name="package">com.mbaas.examples</xsl:variable>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/ANDROID"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>

    <xsl:include href="templates/push/build-gradle.xsl"/>

    <xsl:template match="/">
        <folder name="{$projectName}">
            <folder name="src">
                <folder name="main">
                    <folder name="java">
                        <folder name="com">
                            <folder name="mbaas">
                                <folder name="examples">
                                    <file name="Defaults.java">package <xsl:value-of select="$package"/>;

                                        public class Defaults
                                        {
                                        <xsl:call-template name="common-defaults"/>
                                        }
                                    </file>
                                    <file path="templates/push/MainActivity.java"/>
                                </folder>
                            </folder>
                        </folder>
                    </folder>
                    <folder name="res">
                        <folder name="layout">
                            <file path="templates/push/activity_main.xml" />
                        </folder>
                    </folder>
                    <file path="templates/push/AndroidManifest.xml" />
                </folder>
            </folder>
            <xsl:call-template name="build-gradle-for-push"/>
        </folder>
    </xsl:template>
</xsl:stylesheet>

