<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!--  @formatter:off  -->
	<xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
	<xsl:variable name="projectName">
	<xsl:value-of select="$applicationName"/>
	</xsl:variable>
	<xsl:variable name="subPackage" select="'messaging'"/>
	<xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
	<xsl:variable name="apiKeyIos" select="backendless-codegen/application/apiKeys/IOS"/>
	<xsl:variable name="apiKeyAndroid" select="backendless-codegen/application/apiKeys/ANDROID"/>
	<xsl:variable name="apiKeyJs" select="backendless-codegen/application/apiKeys/JS"/>
	<xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>
	<xsl:template match="/">
		<folder name="{$projectName}">
			<file name=".gitignore"># Miscellaneous
*.class
*.log
*.pyc
*.swp
.DS_Store
.atom/
.buildlog/
.history
.svn/

# IntelliJ related
*.iml
*.ipr
*.iws
.idea/

# The .vscode folder contains launch configuration and tasks you configure in
# VS Code which you may wish to be included in version control, so this line
# is commented out by default.
#.vscode/

# Flutter/Dart/Pub related
**/doc/api/
.dart_tool/
.flutter-plugins
.packages
.pub-cache/
.pub/
/build/

# Android related
**/android/**/gradle-wrapper.jar
**/android/.gradle
**/android/captures/
**/android/gradlew
**/android/gradlew.bat
**/android/local.properties
**/android/**/GeneratedPluginRegistrant.java

# iOS/XCode related
**/ios/**/*.mode1v3
**/ios/**/*.mode2v3
**/ios/**/*.moved-aside
**/ios/**/*.pbxuser
**/ios/**/*.perspectivev3
**/ios/**/*sync/
**/ios/**/.sconsign.dblite
**/ios/**/.tags*
**/ios/**/.vagrant/
**/ios/**/DerivedData/
**/ios/**/Icon?
**/ios/**/Pods/
**/ios/**/.symlinks/
**/ios/**/profile
**/ios/**/xcuserdata
**/ios/.generated/
**/ios/Flutter/App.framework
**/ios/Flutter/Flutter.framework
**/ios/Flutter/Generated.xcconfig
**/ios/Flutter/app.flx
**/ios/Flutter/app.zip
**/ios/Flutter/flutter_assets/
**/ios/ServiceDefinitions.json
**/ios/Runner/GeneratedPluginRegistrant.*

# Exceptions to above rules.
!**/ios/**/default.mode1v3
!**/ios/**/default.mode2v3
!**/ios/**/default.pbxuser
!**/ios/**/default.perspectivev3
!/packages/flutter_tools/test/data/dart_dependencies_test/**/.packages
</file>
			<folder name =".idea">
				<folder name="runConfigurations">
					<file name="main_dart.xml"><![CDATA[<component name="ProjectRunConfigurationManager">
  <configuration default="false" name="main.dart" type="FlutterRunConfigurationType" factoryName="Flutter">
    <option name="filePath" value="$PROJECT_DIR$/lib/main.dart" />
    <method />
  </configuration>
</component>]]>
					</file>
				</folder>
				<file name="modules.xml">&lt;?xml version="1.0" encoding="UTF-8"?>
&lt;project version="4"&gt;
  &lt;component name="ProjectModuleManager"&gt;
    &lt;modules&gt;
      &lt;module fileurl="file://$PROJECT_DIR$/<xsl:value-of select="$projectName"/>.iml" filepath="$PROJECT_DIR$/<xsl:value-of select="$projectName"/>" /&gt;
      &lt;module fileurl="file://$PROJECT_DIR$/android/<xsl:value-of select="$projectName"/>_android.iml" filepath="$PROJECT_DIR$/android/<xsl:value-of select="$projectName"/>_android.iml" /&gt;
    &lt;/modules&gt;
  &lt;/component&gt;
&lt;/project&gt;
				</file>
				<file path="Project/idea/workspace.xml"/>
			</folder>
			<folder name="web">
				<file path="Project/web/favicon.png"/>
				<file path="Project/web/index.html"/>
				<file path="Project/web/manifest.json"/>
				<folder name="icons">
					<file path="Project/web/icons/Icon-192.png"/>
					<file path="Project/web/icons/Icon-512.png"/>
				</folder>
			</folder>
			<folder name="android">
				<folder name="app">
					<file name="build.gradle">def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
}

def flutterRoot = localProperties.getProperty('flutter.sdk')
if (flutterRoot == null) {
    throw new GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}

def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
if (flutterVersionCode == null) {
    flutterVersionCode = '1'
}

def flutterVersionName = localProperties.getProperty('flutter.versionName')
if (flutterVersionName == null) {
    flutterVersionName = '1.0'
}

apply plugin: 'com.android.application'
apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"

android {
    compileSdkVersion 28

    lintOptions {
        disable 'InvalidPackage'
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "com.example.<xsl:value-of select="$projectName"/>"
        minSdkVersion 16
        targetSdkVersion 28
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
        testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig signingConfigs.debug
        }
    }
}

flutter {
    source '../..'
}

