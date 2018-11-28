<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
                xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
                xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
                xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
                xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0"
                xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0"
                xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0"
                xmlns:presentation="urn:oasis:names:tc:opendocument:xmlns:presentation:1.0"
                xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0"
                xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0"
                xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0"
                xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0"
                xmlns:ooo="http://openoffice.org/2004/office"
                xmlns:ooow="http://openoffice.org/2004/writer"
                xmlns:oooc="http://openoffice.org/2004/calc"
                xmlns:dom="http://www.w3.org/2001/xml-events"
                xmlns:xforms="http://www.w3.org/2002/xforms"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:smil="urn:oasis:names:tc:opendocument:xmlns:smil-compatible:1.0"
                xmlns:anim="urn:oasis:names:tc:opendocument:xmlns:animation:1.0"
                xmlns:rpt="http://openoffice.org/2005/report"
                xmlns:of="urn:oasis:names:tc:opendocument:xmlns:of:1.2"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:grddl="http://www.w3.org/2003/g/data-view#"
                xmlns:officeooo="http://openoffice.org/2009/office"
                xmlns:tableooo="http://openoffice.org/2009/table"
                xmlns:drawooo="http://openoffice.org/2010/draw"
                xmlns:calcext="urn:org:documentfoundation:names:experimental:calc:xmlns:calcext:1.0"
                xmlns:loext="urn:org:documentfoundation:names:experimental:office:xmlns:loext:1.0"
                xmlns:field="urn:openoffice:names:experimental:ooo-ms-interop:xmlns:field:1.0"
                xmlns:formx="urn:openoffice:names:experimental:ooxml-odf-interop:xmlns:form:1.0"
                xmlns:css3t="http://www.w3.org/TR/css3-text/" office:version="1.2">
    <xsl:output method="text" />

    <xsl:template match="/">
        <xsl:apply-templates mode="sty"/>
    </xsl:template>

<xsl:template match="style:style[@style:family='paragraph']" mode="sty">.<xsl:value-of select="@style:name" />
<xsl:text> {
</xsl:text><xsl:apply-templates mode="atribut" /><xsl:text>
}

</xsl:text>
</xsl:template>
<xsl:template match="style:style[@style:family='text']" mode="sty">.<xsl:value-of select="@style:name" />
<xsl:text> {
</xsl:text>
        <xsl:apply-templates mode="atribut" />
    <xsl:text>
}

</xsl:text>
</xsl:template>


<xsl:template match="*" mode="atribut">
    <xsl:for-each select="@*">
        <xsl:choose>
        <xsl:when test="name()='fo:background-color'">
    background-color: <xsl:value-of select="." />!important;</xsl:when>
        <xsl:when test="name()='fo:color'">
    color: <xsl:value-of select="." />!important;</xsl:when>
        <xsl:when test="name()='fo:font-size'">
    font-size: calc( <xsl:value-of select="." /> * 0.85 )!important;</xsl:when>
        <xsl:when test="name()='fo:text-align'">
            <xsl:choose>
                <xsl:when test=".='start'">
    text-align: left!important;</xsl:when>
                <xsl:when test=".='end'">
    text-align: right!important;</xsl:when>
                <xsl:otherwise>
    text-align: <xsl:value-of select="." />!important;</xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:when test="name()='style:font-name'">
            <xsl:variable name="stylename" select="." />
            <xsl:variable name="stylefamily" select="//style:font-face[@style:name=$stylename]/@svg:font-family"/>
    font-family: <xsl:value-of select="$stylefamily" />!important;</xsl:when>
        <xsl:when test="name()='fo:line-height'">
    line-height: calc( <xsl:value-of select="." /> * 0.95 )!important;</xsl:when>
        </xsl:choose>
    </xsl:for-each>
</xsl:template>


</xsl:stylesheet>
