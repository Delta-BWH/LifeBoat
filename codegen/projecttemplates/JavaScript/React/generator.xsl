<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->

    <xsl:template match="/">
        <folder name="{backendless-codegen/application/name}">
            <file name="{backendless-codegen/application/name}.iml">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;module type="WEB_MODULE" version="4"&gt;
    &lt;component name="NewModuleRootManager" inherit-compiler-output="false"&gt;
        &lt;content url="file://$MODULE_DIR$" /&gt;
        &lt;orderEntry type="sourceFolder" forTests="false" /&gt;
    &lt;/component&gt;
&lt;/module&gt;
            </file>
            <folder name="src">
                <file name="App.js">import React, { Component } from 'react';
import reactLogo from './react-logo.svg';
import backendlessLogo from './backendless-logo.svg';
import './App.css';

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

class App extends Component {
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
      &lt;div className="App"&gt;
        &lt;div className="App-header"&gt;
          &lt;img src={reactLogo} className="react-logo" alt="logo" /&gt;
          &lt;img src={backendlessLogo} className="backendless-logo" alt="logo" /&gt;
          &lt;h2&gt;Welcome to Backendless with React&lt;/h2&gt;
          &lt;h2&gt;{ loading ? 'Loading...' : message || error } &lt;/h2&gt;
        &lt;/div&gt;
        &lt;p className="App-intro"&gt;
          <h3>{ loading ? 'Loading...' : message || error } </h3>
        &lt;/p&gt;
      &lt;/div&gt;
    );
  }
}

export default App;
                </file>
            </folder>
            <file name="package.json">{
    "name": "react-backendless-app-template",
    "version": "0.1.0",
    "private": true,
    "dependencies": {
        "backendless": "^<xsl:value-of select="backendless-codegen/application/jsSDKVersion"/>",
        "react": "^15.4.2",
        "react-dom": "^15.4.2"
    },
    "devDependencies": {
        "react-scripts": "0.9.5"
    },
    "scripts": {
        "start": "react-scripts start",
        "build": "react-scripts build",
        "test": "react-scripts test --env=jsdom",
        "eject": "react-scripts eject"
    }
}</file>
            <folder path="project-files/public"/>
            <folder path="project-files/src"/>
        </folder>
    </xsl:template>
</xsl:stylesheet>