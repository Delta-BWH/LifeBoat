<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->
    <xsl:import href="js-util.xsl"/>
    <xsl:include href="../util.xsl"/>

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="projectName"><xsl:value-of select="$applicationName"/>-CRUD</xsl:variable>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/JS"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>
    <xsl:variable name="tables" select="backendless-codegen/application/tables"/>
    <xsl:variable name="jsSdkLink" select="backendless-codegen/application/jsSDKLink"/>

    <xsl:template match="/">
        <folder name="{$projectName}">
            <folder path="backendless-codegen/data-service/css"/>
            <folder name="js">
                <file path="backendless-codegen/data-service/js/jquery.js"/>
                <file path="backendless-codegen/data-service/js/ace.js"/>
                <file path="backendless-codegen/data-service/js/data-example.js"/>

                <file name="factory.js">
function getRandomString() {
    return Math.random().toString(36).substr(2, 7);
}

function getRandomInRange(from, to, fixed) {
    return (Math.random() * (to - from) + from).toFixed(fixed) * 1;
}

$rootScope.tablesList = {
<xsl:for-each select="$tables/table[name != 'Users']"><xsl:value-of select="$tab"/><xsl:value-of select="name"/> : function(obj) {
<xsl:value-of select="$tab"/><xsl:value-of select="$tab"/>obj = obj || new $rootScope.Classes.<xsl:value-of select="name"/>();
<xsl:for-each select="columns">
<xsl:if test="(../../@type='internal' and name != 'created' and name != 'updated' and name != 'objectId' and name != 'ownerId' and not(expression)) or (../../@type='external' and isPrimaryKey = 'false')"><xsl:value-of select="$tab"/><xsl:value-of select="$tab"/>obj.<xsl:value-of select="name"/> = <xsl:choose>
<xsl:when test="dataType = 'DATETIME'">new Date();</xsl:when>
<xsl:when test="dataType = 'BOOLEAN'">true;</xsl:when>
<xsl:when test="dataType = 'INT' or dataType = 'AUTO_INCREMENT'">Number(Math.abs(Math.floor(Math.random()*Math.pow(10, 5) - 1)));</xsl:when>
<xsl:when test="dataType = 'DOUBLE'">Number(Math.abs(Math.floor(Math.random()*Math.pow(10, 5) - 1)));</xsl:when>
<xsl:when test="dataType = 'STRING' or dataType = 'TEXT'">String(Math.abs(Math.floor(Math.random()*Math.pow(10, 5) - 1)));</xsl:when>
<xsl:when test="dataType = 'GEO_POINT_COLLECTION'">[];</xsl:when>
<xsl:when test="dataType = 'GEO_POINT'">null;</xsl:when>
<xsl:when test="dataType = 'UNKNOWN'">String(Math.abs(Math.floor(Math.random()*Math.pow(10, 5) - 1)));</xsl:when>
<xsl:otherwise>
<xsl:if test="dataSize = '' or not(dataSize)">String(Math.abs(Math.floor(Math.random()*Math.pow(10, 5) - 1)));</xsl:if>
<xsl:if test="dataSize != ''">String(Math.abs(Math.floor(Math.random()*Math.pow(10, <xsl:value-of select="dataSize"/>) - 1)));</xsl:if>
</xsl:otherwise>
</xsl:choose><xsl:value-of select="$newline"/></xsl:if>
<xsl:if test="(../../@type='external' and isPrimaryKey = 'true')">
<xsl:value-of select="$tab"/><xsl:value-of select="$tab"/>if (!obj.hasOwnProperty('<xsl:value-of select="name"/>')) {<xsl:value-of select="$newline"/>
<xsl:value-of select="$tab"/><xsl:value-of select="$tab"/><xsl:value-of select="$tab"/>obj.<xsl:value-of select="name"/> = <xsl:choose>
<xsl:when test="dataType = 'DATETIME'">new Date();</xsl:when>
<xsl:when test="dataType = 'BOOLEAN'">true;</xsl:when>
<xsl:when test="dataType = 'INT' or dataType = 'AUTO_INCREMENT'">Number(Math.abs(Math.floor(Math.random()*Math.pow(10, 5) - 1)));</xsl:when>
<xsl:when test="dataType = 'DOUBLE'">Number(Math.abs(Math.floor(Math.random()*Math.pow(10, 5) - 1)));</xsl:when>
<xsl:when test="dataType = 'STRING' or dataType = 'TEXT'">String(Math.abs(Math.floor(Math.random()*Math.pow(10, 5) - 1)));</xsl:when>
<xsl:when test="dataType = 'GEO_POINT_COLLECTION'">[];</xsl:when>
<xsl:when test="dataType = 'GEO_POINT'">null;</xsl:when>
<xsl:when test="dataType = 'UNKNOWN'">String(Math.abs(Math.floor(Math.random()*Math.pow(10, 5) - 1)));</xsl:when>
<xsl:otherwise>
<xsl:if test="dataSize = '' or not(dataSize)">String(Math.abs(Math.floor(Math.random()*Math.pow(10, 5) - 1)));</xsl:if>
<xsl:if test="dataSize != ''">String(Math.abs(Math.floor(Math.random()*Math.pow(10, <xsl:value-of select="dataSize"/>) - 1)));</xsl:if>
</xsl:otherwise>
</xsl:choose><xsl:value-of select="$newline"/><xsl:value-of select="$tab"/><xsl:value-of select="$tab"/>}
</xsl:if>

</xsl:for-each>
<xsl:value-of select="$newline"/><xsl:value-of select="$tab"/><xsl:value-of select="$tab"/>return obj;
<xsl:value-of select="$tab"/>}<xsl:if test="position() &lt; last()"> <xsl:text>,</xsl:text><xsl:value-of select="$newline"/> </xsl:if>
</xsl:for-each>
};