dependencies {
    testImplementation 'junit:junit:4.12'
    androidTestImplementation 'com.android.support.test:runner:1.0.2'
    androidTestImplementation 'com.android.support.test.espresso:espresso-core:3.0.2'
    implementation ('io.socket:socket.io-client:1.0.0') {
    //  excluding org.json which is provided by Android
        exclude group: 'org.json', module: 'json'
    }
}
					</file>
					<folder name="src">
						<folder name="debug">
							<file name="AndroidManifest.xml">&lt;manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.<xsl:value-of select="$projectName"/>"&gt;
    &lt;uses-permission android:name="android.permission.INTERNET"/&gt;
&lt;/manifest&gt;
							</file>
						</folder>
						<folder name="main">
							<file name="AndroidManifest.xml">&lt;manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.<xsl:value-of select="$projectName"/>"&gt;

    &lt;application

        android:label="<xsl:value-of select="$projectName"/>"
        android:icon="@mipmap/ic_launcher"&gt;
        &lt;activity
            android:name=".MainActivity"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize"&gt;


            &lt;intent-filter&gt;
                &lt;action android:name="android.intent.action.MAIN"/&gt;
                &lt;category android:name="android.intent.category.LAUNCHER"/&gt;
            &lt;/intent-filter&gt;
        &lt;/activity&gt;
								&lt;meta-data
								android:name="flutterEmbedding"
								android:value="2" /&gt;
    &lt;/application&gt;
&lt;/manifest&gt;
							</file>
							<folder name="java">
								<folder name ="com">
									<folder name ="example">
										<folder name ="{$projectName}">
											<file name="MainActivity.java">package com.example.<xsl:value-of select="$projectName"/>;
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {

}
											</file>
										</folder>
									</folder>
								</folder>
								<folder name ="io">
									<folder name ="flutter">
										<folder name ="plugins">
											<file path="Project/android/GeneratedPluginRegistrant.java"/>
										</folder>
									</folder>
								</folder>
							</folder>
							<folder name="res">
								<folder name="drawable">
									<file path="Project/android/launch_background.xml"/>
								</folder>
								<folder name="mipmap-hdpi">
									<file path="Project/android/logo/mipmap-hdpi/ic_launcher.png"/>
								</folder>
								<folder name="mipmap-mdpi">
									<file path="Project/android/logo/mipmap-mdpi/ic_launcher.png"/>
								</folder>
								<folder name="mipmap-xhdpi">
									<file path="Project/android/logo/mipmap-xhdpi/ic_launcher.png"/>
								</folder>
								<folder name="mipmap-xxhdpi">
									<file path="Project/android/logo/mipmap-xxhdpi/ic_launcher.png"/>
								</folder>
								<folder name="mipmap-xxxhdpi">
									<file path="Project/android/logo/mipmap-xxxhdpi/ic_launcher.png"/>
								</folder>
								<folder name="values">
									<file path="Project/android/logo/styles.xml"/>
								</folder>
							</folder>
						</folder>
						<folder name="profile">
							<file name="AndroidManifest.xml">&lt;manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.<xsl:value-of select="$projectName"/>"&gt;
    
    &lt;uses-permission android:name="android.permission.INTERNET"/&gt;
&lt;/manifest&gt;
							</file>
						</folder>
					</folder>
				</folder>
				<folder name="gradle">
					<folder name="wrapper">
						<file path="Project/android/gradle/gradle-wrapper.jar"/>
						<file path="Project/android/gradle/gradle-wrapper.properties"/>
					</folder>
				</folder>
				<file path="Project/android/gradle/build.gradle"/>
				<file path="Project/android/gradle/gradle.properties"/>
				<file path="Project/android/gradle/gradlew"/>
				<file path="Project/android/gradle/gradlew.bat"/>
				<file path="Project/android/gradle/settings.gradle"/>
				<file name="{$projectName}_android.iml"><![CDATA[<?xml version="1.0" encoding="UTF-8"?>
<module type="JAVA_MODULE" version="4">
  <component name="FacetManager">
    <facet type="android" name="Android">
      <configuration>
        <option name="ALLOW_USER_CONFIGURATION" value="false" />
        <option name="GEN_FOLDER_RELATIVE_PATH_APT" value="/gen" />
        <option name="GEN_FOLDER_RELATIVE_PATH_AIDL" value="/gen" />
        <option name="MANIFEST_FILE_RELATIVE_PATH" value="/app/src/main/AndroidManifest.xml" />
        <option name="RES_FOLDER_RELATIVE_PATH" value="/app/src/main/res" />
        <option name="ASSETS_FOLDER_RELATIVE_PATH" value="/app/src/main/assets" />
        <option name="LIBS_FOLDER_RELATIVE_PATH" value="/app/src/main/libs" />
        <option name="PROGUARD_LOGS_FOLDER_RELATIVE_PATH" value="/app/src/main/proguard_logs" />
      </configuration>
    </facet>
  </component>
  <component name="NewModuleRootManager" inherit-compiler-output="true">
    <exclude-output />
    <content url="file://$MODULE_DIR$">
      <sourceFolder url="file://$MODULE_DIR$/app/src/main/java" isTestSource="false" />
      <sourceFolder url="file://$MODULE_DIR$/gen" isTestSource="false" generated="true" />
    </content>
    <orderEntry type="jdk" jdkName="Android API 25 Platform" jdkType="Android SDK" />
    <orderEntry type="sourceFolder" forTests="false" />
    <orderEntry type="library" name="Flutter for Android" level="project" />
  </component>
</module>]]>		
				</file>
			</folder>
			<folder name="ios">
				<folder name="Flutter">
					<file path="Project/ios/Flutter/AppFrameworkInfo.plist"/>
					<file path="Project/ios/Flutter/Debug.xcconfig"/>
					<file path="Project/ios/Flutter/Release.xcconfig"/>
				</folder>
				<folder name="Runner">
					<file path="Project/ios/AppDelegate.swift"/>
					<folder path="Project/ios/Assets.xcassets"/>
					<folder path="Project/ios/Base.lproj"/>
					<file path="Project/ios/GeneratedPluginRegistrant.h"/>
					<file path="Project/ios/GeneratedPluginRegistrant.m"/>
					<file name="Info.plist">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"&gt;
