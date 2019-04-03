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
    <xsl:param name="oddelovac" select="'\n\n++++\n'"/>
    <xsl:output method="text" />

<xsl:template match="/" priority="3">
    <xsl:apply-templates select="*">
         <xsl:with-param name="odsazeni">0</xsl:with-param>
    </xsl:apply-templates>
</xsl:template>

<!--office:document-content-->
<xsl:template match="office:document-content" priority="3">
    <xsl:param name="odsazeni" />
<xsl:apply-templates select="*">
        <xsl:with-param name="odsazeni"><xsl:value-of select="$odsazeni" /></xsl:with-param>
      </xsl:apply-templates>
</xsl:template>

<!--office:body-->
<xsl:template match="office:body" priority="3">
    <xsl:param name="odsazeni" />
<xsl:apply-templates select="*">
        <xsl:with-param name="odsazeni"><xsl:value-of select="$odsazeni" /></xsl:with-param>
      </xsl:apply-templates>
</xsl:template>

<!--office:presentation-->
<xsl:template match="office:presentation" priority="3">
    <xsl:param name="odsazeni" />
<xsl:apply-templates select="*">
        <xsl:with-param name="odsazeni"><xsl:value-of select="$odsazeni" /></xsl:with-param>
      </xsl:apply-templates>
</xsl:template>

<!--draw:page-->
<xsl:template match="draw:page[position() &lt;= (last() - 1)]" priority="3">
    <xsl:param name="odsazeni" />
<xsl:apply-templates select="*">
        <xsl:with-param name="odsazeni"><xsl:value-of select="$odsazeni" /></xsl:with-param>
      </xsl:apply-templates>
<xsl:text>

</xsl:text>
<xsl:value-of select="$oddelovac" />
</xsl:template>

<xsl:template match="draw:page[position() = last()]" priority="3">
    <xsl:param name="odsazeni" />
<xsl:apply-templates select="*">
        <xsl:with-param name="odsazeni"><xsl:value-of select="$odsazeni" /></xsl:with-param>
      </xsl:apply-templates>
</xsl:template>

<!--draw:frame-->
<xsl:template match="draw:frame" priority="3">
    <xsl:param name="odsazeni" />
    <xsl:param name="styl" />
    <xsl:variable name="framestylename" select='@presentation:style-name' />
    <xsl:variable name="drawstylename" select='@draw:text-style-name' />
    <xsl:text>

</xsl:text>
<xsl:call-template name="for">
    <xsl:with-param name="stop">
        <xsl:value-of select="$odsazeni"/>
    </xsl:with-param>
</xsl:call-template>rozmery &lt;!-- {_class="hide rozmery" width="<xsl:value-of select="@svg:width" />" height="<xsl:value-of select="@svg:height" />" x="<xsl:value-of select="@svg:x" />" y="<xsl:value-of select="@svg:y" />" } -->
    <xsl:variable name="nadrazeny" >
        <xsl:choose>
            <xsl:when test="@presentation:class='title'"><xsl:text>h1</xsl:text></xsl:when>
            <xsl:when test="@presentation:class='subtitle'"><xsl:text>h2</xsl:text></xsl:when>
            <xsl:otherwise><xsl:text></xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
<xsl:apply-templates select="*">
    <xsl:with-param name="odsazeni"><xsl:value-of select="$odsazeni" /></xsl:with-param>
    <xsl:with-param name="styl"><xsl:value-of select="$styl" /><xsl:text> </xsl:text><xsl:value-of select="$framestylename" /><xsl:text> </xsl:text><xsl:value-of select="$drawstylename" /></xsl:with-param>
    <xsl:with-param name="nadrazeny"><xsl:value-of select="$nadrazeny" /></xsl:with-param>
</xsl:apply-templates>
</xsl:template>

<!--draw:text-box-->
<xsl:template match="draw:text-box" priority="3">
    <xsl:param name="odsazeni" />
    <xsl:param name="styl" />
    <xsl:param name="nadrazeny" />
    <xsl:variable name="framestylename" select='@presentation:style-name' />
    <xsl:variable name="drawstylename" select='@draw:text-style-name' />
    <xsl:text></xsl:text>