$rootScope.createInstanceOf = function(table) {
    return tablesList[table]();
};</file>

                <file name="classes.js">
<xsl:call-template name="initApp"/>

function cleanPrivateRelations(data) {
    function isObject(obj) {
        return obj !== null &amp;&amp; typeof obj === 'object';
    }

    if (data.hasOwnProperty('_private_relations') &amp;&amp; data['_private_relations'].length > 0) {
            data['_private_relations'].forEach(function(relation) {
                if (data.hasOwnProperty(relation) &amp;&amp; isObject(data[relation])) {
                    if (Array.isArray(data[relation])) {
                        data[relation].forEach(function(elem) {
                            if (isObject(elem)) {
                                cleanPrivateRelations(elem);
                            }
                        });
                    } else {
                        cleanPrivateRelations(data[relation]);
                }
            }
        });
    }

    if (isObject(data)) {
        delete data['_private_relations'];
        delete data['_private_geoRelations'];
        delete data['_private_dates'];
    }
}

$rootScope.Classes = {
<xsl:for-each select="$tables/table[name != 'Users']"><xsl:value-of select="name"/>: function <xsl:value-of select="name"/>( args ){
    args = args || {};
    this._private_relations = [<xsl:for-each select="relations">
    "<xsl:value-of select="name"/>"<xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>];
    this._private_geoRelations = [<xsl:for-each select="geoRelations">
        "<xsl:value-of select="name"/>"<xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>];
    this._private_dates = [<xsl:for-each select="columns[dataType = 'DATETIME']">
        "<xsl:value-of select="name"/>"<xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>];
    this.___class = "<xsl:value-of select="name"/>";

    <xsl:for-each select="relations">
    this.<xsl:value-of select="name"/> = args.<xsl:value-of select="name"/> || null;
    </xsl:for-each>
    var storage = Backendless.Persistence.of( <xsl:value-of select="name"/> );
    this.save = function ( async ) {
        cleanPrivateRelations(this);
        storage.save( this, async );
    };
    this._private_describeClass = function(){
        return Backendless.Persistence.describe(this.___class);
    };
    this.remove = function ( async ) {
        var result = storage.remove( this, async );
        this.objectId = null;
        return result;
    };
    <xsl:for-each select="relations">
        <xsl:choose>
            <xsl:when test="relationshipType = 'ONE_TO_MANY'">
    this.addItemTo<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template> = function ( item )
                {
                if( this.<xsl:value-of select="name"/> == null )
                    this.<xsl:value-of select="name"/> = [];

                this.<xsl:value-of select="name"/>.push( item );
                return this.<xsl:value-of select="name"/>;
    };

    this.removeItemFrom<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template> = function ( item, async )
                {
                if( this.<xsl:value-of select="name"/> == null )
                    storage.loadRelations( this, ['<xsl:value-of select="name"/>'] );

                for( var j = 0; j &lt; this.<xsl:value-of select="name"/>.length; j++ )
                {
                if( this.<xsl:value-of select="name"/>[j].objectId === item.objectId )
                {
                this.<xsl:value-of select="name"/>.splice( j, j + 1 );
                this.save( async );
                break;
                }
                }
    };
    this.removeAll<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template> = function ( async )
                {
                this.<xsl:value-of select="name"/> = null;
                this.save( async );
    };

    this.get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template> = function ()
                {
                if( this.<xsl:value-of select="name"/> == null )
                storage.loadRelations( this, ['<xsl:value-of select="name"/>'] );

                return this.<xsl:value-of select="name"/>;
    };
            </xsl:when>
            <xsl:when test="relationshipType = 'ONE_TO_ONE'">
    this.get<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template> = function ()
                {
                if( this.<xsl:value-of select="name"/> == null )
                storage.loadRelations( this, ['<xsl:value-of select="name"/>'] );

                return this.<xsl:value-of select="name"/>;
    };
            </xsl:when>
        </xsl:choose>
    </xsl:for-each>
   }<xsl:if test="position() != last()">,</xsl:if></xsl:for-each>
}

