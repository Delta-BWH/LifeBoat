 <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->

    <xsl:template match="/">
        <folder name="{backendless-codegen/application/name}">
            <folder path="project-files/android"/>
            <folder path="project-files/ios"/>
            <file path="project-files/index.ios.js"/>
            <file path="project-files/index.android.js"/>
            <file path="project-files/App.test.js"/>
            <file path="project-files/app.json"/>
            <file name="App.js">import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import Backendless from 'backendless';

const APP_ID = '<xsl:value-of select="backendless-codegen/application/id"/>';
const API_KEY = '<xsl:value-of select="backendless-codegen/application/apiKeys/JS"/>';
Backendless.serverURL = '<xsl:value-of select="backendless-codegen/application/serverURL"/>';
Backendless.initApp(APP_ID, API_KEY);

const initialState = {
  loading: true,
  message: '',
  error  : null
}

export default class App extends React.Component {
  state = initialState

  componentDidMount() {
    Backendless.Data.of('TestTable').save({ foo: 'bar' })
     .then(obj => {
       const message = 'A data object has been saved in Backendless. Check \'TestTable\' in Backendless Console.' +
         `ObjectId = ${obj.objectId}`

       this.setState({ message, loading: false })
     })
     .catch(error => this.setState({ error: `Got an error - ${error}`, loading: false }))
  }

  render() {
    const { error, loading, message } = this.state

    return (
      &lt;View style={styles.container}&gt;
        &lt;Text&gt;{ loading ? 'Loading...' : message || error } &lt;/Text&gt;
      &lt;/View&gt;
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
                </file>
                <file name=".gitignore">node_modules/
.expo/
npm-debug.*
                </file>
                <file name=".flowconfig">[ignore]
; We fork some components by platform
.*/*[.]android.js

; Ignore "BUCK" generated dirs
&lt;PROJECT_ROOT&gt;/\.buckd/

; Ignore unexpected extra "@providesModule"
.*/node_modules/.*/node_modules/fbjs/.*

; Ignore duplicate module providers
; For RN Apps installed via npm, "Libraries" folder is inside
; "node_modules/react-native" but in the source repo it is in the root
.*/Libraries/react-native/React.js
.*/Libraries/react-native/ReactNative.js

; Additional create-react-native-app ignores

; Ignore duplicate module providers
.*/node_modules/fbemitter/lib/*

; Ignore misbehaving dev-dependencies
.*/node_modules/xdl/build/*
.*/node_modules/reqwest/tests/*

; Ignore missing expo-sdk dependencies (temporarily)
; https://github.com/exponent/exponent-sdk/issues/36
.*/node_modules/expo/src/*

; Ignore react-native-fbads dependency of the expo sdk
.*/node_modules/react-native-fbads/*

[include]

[libs]
node_modules/react-native/Libraries/react-native/react-native-interface.js
node_modules/react-native/flow
flow/

[options]
module.system=haste

emoji=true

experimental.strict_type_args=true

munge_underscores=true

module.name_mapper='^[./a-zA-Z0-9$_-]+\.\(bmp\|gif\|jpg\|jpeg\|png\|psd\|svg\|webp\|m4v\|mov\|mp4\|mpeg\|mpg\|webm\|aac\|aiff\|caf\|m4a\|mp3\|wav\|html\|pdf\)$' -> 'RelativeImageStub'

suppress_type=$FlowIssue
suppress_type=$FlowFixMe
suppress_type=$FixMe

suppress_comment=\\(.\\|\n\\)*\\$FlowFixMe\\($\\|[^(]\\|(\\(>=0\\.\\(3[0-8]\\|[1-2][0-9]\\|[0-9]\\).[0-9]\\)? *\\(site=[a-z,_]*react_native_oss[a-z,_]*\\)?)\\)
suppress_comment=\\(.\\|\n\\)*\\$FlowIssue\\((\\(>=0\\.\\(3[0-8]\\|1[0-9]\\|[1-2][0-9]\\).[0-9]\\)? *\\(site=[a-z,_]*react_native_oss[a-z,_]*\\)?)\\)?:? #[0-9]+
suppress_comment=\\(.\\|\n\\)*\\$FlowFixedInNextDeploy

unsafe.enable_getters_and_setters=true

[version]
^0.38.0
                </file>
                <file name=".watchmanconfig">{}</file>
                <file name="package.json">{
    "name": "backendless-react-native-app",
    "version": "0.1.0",
    "private": true,
    "devDependencies": {
        "jest-expo": "^0.3.0",
        "react-test-renderer": "~15.4.1"
    },
    "scripts": {
        "start": "react-native start",
        "android": "react-native run-android",
        "ios": "react-native run-ios",
        "test": "node node_modules/jest/bin/jest.js --watch"
    },
    "jest": {
        "preset": "jest-expo"
    },
    "dependencies": {
        "backendless": "^<xsl:value-of select="backendless-codegen/application/jsSDKVersion"/>",
        "http": "0.0.0",
        "https": "^1.0.0",
        "react": "~15.4.0",
        "react-native": "0.42.3",
        "url": "^0.11.0"
    }
}</file>
        </folder>
    </xsl:template>
</xsl:stylesheet>