<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->
    <xsl:param name="backendlessLogin"/>
    <xsl:param name="facebookLogin"/>
    <xsl:param name="twitterLogin"/>
    <xsl:param name="googleLogin"/>

    <xsl:include href="../util.xsl"/>

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="packageAppName">
        <xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="projectName"><xsl:value-of select="$applicationName"/>-Login</xsl:variable>
    <xsl:variable name="subPackage" select="'login'"/>
    <xsl:variable name="package">com.examples.<xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>.<xsl:value-of select="$subPackage"/></xsl:variable>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/ANDROID"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>

    <xsl:variable name="emailConfirmationRequired" select="backendless-codegen/application/emailConfirmation"/>

    <xsl:include href="android-util.xsl"/>

    <xsl:include href="templates/login/login-manifest.xsl"/>
    <xsl:include href="templates/login/login-res.xsl"/>
    <xsl:include href="templates/login/login-sources.xsl"/>


    <xsl:template match="/">
        <folder name="{$projectName}">

            <folder name="src">
                <folder name="main">
                    <folder name="java">
                        <xsl:call-template name="login-sources"/>
                    </folder>
                    <xsl:call-template name="login-res"/>
                    <xsl:call-template name="login-manifest"/>
                </folder>
            </folder>

            <xsl:call-template name="build-gradle">
                <xsl:with-param name="facebookLogin" select="$facebookLogin"/>
                <xsl:with-param name="googleLogin" select="$googleLogin"/>
            </xsl:call-template>

            <xsl:if test="$googleLogin">
            <file name="google-services.json">
Please, use this documentation to create correct 'google-services.json' for your google application.
https://developers.google.com/identity/sign-in/android/start-integrating
            </file>
            </xsl:if>

        </folder>
    </xsl:template>
</xsl:stylesheet>