Object.keys($rootScope.Classes).forEach(className => {
    Backendless.Data.mapTableToClass(className, $rootScope.Classes[className])
})</file>
 </folder>

            <file name="index.html">&lt;!DOCTYPE html&gt;
&lt;html lang="en"&gt;
    &lt;head&gt;
        &lt;meta charset="utf-8"&gt;
        &lt;meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"&gt;
        &lt;title&gt;<xsl:value-of select="$projectName"/>&lt;/title&gt;
        &lt;link rel="stylesheet" href="css/bootstrap.css"&gt;
        &lt;link rel="stylesheet" href="css/jquery-ui.css"&gt;
        &lt;link rel="stylesheet" href="css/data.css"&gt;
        &lt;script src="js/jquery.js"&gt;&lt;/script&gt;
        &lt;script type="text/javascript"&gt;var $rootScope = window;&lt;/script&gt;
        &lt;script src="https://<xsl:value-of select="$jsSdkLink"/>"&gt;&lt;/script&gt;
    &lt;/head&gt;
    &lt;body&gt;
        &lt;div class="navbar navbar-inverse navbar-static-top"&gt;
            &lt;div class="navbar-inner"&gt;
                &lt;div class="container"&gt;
                    &lt;h4&gt;Create, Retrieve, Update, Delete Data Objects&lt;/h4&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
        &lt;div id="myCarousel" class="carousel"&gt;
            &lt;div class="carousel-inner"&gt;
                &lt;div class="item active index"&gt;
                    &lt;div class="wrapper"&gt;
                        &lt;div class="container"&gt;
                            &lt;div class="container"&gt;
                                &lt;h4&gt;Tables&lt;/h4&gt;

                                &lt;div class="inner"&gt;
                                    &lt;div class="tables"&gt;
                                    <xsl:for-each select="$tables/table[name != 'Users']">
                                        &lt;div class="block" id="<xsl:value-of select="name"/>" onclick="goToOperationMenu('<xsl:value-of select="name"/>')"&gt;<xsl:value-of select="name"/>&lt;/div&gt;
                                    </xsl:for-each>
                                    &lt;/div&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;

                &lt;div class="item operations"&gt;
                    &lt;div class="wrapper"&gt;
                        &lt;div class="container"&gt;
                            &lt;div class="container"&gt;
                                &lt;h4&gt;Operations&lt;/h4&gt;

                                &lt;div class="inner"&gt;
                                    &lt;div class="tables"&gt;
                                        &lt;div class="block" onclick="cudOperation('Create')"&gt;Create&lt;/div&gt;
                                        &lt;div class="block" onclick="showHide('.retrieve', '.operations')"&gt;Retrieve&lt;/div&gt;
                                        &lt;div class="block" onclick="cudOperation('Update')"&gt;Update&lt;/div&gt;
                                        &lt;div class="block" onclick="cudOperation('Delete')"&gt;Delete&lt;/div&gt;
                                    &lt;/div&gt;
                                    &lt;div class="center"&gt;
                                        &lt;button class="back" style="margin:10px 50px"
                                                onclick="showHide('.index','.operations')"&gt;Back
                                        &lt;/button&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;

                &lt;div class="item retrieve"&gt;
                    &lt;div class="wrapper"&gt;
                        &lt;div class="container"&gt;
                            &lt;div class="container"&gt;
                                &lt;h4&gt;Retrieve &lt;span class="table"&gt;&lt;/span&gt; Samples&lt;/h4&gt;

                                &lt;div class="inner"&gt;
                                    &lt;div class="tables"&gt;
                                        &lt;div class="block" onclick="simpleFind('find')"&gt;Basic Find&lt;/div&gt;
                                        &lt;div class="block" onclick="simpleFind('findFirst')"&gt;Find First&lt;/div&gt;
                                        &lt;div class="block" onclick="simpleFind('findLast')"&gt;Find Last&lt;/div&gt;
                                        &lt;div class="block" onclick="complexFind('findSort')"&gt;Find with Sort&lt;/div&gt;
                                        &lt;div class="block" onclick="complexFind('findRel')"&gt;Find with Relations&lt;/div&gt;
                                    &lt;/div&gt;
                                    &lt;div class="center"&gt;
                                        &lt;button class="back" style="margin:10px 50px"
                                                onclick="showHide('.operations','.retrieve')"&gt;Back
                                        &lt;/button&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;

                &lt;div class="item info" id="info"&gt;
                    &lt;div class="wrapper"&gt;
                        &lt;div class="container"&gt;
                            &lt;div class="container"&gt;
                                &lt;h4&gt;Success&lt;/h4&gt;

                                &lt;div class="inner" style="padding:10px 0"&gt;
                                    &lt;div class="textarea"&gt;
                                        Record has been &lt;span id="action"&gt;&lt;/span&gt;.&lt;br/&gt;
                                    &lt;/div&gt;
                                    &lt;div class="center"&gt;
                                        &lt;button class="back" style="margin:10px 50px"
                                                onclick="showHide('#cudOperation','#info')"&gt;Back
                                        &lt;/button&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
                &lt;div class="item sendMail" id="sendByMail"&gt;
                    &lt;div class="wrapper"&gt;
                        &lt;div class="container"&gt;
                            &lt;div class="container"&gt;
                                &lt;h4&gt;Send Code by Email&lt;/h4&gt;

                                &lt;div class="inner" style="padding:10px 10px"&gt;
                                    &lt;label for="email"&gt;Email address:&lt;/label&gt;
                                    &lt;input type="text" id="email" /&gt;
                                    &lt;button style="margin: 5px 0;position: relative;top: -5px;min-width: 100px;"
                                            class="sendCodeByEmail" onclick="sendMail()"&gt;Send
                                    &lt;/button&gt;
                                    &lt;div class="center" id="cudSendMail"&gt;
                                        &lt;button class="back" style="margin:10px 50px"
                                                onclick="showHide('#cudOperation','#sendByMail')"&gt;Back
                                        &lt;/button&gt;
                                    &lt;/div&gt;
                                    &lt;div class="center" id='simpleFindSendMail'&gt;
                                        &lt;button class="back" style="margin:10px 50px"
                                                onclick="showHide('#simpleFind','#sendByMail')"&gt;Back
                                        &lt;/button&gt;
                                    &lt;/div&gt;
                                    &lt;div class="center" id='complexFindSendMail'&gt;
                                        &lt;button class="back" style="margin:10px 50px"
                                                onclick="showHide('#complexFind','#sendByMail')"&gt;Back
                                        &lt;/button&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;

                &lt;div class="item" id="cudOperation"&gt;
                    &lt;div class="wrapper"&gt;
                        &lt;div class="container cudOperator"&gt;
                            &lt;h4&gt;&lt;span class="type"&gt;&lt;/span&gt;&lt;span class="table"&gt;&lt;/span&gt;&lt;/h4&gt;

                            &lt;div class="inner" style="padding:10px 0"&gt;
                                &lt;div class="edWrapper"&gt;
                                    &lt;div id="editor"&gt;&lt;/div&gt;
                                    &lt;pre class="createPre"&gt;Backendless.initApp(  <xsl:value-of
                        select="$applicationId"/>, <xsl:value-of select="$apiKey"/> );
