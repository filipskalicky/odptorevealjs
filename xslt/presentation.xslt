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
    <xsl:apply-templates/>
</xsl:template>

<!-- Slide -->
<xsl:template match="draw:page[position() &lt;= (last() - 1)]">
    <xsl:apply-templates/>

++++
</xsl:template>

<!-- Poslední slide -->
<xsl:template match="draw:page[position() = last()]"><xsl:apply-templates/></xsl:template>

<!-- Nadpis 1 -->
<xsl:template match="draw:frame[@presentation:class='title']">
rozmery &lt;!-- {_class="hide rozmery" width="<xsl:value-of select="@svg:width" />" height="<xsl:value-of select="@svg:height" />" x="<xsl:value-of select="@svg:x" />" y="<xsl:value-of select="@svg:y" />" } --><xsl:text>

</xsl:text><xsl:variable name="framestylename" select='@presentation:style-name' />
    <xsl:variable name="drawstylename" select='@draw:text-style-name' />
    <xsl:for-each select=".//text:p">
        <xsl:variable name="pstylename" select='@text:style-name' /># &lt;!-- {_class="<xsl:value-of select="$framestylename" /><xsl:text> </xsl:text><xsl:value-of select="$drawstylename" /><xsl:text> </xsl:text><xsl:value-of select="$pstylename" />"} --><xsl:for-each select="./text:span">
        <xsl:variable name="spanstylename" select='@text:style-name' />
        <xsl:choose>
            <xsl:when test=".//text:line-break"> <xsl:call-template name="for">
                <xsl:with-param name="stop">
                    <xsl:value-of select="position()"/>
                </xsl:with-param>
            </xsl:call-template><xsl:text> </xsl:text><xsl:call-template name="for">
                <xsl:with-param name="stop">
                    <xsl:value-of select="position()"/>
                </xsl:with-param>
            </xsl:call-template>&lt;!-- {_class="newline"} --></xsl:when>
            <xsl:otherwise><xsl:call-template name="for">
                <xsl:with-param name="stop">
                    <xsl:value-of select="position()"/>
                </xsl:with-param>
            </xsl:call-template>
                <xsl:choose>
                    <xsl:when test="string-length(text()) = 0"><xsl:text> </xsl:text></xsl:when>
                    <xsl:otherwise><xsl:value-of select="text()" /><xsl:variable name="nullstring" select="'nullstring'" /></xsl:otherwise>
                </xsl:choose>
                <xsl:call-template name="for">
                    <xsl:with-param name="stop">
                        <xsl:value-of select="position()"/>
                    </xsl:with-param>
                </xsl:call-template>&lt;!-- {_class="<xsl:value-of select="$spanstylename" />"} --><xsl:text> </xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:for-each><xsl:text>
</xsl:text>
    </xsl:for-each><xsl:text>
</xsl:text>
</xsl:template>


