<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->
    <xsl:include href="../util.xsl"/>

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="packageAppName">
        <xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="projectName"><xsl:value-of select="$applicationName"/>-Messaging</xsl:variable>
    <xsl:variable name="subPackage" select="'messaging'"/>
    <xsl:variable name="package">com.examples.<xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>.<xsl:value-of select="$subPackage"/></xsl:variable>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/ANDROID"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>

    <xsl:include href="android-util.xsl"/>

    <xsl:include href="templates/messaging/messaging-res.xsl"/>
    <xsl:include href="templates/messaging/messaging-sources.xsl"/>
    <xsl:include href="templates/messaging/messaging-manifest.xsl"/>

    <xsl:include href="templates/messaging/AcceptChatActivity.xsl"/>
    <xsl:include href="templates/messaging/ChatActivity.xsl"/>
    <xsl:include href="templates/messaging/ChatUser.xsl"/>
    <xsl:include href="templates/messaging/ChooseNicknameActivity.xsl"/>
    <xsl:include href="templates/messaging/DefaultCallback.xsl"/>
    <xsl:include href="templates/messaging/SelectUserActivity.xsl"/>


    <xsl:template match="/">
        <folder name="{$projectName}">

            <folder name="src">
                <folder name="main">
                    <folder name="java">
                        <xsl:call-template name="messaging-sources"/>
                    </folder>
                    <xsl:call-template name="messaging-res"/>
                    <xsl:call-template name="messaging-manifest"/>
                </folder>
            </folder>

            <xsl:call-template name="build-gradle"/>

        </folder>
    </xsl:template>
</xsl:stylesheet>