var My&lt;span class='table'&gt;&lt;/span&gt; = new &lt;span class='table'&gt;&lt;/span&gt;("sampleObj");
Backendless.Persistence.of(&lt;span class='table'&gt;&lt;/span&gt;).save(My&lt;span class='table'&gt;&lt;/span&gt;);
                                    &lt;/pre&gt;
                                    &lt;pre class="updatePre"&gt;Backendless.initApp(  <xsl:value-of
                        select="$applicationId"/>, <xsl:value-of select="$apiKey"/> );
var storage = Backendless.Persistence.of( &lt;span class='table'&gt;&lt;/span&gt; );
var My&lt;span class='table'&gt;&lt;/span&gt; = new &lt;span class='table'&gt;&lt;/span&gt;({updated: new Date(),created: new Date(),objectId: "sample_objectId",ownerId: "sample_ownerId"}));
storage.save(My&lt;span class='table'&gt;&lt;/span&gt;);
saved&lt;span class='table'&gt;&lt;/span&gt;["sampleProperty"] = "sample_value,
storage.save(My&lt;span class='table'&gt;&lt;/span&gt;);&lt;/pre&gt;
                                    &lt;pre class="deletePre"&gt;Backendless.initApp(  <xsl:value-of
                        select="$applicationId"/>, <xsl:value-of select="$apiKey"/> );
