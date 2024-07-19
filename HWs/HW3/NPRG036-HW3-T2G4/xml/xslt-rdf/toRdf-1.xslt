<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                         xmlns:xs="http://www.w3.org/2001/XMLSchema"
                         xmlns:array="http://www.w3.org/2005/xpath-functions/array"
                         xmlns:map="http://www.w3.org/2005/xpath-functions/map"
                         xmlns:math="http://www.w3.org/2005/xpath-functions/math"
                         xmlns:sp="http://nasesportoviste.cz/slovnik/"
                         xmlns:fn="http://www.w3.org/2005/xpath-functions"
                         >
    <xsl:output method="text" encoding="UTF-8"/>
    <xsl:template match="sp:SportovníStředisko">
        @prefix sp: &lt;http://nasesportoviste.cz/slovnik/&gt; .
        @prefix lok: &lt;http://nasesportoviste.cz/lokace/&gt; .
        @prefix kr: &lt;http://nasesportoviste.cz/kryti/&gt; .
        @prefix po: &lt;http://nasesportoviste.cz/povrch/&gt; .
        @prefix ro: &lt;http://nasesportoviste.cz/rozvrh/&gt; .
        @prefix ud: &lt;http://nasesportoviste.cz/udalost/&gt; .
        @prefix zam: &lt;http://nasesportoviste.cz/zamestnanec/&gt; .
        @prefix sport: &lt;http://nasesportoviste.cz/sportovec/&gt; .
            
        
        @prefix xsd: &lt;http://www.w3.org/2001/XMLSchema#&gt; .
        @prefix rdf: &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt; .
        @prefix rdfs: &lt;http://www.w3.org/2000/01/rdf-schema#&gt; .
        @prefix proton: &lt;http://www.ontotext.com/proton/protontop#&gt; .
        @prefix foaf: &lt;http://xmlns.com/foaf/0.1/&gt; .
    
        <xsl:apply-templates select="sp:DostupnéLokace/sp:Lokace"/>
    </xsl:template>
    <xsl:template match="sp:Lokace">
        <xsl:variable name="lokId" select="fn:position()"/>
        <xsl:variable name="krId" select="fn:position()"/>
        <xsl:variable name="poId" select="fn:position()"/>
        <xsl:variable name="lokIRI" select="concat('lok:', $lokId)"/>
        <xsl:value-of select="$lokIRI"/> a sp:Lokace;
            sp:nazev "<xsl:value-of select="sp:Název"/>"@<xsl:value-of select="sp:Název/@xml:lang"/>;
            sp:plocha "<xsl:value-of select="sp:Plocha"/>"^^xsd:float;
            sp:kapacita "<xsl:value-of select="sp:Kapacita"/>"^^xsd:unsignedInt;
            sp:kryje kr:<xsl:value-of select="$krId"/>;
            sp:povrch po:<xsl:value-of select="$poId"/>.
            
            <xsl:apply-templates select="sp:Krytí">
                <xsl:with-param name="krId" select="$krId"/>
            </xsl:apply-templates>
            <xsl:apply-templates select="sp:Povrch">
                <xsl:with-param name="poId" select="$poId"/>
            </xsl:apply-templates>
            <xsl:apply-templates select="sp:PravidelnýRozvrh/sp:Rozvrh">
                    <xsl:with-param name="lokIRI" select="$lokIRI"/>
            </xsl:apply-templates>
            <xsl:apply-templates select="sp:Události/sp:Událost">
                <xsl:with-param name="lokId" select="$lokId"/>
            </xsl:apply-templates>

            <xsl:apply-templates select="sp:OprávněniKPřístupu/sp:Sportovec">
                <xsl:with-param name="lokId" select="$lokId"/>
            </xsl:apply-templates>
    
    </xsl:template>
    <xsl:template match="sp:Krytí">
        <xsl:param name="krId" required="yes"/>
        kr:<xsl:value-of select="$krId"/> a sp:Kryti;
            sp:nazev "<xsl:value-of select="sp:Název"/>"@<xsl:value-of select="sp:Název/@xml:lang"/>;
            sp:popis "<xsl:value-of select="sp:Popis"/>"@<xsl:value-of select="sp:Popis/@xml:lang"/>;
            sp:urovenKryti "<xsl:value-of select="sp:ÚroveňKrytí"/>"^^xsd:float.
            
    </xsl:template>
    <xsl:template match="sp:Povrch">
    <xsl:param name="poId" required="yes"/>
        po:<xsl:value-of select="$poId"/> a sp:Povrch;
            sp:nazev "<xsl:value-of select="sp:Název"/>"@<xsl:value-of select="sp:Název/@xml:lang"/>;
    </xsl:template>
    <xsl:template match="sp:Rozvrh">
        <xsl:param name="lokIRI" required="yes"/>
        <xsl:variable name="rozvrhId" select="sp:id"/>
        <xsl:value-of select="$lokIRI"/> sp:rozvrh ro:<xsl:value-of select="$rozvrhId"/>.
        ro:<xsl:value-of select="$rozvrhId"/> a sp:Rozvrh ;
            sp:den "<xsl:value-of select="sp:Den"/>"^^xsd:unsignedInt ;
            sp:od "<xsl:value-of select="sp:Od"/>"^^xsd:time ;
            sp:do "<xsl:value-of select="sp:Do"/>"^^xsd:time .
    </xsl:template>
    <xsl:template match="sp:Událost">
        <xsl:param name="lokId" required="yes"/>
        <xsl:variable name="udalostId" select="sp:id"/>
        ud:<xsl:value-of select="$udalostId"/> a sp:Udalost ;
            sp:nazev "<xsl:value-of select="sp:Název"/>"@<xsl:value-of select="sp:Název/@xml:lang"/> ;
            sp:datum "<xsl:value-of select="sp:Datum"/>"^^xsd:date ;
            sp:od "<xsl:value-of select="sp:Od"/>"^^xsd:time ;
            sp:do "<xsl:value-of select="sp:Do"/>"^^xsd:time ;
            sp:lokace lok:<xsl:value-of select="$lokId"/>.
        <xsl:apply-templates select="sp:Organizátoři">
            <xsl:with-param name="udalostId" select="$udalostId"/>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="sp:Zaměstnanec">
        <xsl:param name="udalostId" required="yes"/>
        <xsl:variable name="zamId" select="sp:id"/>
        <xsl:variable name="zamIRI" select="concat('zam:', $zamId)"/>
        <xsl:value-of select="$zamIRI"/> a sp:Zamestnanec ;
            foaf:givenName "<xsl:value-of select="sp:KřestníJméno"/>"@<xsl:value-of select="sp:KřestníJméno/@xml:lang"/> ;
            foaf:familyName "<xsl:value-of select="sp:Příjmení"/>"@<xsl:value-of select="sp:Příjmení/@xml:lang"/> ;            
            sp:mzda "<xsl:value-of select="sp:Mzda/@hodnota"/>"^^xsd:decimal ;
            sp:aktivni <xsl:value-of select="@aktivni"/> .
            <xsl:call-template name="Telefon">
                <xsl:with-param name="telefon" select="sp:PracovníTelefon"/>
                <xsl:with-param name="ownerIRI" select="$zamIRI"/>
                <xsl:with-param name="rel">sp:pracovniTelefon</xsl:with-param>
            </xsl:call-template>
        ud:<xsl:value-of select="$udalostId"/> sp:organizovan zam:<xsl:value-of select="$zamId"/>.
    </xsl:template>
    <xsl:template name="Telefon">
        <xsl:param name="telefon" required="yes"/>
        <xsl:param name="rel" required="yes"/>
        <xsl:param name="ownerIRI" required="yes"/>
        <xsl:variable name="pref" select="concat($ownerIRI, ' ', $rel)"/>
        <xsl:value-of select="$pref"/> &lt;tel:"<xsl:value-of select="replace($telefon, ' ', '.')"/>"&gt;.
    </xsl:template>
    
     <xsl:template match="sp:Sportovec">
        <xsl:param name="lokId" required="yes"/>
        <xsl:variable name="sportIRI" select="concat('sport:', sp:id)"/>
        <xsl:value-of select="$sportIRI"/> a sp:Sportovec ;
            foaf:givenName "<xsl:value-of select="sp:KřestníJméno"/>"@<xsl:value-of select="sp:KřestníJméno/@xml:lang"/> ;
            foaf:familyName "<xsl:value-of select="sp:Příjmení"/>"@<xsl:value-of select="sp:Příjmení/@xml:lang"/> ;
            sp:opravnen lok:<xsl:value-of select="$lokId"/> .
            <xsl:for-each select="sp:Telefon">
                <xsl:call-template name="Telefon">
                    <xsl:with-param name="telefon" select="."/>  
                    <xsl:with-param name="ownerIRI" select="$sportIRI"/>  
                    <xsl:with-param name="rel">sp:osobniTelefon</xsl:with-param>
                </xsl:call-template>
            </xsl:for-each>
            
    </xsl:template>

</xsl:stylesheet>
    