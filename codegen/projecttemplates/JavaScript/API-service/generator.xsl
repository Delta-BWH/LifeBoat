  <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->

    <xsl:template match="/">
        <folder name="{backendless-codegen/application/name}">
            <folder path="project-files/models"/>
            <folder path="project-files/services"/>
            <file name="package.json">{
  "name": "<xsl:value-of select="backendless-codegen/application/name"/>-coderunner-project-template",
  "version": "1.0.0",
  "author": "<xsl:value-of select="backendless-codegen/application/developerEmail"/>",
  "scripts": {
    "debug": "coderunner debug",
    "deploy": "coderunner deploy"
  },
  "license": "MIT",
  "devDependencies": {
    "backendless-coderunner": "^<xsl:value-of select="backendless-codegen/application/jsCodeRunnerVersion"/>"
  }
}</file>

  <file name="coderunner.json">{
  "backendless": {
    "apiServer": "<xsl:value-of select="backendless-codegen/application/serverURL"/>",
    "msgBroker": {
      "host": "<xsl:value-of select="backendless-codegen/application/blDebugHost"/>",
      "port": <xsl:value-of select="backendless-codegen/application/blDebugPort"/>
    }
  },
  "app": {
    "id": "<xsl:value-of select="backendless-codegen/application/id"/>",
    "apiKey": "<xsl:value-of select="backendless-codegen/application/apiKeys/BL"/>",
    "exclude": [
      "package.json",
      "coderunner.json",
      "README.md",
      "servercode.iml",
      "servercode.ipr",
      "servercode.iws"
    ]
  }
}</file>
        </folder>
    </xsl:template>
</xsl:stylesheet>