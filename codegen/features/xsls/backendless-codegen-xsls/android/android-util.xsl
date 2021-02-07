<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="build-gradle">

<xsl:param name="googleLogin" select="false()"/>
<xsl:param name="facebookLogin" select="false()"/>

<folder path="./gradlewrapper/gradle"/>
<file path="./gradlewrapper/gradlew"/>
<file path="./gradlewrapper/gradlew.bat"/>
<file path="./gradlewrapper/gradle.properties"/>

<file name="build.gradle">
buildscript {
  repositories {
    mavenLocal()
    mavenCentral()
    jcenter()
    google()
  }

  dependencies {
    classpath "com.android.tools.build:gradle:4.0.1"
  <xsl:if test="$subPackage='login' and $googleLogin">
    classpath 'com.google.gms:google-services:4.3.3'
  </xsl:if>
    // NOTE: Do not place your application dependencies here;
    // they belong in the individual module build.gradle files;
  }
}

apply plugin: 'com.android.application'

repositories {
  mavenLocal()
  mavenCentral()
  jcenter()
  google()
}

android {
  compileSdkVersion 29
  buildToolsVersion "30.0.1"

  defaultConfig {
    applicationId "<xsl:value-of select="$package"/>"
    minSdkVersion 21
    targetSdkVersion 29
    versionCode 1
    versionName "1.0"
  }

  buildTypes {
    release {
      minifyEnabled false
    }
  }

  lintOptions {
    disable 'InvalidPackage', 'RtlCompat'
    abortOnError false
  }

  defaultConfig {
    multiDexEnabled true
   }

  dexOptions {
    javaMaxHeapSize "3g" //specify the heap size for the dex process
  }
}

dependencies {
  implementation fileTree( include: ['*.jar'], dir: 'libs' )
  implementation group: 'com.backendless', name: 'backendless', version: '<xsl:value-of select="backendless-codegen/application/javaSDKVersion"/>'
  implementation ( group: 'io.socket', name: 'socket.io-client', version: '1.0.0' ) {
  //      excluding org.json which is provided by Android
          exclude group: 'org.json', module: 'json'
  }

  implementation 'androidx.appcompat:appcompat:1.2.0'
  implementation 'androidx.core:core:1.3.1'
  implementation 'androidx.fragment:fragment:1.2.5'

  <xsl:if test="$subPackage='template'">
  implementation ('io.socket:socket.io-client:1.0.0') {
//       excluding org.json which is provided by Android
      exclude group: 'org.json', module: 'json'
  }
  </xsl:if>
  <xsl:if test="$subPackage='login'">
  <xsl:if test="$facebookLogin">
  implementation 'com.facebook.android:facebook-android-sdk:4.27.0'
  </xsl:if>
  <xsl:if test="$googleLogin">
  implementation ('com.google.api-client:google-api-client:1.23.0'){
    exclude group: 'com.google.code.findbugs', module: 'jsr305'
  }
  implementation 'com.google.android.gms:play-services-auth:18.1.0'
  </xsl:if>
  </xsl:if>

  <xsl:if test="$subPackage='geo'">
  implementation 'com.google.android.gms:play-services-maps:11.4.2'
  implementation 'com.google.android.gms:play-services-location:11.4.2'
  </xsl:if>
}
<xsl:if test="$subPackage='login' and $googleLogin">
apply plugin: 'com.google.gms.google-services'
</xsl:if>
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
