{capture name=dummy}{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}
{*
	Name : ScoutNet Standard Template
	Autor : Scoutnet Kalender-Team (Christopher Vogt)
	Letzte Änderung : 11.02.2008
	Version : 1.2
*}
{* Anleitung *}

	Dieses Template stellt den Kalender als Tabelle bereit.	
	Folgende Parameter können in der URL (per get oder post) übergeben werden, um das Verhalten des templates zu verändern:

	&onlybody  -  Zum Einbinden in eine existierende Webseite, werden hiermit nur der Inhalt des <body> tags ausgegeben.
	
	&xhtml - Passt den Doctype an und erzeugt schließende / bei tags wo das nötig ist.
	
	&css=http://deineseite.de/dein-stylesheet.css - um ein eigenes stylesheet anzugeben

	&js=http://deineseite.de/dein-javascript.js - um ein eigenes javascript anzugeben

	&nostrip - verhindert das komprimieren des html codes in eine Zeile. Ergibt besser lesbaren html code, zum testen.

{* Anleitung ENDE *}

{* Initialisierung *}
	{* Zuweisung der richtigen Gruppe (nur nötig, wenn man den URL-Parameter groupby nicht übergibt) *}
	{if $groups.jahrmonat}
		{assign var="groups" value="`$groups.jahrmonat`"}
	{/if}
	{assign var="SNK_PHP_SELF_URL" value="http://"|cat:$smarty.server.SERVER_NAME|cat:$smarty.server.PHP_SELF}
	{assign var="SNK_URL"          value=$SNK_PHP_SELF_URL|dirname|dirname|cat:"/"}
	{assign var="SNK_REQUEST_URL"  value=$SNK_PHP_SELF_URL|cat:"?"|cat:$smarty.server.QUERY_STRING}

	{if isset($smarty.request.css)}
		{assign var="css" value=`$smarty.request.css`}
	{else}
		{assign var="css" value="`$SNK_URL`2.0/templates/scoutnet/style.css"}
	{/if}
	{if isset($smarty.request.js)}
		{assign var="js" value=`$smarty.request.js`}
	{else}
		{assign var="js" value="`$SNK_URL`2.0/templates/scoutnet/behavior.js"}
	{/if}
{* Initialisierung ENDE *}
{/capture}{capture name=content}

{* Kopfbereich *}
{if !isset($smarty.request.onlybody)}
{if isset($smarty.request.xhtml)}
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	{assign var="xhtmlend" value=" /"}
{else}
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 	{assign var="xhtmlend" value=""}
{/if}
<html{if isset($smarty.request.xhtml)} xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en"{/if}>
<head>
	<title>ScoutNet-Kalender f&uuml;r {$kalender.ebene|htmlentities|nl2br} {$kalender.name|htmlentities|nl2br}</title>
	<link rel="stylesheet" type="text/css" href="{$css}" media="screen"{$xhtmlend}>
	<script type="text/javascript" src="{$js}"></script>
	<script type="text/javascript" src="{$SNK_URL}js/base2-p.js"></script>
	<script type="text/javascript" src="{$SNK_URL}js/base2-dom-p.js"></script>
{literal}
	<style type="text/css" media="none">.snk-termin-infos{display:none;}</style>
	<script type="text/javascript">
		base2.DOM.bind(document);
		snk_init();
		document.addEventListener('DOMContentLoaded', function(){ return snk_finish('{/literal}{$SNK_REQUEST_URL|addslashes}{literal}'); }, false);
	</script>
{/literal}
</head>
<body>
{/if}
{* Kopfbereich ENDE *}

{* Inhalt *}
<div id="snk-{$kalender.id}" class="snk">

<div class="snk-datum">
	{$smarty.now|date_format:"Heute ist %A, der %d.%m.%Y."}
</div>
<div class="snk-uhrzeit">
	{$smarty.now|date_format:"Es ist %H:%M Uhr."}
</div>

<div class="snk-ebenene-menu">
	{if $temp_kalender.ebene_id != 5}
		{assign var="temp_kalender" value=$kalender}
		<form method="get" action="{$smarty.server.PHP_SELF}">
			{foreach from=$smarty.request key=var item=value}
				{if $var != "ebenenup"}
					<input type="hidden" name="{$var}" value="{$value}"{$xhtmlend}>
				{/if}
			{/foreach}
			<label for="snk-auswahlbox">Termine bis</label>
			<select id="snk-auswahlbox" name="ebenenup">
			{section loop=10 name="menu"}
				{if $temp_kalender.ebene_id == 9
				 || $temp_kalender.ebene_id == 8
				 || $temp_kalender.ebene_id == 7
				 || $temp_kalender.ebene_id == 5}
				<option
					value="{$smarty.section.menu.index}"
					{if isset($smarty.request.ebenenup) && $smarty.request.ebenenup == $smarty.section.menu.index}
						selected
					{/if}
				>
					{$temp_kalender.ebene|htmlentities|nl2br}
				</option>
				{/if}
			{assign var="temp_kalender" value=$temp_kalender.gehoertzu}
		{/section}
	    </select>
	    	<span id="snk-anzeigen"></span><noscript><input type="submit" value="anzeigen"{$xhtmlend}></noscript>
	    </form>
	{/if}
</div>