<xsl:call-template name="for">
    <xsl:with-param name="stop">
        <xsl:value-of select="$odsazeni"/>
    </xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="*">
    <xsl:with-param name="odsazeni"><xsl:value-of select="$odsazeni" /></xsl:with-param>
    <xsl:with-param name="styl"><xsl:value-of select="$styl" /><xsl:text> </xsl:text><xsl:value-of select="$framestylename" /><xsl:text> </xsl:text><xsl:value-of select="$drawstylename" /></xsl:with-param>
    <xsl:with-param name="nadrazeny"><xsl:value-of select="$nadrazeny" /></xsl:with-param>
</xsl:apply-templates>
</xsl:template>

<!--text:p-->
<xsl:template match="text:p" priority="3">
    <xsl:param name="odsazeni" />
    <xsl:param name="styl" />
    <xsl:param name="nadrazeny" />
    <xsl:variable name="textstylename" select='@text:style-name' />
    <xsl:choose>
    <xsl:when test="$nadrazeny = 'li' or $nadrazeny = 'table'"><xsl:text></xsl:text></xsl:when>
    <xsl:otherwise><xsl:text>

</xsl:text>!--<xsl:value-of select="." />--!<xsl:text>
</xsl:text></xsl:otherwise>
</xsl:choose><xsl:choose>
    <xsl:when test="$nadrazeny = 'h1'">#</xsl:when>
    <xsl:when test="$nadrazeny = 'h2'">##</xsl:when>
    <xsl:otherwise><xsl:text></xsl:text></xsl:otherwise>
</xsl:choose>
<xsl:choose><xsl:when test="(count(*) &gt; 0) and (count(./text()) &gt; 0)">
    <xsl:variable name="elementchyba"  select="name(.)" />
<xsl:for-each select="./text()">
    <xsl:choose>
        <xsl:when test="string-length() &gt; 1"><xsl:text>&lt;!-- {_class="hide pozor" data-id="</xsl:text><xsl:value-of select="$elementchyba" /><xsl:text>" } --></xsl:text></xsl:when>
    </xsl:choose>
</xsl:for-each>
<xsl:choose>
    <xsl:when test="$nadrazeny = 'h1' or $nadrazeny = 'h2' or $nadrazeny = 'li'"> &lt;!-- {_class="<xsl:value-of select="$styl" /><xsl:text> </xsl:text><xsl:value-of select="$textstylename" />"} --></xsl:when>
    <xsl:otherwise><xsl:text></xsl:text></xsl:otherwise>
</xsl:choose><xsl:text></xsl:text>
<xsl:apply-templates select="*">
    <xsl:with-param name="odsazeni"><xsl:value-of select="$odsazeni" /></xsl:with-param>
    <xsl:with-param name="styl"><xsl:value-of select="$styl" /><xsl:text> </xsl:text><xsl:value-of select="$textstylename" /></xsl:with-param>
    <xsl:with-param name="nadrazeny"><xsl:value-of select="$nadrazeny" /></xsl:with-param>
</xsl:apply-templates>
</xsl:when><xsl:when test="0 = count(*)"><xsl:text> </xsl:text><xsl:value-of select="." /> &lt;!-- {_class="<xsl:value-of select="$styl" /><xsl:text> </xsl:text><xsl:value-of select="$textstylename" />"} --><xsl:text>
</xsl:text>
</xsl:when>
<xsl:otherwise><xsl:choose>
    <xsl:when test="$nadrazeny = 'h1' or $nadrazeny = 'h2' or $nadrazeny = 'li'"> &lt;!-- {_class="<xsl:value-of select="$styl" /><xsl:text> </xsl:text><xsl:value-of select="$textstylename" />"} --></xsl:when>
    <xsl:otherwise><xsl:text></xsl:text></xsl:otherwise>
</xsl:choose><xsl:text></xsl:text>
<xsl:apply-templates select="*">
    <xsl:with-param name="odsazeni"><xsl:value-of select="$odsazeni" /></xsl:with-param>
    <xsl:with-param name="styl"><xsl:value-of select="$styl" /><xsl:text> </xsl:text><xsl:value-of select="$textstylename" /></xsl:with-param>
    <xsl:with-param name="nadrazeny"><xsl:value-of select="$nadrazeny" /></xsl:with-param>
</xsl:apply-templates>
        </xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--text:span-->
