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
  ext.kotlin_version = '1.3.31'
  repositories {
    jcenter()
    google()
  }

  dependencies {
    classpath 'com.android.tools.build:gradle:3.4.1'
    classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
  <xsl:if test="$subPackage='login' and $googleLogin">
    classpath 'com.google.gms:google-services:3.1.1'
  </xsl:if>
    // NOTE: Do not place your application dependencies here;
    // they belong in the individual module build.gradle files;
  }
}

apply plugin: 'com.android.application'
apply plugin: 'kotlin-android-extensions'
apply plugin: 'kotlin-android'

repositories {
  jcenter()
  google()
}

android {
  compileSdkVersion 28
  buildToolsVersion "29.0.0"

  defaultConfig {
    applicationId "<xsl:value-of select="$package"/>"
    minSdkVersion 21
    targetSdkVersion 28
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
  implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
  implementation 'com.backendless:backendless:<xsl:value-of select="backendless-codegen/application/javaSDKVersion"/>'

  implementation ('io.socket:socket.io-client:1.0.0') {
  //      excluding org.json which is provided by Android
          exclude group: 'org.json', module: 'json'
  }

  <xsl:if test="$subPackage='login'">
  <xsl:if test="$facebookLogin">
  implementation 'com.facebook.android:facebook-android-sdk:4.27.0'
  </xsl:if>
  <xsl:if test="$googleLogin">
  implementation ('com.google.api-client:google-api-client:1.23.0'){
    exclude group: 'com.google.code.findbugs', module: 'jsr305'
  }
  implementation 'com.google.android.gms:play-services-auth:11.4.2'
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
const val APPLICATION_ID = "<xsl:value-of select="$applicationId"/>"
const val API_KEY = "<xsl:value-of select="$apiKey"/>"
const val SERVER_URL = "<xsl:value-of select="$serverURL"/>"
    </xsl:template>

</xsl:stylesheet>