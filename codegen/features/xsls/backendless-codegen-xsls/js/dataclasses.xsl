<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->
    <xsl:import href="js-util.xsl"/>
    <xsl:include href="../util.xsl"/>

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="projectName"><xsl:value-of select="$applicationName"/>-Data</xsl:variable>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/JS"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>

    <xsl:template match="/">
        <folder name="{$projectName}">
            <folder name="js">

                <file name="{$projectName}.js">
<xsl:call-template name="initApp"/>

var $rootScope = window;

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
  <xsl:for-each select="backendless-codegen/application/tables/table[name != 'Users']"><xsl:value-of select="name"/>: function <xsl:value-of select="name"/>( args ){
    args = args || {};
    <xsl:for-each select="columns">
    <xsl:if test="not(expression)">
    this.<xsl:value-of select="name"/> = args.<xsl:value-of select="name"/> || null;
    </xsl:if>
    </xsl:for-each>

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

    this.save = function ()
    {
        cleanPrivateRelations(this);
        storage.save( this );
    };

    this.remove = function ()
    {
        storage.remove( this ).then(result => {
            this.objectId = null;
            return result;
        });
    };

    this._private_describeClass = function(){
        return Backendless.Persistence.describe(this.___class);
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
}</file>

            </folder>

        </folder>
    </xsl:template>
</xsl:stylesheet>