var storage = Backendless.Persistence.of( &lt;span class='table'&gt;&lt;/span&gt; );
var My&lt;span class='table'&gt;&lt;/span&gt;= new &lt;span class='table'&gt;&lt;/span&gt;({updated: new Date(),created: new Date(),objectId: "sample_objectId",ownerId: "sample_ownerId"
}));
storage.save(My&lt;span class='table'&gt;&lt;/span&gt;);
storage.remove(My&lt;span class='table'&gt;&lt;/span&gt;);&lt;/pre&gt;
                                &lt;/div&gt;
                                &lt;div class="center"&gt;
                                    &lt;button onclick="runCode()"&gt;Run Code&lt;/button&gt;
                                &lt;/div&gt;
                                &lt;div class="center"&gt;
                                    &lt;button onclick="showHide('#sendByMail','#cudOperation')"&gt;Send Code by Email&lt;/button&gt;
                                &lt;/div&gt;
                                &lt;div class="center"&gt;
                                    &lt;button class="back" style="margin:10px 50px" onclick="showHide('.operations','#cudOperation')"&gt;Back&lt;/button&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;

                &lt;div class="item" id="simpleFind"&gt;
                    &lt;div class="wrapper"&gt;
                        &lt;div class="container simpleFind"&gt;
                            &lt;h4&gt;Retrieve &lt;span class="table"&gt;&lt;/span&gt;objects&lt;/h4&gt;

                            &lt;div class="inner" style="padding:10px 0"&gt;
                                &lt;div class="edWrapper"&gt;
                                    &lt;div id="editor2"&gt;&lt;/div&gt;
                                    &lt;pre&gt;Backendless.initApp(  <xsl:value-of
                        select="$applicationId"/>, <xsl:value-of select="$apiKey"/> );
