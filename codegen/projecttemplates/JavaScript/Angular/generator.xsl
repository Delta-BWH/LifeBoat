  <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->

    <xsl:template match="/">
        <folder name="{backendless-codegen/application/name}">
            <folder path="project-files/e2e"/>
            <folder path="project-files/src"/>
            <file path="project-files/karma.conf.js"/>
            <file path="project-files/protractor.conf.js"/>
            <file path="project-files/README.md"/>
            <file path="project-files/tsconfig.json"/>
            <file path="project-files/tslint.json"/>
            <file name=".angular-cli.json">{
  "$schema": "./node_modules/@angular/cli/lib/config/schema.json",
  "project": {
    "name": "backendless-angular-app"
  },
  "apps": [
    {
      "root": "src",
      "outDir": "dist",
      "assets": [
        "assets",
        "favicon.ico"
      ],
      "index": "index.html",
      "main": "main.ts",
      "polyfills": "polyfills.ts",
      "test": "test.ts",
      "tsconfig": "tsconfig.app.json",
      "testTsconfig": "tsconfig.spec.json",
      "prefix": "app",
      "styles": [
        "styles.css"
      ],
      "scripts": [],
      "environmentSource": "environments/environment.ts",
      "environments": {
        "dev": "environments/environment.ts",
        "prod": "environments/environment.prod.ts"
      }
    }
  ],
  "e2e": {
    "protractor": {
      "config": "./protractor.conf.js"
    }
  },
  "lint": [
    {
      "project": "src/tsconfig.app.json"
    },
    {
      "project": "src/tsconfig.spec.json"
    },
    {
      "project": "e2e/tsconfig.e2e.json"
    }
  ],
  "test": {
    "karma": {
      "config": "./karma.conf.js"
    }
  },
  "defaults": {
    "styleExt": "css",
    "component": {}
  }
}</file>
            <file name=".editorconfig"># Editor configuration, see http://editorconfig.org
root = true

[*]
charset = utf-8
indent_style = space
indent_size = 2
insert_final_newline = true
trim_trailing_whitespace = true

[*.md]
max_line_length = off
trim_trailing_whitespace = false</file>
            <file name=".gitignore"># See http://help.github.com/ignore-files/ for more about ignoring files.

# compiled output
/dist
/tmp
/out-tsc

# dependencies
/node_modules

# IDEs and editors
/.idea
.project
.classpath
.c9/
*.launch
.settings/
*.sublime-workspace

# IDE - VSCode
.vscode/*
!.vscode/settings.json
!.vscode/tasks.json
!.vscode/launch.json
!.vscode/extensions.json

# misc
/.sass-cache
/connect.lock
/coverage
/libpeerconnection.log
npm-debug.log
testem.log
/typings

# e2e
/e2e/*.js
/e2e/*.map

# System Files
.DS_Store
Thumbs.db</file>
            <file name="package.json">{
    "name": "backendless-angular-app",
    "version": "0.0.0",
    "license": "MIT",
    "scripts": {
        "ng": "ng",
        "start": "ng serve",
        "build": "ng build",
        "test": "ng test",
        "lint": "ng lint",
        "e2e": "ng e2e"
    },
    "private": true,
    "dependencies": {
        "@angular/common": "^4.0.0",
        "@angular/compiler": "^4.0.0",
        "@angular/core": "^4.0.0",
        "@angular/forms": "^4.0.0",
        "@angular/http": "^4.0.0",
        "@angular/platform-browser": "^4.0.0",
        "@angular/platform-browser-dynamic": "^4.0.0",
        "@angular/router": "^4.0.0",
        "backendless": "^<xsl:value-of select="backendless-codegen/application/jsSDKVersion"/>",
        "core-js": "^2.4.1",
        "rxjs": "^5.1.0",
        "zone.js": "^0.8.4"
    },
    "devDependencies": {
        "@angular/cli": "1.0.0",
        "@angular/compiler-cli": "^4.0.0",
        "@types/jasmine": "2.5.38",
        "@types/node": "~6.0.60",
        "codelyzer": "~2.0.0",
        "jasmine-core": "~2.5.2",
        "jasmine-spec-reporter": "~3.2.0",
        "karma": "~1.4.1",
        "karma-chrome-launcher": "~2.0.0",
        "karma-cli": "~1.0.1",
        "karma-jasmine": "~1.1.0",
        "karma-jasmine-html-reporter": "^0.2.2",
        "karma-coverage-istanbul-reporter": "^0.2.0",
        "protractor": "~5.1.0",
        "ts-node": "~2.0.0",
        "tslint": "~4.5.0",
        "typescript": "~2.2.0"
    }
}</file>
            <folder name="src">
                <folder name="app">
                  <file name="app.component.ts">import { Component, OnInit } from '@angular/core';
import { DataService } from './data.service';
import Backendless from 'backendless';

const APP_ID: string = '<xsl:value-of select="backendless-codegen/application/id"/>';
const API_KEY: string = '<xsl:value-of select="backendless-codegen/application/apiKeys/JS"/>';
Backendless.serverURL = '<xsl:value-of select="backendless-codegen/application/serverURL"/>';

Backendless.initApp(APP_ID, API_KEY);

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  providers: [DataService]
})
export class AppComponent implements OnInit {
  title = 'app works!';

  message: string;

  error = null;

  loading = null;

  constructor(private dataService: DataService) { }

  saveTestObject(): void {
    this.loading = true;

    this.dataService.saveTestObject()
      .then(object => {
        this.message = 'A data object has been saved in Backendless. Check \'TestTable\' in Backendless Console.';
        this.loading = false;
      })
      .catch(error => {
        this.error = error;
        this.loading = false;
      });
  }

  ngOnInit(): void {
    this.saveTestObject();
  }
}</file>
                </folder>
            </folder>
        </folder>
    </xsl:template>
</xsl:stylesheet>