<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://exslt.org/math">
    <!-- @formatter:off -->

    <xsl:variable name="tab"><xsl:text>&#x09;</xsl:text></xsl:variable>
    <xsl:variable name='newline'><xsl:text>
</xsl:text></xsl:variable>

    <xsl:template name="toPackageName">
        <xsl:param name="str"/>
        <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
        <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
        <xsl:value-of select="translate(translate($str,' ',''), $uppercase, $smallcase)"/>
    </xsl:template>

    <xsl:template name="firstCharToUpperCase">
        <xsl:param name="str"/>
        <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
        <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
        <xsl:value-of select="concat(translate(substring($str,1,1), $smallcase, $uppercase),substring($str,2))"/>
    </xsl:template>

    <xsl:template name="firstCharToLowerCase">
        <xsl:param name="str"/>
        <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
        <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
        <xsl:value-of select="concat(translate(substring($str,1,1), $uppercase, $smallcase),substring($str,2))"/>
    </xsl:template>

    <xsl:template name="toUpperCase">
        <xsl:param name="str"/>
        <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
        <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
        <xsl:value-of select="translate($str, $smallcase, $uppercase)"/>
    </xsl:template>

    <xsl:template name="generateStoryboardId">
        <xsl:variable name="alphabet" select="'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
        <xsl:variable name="n" select="string-length($alphabet)"/>
        <xsl:value-of select="concat(
            substring($alphabet, floor(math:random() * $n - 1) + 1, 1),
            substring($alphabet, floor(math:random() * $n - 1) + 1, 1),
            substring($alphabet, floor(math:random() * $n - 1) + 1, 1),
            '-',
            substring($alphabet, floor(math:random() * $n - 1) + 1, 1),
            substring($alphabet, floor(math:random() * $n - 1) + 1, 1),
            '-',
            substring($alphabet, floor(math:random() * $n - 1) + 1, 1),
            substring($alphabet, floor(math:random() * $n - 1) + 1, 1),
            substring($alphabet, floor(math:random() * $n - 1) + 1, 1)
        )"/>
    </xsl:template>

    <xsl:template name="getJavaType">
        <xsl:param name="str"/>
        <xsl:choose>
            <xsl:when test="$str = 'UNKNOWN' or $str = 'STRING' or $str = 'STRING_ID' or $str = 'TEXT' or $str = 'FILE_REF' or $str = 'EXTENDED_STRING'">String</xsl:when>
            <xsl:when test="$str = 'INT' or $str = 'AUTO_INCREMENT'">Integer</xsl:when>
            <xsl:when test="$str = 'DOUBLE'">Double</xsl:when>
            <xsl:when test="$str = 'BOOLEAN'">Boolean</xsl:when>
            <xsl:when test="$str = 'DATETIME'">Date</xsl:when>
            <xsl:when test="$str = 'GEOMETRY'">Geometry</xsl:when>
            <xsl:when test="$str = 'POINT'">Point</xsl:when>
            <xsl:when test="$str = 'LINESTRING'">LineString</xsl:when>
            <xsl:when test="$str = 'POLYGON'">Polygon</xsl:when>
            <xsl:when test="$str = 'LOCATION'">Location</xsl:when>
            <xsl:when test="$str = 'PATH'">Path</xsl:when>
            <xsl:when test="$str = 'AREA'">Area</xsl:when>
            <xsl:when test="$str = 'COLLECTION' or $str = 'RELATION_LIST'">List</xsl:when>
            <xsl:otherwise>Object</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="GetTypeNET">
      <xsl:param name="str"/>
        <xsl:choose>
          <xsl:when test="$str = 'UNKNOWN' or $str = 'STRING' or $str = 'STRING_ID' or $str = 'TEXT' or $str = 'FILE_REF' or $str = 'EXTENDED_STRING'">String</xsl:when>
          <xsl:when test="$str = 'INT'">Int32</xsl:when>
          <xsl:when test="$str = 'DOUBLE'">Double</xsl:when>
          <xsl:when test="$str = 'BOOLEAN'">Boolean</xsl:when>
          <xsl:when test="$str = 'DATETIME'">DateTime</xsl:when>
          <xsl:when test="$str = 'GEOMETRY'">Geometry</xsl:when>
          <xsl:when test="$str = 'POINT'">Point</xsl:when>
          <xsl:when test="$str = 'LINESTRING'">LineString</xsl:when>
          <xsl:when test="$str = 'POLYGON'">Polygon</xsl:when>
          <xsl:when test="$str = 'PATH'">Path</xsl:when>
          <xsl:when test="$str = 'COLLECTION' or $str = 'RELATION_LIST'">List</xsl:when>
          <xsl:otherwise>Object</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="getDartType">
        <xsl:param name="str"/>
        <xsl:choose>
            <xsl:when test="$str = 'UNKNOWN' or $str = 'STRING' or $str = 'STRING_ID' or $str = 'TEXT' or $str = 'FILE_REF' or $str = 'EXTENDED_STRING'">String</xsl:when>
            <xsl:when test="$str = 'INT' or $str = 'AUTO_INCREMENT'">int</xsl:when>
            <xsl:when test="$str = 'DOUBLE'">double</xsl:when>
            <xsl:when test="$str = 'BOOLEAN'">bool</xsl:when>
            <xsl:when test="$str = 'DATETIME'">DateTime</xsl:when>
            <xsl:when test="$str = 'GEOMETRY'">Geometry</xsl:when>
            <xsl:when test="$str = 'POINT'">Point</xsl:when>
            <xsl:when test="$str = 'LINESTRING'">LineString</xsl:when>
            <xsl:when test="$str = 'POLYGON'">Polygon</xsl:when>
            <xsl:when test="$str = 'COLLECTION' or $str = 'RELATION_LIST'">List</xsl:when>
            <xsl:otherwise>Object</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="getIOSType">
        <xsl:param name="str"/>
        <xsl:choose>
            <xsl:when test="$str = 'UNKNOWN' or $str = 'STRING' or $str = 'STRING_ID' or $str = 'TEXT' or $str = 'FILE_REF' or $str = 'EXTENDED_STRING'">NSString</xsl:when>
            <xsl:when test="$str = 'INT' or $str = 'DOUBLE' or $str = 'BOOLEAN' or $str = 'AUTO_INCREMENT'">NSNumber</xsl:when>
            <xsl:when test="$str = 'DATETIME'">NSDate</xsl:when>
            <xsl:when test="$str = 'COLLECTION' or $str = 'RELATION_LIST'">NSArray</xsl:when>
            <xsl:otherwise>NSObject</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="getSwiftType">
        <xsl:param name="str"/>
        <xsl:choose>
            <xsl:when test="$str = 'UNKNOWN' or $str = 'STRING' or $str = 'STRING_ID' or $str = 'TEXT' or $str = 'FILE_REF' or $str = 'EXTENDED_STRING'">String</xsl:when>
            <xsl:when test="$str = 'INT' or $str = 'DOUBLE' or $str = 'BOOLEAN' or $str = 'AUTO_INCREMENT'">NSNumber</xsl:when>
            <xsl:when test="$str = 'DATETIME'">Date</xsl:when>
            <xsl:when test="$str = 'COLLECTION' or $str = 'RELATION_LIST'">NSArray</xsl:when>
            <xsl:otherwise>NSObject</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="getActionScriptType">
        <xsl:param name="str"/>
        <xsl:choose>
            <xsl:when test="$str = 'UNKNOWN' or $str = 'STRING' or $str = 'STRING_ID' or $str = 'TEXT' or $str = 'FILE_REF' or $str = 'EXTENDED_STRING'">String</xsl:when>
            <xsl:when test="$str = 'INT' or $str = 'DOUBLE' or $str = 'AUTO_INCREMENT'">Number</xsl:when>
            <xsl:when test="$str = 'BOOLEAN'">Boolean</xsl:when>
            <xsl:when test="$str = 'DATETIME'">Date</xsl:when>
            <xsl:when test="$str = 'COLLECTION' or $str = 'RELATION_LIST'">Array</xsl:when>
            <xsl:otherwise>Object</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>