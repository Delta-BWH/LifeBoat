<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   
    <!-- @formatter:off -->
    
    <xsl:import href="../util.xsl"/>

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>

    <xsl:template name="dataclassesSwift">
      <folder  hideContent="true" name="{$applicationName}-Data">
        <file  hideContent="true" path="backendless-codegen/Swift/DataClasses/README.txt"/>
        
         <folder  hideContent="true" name="{$applicationName}-Data">
           
         <xsl:for-each select="backendless-codegen/application/tables/table[name != 'Users']">
            <!-- .swift file for each table -->
            <file  hideContent="true" name="{name}.swift">
import UIKit
import Backendless

@objcMembers class <xsl:value-of select="name"/>: NSObject {

    <xsl:for-each select="columns"><xsl:if test="not(expression)">var <xsl:value-of select="name"/> : <xsl:call-template name="getSwiftType"><xsl:with-param name="str" select="dataType"/></xsl:call-template>?
    </xsl:if></xsl:for-each>
    
    <xsl:for-each select="columns"><xsl:if test="(expression)">private(set) var <xsl:value-of select="name"/> : <xsl:call-template name="getSwiftType"><xsl:with-param name="str" select="dataType"/></xsl:call-template>?
    </xsl:if></xsl:for-each>

                  <xsl:for-each select="relations">
                    <xsl:variable name="toTableName" select="toTableName"/>
                      <xsl:choose>
                        <xsl:when test="relationshipType = 'ONE_TO_ONE'">
                          <xsl:choose>
                            <xsl:when test="$toTableName = 'Users'">
    var <xsl:value-of select="name"/> : BackendlessUser?</xsl:when>
                            <xsl:otherwise>
    var <xsl:value-of select="name"/> : <xsl:value-of select="$toTableName"/>?
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:when>
                        <xsl:when test="relationshipType = 'ONE_TO_MANY'">
    var <xsl:value-of select="name"/> : [Any]?</xsl:when>
                    </xsl:choose>
                  </xsl:for-each>  
                  <xsl:for-each select="geoRelations">
                  <xsl:choose>
                    <xsl:when test="relationshipType = 'ONE_TO_ONE'">
    var <xsl:value-of select="name"/> : GeoPoint?</xsl:when>
                    <xsl:when test="relationshipType = 'ONE_TO_MANY'">
    var <xsl:value-of select="name"/> : [Any]?</xsl:when>
                  </xsl:choose>
                </xsl:for-each>
}
            </file>
          </xsl:for-each>
        </folder> 
      </folder>
    </xsl:template>
  </xsl:stylesheet>