<xsl:template match="text:span" priority="3">
    <xsl:param name="odsazeni" />
    <xsl:param name="styl" />
    <xsl:param name="nadrazeny" />
    <xsl:param name="apostrof"><xsl:value-of select="position()" /></xsl:param>
    <xsl:variable name="textstylename" select='@text:style-name' /><xsl:text></xsl:text>
<xsl:choose><xsl:when test="(count(*) &gt; 0) and (count(./text()) &gt; 0)">
    <xsl:variable name="elementchyba"  select="name(.)" />
<xsl:for-each select="./text()">
    <xsl:choose>
        <xsl:when test="string-length() &gt; 1"><xsl:text>&lt;!-- {_class="hide pozor" data-id="</xsl:text><xsl:value-of select="$elementchyba" /><xsl:text>" } --></xsl:text></xsl:when>
    </xsl:choose>
</xsl:for-each>
<xsl:text></xsl:text>
<xsl:apply-templates select="*">
    <xsl:with-param name="odsazeni"><xsl:value-of select="$odsazeni" /></xsl:with-param>
    <xsl:with-param name="styl"><xsl:value-of select="$styl" /><xsl:text> </xsl:text><xsl:value-of select="$textstylename" /></xsl:with-param>
    <xsl:with-param name="nadrazeny"><xsl:value-of select="$nadrazeny" /></xsl:with-param>
    <xsl:with-param name="apostrof"><xsl:value-of select="$apostrof" /></xsl:with-param>
</xsl:apply-templates>
</xsl:when><xsl:when test="0 = count(*)"><xsl:call-template name="for">
    <xsl:with-param name="znak">
        <xsl:text>`</xsl:text>
    </xsl:with-param>
    <xsl:with-param name="stop">
        <xsl:value-of select="$apostrof"/>
    </xsl:with-param>
</xsl:call-template><xsl:choose>
                    <xsl:when test="string-length(.) = 0"><xsl:text> </xsl:text></xsl:when>
                    <xsl:otherwise><xsl:value-of select="." /></xsl:otherwise>
                </xsl:choose><xsl:call-template name="for">
    <xsl:with-param name="znak">
        <xsl:text>`</xsl:text>
    </xsl:with-param>
    <xsl:with-param name="stop">
        <xsl:value-of select="$apostrof"/>
    </xsl:with-param>