Backendless.Persistence.of(&lt;span class="table"&gt;&lt;/span&gt;).&lt;span class="method"&gt;&lt;/span&gt;();&lt;/pre&gt;
                                &lt;/div&gt;
                                &lt;div class="center"&gt;
                                    &lt;button onclick="runSimpleFindCode()"&gt;Run Code&lt;/button&gt;
                                &lt;/div&gt;
                                &lt;div class="center"&gt;
                                    &lt;button onclick="showHide('#sendByMail','#simpleFind')"&gt;Send Code by Email&lt;/button&gt;
                                &lt;/div&gt;
                                &lt;div class="center"&gt;
                                    &lt;button class="back" style="margin:10px 50px" onclick="showHide('.retrieve','#simpleFind')"&gt;Back&lt;/button&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;

                &lt;div class="item" id="complexFind"&gt;
                    &lt;div class="wrapper"&gt;
                        &lt;div class="container complexFind"&gt;
                            &lt;h4&gt;Retrieve objects&lt;/h4&gt;

                            &lt;div class="inner" style="padding:10px 0"&gt;
                                &lt;div class="edWrapper"&gt;
                                    &lt;div id="editor3"&gt;&lt;/div&gt;
                                    &lt;pre&gt;Backendless.initApp( '<xsl:value-of
                        select="$applicationId"/>', '<xsl:value-of select="$apiKey"/>' );
var dataQuery = Backendless.DataQueryBuilder.create();
dataQuery.setRelated(checkedRelations);
Backendless.Persistence.of('&lt;span class="table"&gt;&lt;/span&gt;').find(dataQuery);&lt;/pre&gt;
                                &lt;/div&gt;
                                &lt;div class="center"&gt;
                                    &lt;button onclick="runComplexFindCode()"&gt;Run Code&lt;/button&gt;
                                &lt;/div&gt;
                                &lt;div class="center"&gt;
                                    &lt;button onclick="showHide('#sendByMail','#complexFind')"&gt;Send Code by Email&lt;/button&gt;
                                &lt;/div&gt;
                                &lt;div class="center"&gt;
                                    &lt;button class="back" style="margin:10px 50px" onclick="showHide('#complexFindCheck','#complexFind')"&gt;Back&lt;/button&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;

                &lt;div class="item" id="complexFindCheck"&gt;
                    &lt;div class="wrapper"&gt;
                        &lt;div class="container"&gt;
                            &lt;div class="container"&gt;
                                &lt;h4&gt;Check fields&lt;/h4&gt;

                                &lt;div class="inner"&gt;
                                    &lt;div class="attrs"&gt;&lt;/div&gt;
                                    &lt;div class="center"&gt;
                                        &lt;button class="back" style="margin:10px 50px"
                                                onclick="showHide('.retrieve','#complexFindCheck')"&gt;Back
                                        &lt;/button&gt;
                                        &lt;button
                                                onclick="showExampleSort()"&gt;Find
                                        &lt;/button&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;

                &lt;div class="item" id="attrContainer"&gt;
                    &lt;div class="wrapper"&gt;
                        &lt;div class="container"&gt;
                            &lt;div class="container"&gt;
                                &lt;h4&gt;Attributes&lt;/h4&gt;

                                &lt;div class="inner"&gt;
                                    &lt;div class="attrs"&gt;
                                        &lt;div class="simpleFindHTML"&gt;&lt;/div&gt;
                                        &lt;div class="center"&gt;
                                            &lt;button class="back" style="margin:10px 50px"
                                                    onclick="showHide('#simpleFind','#attrContainer')"&gt;Back
                                            &lt;/button&gt;
                                        &lt;/div&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;

                &lt;div class="item" id="attrContainerSort"&gt;
                    &lt;div class="wrapper"&gt;
                        &lt;div class="container"&gt;
                            &lt;div class="container"&gt;
                                &lt;h4&gt;Attributes&lt;/h4&gt;

                                &lt;div class="inner"&gt;
                                    &lt;div class="attrs"&gt;&lt;/div&gt;
                                    &lt;div class="center"&gt;
                                        &lt;button class="back" style="margin:10px 50px"
                                                onclick="showHide('#complexFind','#attrContainerSort')"&gt;Back
                                        &lt;/button&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;

                &lt;div class="item" id="attrContainerRel"&gt;
                    &lt;div class="wrapper"&gt;
                        &lt;div class="container"&gt;
                            &lt;div class="container"&gt;
                                &lt;h4&gt;Attributes&lt;/h4&gt;

                                &lt;div class="inner"&gt;
                                    &lt;div class="attrs"&gt;
                                        &lt;div class="attrsCont"&gt;&lt;/div&gt;
                                        &lt;div class="center"&gt;
                                            &lt;button class="back" style="margin:10px 50px"
                                                    onclick="showHide('#complexFind','#attrContainerRel')"&gt;Back
                                            &lt;/button&gt;
                                        &lt;/div&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;

                &lt;div class="item" id="uniqueAttrContainer"&gt;
                    &lt;div class="wrapper"&gt;
                        &lt;div class="container"&gt;
                            &lt;div class="container"&gt;
                                &lt;h4&gt;Values&lt;/h4&gt;

                                &lt;div class="inner"&gt;
                                    &lt;div class="attrs"&gt;&lt;/div&gt;
                                    &lt;div class="center"&gt;
                                        &lt;button class="back" style="margin:10px 50px"
                                                onclick="showHide('#attrContainer','#uniqueAttrContainer')"&gt;Back
                                        &lt;/button&gt;
                                    &lt;/div&gt;
                                    &lt;div class="center"&gt;
                                        &lt;button class="back" style="margin:10px 50px"
                                                onclick="showHide('#simpleFind','#uniqueAttrContainer')"&gt;Back
                                        &lt;/button&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;

                &lt;div class="item" id="sortAttrContainer"&gt;
                    &lt;div class="wrapper"&gt;
                        &lt;div class="container"&gt;
                            &lt;div class="container"&gt;
                                &lt;h4&gt;Values&lt;/h4&gt;

                                &lt;div class="inner"&gt;
                                    &lt;div class="attrs"&gt;&lt;/div&gt;
                                    &lt;div class="center"&gt;
                                        &lt;button class="back" style="margin:10px 50px"
                                                onclick="showHide('#attrContainerSort','#sortAttrContainer')"&gt;Back
                                        &lt;/button&gt;
                                    &lt;/div&gt;
                                    &lt;div class="center"&gt;
                                        &lt;button class="back" style="margin:10px 50px"
                                                onclick="showHide('#attrContainerRel','#sortAttrContainer')"&gt;Back
                                        &lt;/button&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;

            &lt;/div&gt;
        &lt;/div&gt;
        &lt;script src="js/ace.js" type="text/javascript" charset="utf-8"&gt;&lt;/script&gt;
        &lt;script type="text/javascript" src="js/classes.js"&gt;&lt;/script&gt;
        &lt;script type="text/javascript" src="js/data-example.js"&gt;&lt;/script&gt;
        &lt;script type="text/javascript" src="js/factory.js"&gt;&lt;/script&gt;
    &lt;/body&gt;
&lt;/html&gt;</file>

        </folder>
    </xsl:template>
</xsl:stylesheet>