<!--for cyklus-->
    <xsl:template name="for">
        <xsl:param name="start">1</xsl:param>
        <xsl:param name="stop">1</xsl:param>
        <xsl:param name="step">1</xsl:param>
        <xsl:text>`</xsl:text>
        <xsl:if test="$start &lt; $stop">
            <xsl:call-template name="for">
                <xsl:with-param name="stop">
                    <xsl:value-of select="$stop"/>
                </xsl:with-param>
                <xsl:with-param name="start">
                    <xsl:value-of select="$start + $step"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

<!-- Nadpis 2 -->
<xsl:template match="draw:frame[@presentation:class='subtitle']">
rozmery &lt;!-- {_class="hide rozmery" width="<xsl:value-of select="@svg:width" />" height="<xsl:value-of select="@svg:height" />" x="<xsl:value-of select="@svg:x" />" y="<xsl:value-of select="@svg:y" />" } --><xsl:text>

</xsl:text>
    <xsl:variable name="framestylename" select='@presentation:style-name' />
    <xsl:variable name="drawstylename" select='@draw:text-style-name' />
    <xsl:for-each select=".//text:p">
        <xsl:variable name="pstylename" select='@text:style-name' />## &lt;!-- {_class="<xsl:value-of select="$framestylename" /><xsl:text> </xsl:text><xsl:value-of select="$drawstylename" /><xsl:text> </xsl:text><xsl:value-of select="$pstylename" />"} --><xsl:for-each select="./text:span">
        <xsl:variable name="spanstylename" select='@text:style-name' />
        <xsl:choose>
            <xsl:when test=".//text:line-break"> <xsl:call-template name="for">
                <xsl:with-param name="stop">
                    <xsl:value-of select="position()"/>
                </xsl:with-param>
            </xsl:call-template><xsl:text> </xsl:text><xsl:call-template name="for">
                <xsl:with-param name="stop">
                    <xsl:value-of select="position()"/>
                </xsl:with-param>
            </xsl:call-template>&lt;!-- {_class="newline"} --></xsl:when>
            <xsl:otherwise><xsl:call-template name="for">
                <xsl:with-param name="stop">
                    <xsl:value-of select="position()"/>
                </xsl:with-param>
            </xsl:call-template>
                <xsl:choose>
                    <xsl:when test="string-length(text()) = 0"><xsl:text> </xsl:text></xsl:when>
                    <xsl:otherwise><xsl:value-of select="text()" /><xsl:variable name="nullstring" select="'nullstring'" /></xsl:otherwise>
                </xsl:choose>
                <xsl:call-template name="for">
                    <xsl:with-param name="stop">
                        <xsl:value-of select="position()"/>
                    </xsl:with-param>
                </xsl:call-template>&lt;!-- {_class="<xsl:value-of select="$spanstylename" />"} --><xsl:text> </xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:for-each><xsl:text>
</xsl:text>
    </xsl:for-each><xsl:text>
</xsl:text>
</xsl:template>

<!-- Tabulka-->
<xsl:template match="draw:frame/table:table">
rozmery &lt;!-- {_class="hide rozmery" width="<xsl:value-of select="@svg:width" />" height="<xsl:value-of select="@svg:height" />" x="<xsl:value-of select="@svg:x" />" y="<xsl:value-of select="@svg:y" />" } --><xsl:text>

</xsl:text>
    <xsl:for-each select="./table:table-row">
        <xsl:for-each select="./table:table-cell">
            <xsl:if test="not(position()=1)"> | </xsl:if>
            <xsl:value-of disable-output-escaping="no" select="."/>
<xsl:text disable-output-escaping="yes">&lt;!-- {_class="</xsl:text>
            <xsl:value-of select="./@table:style-name" />
            <xsl:text> </xsl:text>
            <xsl:value-of select="../@table:style-name" />
            <xsl:text>"} --></xsl:text>
        </xsl:for-each>
        <xsl:if test="position()=1"><xsl:text>
</xsl:text><xsl:for-each select="./table:table-cell"><xsl:if test="not(position()=1)"> | </xsl:if>--------------</xsl:for-each>
        </xsl:if>
        <xsl:text>
</xsl:text>
    </xsl:for-each>

<!--## <xsl:value-of select="../@draw:style-name"/>-->
<xsl:text>

</xsl:text>
</xsl:template>

<!-- Odrážky -->
<xsl:template match="draw:frame[@presentation:class='outline']">
rozmery &lt;!-- {_class="hide rozmery" width="<xsl:value-of select="@svg:width" />" height="<xsl:value-of select="@svg:height" />" x="<xsl:value-of select="@svg:x" />" y="<xsl:value-of select="@svg:y" />" } --><xsl:text>

</xsl:text>
    <xsl:variable name="framestylename" select='@presentation:style-name' />
    <xsl:variable name="drawstylename" select='@draw:text-style-name' />
    <xsl:for-each select=".//text:list-item">
        <xsl:variable name="liststylename" select='@text:style-name' />
- &lt;!-- {_class="<xsl:value-of select="$framestylename" /><xsl:text> </xsl:text><xsl:value-of select="$drawstylename" /><xsl:text> </xsl:text><xsl:value-of select="$liststylename" />"} --> <xsl:for-each select=".//text:p"><xsl:variable name="pstylename" select='@text:style-name' />
<xsl:for-each select="./text:span">
<xsl:variable name="spanstylename" select='@text:style-name' />
<xsl:choose>
<xsl:when test=".//text:line-break">
                        <xsl:call-template name="for">
                            <xsl:with-param name="stop">
                                <xsl:value-of select="position()"/>
                            </xsl:with-param>
                        </xsl:call-template>
                        <xsl:text> </xsl:text>
                        <xsl:call-template name="for">
                            <xsl:with-param name="stop">
                                <xsl:value-of select="position()"/>
                            </xsl:with-param>
                        </xsl:call-template>&lt;!-- _class="newline<xsl:text> </xsl:text><xsl:value-of select="$pstylename" /><xsl:text> </xsl:text><xsl:value-of select="$spanstylename" />"} --></xsl:when>
<xsl:otherwise><xsl:call-template name="for">
                        <xsl:with-param name="stop">
                            <xsl:value-of select="position()"/>
                        </xsl:with-param>
                    </xsl:call-template><xsl:choose>
<xsl:when test="string-length(text()) = 0"><xsl:text> </xsl:text></xsl:when>
<xsl:otherwise><xsl:value-of select="text()" /><xsl:variable name="nullstring" select="'nullstring'" /></xsl:otherwise>
                        </xsl:choose><xsl:call-template name="for">
                            <xsl:with-param name="stop">
                                <xsl:value-of select="position()"/>
                            </xsl:with-param>
                        </xsl:call-template>&lt;!-- {_class="<xsl:value-of select="$pstylename" /><xsl:text> </xsl:text><xsl:value-of select="$spanstylename" />"} --><xsl:text> </xsl:text></xsl:otherwise>
</xsl:choose></xsl:for-each></xsl:for-each>
    </xsl:for-each>
    <xsl:text>

</xsl:text>
</xsl:template>



<!-- Běžný text -->
<xsl:template match="draw:text-box">
rozmery &lt;!-- {_class="hide rozmery" width="<xsl:value-of select="../@svg:width" />" height="<xsl:value-of select="../@svg:height" />" x="<xsl:value-of select="../@svg:x" />" y="<xsl:value-of select="../@svg:y" />" } --><xsl:text>

</xsl:text>
    <xsl:for-each select=".//text:p">
        <xsl:text>

</xsl:text><xsl:value-of select="."/>
    </xsl:for-each>
</xsl:template>

<xsl:template match="draw:custom-shape">
rozmery &lt;!-- {_class="hide rozmery" width="<xsl:value-of select="@svg:width" />" height="<xsl:value-of select="@svg:height" />" x="<xsl:value-of select="@svg:x" />" y="<xsl:value-of select="@svg:y" />" } --><xsl:text>

</xsl:text>
    <xsl:for-each select=".//text:p">
        <xsl:text>

</xsl:text><xsl:value-of select="."/>
    </xsl:for-each>
</xsl:template>


<!-- Vodorovná čára -->
<!--<xsl:template match="draw:line">

-&#45;&#45;

<xsl:text disable-output-escaping="yes">&lt;!&#45;&#45; {_class="</xsl:text><xsl:value-of select="./@draw:style-name" /><xsl:text> </xsl:text> <xsl:value-of select="./@draw:text-style-name" /><xsl:text>"} &ndash;&gt;

</xsl:text>
</xsl:template>-->

</xsl:stylesheet>