&lt;plist version="1.0"&gt;
&lt;dict&gt;
	&lt;key&gt;CFBundleDevelopmentRegion&lt;/key&gt;
	&lt;string&gt;$(DEVELOPMENT_LANGUAGE)&lt;/string&gt;
	&lt;key&gt;CFBundleExecutable&lt;/key&gt;
	&lt;string&gt;$(EXECUTABLE_NAME)&lt;/string&gt;
	&lt;key&gt;CFBundleIdentifier&lt;/key&gt;
	&lt;string&gt;$(PRODUCT_BUNDLE_IDENTIFIER)&lt;/string&gt;
	&lt;key&gt;CFBundleInfoDictionaryVersion&lt;/key&gt;
	&lt;string&gt;6.0&lt;/string&gt;
	&lt;key&gt;CFBundleName&lt;/key&gt;
	&lt;string&gt;<xsl:value-of select="$projectName"/>&lt;/string&gt;
	&lt;key&gt;CFBundlePackageType&lt;/key&gt;
	&lt;string&gt;APPL&lt;/string&gt;
	&lt;key&gt;CFBundleShortVersionString&lt;/key&gt;
	&lt;string&gt;$(FLUTTER_BUILD_NAME)&lt;/string&gt;
	&lt;key&gt;CFBundleSignature&lt;/key&gt;
	&lt;string&gt;????&lt;/string&gt;
	&lt;key&gt;CFBundleVersion&lt;/key&gt;
	&lt;string&gt;$(FLUTTER_BUILD_NUMBER)&lt;/string&gt;
	&lt;key&gt;LSRequiresIPhoneOS&lt;/key&gt;
	&lt;true/&gt;
	&lt;key&gt;UILaunchStoryboardName&lt;/key&gt;
	&lt;string&gt;LaunchScreen&lt;/string&gt;
	&lt;key&gt;UIMainStoryboardFile&lt;/key&gt;
	&lt;string&gt;Main&lt;/string&gt;
	&lt;key&gt;UISupportedInterfaceOrientations&lt;/key&gt;
	&lt;array&gt;
		&lt;string&gt;UIInterfaceOrientationPortrait&lt;/string&gt;
		&lt;string&gt;UIInterfaceOrientationLandscapeLeft&lt;/string&gt;
		&lt;string&gt;UIInterfaceOrientationLandscapeRight&lt;/string&gt;
	&lt;/array&gt;
	&lt;key&gt;UISupportedInterfaceOrientations~ipad&lt;/key&gt;
	&lt;array&gt;
		&lt;string&gt;UIInterfaceOrientationPortrait&lt;/string&gt;
		&lt;string&gt;UIInterfaceOrientationPortraitUpsideDown&lt;/string&gt;
		&lt;string&gt;UIInterfaceOrientationLandscapeLeft&lt;/string&gt;
		&lt;string&gt;UIInterfaceOrientationLandscapeRight&lt;/string&gt;
	&lt;/array&gt;
	&lt;key&gt;UIViewControllerBasedStatusBarAppearance&lt;/key&gt;
	&lt;false/&gt;
