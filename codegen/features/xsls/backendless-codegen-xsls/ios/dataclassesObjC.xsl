<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   
    <!-- @formatter:off -->
    
    <xsl:import href="../util.xsl"/>

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>

    <xsl:template name="dataclassesObjC">
      <folder  hideContent="true" name="{$applicationName}-Data">
        <file  hideContent="true" path="backendless-codegen/ObjC/DataClasses/README.txt"/>
        
        <folder  hideContent="true" name="{$applicationName}-Data">
          
          <xsl:for-each select="backendless-codegen/application/tables/table[name != 'Users']">
            
            <!-- .h file for each table -->
            <file  hideContent="true" name="{name}.h">
#import &lt;Foundation/Foundation.h&gt;
#import &lt;Backendless/Backendless-Swift.h&gt;

<xsl:if test="relations[toTableName = 'Users']"> @class BackendlessUser;
</xsl:if>
<xsl:if test="geoRelations">@class GeoPoint;
</xsl:if>
<xsl:for-each select="relations[toTableName != 'Users']"><xsl:variable name="toTableName" select="toTableName"/>@class <xsl:value-of select="$toTableName"/>;
</xsl:for-each>
@interface <xsl:value-of select="name"/>: NSObject
                <xsl:for-each select="columns"><xsl:if test="not(expression)">
@property (nonatomic, strong) <xsl:call-template name="getIOSType"><xsl:with-param name="str" select="dataType"/></xsl:call-template> *<xsl:value-of select="name"/>;</xsl:if></xsl:for-each>
                <xsl:for-each select="columns"><xsl:if test="(expression)">
@property (nonatomic, strong, readonly) <xsl:call-template name="getIOSType"><xsl:with-param name="str" select="dataType"/></xsl:call-template> *<xsl:value-of select="name"/>;</xsl:if></xsl:for-each>
                
                <xsl:for-each select="relations">
                  <xsl:variable name="toTableName" select="toTableName"/>
                  <xsl:choose>
                    <xsl:when test="relationshipType = 'ONE_TO_ONE'">
                      <xsl:choose>
                        <xsl:when test="$toTableName = 'Users'">
@property (nonatomic, strong) BackendlessUser *<xsl:value-of select="name"/>;</xsl:when>
                        <xsl:otherwise>
@property (nonatomic, strong) <xsl:value-of select="$toTableName"/> *<xsl:value-of select="name"/>;
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:when>
                    <xsl:when test="relationshipType = 'ONE_TO_MANY'">
@property (nonatomic, strong) NSMutableArray *<xsl:value-of select="name"/>;</xsl:when>
                  </xsl:choose>
              </xsl:for-each>
              <xsl:for-each select="geoRelations">
                  <xsl:choose>
                    <xsl:when test="relationshipType = 'ONE_TO_ONE'">
@property (nonatomic, strong) GeoPoint *<xsl:value-of select="name"/>;</xsl:when>
                    <xsl:when test="relationshipType = 'ONE_TO_MANY'">
@property (nonatomic, strong) NSMutableArray *<xsl:value-of select="name"/>;</xsl:when>
                  </xsl:choose>
                </xsl:for-each>
              
@end
            </file>
            
            <!-- .m file for each table -->
            <file  hideContent="true" name="{name}.m">
#import "<xsl:value-of select="name"/>.h"

@implementation <xsl:value-of select="name"/>

@end
            </file>
          </xsl:for-each>
        </folder>
      </folder>
    </xsl:template>
</xsl:stylesheet>