</xsl:call-template>&lt;!-- {_class="<xsl:choose>
                    <xsl:when test="$nadrazeny = 'table'"><xsl:value-of select="$styl" /><xsl:text> </xsl:text></xsl:when>
                    <xsl:when test="$nadrazeny = ''"><xsl:value-of select="$styl" /><xsl:text> </xsl:text></xsl:when>
                </xsl:choose><xsl:value-of select="$textstylename" /><xsl:choose>
                    <xsl:when test="string-length(.) = 0"><xsl:text> nullstring</xsl:text></xsl:when>
                </xsl:choose>"} --><xsl:text> </xsl:text>
</xsl:when>
<xsl:otherwise><xsl:text></xsl:text>
<xsl:apply-templates select="*">
    <xsl:with-param name="odsazeni"><xsl:value-of select="$odsazeni" /></xsl:with-param>
    <xsl:with-param name="styl"><xsl:value-of select="$styl" /><xsl:text> </xsl:text><xsl:value-of select="$textstylename" /></xsl:with-param>
    <xsl:with-param name="nadrazeny"><xsl:value-of select="$nadrazeny" /></xsl:with-param>
    <xsl:with-param name="apostrof"><xsl:value-of select="$apostrof" /></xsl:with-param>
</xsl:apply-templates>
        </xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--text:line-break-->
<xsl:template match="text:line-break" priority="3">
    <xsl:param name="odsazeni" />
    <xsl:param name="styl" />
    <xsl:param name="nadrazeny" />
    <xsl:param name="apostrof"><xsl:value-of select="position()" /></xsl:param><xsl:call-template name="for">
    <xsl:with-param name="znak">
        <xsl:text>`</xsl:text>
    </xsl:with-param>
    <xsl:with-param name="stop">
        <xsl:value-of select="$apostrof"/>
    </xsl:with-param>
</xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="for">
    <xsl:with-param name="znak">
        <xsl:text>`</xsl:text>
    </xsl:with-param>
    <xsl:with-param name="stop">
        <xsl:value-of select="$apostrof"/>
    </xsl:with-param>
</xsl:call-template>&lt;!-- {_class="newline"} --><xsl:text></xsl:text>
</xsl:template>

<!--text:list-->
<xsl:template match="text:list" priority="3">
    <xsl:param name="odsazeni" />
    <xsl:param name="styl" />
    <xsl:param name="nadrazeny" />
    <xsl:variable name="textstylename" select='@text:style-name' />
    <xsl:text>
</xsl:text>
<xsl:apply-templates select="*">
    <xsl:with-param name="odsazeni"><xsl:value-of select="$odsazeni" /></xsl:with-param>
    <xsl:with-param name="styl"><xsl:value-of select="$styl" /><xsl:text> </xsl:text><xsl:value-of select="$textstylename" /></xsl:with-param>
    <xsl:with-param name="nadrazeny"><xsl:value-of select="$nadrazeny" /></xsl:with-param>
</xsl:apply-templates>
</xsl:template>

<!--text:list-item-->
<xsl:template match="text:list-item" priority="3">
    <xsl:param name="odsazeni" />
    <xsl:param name="styl" />
    <xsl:param name="nadrazeny" />
    <xsl:variable name="textstylename" select='@text:style-name' />
    <xsl:text>
</xsl:text>!--<xsl:value-of select="." />--!<xsl:text>
</xsl:text>
<xsl:choose>
    <xsl:when test="$nadrazeny = 'li'"><xsl:text>
</xsl:text></xsl:when>
</xsl:choose>
<xsl:call-template name="for">
    <xsl:with-param name="stop">
        <xsl:value-of select="$odsazeni"/>
    </xsl:with-param>
</xsl:call-template>-<xsl:choose>
    <xsl:when test="(count(*) &gt; 0) and (count(./text()) &gt; 0)">
    <xsl:variable name="elementchyba"  select="name(.)" />
<xsl:for-each select="./text()">
    <xsl:choose>
        <xsl:when test="string-length() &gt; 1"><xsl:text>&lt;!-- {_class="hide pozor" data-id="</xsl:text><xsl:value-of select="$elementchyba" /><xsl:text>" } --></xsl:text></xsl:when>
    </xsl:choose>
</xsl:for-each>
<xsl:apply-templates select="*">
    <xsl:with-param name="odsazeni"><xsl:value-of select="$odsazeni + 1" /></xsl:with-param>
    <xsl:with-param name="styl"><xsl:value-of select="$styl" /><xsl:text> </xsl:text><xsl:value-of select="$textstylename" /></xsl:with-param>
    <xsl:with-param name="nadrazeny"><xsl:text>li</xsl:text></xsl:with-param>
</xsl:apply-templates>
</xsl:when><xsl:when test="0 = count(*)"><xsl:text> </xsl:text><xsl:value-of select="." /> &lt;!-- {_class="<xsl:value-of select="$styl" /><xsl:text> </xsl:text><xsl:value-of select="$textstylename" />"} --><xsl:text>
</xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="*">
    <xsl:with-param name="odsazeni"><xsl:value-of select="$odsazeni + 1" /></xsl:with-param>
    <xsl:with-param name="styl"><xsl:value-of select="$styl" /><xsl:text> </xsl:text><xsl:value-of select="$textstylename" /></xsl:with-param>
    <xsl:with-param name="nadrazeny"><xsl:text>li</xsl:text></xsl:with-param>
</xsl:apply-templates>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--table:table-->
<xsl:template match="table:table" priority="3">
    <xsl:param name="odsazeni" />
    <xsl:param name="styl" />
    <xsl:param name="nadrazeny" />
    <xsl:variable name="tablestylename" select='@table:style-name' />
<xsl:text>
|</xsl:text>
<xsl:apply-templates select="*">
    <xsl:with-param name="odsazeni"><xsl:value-of select="$odsazeni" /></xsl:with-param>
    <xsl:with-param name="styl"><xsl:value-of select="$styl" /><xsl:text> </xsl:text><xsl:value-of select="$tablestylename" /></xsl:with-param>
    <xsl:with-param name="nadrazeny"><xsl:value-of select="$nadrazeny" /></xsl:with-param>
</xsl:apply-templates>
</xsl:template>

<!--table:table-row-->
<xsl:template match="table:table-row" priority="3">
    <xsl:param name="odsazeni" />
    <xsl:param name="styl" />
    <xsl:param name="nadrazeny" />
    <xsl:variable name="tablestylename" select='@table:style-name' />
    <xsl:text>
|</xsl:text>
<xsl:apply-templates select="*">
    <xsl:with-param name="odsazeni"><xsl:value-of select="$odsazeni" /></xsl:with-param>
    <xsl:with-param name="styl"><xsl:value-of select="$styl" /><xsl:text> </xsl:text><xsl:value-of select="$tablestylename" /></xsl:with-param>
    <xsl:with-param name="nadrazeny"><xsl:value-of select="$nadrazeny" /></xsl:with-param>
</xsl:apply-templates>
</xsl:template>

<!--table:table-column-->
<xsl:template match="table:table-column" priority="3"><xsl:text> --- |</xsl:text>
</xsl:template>

<!--table:table-cell-->
<xsl:template match="table:table-cell" priority="3">
    <xsl:param name="odsazeni" />
    <xsl:param name="styl" />
    <xsl:param name="nadrazeny" />
    <xsl:variable name="tablestylename" select='@table:style-name' />
    <xsl:text> </xsl:text>&lt;!-- {_class="<xsl:value-of select="$styl" /><xsl:text> </xsl:text><xsl:value-of select="$tablestylename" />"} --><xsl:apply-templates select="*">
    <xsl:with-param name="odsazeni"><xsl:value-of select="$odsazeni" /></xsl:with-param>
    <xsl:with-param name="styl"><xsl:text></xsl:text></xsl:with-param>
    <xsl:with-param name="nadrazeny"><xsl:text>table</xsl:text></xsl:with-param>
</xsl:apply-templates><xsl:text>|</xsl:text>
</xsl:template>

<!--draw:image-->
<xsl:template match="draw:image" priority="3">
    <xsl:param name="odsazeni" />
    <xsl:param name="styl" />
    <xsl:param name="nadrazeny" />
    <xsl:text></xsl:text>
    <xsl:variable name="jmeno" select="."/>
    <xsl:choose>
    <xsl:when test="not(contains(./@xlink:href, '.svm'))">
![<xsl:value-of select="$jmeno" />](<xsl:value-of select="@xlink:href" /> "<xsl:value-of select="$jmeno" />") &lt;!-- {_class="<xsl:value-of select="$styl" />"} -->
    </xsl:when>
</xsl:choose>
</xsl:template>

<!--text:line-break-->
<xsl:template match="text:line-break" priority="3">
    <xsl:param name="odsazeni" />
    <xsl:param name="styl" />
    <xsl:param name="nadrazeny" />
    <xsl:param name="apostrof"><xsl:value-of select="position()" /></xsl:param><xsl:call-template name="for">
    <xsl:with-param name="znak">
        <xsl:text>`</xsl:text>
    </xsl:with-param>
    <xsl:with-param name="stop">
        <xsl:value-of select="$apostrof"/>
    </xsl:with-param>
</xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="for">
    <xsl:with-param name="znak">
        <xsl:text>`</xsl:text>
    </xsl:with-param>
    <xsl:with-param name="stop">
        <xsl:value-of select="$apostrof"/>
    </xsl:with-param>
</xsl:call-template>&lt;!-- {_class="newline"} --><xsl:text></xsl:text>
</xsl:template>




<!-- vypnutí defaultního zpracování -->
<xsl:template match="*" priority="2"></xsl:template>

<!--for cyklus-->
<xsl:template name="for">
    <xsl:param name="start">0</xsl:param>
    <xsl:param name="stop">0</xsl:param>
    <xsl:param name="step">1</xsl:param>
    <xsl:param name="znak"><xsl:text>   </xsl:text></xsl:param>
    <xsl:if test="$start &lt; $stop">
    <xsl:value-of select="$znak" />
    </xsl:if>
    <xsl:if test="$start &lt; $stop">
        <xsl:call-template name="for">
            <xsl:with-param name="stop">
                <xsl:value-of select="$stop"/>
            </xsl:with-param>
            <xsl:with-param name="start">
                <xsl:value-of select="$start + $step"/>
            </xsl:with-param>
            <xsl:with-param name="step">
                <xsl:value-of select="$step"/>
            </xsl:with-param>
            <xsl:with-param name="znak">
                <xsl:value-of select="$znak"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:if>
</xsl:template>

</xsl:stylesheet>