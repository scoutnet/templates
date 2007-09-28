{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}
{*
        Name : Kalender 2.0 Template - Old Style Infoinline
        Dateiname : old_style.tpl
        Autor : Scoutnet Kalender-Team - Christopher Vogt
        Letzte Änderung : 30.09.2003 (Peter Dübbert)
        Version : 1.1.4
        benötigte andere Dateien : box_inhalt_datum.tpl ; box_inhalt_eintrag.tpl
        notwendige Konfiguration : keine
        Bemerkungen : Dieses Template bietet das Design des Kalender 1.0 unter Hinzunahme der Infos auf einer Seite
        W3C konformität : bisher nicht getestet
        Änderungen in Version 1.1.4 - 30.09.2003:
                - Die Infos zu den jeweiligen Terminen werden direkt in der Tabelle angezeigt. Für die Stufen werden die kleine Symbole mit angezeigt. Der Link heisst jetzt Termine verwalten anstatt Termin eintragen.
        Änderungen in Version 1.1.3 - 16.07.2003:
                - Als Autor wird jetzt entweder Vor- und/oder Nachname angezeigt (wenn in der Community eingegeben) und sonst der Nickname des Autors
        Änderungen in Version 1.1.2 - 16.07.2003:
                - Korrektur der Datumsanzeige, vielen Dank an den freundlichen Finder: Christian Mertens
        Änderungen in Version 1.1.1 - 15.07.2003:
                - nl2br: Zeilenumbrüche in den Infos werden in HTML Zeilenumbrüche umgewandelt
        Änderungen in Version 1.1.0 - 13.07.2003:
                - Pfad zu old_style.tpl auch für infos_zeigen.tpl in der JavaScript Funktion infoszeigen
                - Korrektur des setzens von "checked" wenn kein ebenenup übergeben wurde
                - kleinere Designanpassungen
                - Es gibt nun viele Konfigurationsmöglichkeiten am Anfang und über die URL
        Änderungen in Version 1.0.1 - 05.07.2003:
                - absoluter Pfad zu show.php in der JavaScript Funktion infoszeigen
*}

{* Zuweisung der richtigen Gruppe (nur nötig, wenn man den URL-Parameter groupby nicht übergibt) *}
{if $groups.jahrmonat}
    {assign var="groups" value="`$groups.jahrmonat`"}
{/if}
{/strip}<html>
<head>
<title>ScoutNet-Kalender</title>
</head>
<body>

{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}
{foreach from=$url_parameters key=name item=value}
        {if $name != "ebenenup" && $name != "groupby"}
                {assign var="parameters" value="$parameters$name=$value&"}
        {/if}
{/foreach}

<p>{$smarty.now|date_format:"Heute ist %A, der %d.%m.%Y"}
</p>
<!-- Beginn Kalendereintraege -->

<h1 class="csc-firstHeader">Kalender</h1>
<table border="0" cellspacing="3" cellpadding="5" class="kalendertabelle" summary="Termine aus dem ScoutNet Kalender für das 21. WorldScoutJamboree (http://kalender.scoutnet.de/)">

    {foreach from=$groups item=monat}
    <tr>
        <td colspan="5" class="kalendermonat"><strong>{$monat.startdatum|date_format:"%B %Y"}</strong></td>
    </tr>
    {foreach from=$monat.eintraege item=eintrag}
    <tr>
        <td valign="top" class="kalenderdatum">{$starttags}{$eintrag.startdatum|date_format:"%A"|truncate:2:""}{$eintrag.startdatum|date_format:",&nbsp;%d.%m."} {if $eintrag.enddatum!= ""}&nbsp;- {$eintrag.enddatum|date_format:"%A"|truncate:2:""}{$eintrag.enddatum|date_format:",&nbsp;%d.%m."}{/if}<br />{$eintrag.startzeit|date_format:"%H:%M"}{if $eintrag.endzeit!= ""}&nbsp;- {$eintrag.endzeit|date_format:"%H:%M"}{/if}{$endtags}</td>

        <td valign="top">{$starttags}<strong>{$eintrag.titel}</strong>{$endtags}<br />
{$starttags}{$eintrag.ort}{$endtags}</td>
        <td valign="top">{$starttags}{$eintrag.kategorie}<br /><img src="http://kalender.scoutnet.de/2.0/images/{$eintrag.kalender.verband}.gif" alt="{$eintrag.kalender.verband}" />{$endtags}</td>
        <td valign="top">Eingetragen von:<br />{$starttags}{if $eintrag.autor.vorname || $eintrag.autor.nachname}{$eintrag.autor.vorname}&nbsp;{$eintrag.autor.nachname}{else}{$eintrag.autor.nickname}{/if}<br />{$eintrag.kalender.ebene}{$endtags}</td>
    </tr>
    {if $eintrag.info != ""}
    <tr>
        <td colspan="4" valign="top">{$starttags}{$eintrag.info|nl2br}{$endtags}</td></tr>
    {else}
        <td valign="top">{$starttags}{$eintrag.info|nl2br}{$endtags}</td>
    {/if}<tr><td colspan="4"><hr /></td></tr>

    {/foreach}
        {/foreach}
</table>
<!-- Ende Kalendereintraege -->
{/strip}

</body>
</html>