&lt;/dict&gt;
&lt;/plist&gt;
					</file>
					<file path="Project/ios/Runner-Bridging-Header.h"/>
				</folder>
				<folder name="Runner.xcodeproj">
					<file name="project.pbxproj">// !$*UTF8*$!
						{
						archiveVersion = 1;
						classes = {
						};
						objectVersion = 46;
						objects = {

						/* Begin PBXBuildFile section */
						1498D2341E8E89220040F4C2 /* GeneratedPluginRegistrant.m in Sources */ = {isa = PBXBuildFile; fileRef = 1498D2331E8E89220040F4C2 /* GeneratedPluginRegistrant.m */; };
						3B3967161E833CAA004F5970 /* AppFrameworkInfo.plist in Resources */ = {isa = PBXBuildFile; fileRef = 3B3967151E833CAA004F5970 /* AppFrameworkInfo.plist */; };
						74858FAF1ED2DC5600515810 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 74858FAE1ED2DC5600515810 /* AppDelegate.swift */; };
						97C146FC1CF9000F007C117D /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 97C146FA1CF9000F007C117D /* Main.storyboard */; };
						97C146FE1CF9000F007C117D /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 97C146FD1CF9000F007C117D /* Assets.xcassets */; };
						97C147011CF9000F007C117D /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 97C146FF1CF9000F007C117D /* LaunchScreen.storyboard */; };
						/* End PBXBuildFile section */

						/* Begin PBXCopyFilesBuildPhase section */
						9705A1C41CF9048500538489 /* Embed Frameworks */ = {
						isa = PBXCopyFilesBuildPhase;
						buildActionMask = 2147483647;
						dstPath = "";
						dstSubfolderSpec = 10;
						files = (
						);
						name = "Embed Frameworks";
						runOnlyForDeploymentPostprocessing = 0;
						};
						/* End PBXCopyFilesBuildPhase section */

						/* Begin PBXFileReference section */
						1498D2321E8E86230040F4C2 /* GeneratedPluginRegistrant.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = GeneratedPluginRegistrant.h; sourceTree = "&lt;group&gt;"; };
						1498D2331E8E89220040F4C2 /* GeneratedPluginRegistrant.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; path = GeneratedPluginRegistrant.m; sourceTree = "&lt;group&gt;"; };
						3B3967151E833CAA004F5970 /* AppFrameworkInfo.plist */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = text.plist.xml; name = AppFrameworkInfo.plist; path = Flutter/AppFrameworkInfo.plist; sourceTree = "&lt;group&gt;"; };
						3B80C3931E831B6300D905FE /* App.framework */ = {isa = PBXFileReference; lastKnownFileType = wrapper.framework; name = App.framework; path = Flutter/App.framework; sourceTree = "&lt;group&gt;"; };
						74858FAD1ED2DC5600515810 /* Runner-Bridging-Header.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = "Runner-Bridging-Header.h"; sourceTree = "&lt;group&gt;"; };
						74858FAE1ED2DC5600515810 /* AppDelegate.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "&lt;group&gt;"; };
						7AFA3C8E1D35360C0083082E /* Release.xcconfig */ = {isa = PBXFileReference; lastKnownFileType = text.xcconfig; name = Release.xcconfig; path = Flutter/Release.xcconfig; sourceTree = "&lt;group&gt;"; };
						9740EEB21CF90195004384FC /* Debug.xcconfig */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = text.xcconfig; name = Debug.xcconfig; path = Flutter/Debug.xcconfig; sourceTree = "&lt;group&gt;"; };
						9740EEB31CF90195004384FC /* Generated.xcconfig */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = text.xcconfig; name = Generated.xcconfig; path = Flutter/Generated.xcconfig; sourceTree = "&lt;group&gt;"; };
						9740EEBA1CF902C7004384FC /* Flutter.framework */ = {isa = PBXFileReference; lastKnownFileType = wrapper.framework; name = Flutter.framework; path = Flutter/Flutter.framework; sourceTree = "&lt;group&gt;"; };
						97C146EE1CF9000F007C117D /* Runner.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = Runner.app; sourceTree = BUILT_PRODUCTS_DIR; };
						97C146FB1CF9000F007C117D /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "&lt;group&gt;"; };
						97C146FD1CF9000F007C117D /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "&lt;group&gt;"; };
						97C147001CF9000F007C117D /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "&lt;group&gt;"; };
						97C147021CF9000F007C117D /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "&lt;group&gt;"; };
						/* End PBXFileReference section */

						/* Begin PBXFrameworksBuildPhase section */
						97C146EB1CF9000F007C117D /* Frameworks */ = {
						isa = PBXFrameworksBuildPhase;
						buildActionMask = 2147483647;
						files = (
						);
						runOnlyForDeploymentPostprocessing = 0;
						};
						/* End PBXFrameworksBuildPhase section */

						/* Begin PBXGroup section */
						9740EEB11CF90186004384FC /* Flutter */ = {
						isa = PBXGroup;
						children = (
						3B3967151E833CAA004F5970 /* AppFrameworkInfo.plist */,
						9740EEB21CF90195004384FC /* Debug.xcconfig */,
						7AFA3C8E1D35360C0083082E /* Release.xcconfig */,
						9740EEB31CF90195004384FC /* Generated.xcconfig */,
						);
						name = Flutter;
						sourceTree = "&lt;group&gt;";
						};
						97C146E51CF9000F007C117D = {
						isa = PBXGroup;
						children = (
						9740EEB11CF90186004384FC /* Flutter */,
						97C146F01CF9000F007C117D /* Runner */,
						97C146EF1CF9000F007C117D /* Products */,
						CD4A1CB5B6EB3C5E84856BA8 /* Pods */,
						);
						sourceTree = "&lt;group&gt;";
						};
						97C146EF1CF9000F007C117D /* Products */ = {
						isa = PBXGroup;
						children = (
						97C146EE1CF9000F007C117D /* Runner.app */,
						);
						name = Products;
						sourceTree = "&lt;group&gt;";
						};
						97C146F01CF9000F007C117D /* Runner */ = {
						isa = PBXGroup;
						children = (
						97C146FA1CF9000F007C117D /* Main.storyboard */,
						97C146FD1CF9000F007C117D /* Assets.xcassets */,
						97C146FF1CF9000F007C117D /* LaunchScreen.storyboard */,
						97C147021CF9000F007C117D /* Info.plist */,
						1498D2321E8E86230040F4C2 /* GeneratedPluginRegistrant.h */,
						1498D2331E8E89220040F4C2 /* GeneratedPluginRegistrant.m */,
						74858FAE1ED2DC5600515810 /* AppDelegate.swift */,
						74858FAD1ED2DC5600515810 /* Runner-Bridging-Header.h */,
						);
						path = Runner;
						sourceTree = "&lt;group&gt;";
						};
						/* End PBXGroup section */

						/* Begin PBXNativeTarget section */
						97C146ED1CF9000F007C117D /* Runner */ = {
						isa = PBXNativeTarget;
						buildConfigurationList = 97C147051CF9000F007C117D /* Build configuration list for PBXNativeTarget "Runner" */;
						buildPhases = (
						9740EEB61CF901F6004384FC /* Run Script */,
						97C146EA1CF9000F007C117D /* Sources */,
						97C146EB1CF9000F007C117D /* Frameworks */,
						97C146EC1CF9000F007C117D /* Resources */,
						9705A1C41CF9048500538489 /* Embed Frameworks */,
						3B06AD1E1E4923F5004D2608 /* Thin Binary */,
						);
						buildRules = (
						);
						dependencies = (
						);
						name = Runner;
						productName = Runner;
						productReference = 97C146EE1CF9000F007C117D /* Runner.app */;
						productType = "com.apple.product-type.application";
						};
						/* End PBXNativeTarget section */

						/* Begin PBXProject section */
						97C146E61CF9000F007C117D /* Project object */ = {
						isa = PBXProject;
						attributes = {
						LastUpgradeCheck = 1020;
						ORGANIZATIONNAME = "";
						TargetAttributes = {
						97C146ED1CF9000F007C117D = {
						CreatedOnToolsVersion = 7.3.1;
						LastSwiftMigration = 1100;
						};
						};
						};
						buildConfigurationList = 97C146E91CF9000F007C117D /* Build configuration list for PBXProject "Runner" */;
						compatibilityVersion = "Xcode 9.3";
						developmentRegion = en;
						hasScannedForEncodings = 0;
						knownRegions = (
						en,
						Base,
						);
						mainGroup = 97C146E51CF9000F007C117D;
						productRefGroup = 97C146EF1CF9000F007C117D /* Products */;
						projectDirPath = "";
						projectRoot = "";
						targets = (
						97C146ED1CF9000F007C117D /* Runner */,
						);
						};
						/* End PBXProject section */

						/* Begin PBXResourcesBuildPhase section */
						97C146EC1CF9000F007C117D /* Resources */ = {
						isa = PBXResourcesBuildPhase;
						buildActionMask = 2147483647;
						files = (
						97C147011CF9000F007C117D /* LaunchScreen.storyboard in Resources */,
						3B3967161E833CAA004F5970 /* AppFrameworkInfo.plist in Resources */,
						97C146FE1CF9000F007C117D /* Assets.xcassets in Resources */,
						97C146FC1CF9000F007C117D /* Main.storyboard in Resources */,
						);
						runOnlyForDeploymentPostprocessing = 0;
						};
						/* End PBXResourcesBuildPhase section */

						/* Begin PBXShellScriptBuildPhase section */
						3B06AD1E1E4923F5004D2608 /* Thin Binary */ = {
						isa = PBXShellScriptBuildPhase;
						buildActionMask = 2147483647;
						files = (
						);
						inputPaths = (
						);
						name = "Thin Binary";
						outputPaths = (
						);
						runOnlyForDeploymentPostprocessing = 0;
						shellPath = /bin/sh;
						shellScript = "/bin/sh \"$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh\" embed_and_thin";
						};
						9740EEB61CF901F6004384FC /* Run Script */ = {
						isa = PBXShellScriptBuildPhase;
						buildActionMask = 2147483647;
						files = (
						);
						inputPaths = (
						);
						name = "Run Script";
						outputPaths = (
						);
						runOnlyForDeploymentPostprocessing = 0;
						shellPath = /bin/sh;
						shellScript = "/bin/sh \"$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh\" build";
						};
						/* End PBXShellScriptBuildPhase section */

						/* Begin PBXSourcesBuildPhase section */
						97C146EA1CF9000F007C117D /* Sources */ = {
						isa = PBXSourcesBuildPhase;
						buildActionMask = 2147483647;
						files = (
						74858FAF1ED2DC5600515810 /* AppDelegate.swift in Sources */,
						1498D2341E8E89220040F4C2 /* GeneratedPluginRegistrant.m in Sources */,
						);
						runOnlyForDeploymentPostprocessing = 0;
						};
						/* End PBXSourcesBuildPhase section */

						/* Begin PBXVariantGroup section */
						97C146FA1CF9000F007C117D /* Main.storyboard */ = {
						isa = PBXVariantGroup;
						children = (
						97C146FB1CF9000F007C117D /* Base */,
						);
						name = Main.storyboard;
						sourceTree = "&lt;group&gt;";
						};
						97C146FF1CF9000F007C117D /* LaunchScreen.storyboard */ = {
						isa = PBXVariantGroup;
						children = (
						97C147001CF9000F007C117D /* Base */,
						);
						name = LaunchScreen.storyboard;
						sourceTree = "&lt;group&gt;";
						};
						/* End PBXVariantGroup section */

						/* Begin XCBuildConfiguration section */
						249021D3217E4FDB00AE95B9 /* Profile */ = {
						isa = XCBuildConfiguration;
						buildSettings = {
						ALWAYS_SEARCH_USER_PATHS = NO;
						CLANG_ANALYZER_NONNULL = YES;
						CLANG_CXX_LANGUAGE_STANDARD = "gnu++0x";
						CLANG_CXX_LIBRARY = "libc++";
						CLANG_ENABLE_MODULES = YES;
						CLANG_ENABLE_OBJC_ARC = YES;
						CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
						CLANG_WARN_BOOL_CONVERSION = YES;
						CLANG_WARN_COMMA = YES;
						CLANG_WARN_CONSTANT_CONVERSION = YES;
						CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
						CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
						CLANG_WARN_EMPTY_BODY = YES;
						CLANG_WARN_ENUM_CONVERSION = YES;
						CLANG_WARN_INFINITE_RECURSION = YES;
						CLANG_WARN_INT_CONVERSION = YES;
						CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
						CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
						CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
						CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
						CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
						CLANG_WARN_STRICT_PROTOTYPES = YES;
						CLANG_WARN_SUSPICIOUS_MOVE = YES;
						CLANG_WARN_UNREACHABLE_CODE = YES;
						CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
						"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "iPhone Developer";
						COPY_PHASE_STRIP = NO;
						DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
						ENABLE_NS_ASSERTIONS = NO;
						ENABLE_STRICT_OBJC_MSGSEND = YES;
						GCC_C_LANGUAGE_STANDARD = gnu99;
						GCC_NO_COMMON_BLOCKS = YES;
						GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
						GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
						GCC_WARN_UNDECLARED_SELECTOR = YES;
						GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
						GCC_WARN_UNUSED_FUNCTION = YES;
						GCC_WARN_UNUSED_VARIABLE = YES;
						IPHONEOS_DEPLOYMENT_TARGET = 8.0;
						MTL_ENABLE_DEBUG_INFO = NO;
						SDKROOT = iphoneos;
						SUPPORTED_PLATFORMS = iphoneos;
						TARGETED_DEVICE_FAMILY = "1,2";
						VALIDATE_PRODUCT = YES;
						};
						name = Profile;
						};
						249021D4217E4FDB00AE95B9 /* Profile */ = {
						isa = XCBuildConfiguration;
						baseConfigurationReference = 7AFA3C8E1D35360C0083082E /* Release.xcconfig */;
						buildSettings = {
						ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
						CLANG_ENABLE_MODULES = YES;
						CURRENT_PROJECT_VERSION = "$(FLUTTER_BUILD_NUMBER)";
						ENABLE_BITCODE = NO;
						FRAMEWORK_SEARCH_PATHS = (
						"$(inherited)",
						"$(PROJECT_DIR)/Flutter",
						);
						INFOPLIST_FILE = Runner/Info.plist;
						LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
						LIBRARY_SEARCH_PATHS = (
						"$(inherited)",
						"$(PROJECT_DIR)/Flutter",
						);
						PRODUCT_BUNDLE_IDENTIFIER = com.backendless.<xsl:value-of select="$projectName"/>Chat;
						PRODUCT_NAME = "$(TARGET_NAME)";
						SWIFT_OBJC_BRIDGING_HEADER = "Runner/Runner-Bridging-Header.h";
						SWIFT_VERSION = 5.0;
						VERSIONING_SYSTEM = "apple-generic";
						};
						name = Profile;
						};
						97C147031CF9000F007C117D /* Debug */ = {
						isa = XCBuildConfiguration;
						buildSettings = {
						ALWAYS_SEARCH_USER_PATHS = NO;
						CLANG_ANALYZER_NONNULL = YES;
						CLANG_CXX_LANGUAGE_STANDARD = "gnu++0x";
						CLANG_CXX_LIBRARY = "libc++";
						CLANG_ENABLE_MODULES = YES;
						CLANG_ENABLE_OBJC_ARC = YES;
						CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
						CLANG_WARN_BOOL_CONVERSION = YES;
						CLANG_WARN_COMMA = YES;
						CLANG_WARN_CONSTANT_CONVERSION = YES;
						CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
						CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
						CLANG_WARN_EMPTY_BODY = YES;
						CLANG_WARN_ENUM_CONVERSION = YES;
						CLANG_WARN_INFINITE_RECURSION = YES;
						CLANG_WARN_INT_CONVERSION = YES;
						CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
						CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
						CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
						CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
						CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
						CLANG_WARN_STRICT_PROTOTYPES = YES;
						CLANG_WARN_SUSPICIOUS_MOVE = YES;
						CLANG_WARN_UNREACHABLE_CODE = YES;
						CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
						"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "iPhone Developer";
						COPY_PHASE_STRIP = NO;
						DEBUG_INFORMATION_FORMAT = dwarf;
						ENABLE_STRICT_OBJC_MSGSEND = YES;
						ENABLE_TESTABILITY = YES;
						GCC_C_LANGUAGE_STANDARD = gnu99;
						GCC_DYNAMIC_NO_PIC = NO;
						GCC_NO_COMMON_BLOCKS = YES;
						GCC_OPTIMIZATION_LEVEL = 0;
						GCC_PREPROCESSOR_DEFINITIONS = (
						"DEBUG=1",
						"$(inherited)",
						);
						GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
						GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
						GCC_WARN_UNDECLARED_SELECTOR = YES;
						GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
						GCC_WARN_UNUSED_FUNCTION = YES;
						GCC_WARN_UNUSED_VARIABLE = YES;
						IPHONEOS_DEPLOYMENT_TARGET = 8.0;
						MTL_ENABLE_DEBUG_INFO = YES;
						ONLY_ACTIVE_ARCH = YES;
						SDKROOT = iphoneos;
						TARGETED_DEVICE_FAMILY = "1,2";
						};
						name = Debug;
						};
						97C147041CF9000F007C117D /* Release */ = {
						isa = XCBuildConfiguration;
						buildSettings = {
						ALWAYS_SEARCH_USER_PATHS = NO;
						CLANG_ANALYZER_NONNULL = YES;
						CLANG_CXX_LANGUAGE_STANDARD = "gnu++0x";
						CLANG_CXX_LIBRARY = "libc++";
						CLANG_ENABLE_MODULES = YES;
						CLANG_ENABLE_OBJC_ARC = YES;
						CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
						CLANG_WARN_BOOL_CONVERSION = YES;
						CLANG_WARN_COMMA = YES;
						CLANG_WARN_CONSTANT_CONVERSION = YES;
						CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
						CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
						CLANG_WARN_EMPTY_BODY = YES;
						CLANG_WARN_ENUM_CONVERSION = YES;
						CLANG_WARN_INFINITE_RECURSION = YES;
						CLANG_WARN_INT_CONVERSION = YES;
						CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
						CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
						CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
						CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
						CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
						CLANG_WARN_STRICT_PROTOTYPES = YES;
						CLANG_WARN_SUSPICIOUS_MOVE = YES;
						CLANG_WARN_UNREACHABLE_CODE = YES;
						CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
						"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "iPhone Developer";
						COPY_PHASE_STRIP = NO;
						DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
						ENABLE_NS_ASSERTIONS = NO;
						ENABLE_STRICT_OBJC_MSGSEND = YES;
						GCC_C_LANGUAGE_STANDARD = gnu99;
						GCC_NO_COMMON_BLOCKS = YES;
						GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
						GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
						GCC_WARN_UNDECLARED_SELECTOR = YES;
						GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
						GCC_WARN_UNUSED_FUNCTION = YES;
						GCC_WARN_UNUSED_VARIABLE = YES;
						IPHONEOS_DEPLOYMENT_TARGET = 8.0;
						MTL_ENABLE_DEBUG_INFO = NO;
						SDKROOT = iphoneos;
						SUPPORTED_PLATFORMS = iphoneos;
						SWIFT_OPTIMIZATION_LEVEL = "-Owholemodule";
						TARGETED_DEVICE_FAMILY = "1,2";
						VALIDATE_PRODUCT = YES;
						};
						name = Release;
						};
						97C147061CF9000F007C117D /* Debug */ = {
						isa = XCBuildConfiguration;
						baseConfigurationReference = 9740EEB21CF90195004384FC /* Debug.xcconfig */;
						buildSettings = {
						ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
						CLANG_ENABLE_MODULES = YES;
						CURRENT_PROJECT_VERSION = "$(FLUTTER_BUILD_NUMBER)";
						ENABLE_BITCODE = NO;
						FRAMEWORK_SEARCH_PATHS = (
						"$(inherited)",
						"$(PROJECT_DIR)/Flutter",
						);
						INFOPLIST_FILE = Runner/Info.plist;
						LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
						LIBRARY_SEARCH_PATHS = (
						"$(inherited)",
						"$(PROJECT_DIR)/Flutter",
						);
						PRODUCT_BUNDLE_IDENTIFIER = com.backendless.<xsl:value-of select="$projectName"/>Chat;
						PRODUCT_NAME = "$(TARGET_NAME)";
						SWIFT_OBJC_BRIDGING_HEADER = "Runner/Runner-Bridging-Header.h";
						SWIFT_OPTIMIZATION_LEVEL = "-Onone";
						SWIFT_VERSION = 5.0;
						VERSIONING_SYSTEM = "apple-generic";
						};
						name = Debug;
						};
						97C147071CF9000F007C117D /* Release */ = {
						isa = XCBuildConfiguration;
						baseConfigurationReference = 7AFA3C8E1D35360C0083082E /* Release.xcconfig */;
						buildSettings = {
						ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
						CLANG_ENABLE_MODULES = YES;
						CURRENT_PROJECT_VERSION = "$(FLUTTER_BUILD_NUMBER)";
						ENABLE_BITCODE = NO;
						FRAMEWORK_SEARCH_PATHS = (
						"$(inherited)",
						"$(PROJECT_DIR)/Flutter",
						);
						INFOPLIST_FILE = Runner/Info.plist;
						LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
						LIBRARY_SEARCH_PATHS = (
						"$(inherited)",
						"$(PROJECT_DIR)/Flutter",
						);
						PRODUCT_BUNDLE_IDENTIFIER = com.backendless.<xsl:value-of select="$projectName"/>Chat;
						PRODUCT_NAME = "$(TARGET_NAME)";
						SWIFT_OBJC_BRIDGING_HEADER = "Runner/Runner-Bridging-Header.h";
						SWIFT_VERSION = 5.0;
						VERSIONING_SYSTEM = "apple-generic";
						};
						name = Release;
						};
						/* End XCBuildConfiguration section */

						/* Begin XCConfigurationList section */
						97C146E91CF9000F007C117D /* Build configuration list for PBXProject "Runner" */ = {
						isa = XCConfigurationList;
						buildConfigurations = (
						97C147031CF9000F007C117D /* Debug */,
						97C147041CF9000F007C117D /* Release */,
						249021D3217E4FDB00AE95B9 /* Profile */,
						);
						defaultConfigurationIsVisible = 0;
						defaultConfigurationName = Release;
						};
						97C147051CF9000F007C117D /* Build configuration list for PBXNativeTarget "Runner" */ = {
						isa = XCConfigurationList;
						buildConfigurations = (
						97C147061CF9000F007C117D /* Debug */,
						97C147071CF9000F007C117D /* Release */,
						249021D4217E4FDB00AE95B9 /* Profile */,
						);
						defaultConfigurationIsVisible = 0;
						defaultConfigurationName = Release;
						};
						/* End XCConfigurationList section */
						};
						rootObject = 97C146E61CF9000F007C117D /* Project object */;
						}
					</file>
					<folder name="project.xcworkspace">
						<file path="Project/ios/contents.xcworkspacedata"/>
						<folder name ="xcshareddata">
							<file path="Project/ios/IDEWorkspaceChecks.plist"/>
						</folder>
						<folder name="xcuserdata"/>
					</folder>
					<folder name="xcshareddata">
						<folder name="xcschemes">
							<file path="Project/ios/Runner.xcscheme"/>
						</folder>
					</folder>
				</folder>
				<folder name="Runner.xcworkspace">
					<file path="Project/ios/contents.xcworkspacedata"/>
				</folder>
			</folder>
			<folder name="lib">
				<file name="main.dart">import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State&lt;MyHomePage&gt; {
  String _status = 'Object is saving to the real time database...';
  String _savedValue = '...';
  Map _savedTestObject;
  IDataStore&lt;Map&gt; _testTableDataStore;
  TextEditingController _controller;

  static const String SERVER_URL = "<xsl:value-of select="$serverURL"/>";
  static const String APPLICATION_ID = "<xsl:value-of select="$applicationId"/>";
  static const String ANDROID_API_KEY = "<xsl:value-of select="$apiKeyAndroid"/>";
  static const String IOS_API_KEY = "<xsl:value-of select="$apiKeyIos"/>";
	static const String JS_API_KEY = "<xsl:value-of select="$apiKeyJs"/>";


  @override
  void initState() {
    super.initState();
		init();
	}

	void init() async {

    _controller = TextEditingController();

    await Backendless.setUrl(SERVER_URL);
    await Backendless.initApp(
      APPLICATION_ID,
      ANDROID_API_KEY,
      IOS_API_KEY);
		await Backendless.initWebApp(
			APPLICATION_ID,
			JS_API_KEY);

    Map testObject = Map();
    testObject['foo'] = 'Hello World';
    _testTableDataStore = Backendless.data.of('TestTable');
    _testTableDataStore.save(testObject).then((response) {
      _savedTestObject = response;
      _subscribeForObjectUpdate();
      setState(() {
        _status = 'Object has been saved in the real-time database';
        _savedValue = response['foo'];
      });
    });
    
  }

  void _subscribeForObjectUpdate() {
    _testTableDataStore.rt().addUpdateListener(
      (response) => setState(() => _savedValue = response['foo']),
      whereClause: "objectId='${_savedTestObject["objectId"]}'");
  }

  void _updateValue() {
    _savedTestObject['foo'] = _controller.text;
    _testTableDataStore.save(_savedTestObject).then((response) {
      print("Saved $response");
      _controller.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(padding: EdgeInsets.all(10), child:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: &lt;Widget&gt;[
            Text(
              '$_status',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Live update object property:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '$_savedValue',
              style: Theme.of(context).textTheme.display1,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Change property value'
              ),
              controller: _controller,
            ),
            RaisedButton(
              child: const Text('Update'),
              color: Colors.white54,
              
              onPressed: _updateValue,
            ),
          ],
        ),
      ),
    ));
  }
}
				</file>
			</folder>
			<file name="pubspec.yaml">name: "<xsl:value-of select="$projectName"/>"
