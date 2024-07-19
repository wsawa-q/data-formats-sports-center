<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                         xmlns:xs="http://www.w3.org/2001/XMLSchema"
                         xmlns:array="http://www.w3.org/2005/xpath-functions/array"
                         xmlns:map="http://www.w3.org/2005/xpath-functions/map"
                         xmlns:math="http://www.w3.org/2005/xpath-functions/math"
                         xmlns:sp="http://nasesportoviste.cz/slovnik/">

    <xsl:output method="html" indent="yes"/>

    <xsl:template match="sp:SportovníStředisko">
        <html>
            <head>
            <title>
                <xsl:value-of select="sp:Název"/>
            </title>
            </head>
            <body>
                <h1><xsl:value-of select="sp:Název"/></h1>
                <xsl:apply-templates select="sp:DostupnéLokace/sp:Lokace"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="sp:Lokace">
        <p>
            <h2><xsl:value-of select="sp:Název"/></h2>
            <ul>
                <xsl:for-each select="sp:Název/following-sibling::*">
                        <xsl:if test="count(./self::node()) > 0">
                            <li><xsl:apply-templates select="."/></li>
                        </xsl:if>
                </xsl:for-each>
            </ul>
        </p>
    </xsl:template>


    <xsl:template match="sp:Plocha">
        Plocha: <xsl:value-of select="."/> m^2
    </xsl:template>

    <xsl:template match="sp:Kapacita">
        Kapacita: <xsl:value-of select="."/> osob
    </xsl:template>

    <xsl:template match="sp:Krytí">
        Krytí: <xsl:value-of select="sp:Název"/> (<xsl:value-of select="sp:ÚroveňKrytí*100.0"/> %)
    </xsl:template>

    <xsl:template match="sp:Povrch">
        Povrch: <xsl:value-of select="sp:Název"/>
    </xsl:template>


    <xsl:template match="sp:OprávněniKPřístupu">
        <p>Oprávněni k přístupu:</p>
        <ul>
            <xsl:for-each select="./child::*">
                <li><xsl:apply-templates select="."/></li>
            </xsl:for-each>
        </ul>
    </xsl:template>

    <xsl:template match="sp:PravidelnýRozvrh">
        <p>Rozvrh:</p>
        <ul>
            <xsl:for-each select="./child::*">
                <li><xsl:apply-templates select="."/></li>
            </xsl:for-each>
        </ul>
    </xsl:template>

    <xsl:template match="sp:Události">
        <p>Události:</p>
        <ul>
            <xsl:for-each select="./child::*">
                <li><xsl:apply-templates select="."/></li>
            </xsl:for-each>
        </ul>
    </xsl:template>


    <xsl:template match="sp:Rozvrh">
        <p>Den <xsl:value-of select="sp:Den"/> (<xsl:value-of select="sp:Od"/> - <xsl:value-of select="sp:Do"/>)</p>
        <p>Organizátoři:</p>
        <ul>
            <xsl:for-each select="./sp:Organizátoři/sp:Zaměstnanec">
                <li><xsl:apply-templates select="."/></li>
            </xsl:for-each>
        </ul>
    </xsl:template>

    <xsl:template match="sp:Událost">
        <p><b><xsl:value-of select="sp:Název"/></b></p>
        <p><xsl:value-of select="sp:Datum"/> (<xsl:value-of select="sp:Od"/> - <xsl:value-of select="sp:Do"/>)</p>
        <p>Organizátoři:</p>
        <ul>
            <xsl:for-each select="./sp:Organizátoři/sp:Zaměstnanec">
                <li><xsl:apply-templates select="."/></li>
            </xsl:for-each>
        </ul>
    </xsl:template>

    <xsl:template match="sp:Sportovec">
    <xsl:value-of select="concat(sp:KřestníJméno, ' ', sp:Příjmení)"/>
    </xsl:template>
    <xsl:template match="sp:Zaměstnanec">
    <xsl:value-of select="concat(sp:KřestníJméno, ' ', sp:Příjmení)"/> (tel. <xsl:value-of select="sp:PracovníTelefon"/>)
    </xsl:template>

    <xsl:template match="text()"/>

</xsl:stylesheet>

