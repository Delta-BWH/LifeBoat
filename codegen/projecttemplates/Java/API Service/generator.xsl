<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->

    <xsl:include href="../../../features/xsls/backendless-codegen-xsls/util.xsl"/>

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="packageAppName">
        <xsl:call-template name="toPackageName"><xsl:with-param name="str" select="$applicationName"/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="projectName"><xsl:value-of select="$applicationName"/></xsl:variable>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/BL"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>
    <xsl:variable name="blDebugHost" select="backendless-codegen/application/blDebugHost"/>
    <xsl:variable name="blDebugPort" select="backendless-codegen/application/blDebugPort"/>

    <xsl:template match="/">
        <folder name="{$projectName}">
            <folder name="src">
                <folder name="com">
                    <folder name="sample">
                       <folder name="api">
                           <file name="DemoService.java">
package com.sample.api;

import com.backendless.Backendless;
import com.backendless.servercode.IBackendlessService;

public class DemoService implements IBackendlessService
{
  public String getGreeting( String guestName )
  {
    System.out.println( "in get greeing" );
    return "Hello, " + guestName;
  }

  public String saveComment( DemoComment comment )
  {
    DemoComment savedComment = Backendless.Data.of( DemoComment.class ).save( comment );
    return Backendless.FootprintsManager.getObjectId( savedComment );
  }
}
                           </file>
                           <file name="DemoComment.java">
package com.sample.api;

public class DemoComment
{
  private String commentText;
  private String author;

  public String getCommentText()
  {
    return commentText;
  }

  public void setCommentText( String commentText )
  {
    this.commentText = commentText;
  }

  public String getAuthor()
  {
    return author;
  }

  public void setAuthor( String author )
  {
    this.author = author;
  }
}
                           </file>
                       </folder>
                    </folder>
                </folder>
            </folder>
            <folder name="libs">
                <file path="libs/backendless.jar"/>
                <file path="libs/readme.txt"/>
                <file path="libs/servlet-api-2.5.jar"/>
            </folder>
            <folder name="bin">
                <file path="bin/CodeRunner.bat"/>
                <file path="bin/CodeRunner.jar"/>
                <file path="bin/CodeRunner.sh"/>
                <file path="bin/Deploy.bat"/>
                <file path="bin/Deploy.sh"/>
                <file path="bin/weborb.jar"/>
                <file path="bin/security.policy"/>
                <file path="bin/logback.xml"/>
                <file name="runner.properties"># This is main configuration file for Code Runner

# Application id
application.id = <xsl:value-of select="$applicationId"/>

# CodeRunner API Key assigned by Backendless Console.
application.apiKey = <xsl:value-of select="$apiKey"/>

application.deployment.model = default

# Optional argument. Search path for classes which will be used for debugging or publishing.
# By default Code Runner looks for the ./build/classes directory located in the current directory
location.classes = ../classes/

# Optional argument. Search path for jar files which are the dependencies for the code which is debugged or published.
# By default Code Runner looks for the ./build/libs directory located in the current directory.
location.jar = ../libs/

# System properties
# Don't touch, if you do not really understand this
system.server.url = <xsl:value-of select="$serverURL"/>
system.redis.master.host = <xsl:value-of select="$blDebugHost"/>
system.redis.master.port = <xsl:value-of select="$blDebugPort"/>
system.pool.core = 20
system.type = LOCAL
system.repo.path = ../repo/

system.services.exclude.jar = backendless.jar,servlet-api-*.jar,weborb-*.jar
system.thread.manipulation.exclude.classes = weborb.cloud.AmazonBillingClient,sun.awt.AppContext$2,java.util.logging.LogRecord$CallerFinder,java.awt.image.ColorModel$1,com.sun.imageio.stream.StreamCloser$2,sun.java2d.Disposer,sun.net.www.http.KeepAliveCache$1,sun.net.www.protocol.http.HttpURLConnection,com.sun.net.ssl.HttpsURLConnection,sun.net.www.protocol.https.HttpsClient,sun.net.www.http.HttpClient,sun.net.www.http.KeepAliveCache,sun.security.ssl.SupportedGroupsExtension,sun.security.ssl.SupportedGroupsExtension$SupportedGroups,sun.security.ssl.SSLContextImpl,sun.security.ssl.SSLContextImpl$DefaultSSLContext,sun.security.ssl.SSLSocketImpl,jdk.internal.net.http.HttpClientImpl,jdk.internal.net.http.HttpClientImpl$DelegatingExecutor,jdk.internal.net.http.HttpClientImpl$DefaultThreadFactory,jdk.internal.net.http.HttpClientImpl$SelectorManager,jdk.internal.net.http.common.MinimalFuture,jdk.internal.net.http.PlainHttpConnection,jdk.internal.net.http.MultiExchange,jdk.internal.net.http.SocketTube,jdk.internal.net.http.common.SSLTube,jdk.internal.net.http.common.SSLTube$DelegateWrapper,jdk.internal.net.http.common.SSLTube$SSLSubscriberWrapper,jdk.internal.net.http.common.SubscriberWrapper,jdk.internal.net.http.common.SubscriberWrapper$DownstreamPusher,jdk.internal.net.http.common.SequentialScheduler,jdk.internal.net.http.common.SequentialScheduler$SynchronizedRestartableTask,jdk.internal.net.http.common.SequentialScheduler$SchedulableTask,jdk.internal.net.http.common.SSLFlowDelegate,jdk.internal.net.http.common.SSLFlowDelegate$Reader,jdk.internal.net.http.common.SSLFlowDelegate$Reader$ReaderDownstreamPusher,sun.net.www.protocol.https.DelegateHttpsURLConnection,sun.nio.ch.EPoll,sun.nio.ch.SelectorImpl

compression.enabled = false
                </file>
            </folder>
            <folder path="classes"/>
            <folder path=".idea"/>
            <file path="project-files/servercode.iml"/>
            <file path="project-files/servercode.ipr"/>
            <file name=".classpath">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
                &lt;classpath&gt;
                &lt;classpathentry kind="src" path="src"/&gt;
                &lt;classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/JavaSE-1.7"/&gt;
                &lt;classpathentry kind="lib" path="libs/backendless.jar"/&gt;
                &lt;classpathentry kind="output" path="classes"/&gt;
                &lt;/classpath&gt;</file>
            <file name=".project">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
                &lt;projectDescription&gt;
                &lt;name&gt;<xsl:value-of select="$applicationName"/>&lt;/name&gt;
                &lt;comment&gt;&lt;/comment&gt;
                &lt;projects&gt;
                &lt;/projects&gt;
                &lt;buildSpec&gt;
                &lt;buildCommand&gt;
                &lt;name&gt;org.eclipse.jdt.core.javabuilder&lt;/name&gt;
                &lt;arguments&gt;
                &lt;/arguments&gt;
                &lt;/buildCommand&gt;
                &lt;/buildSpec&gt;
                &lt;natures&gt;
                &lt;nature&gt;org.eclipse.jdt.core.javanature&lt;/nature&gt;
                &lt;/natures&gt;
                &lt;/projectDescription&gt;</file>
        </folder>
    </xsl:template>
</xsl:stylesheet>