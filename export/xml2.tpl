{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}
{*
        Name : Kalender 2.0 Template - XML
        Dateiname : xml2.tpl
        Autor : Carsten Horst
        Letzte Änderung : 13.09.2006 (Stefan Motz)
        Version : 2.0.0
        notwendige Konfiguration : keine
*}
        {if $groups.jahrmonat}
                {assign var="groups" value="`$groups.jahrmonat`"}
        {/if}
{/strip}<?xml version="1.0" encoding="ISO-8859-1" standalone="yes"?>

<!DOCTYPE ScoutNetCalendarData [
  <!ELEMENT ScoutNetCalendarData (Entry)+>
  <!ELEMENT Entry (Id, CId, SDate, STime, EDate, ETime, Title, Place, Category, Section, Author, Association, Level, Info)>
  <!ELEMENT Id (#PCDATA)>
  <!ELEMENT CId (#PCDATA)>
  <!ELEMENT SDate (#PCDATA)>
  <!ELEMENT STime (#PCDATA)>
  <!ELEMENT EDate (#PCDATA)>
  <!ELEMENT ETime (#PCDATA)>
  <!ELEMENT Title (#PCDATA)>
  <!ELEMENT Place (#PCDATA)>
  <!ELEMENT Category (#PCDATA)>
  <!ELEMENT Section (#PCDATA)>
  <!ELEMENT Author (#PCDATA)>
  <!ELEMENT Association (#PCDATA)>
  <!ELEMENT Level (#PCDATA)>
  <!ELEMENT Info (#PCDATA)>
]>

    <ScoutNetCalendarData>
{foreach from=$groups item=monat}
{foreach from=$monat.eintraege item=eintrag}
        <Entry>
            <Id>{$eintrag.id}</Id>
            <CId>{$kalender.id}</CId>
            <SDate>{$eintrag.startdatum|date_format:"%y-%m-%d"}</SDate>
            <STime>{$eintrag.startzeit|date_format:"%H:%M:00"}</STime>
            <EDate>{$eintrag.enddatum|date_format:"%y-%m-%d"}</EDate>
            <ETime>{$eintrag.endzeit|date_format:"%H:%M:00"}</ETime>
            <Title><![CDATA[{$eintrag.titel}]]></Title>
            <Place>{$eintrag.ort}</Place>
            <Category>{$eintrag.kategorie}</Category>
            <Section><![CDATA[{$eintrag.stufe.bildlich_scoutnet}]]></Section>
{if $eintrag.autor.vorname || $eintrag.autor.nachname}
            <Author>{$eintrag.autor.vorname} {$eintrag.autor.nachname}</Author>
{else}
            <Author>{$eintrag.autor.nickname}</Author>
{/if}
            <Association>{$eintrag.verband}</Association>
            <Level>{$eintrag.kalender.ebene}</Level>
            <Info><![CDATA[{$eintrag.info|nl2br}]]></Info>
        </Entry>
{/foreach}
{/foreach}
    </ScoutNetCalendarData>
