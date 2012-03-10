{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}
{*
        Name : Kalender 2.0 Template - XML
        Dateiname : xmlrpc.tpl
        Autor : Jan Brohl
        Letzte Änderung : 04.02.2010 (Jan Brohl)
        Version : 1.1.0
        notwendige Konfiguration : keine
*}
        {if $groups.jahrmonat}
                {assign var="groups" value="`$groups.jahrmonat`"}
        {/if}
{/strip}<?xml version="1.0" encoding="ISO-8859-1"?>
{strip}
<methodResponse>
   <params>
      <param>
         <value>
<struct>
{foreach from=$groups item=monat}
{foreach from=$monat.eintraege item=eintrag}
        <member>
            <name>{$eintrag.id}</name>
<value>
<struct>
            <member><name>startdatum</name><value><string>{$eintrag.startdatum|date_format:"%y-%m-%d"}</string></value></member>
            <member><name>startzeit</name><value><string>{$eintrag.startzeit|date_format:"%H:%M:00"}</string></value></member>
            <member><name>enddatum</name><value><string>{$eintrag.enddatum|date_format:"%y-%m-%d"}</string></value></member>
            <member><name>endzeit</name><value><string>{$eintrag.endzeit|date_format:"%H:%M:00"}</string></value></member>
            <member><name>titel</name><value><string>{$eintrag.titel}</string></value></member>
            <member><name>ort</name><value><string>{$eintrag.ort}</string></value></member>
            <member><name>kategorie</name><value><string>{$eintrag.kategorie}</string></value></member>
            <member><name>stufen</name>
<value><array><data>
{foreach from=$eintrag.stufe.bezeichnungen_array item=stufe}
<value><string>{$stufe}</string></value>
{/foreach}
</data></array></value></member>
{if $eintrag.autor.vorname || $eintrag.autor.nachname}
            <member><name>autor</name><value><string>{$eintrag.autor.vorname} {$eintrag.autor.nachname}</string></value></member>
{else}
            <member><name>autor</name><value><string>{$eintrag.autor.nickname}</string></value></member>
{/if}
            <member><name>verband</name><value><string>{$eintrag.autor.verband}</string></value></member>
<member><name>ebene</name><value><string>{$eintrag.kalender.ebene} </string></value></member>
            <member><name>info</name><value><string>{$eintrag.info|nl2br|escape}</string></value></member>
</struct>
</value>
        </member>
{/foreach}
{/foreach}
</struct>
</value>
         </param>
      </params>
   </methodResponse>
{/strip}