<div class="snk-termine">
<table>
	<caption>ScoutNet-Kalender f&uuml;r {$kalender.ebene|htmlentities|nl2br}&nbsp;{$kalender.name|htmlentities|nl2br}</caption>
	<tr class="snk-headings-row"> 
		<th class="snk-eintrag-datum-ueberschrift">Datum</th>
		<th class="snk-eintrag-zeit-ueberschrift">Zeit</th>
		<th class="snk-eintrag-titel-ueberschrift">Titel</th>
		<th class="snk-eintrag-stufen-ueberschrift">Stufen</th>
		<th class="snk-eintrag-kategorien-ueberschrift">Kategorien</th>
		<th class="snk-eintrag-ebene-ueberschrift">Ebene</th>
	</tr>
	{foreach from=$groups item=monat} 
	<tr> 
		<th colspan="6" class="snk-monat-heading">{$monat.startdatum|date_format:"%B '%y"}</th>
	</tr>
	{foreach from=$monat.eintraege item=eintrag} 
	<tr> 
		<td class="snk-eintrag-datum">{$eintrag.startdatum|date_format:"%A"|truncate:2:""}{$eintrag.startdatum|date_format:", %d.%m."} {if $eintrag.enddatum!= ""}&nbsp;-&nbsp;{$eintrag.enddatum|date_format:"%A"|truncate:2:""}{$eintrag.enddatum|date_format:", %d.%m."}{/if}</td>
		<td class="snk-eintrag-zeit">{$eintrag.startzeit|date_format:"%H:%M"}{if $eintrag.endzeit!= ""}&nbsp;-&nbsp;{$eintrag.endzeit|date_format:"%H:%M"}{/if}</td>
		<td class="snk-eintrag-titel">
			{if $eintrag.Description || $eintrag.Location || $eintrag.Organizer || $eintrag.Target_Group || $eintrag.URL}
			<a
				href="#snk-termin-{$eintrag.id}" class="snk-termin-link"
				onclick="if(snk_show_termin) return snk_show_termin({$eintrag.id},this); "
			>
				{$eintrag.titel|htmlentities|nl2br}
			</a>{else}{$eintrag.titel|htmlentities|nl2br}{/if}
		</td>
		<td class="snk-eintrag-stufe">
			{foreach from=$eintrag.stufe.records item=stufe}
				<img src="{$SNK_URL}2.0/images/{$stufe.id}.gif" alt="{$stufe.bezeichnung|htmlentities|nl2br}"{$xhtmlend}>
			{/foreach}			
		</td>
		<td class="snk-eintrag-kategorien">{$eintrag.kategorie|htmlentities|nl2br}</td>
		<td class="snk-eintrag-ebene">{$eintrag.kalender.ebene|htmlentities|nl2br}</td>
	</tr>
	{if $eintrag.Description || $eintrag.Location || $eintrag.Organizer || $eintrag.Target_Group || $eintrag.URL}
	<tr id="snk-termin-{$eintrag.id}" class="snk-termin-infos">
		<td colspan="6">
			<dl>
					{if $eintrag.Description}<dt class="snk-eintrag-beschreibung">Beschreibung</dt><dd>{$eintrag.Description|nl2br}</dd>{/if}
					{if $eintrag.plz && $eintrag.ort}<dt class="snk-eintrag-ort">Ort</dt><dd>{$eintrag.plz|htmlentities|nl2br} {$eintrag.ort|htmlentities|nl2br}</dd>{/if}
					{if $eintrag.Organizer}<dt class="snk-eintrag-veranstalter">Veranstalter</dt><dd>{$eintrag.Organizer|htmlentities|nl2br}</dd>{/if}
					{if $eintrag.Target_Group}<dt class="snk-eintrag-zielgruppe">Zielgruppe</dt><dd>{$eintrag.Target_Group|htmlentities|nl2br}</dd>{/if}
					{if $eintrag.URL}<dt class="snk-eintrag-zielgruppe">Link</dt><dd><a href="{$eintrag.URL}">{if $eintrag.URL_Text|htmlentities|nl2br}{$eintrag.URL_Text}{else}{$eintrag.URL|htmlentities|nl2br}{/if}</a></dd>{/if}
					<dt class="snk-eintrag-autor">Eingetragen von</dt><dd>{if $eintrag.autor.vorname || $eintrag.autor.nachname}{$eintrag.autor.vorname|htmlentities|nl2br}&nbsp;{$eintrag.autor.nachname|htmlentities|nl2br}{else}{$eintrag.autor.nickname|htmlentities|nl2br}{/if}</dd>
			</dl>
		</td>
	</tr>
	{/if}
	{/foreach} 
	{/foreach} 
</table>
</div>

<div class="snk-hinzufuegen">
	<a href="http://www.scoutnet.de/community/kalender/events.html?task=create&nbsp;SSID={$kalender.id}">Termin&nbsp;hinzufügen</a>
</div>

<div class="snk-powered-by">
	Powered by <a href="http://kalender.scoutnet.de/" target="_blank">ScoutNet-Kalender</a>
</div>


</div>
{* Inhalt Ende *}

{* Fußbereich *}
{if !isset($urlparameters.onlybody)}
</body>
</html>
{/if}
{* Fußbereich ENDE *}

{* Captured Daten ausgeben *}
{/capture}{if !isset($smarty.request.nostrip)}{$smarty.capture.content|strip}{else}{$smarty.capture.content}{/if}
