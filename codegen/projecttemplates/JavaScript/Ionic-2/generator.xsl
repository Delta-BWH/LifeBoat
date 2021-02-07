  <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->

    <xsl:template match="/">
        <folder name="{backendless-codegen/application/name}">
            <folder path="project-files/src"/>
            <folder path="project-files/www"/>
            <file path="project-files/ionic.config.json"/>
            <file path="project-files/README.md"/>
            <file path="project-files/tsconfig.json"/>
            <file path="project-files/tslint.json"/>
            <file name=".editorconfig"># EditorConfig helps developers define and maintain consistent coding styles between different editors and IDEs
# editorconfig.org

root = true

[*]
indent_style = space
indent_size = 2

# We recommend you to keep these unchanged
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true

[*.md]
trim_trailing_whitespace = false</file>
            <file name="config.xml">&lt;?xml version="1.0" encoding="UTF-8" standalone="yes"?&gt;
&lt;widget id="com.ionicframework.ionic2pushtest303307" version="0.0.1" xmlns="http://www.w3.org/ns/widgets" xmlns:cdv="http://cordova.apache.org/ns/1.0"&gt;
&lt;name&gt;backendless-ionic2-template&lt;/name&gt;
&lt;description&gt;An awesome Backendless/Ionic/Cordova app.&lt;/description&gt;
&lt;author email="<xsl:value-of select="backendless-codegen/application/developerEmail"/>" &gt;<xsl:value-of select="backendless-codegen/application/name"/> Team&lt;/author&gt;
&lt;content src="index.html"/&gt;
&lt;access origin="*"/&gt;
&lt;allow-navigation href="http://ionic.local/*"/&gt;
&lt;allow-intent href="http://*/*"/&gt;
&lt;allow-intent href="https://*/*"/&gt;
&lt;allow-intent href="tel:*"/&gt;
&lt;allow-intent href="sms:*"/&gt;
&lt;allow-intent href="mailto:*"/&gt;
&lt;allow-intent href="geo:*"/&gt;
&lt;platform name="android"&gt;
&lt;allow-intent href="market:*"/&gt;
&lt;/platform&gt;
&lt;platform name="ios"&gt;
&lt;allow-intent href="itms:*"/&gt;
&lt;allow-intent href="itms-apps:*"/&gt;
&lt;/platform&gt;
&lt;preference name="webviewbounce" value="false"/&gt;
&lt;preference name="UIWebViewBounce" value="false"/&gt;
&lt;preference name="DisallowOverscroll" value="true"/&gt;
&lt;preference name="android-minSdkVersion" value="16"/&gt;
&lt;preference name="BackupWebStorage" value="none"/&gt;
&lt;preference name="SplashMaintainAspectRatio" value="true"/&gt;
&lt;preference name="FadeSplashScreenDuration" value="300"/&gt;
&lt;preference name="SplashShowOnlyFirstTime" value="false"/&gt;
&lt;feature name="StatusBar"&gt;
&lt;param name="ios-package" onload="true" value="CDVStatusBar"/&gt;
&lt;/feature&gt;
&lt;plugin name="ionic-plugin-keyboard" spec="~2.2.1"/&gt;
&lt;plugin name="cordova-plugin-whitelist" spec="1.3.1"/&gt;
&lt;plugin name="cordova-plugin-console" spec="1.0.5"/&gt;
&lt;plugin name="cordova-plugin-statusbar" spec="2.2.1"/&gt;
&lt;plugin name="cordova-plugin-device" spec="1.1.4"/&gt;
&lt;plugin name="cordova-plugin-splashscreen" spec="~4.0.1"/&gt;

&lt;plugin name="phonegap-plugin-push" spec="1.8.2"&gt;


&lt;variable name="SENDER_ID" value="YOUR_SENDER_ID"/&gt;


&lt;/plugin&gt;
&lt;/widget&gt;
            </file>
            <file name="package.json">{
  "name": "backendless-ionic2-app",
  "private": true,
  "scripts": {
    "start": "npm run ionic:serve",
    "clean": "ionic-app-scripts clean",
    "build": "ionic-app-scripts build",
    "ionic:build": "ionic-app-scripts build",
    "ionic:serve": "ionic-app-scripts serve"
  },
  "dependencies": {
    "@angular/common": "2.2.1",
    "@angular/compiler": "2.2.1",
    "@angular/compiler-cli": "2.2.1",
    "@angular/core": "2.2.1",
    "@angular/forms": "2.2.1",
    "@angular/http": "2.2.1",
    "@angular/platform-browser": "2.2.1",
    "@angular/platform-browser-dynamic": "2.2.1",
    "@angular/platform-server": "2.2.1",
    "@ionic/storage": "1.1.7",
    "backendless": "^<xsl:value-of select="backendless-codegen/application/jsSDKVersion"/>",
    "ionic-angular": "2.0.1",
    "ionic-native": "2.4.1",
    "ionicons": "3.0.0",
    "rxjs": "5.0.0-beta.12",
    "sw-toolbox": "3.4.0",
    "zone.js": "0.6.26"
  },
  "devDependencies": {
    "@ionic/app-scripts": "1.0.0",
    "typescript": "2.3.0"
  },
  "cordovaPlugins": [
    "cordova-plugin-whitelist",
    "cordova-plugin-console",
    "cordova-plugin-device",
    "cordova-plugin-statusbar",
    "cordova-plugin-splashscreen",
    "ionic-plugin-keyboard"
  ],
  "cordovaPlatforms": [
    "ios",
    {
      "platform": "ios",
      "version": "",
      "locator": "ios"
    }
  ],
  "description": "backendless-ionic2-app: An Ionic project"
}</file>
            <folder name="src">
                <folder name="app">
                  <file name="app.component.ts">

import {Component} from '@angular/core';
import {Platform} from "ionic-angular";
import {StatusBar, Splashscreen} from "ionic-native";

import {HomePage} from '../pages/home/home';


import Backendless from 'backendless';

const APP_ID: string = '<xsl:value-of select="backendless-codegen/application/id"/>';
const API_KEY: string = '<xsl:value-of select="backendless-codegen/application/apiKeys/JS"/>';
Backendless.serverURL = '<xsl:value-of select="backendless-codegen/application/serverURL"/>';

Backendless.initApp(APP_ID, API_KEY);

@Component({
  templateUrl: 'app.html'
})
export class MyApp {
  rootPage = HomePage;

  constructor(public platform: Platform) {
    platform.ready().then(() => {
      // Okay, so the platform is ready and our plugins are available.
      // Here you can do any higher level native things you might need.
      StatusBar.styleDefault();
      Splashscreen.hide();
    });
  }

}
                </file>
                </folder>
            </folder>
        </folder>
    </xsl:template>
</xsl:stylesheet>