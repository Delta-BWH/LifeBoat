<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="create_ipr">
        <xsl:param name="projectName"/>
        <xsl:variable name="path"><xsl:value-of select="$projectName"/>/<xsl:value-of select="$projectName"/></xsl:variable>
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;project version="4"&gt;
    &lt;component name="CompilerConfiguration"&gt;
        &lt;option name="DEFAULT_COMPILER" value="Javac" /&gt;
        &lt;resourceExtensions /&gt;
        &lt;wildcardResourcePatterns&gt;
            &lt;entry name="!?*.java" /&gt;
            &lt;entry name="!?*.form" /&gt;
            &lt;entry name="!?*.class" /&gt;
            &lt;entry name="!?*.groovy" /&gt;
            &lt;entry name="!?*.scala" /&gt;
            &lt;entry name="!?*.flex" /&gt;
            &lt;entry name="!?*.kt" /&gt;
            &lt;entry name="!?*.clj" /&gt;
        &lt;/wildcardResourcePatterns&gt;
        &lt;annotationProcessing&gt;
            &lt;profile default="true" name="Default" enabled="false"&gt;
                &lt;processorPath useClasspath="true" /&gt;
            &lt;/profile&gt;
        &lt;/annotationProcessing&gt;
    &lt;/component&gt;
    &lt;component name="DependencyValidationManager"&gt;
        &lt;option name="SKIP_IMPORT_STATEMENTS" value="false" /&gt;
    &lt;/component&gt;
    &lt;component name="ProjectModuleManager"&gt;
        &lt;modules&gt;
            &lt;module fileurl="file://$PROJECT_DIR$/<xsl:value-of select="$path"/>.iml" filepath="$PROJECT_DIR$/<xsl:value-of select="$path"/>.iml" /&gt;
        &lt;/modules&gt;
    &lt;/component&gt;
    &lt;component name="ProjectRootManager" version="2" languageLevel="JDK_1_6" assert-keyword="true" jdk-15="true"&gt;
        &lt;output url="file://$PROJECT_DIR$/out" /&gt;
    &lt;/component&gt;
    &lt;component name="VcsDirectoryMappings"&gt;
        &lt;mapping directory="" vcs="" /&gt;
    &lt;/component&gt;
&lt;/project&gt;</xsl:template>

    <xsl:template name="create_iml">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;module type="WEB_MODULE" version="4"&gt;
    &lt;component name="NewModuleRootManager"&gt;
        &lt;content url="file://$MODULE_DIR$"&gt;
            &lt;excludeFolder url="file://$MODULE_DIR$/.tmp" /&gt;
            &lt;excludeFolder url="file://$MODULE_DIR$/temp" /&gt;
            &lt;excludeFolder url="file://$MODULE_DIR$/tmp" /&gt;
        &lt;/content&gt;
        &lt;orderEntry type="inheritedJdk" /&gt;
        &lt;orderEntry type="sourceFolder" forTests="false" /&gt;
    &lt;/component&gt;
&lt;/module&gt;</xsl:template>

    <xsl:template name="initApp">
//Backendless: defaults
const APPLICATION_ID = '<xsl:value-of select="$applicationId"/>';
const API_KEY = '<xsl:value-of select="$apiKey"/>';
Backendless.serverURL = "<xsl:value-of select="$serverURL"/>";
Backendless.initApp(APPLICATION_ID, API_KEY);

if (!APPLICATION_ID || !API_KEY) {
  alert(
    'Missing application ID or api key arguments. ' +
    'Login to Backendless Console, select your app and get the ID and key from the Manage &gt; App Settings screen. ' +
    'Copy/paste the values into the Backendless.initApp call located in <xsl:value-of select="$projectName"/>.js'
  );
}
    </xsl:template>

</xsl:stylesheet>