description: A new Flutter project.

version: 1.0.0+1

environment:
  sdk: ">=2.1.0 &lt;3.0.0"

dependencies:
  flutter:
    sdk: flutter
  backendless_sdk: ^6.0.1

  cupertino_icons: ^0.1.2

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:

  uses-material-design: true
</file>
			<file name="{$projectName}.iml"><![CDATA[<?xml version="1.0" encoding="UTF-8"?>
<module type="JAVA_MODULE" version="4">
  <component name="NewModuleRootManager" inherit-compiler-output="true">
    <exclude-output />
    <content url="file://$MODULE_DIR$">
      <sourceFolder url="file://$MODULE_DIR$/lib" isTestSource="false" />
      <sourceFolder url="file://$MODULE_DIR$/test" isTestSource="true" />
      <excludeFolder url="file://$MODULE_DIR$/.dart_tool" />
      <excludeFolder url="file://$MODULE_DIR$/.idea" />
      <excludeFolder url="file://$MODULE_DIR$/.pub" />
      <excludeFolder url="file://$MODULE_DIR$/build" />
    </content>
    <orderEntry type="sourceFolder" forTests="false" />
    <orderEntry type="library" name="Dart SDK" level="project" />
    <orderEntry type="library" name="Flutter Plugins" level="project" />
    <orderEntry type="library" name="Dart Packages" level="project" />
  </component>
</module>]]>
			</file>
		</folder>
	</xsl:template>
</xsl:stylesheet>
