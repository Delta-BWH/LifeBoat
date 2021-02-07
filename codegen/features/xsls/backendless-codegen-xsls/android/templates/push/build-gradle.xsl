<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="build-gradle-for-push">

        <folder path="templates/push/gradlewrapper/gradle"/>
        <file path="templates/push/gradlewrapper/gradlew"/>
        <file path="templates/push/gradlewrapper/gradlew.bat"/>
        <file path="templates/push/gradlewrapper/gradle.properties"/>

        <file path="templates/push/build.gradle">

        </file>

        <file name="local.properties">
            # Location of the SDK. This is only used by Gradle.
            # Uncomment and set where is Android-SDK located on your computer
            #sdk.dir=/path/to/Android-SDK
        </file>

    </xsl:template>

    <xsl:template name="common-defaults">
        public static final String APPLICATION_ID = "<xsl:value-of select="$applicationId"/>";
        public static final String API_KEY = "<xsl:value-of select="$apiKey"/>";
        public static final String SERVER_URL = "<xsl:value-of select="$serverURL"/>";
    </xsl:template>

</xsl:stylesheet>
