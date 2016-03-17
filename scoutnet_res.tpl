{capture name=dummy}{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}
{*
	Name : ScoutNet Responsive Template
	Autor : Scoutnet Kalender-Team (Christopher Vogt) + Raphael Topel
	Letzte Änderung : 17.03.2016
	Version : 0.0.1
*}
{* Anleitung *}

	Dieses Template stellt den Kalender als Tabelle bereit.	
	Folgende Parameter können in der URL (per get oder post) übergeben werden, um das Verhalten des templates zu verändern:

	&onlybody  -  Zum Einbinden in eine existierende Webseite, werden hiermit nur der Inhalt des <body> tags ausgegeben.
	
	&css=http://deineseite.de/dein-stylesheet.css - um ein eigenes stylesheet anzugeben

	&js=http://deineseite.de/dein-javascript.js - um ein eigenes javascript anzugeben

	&nostrip - verhindert das komprimieren des html codes in eine Zeile. Ergibt besser lesbaren html code, zum testen.

{* Anleitung ENDE *}

{* Initialisierung *}
	{* Zuweisung der richtigen Gruppe (nur nötig, wenn man den URL-Parameter groupby nicht übergibt) *}
	{if $groups.jahrmonat}
		{assign var="groups" value="`$groups.jahrmonat`"}
	{/if}
	{assign var="SNK_PHP_SELF_URL" value="https://"|cat:$smarty.server.SERVER_NAME|cat:$smarty.server.PHP_SELF}
	{assign var="SNK_URL"          value=$SNK_PHP_SELF_URL|dirname|dirname|cat:"/"}
	{assign var="SNK_REQUEST_URL"  value=$SNK_PHP_SELF_URL|cat:"?"|cat:$smarty.server.QUERY_STRING}

	{if isset($smarty.request.css)}
		{assign var="css" value=`$smarty.request.css`}
	{else}
		{assign var="css" value="`$SNK_URL`2.0/templates/scoutnet_res/style.css"}
	{/if}
	{if isset($smarty.request.js)}
		{assign var="js" value=`$smarty.request.js`}
	{else}
		{assign var="js" value="`$SNK_URL`2.0/templates/scoutnet_res/behavior.js"}
	{/if}
{* Initialisierung ENDE *}
{/capture}{capture name=content}

{* Kopfbereich *}
{if !isset($smarty.request.onlybody)}
<!DOCTYPE html>
<html>
<head>
	<title>ScoutNet-Kalender {$kalender.ebene|htmlentities|nl2br} {$kalender.name|htmlentities|nl2br}{if $kalender.District OR $kalender.City}, {$kalender.City|htmlentities|nl2br}{if $kalender.District AND $kalender.City}-{/if}{$kalender.District|htmlentities|nl2br}{/if}</title>

	<!-- Bootstrap minified CSS -->
    	<link rel="stylesheet" href="http://v.rtopel.de/dev/templates/scoutnet_res/bootstrap.min.css">
    	<!-- jQuery library -->
    	<script src="http://v.rtopel.de/dev/templates/scoutnet_res/jquery.min.js"></script>

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
<div class="snk-body">
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
				{if $temp_kalender}
				<option
					value="{$smarty.section.menu.index}"
					{if isset($smarty.request.ebenenup) && $smarty.request.ebenenup == $smarty.section.menu.index}
						selected="selected"
					{/if}
				>
					{$temp_kalender.ebene|htmlentities|nl2br} {if $temp_kalender.ebene_id >= 6} {$temp_kalender.name|htmlentities|nl2br}{/if}
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
<div class="container-fluid">
	<p class="snk-termine-heading">ScoutNet-Kalender {$kalender.verband|htmlentities|nl2br} {$kalender.ebene|htmlentities|nl2br} {$kalender.name|htmlentities|nl2br}{if $kalender.District OR $kalender.City}, {$kalender.City|htmlentities|nl2br}{if $kalender.District AND $kalender.City}-{/if}{$kalender.District|htmlentities|nl2br}{/if}</p>
	{foreach from=$groups item=monat} 
	<div class="row"> 
		<div class="snk-monat-heading col-sm-12 col-md-12">{$monat.startdatum|date_format:"%B '%y"}</div>
	</div>
	{foreach from=$monat.eintraege item=eintrag} 
	<div class="row grid-hover"> 
		{if count($used.kalender) > 1}<div class="snk-eintrag-ebene col-sm-1 col-md-1">{$eintrag.kalender.ebene|htmlentities|nl2br|replace:" ":"&nbsp;"}{if $eintrag.kalender.ebene_id >= 7}&nbsp;{$eintrag.kalender.name|htmlentities|nl2br|replace:" ":"&nbsp;"}{/if}</div>{/if}
		<div class="snk-eintrag-datum col-sm-3 col-md-2">{$eintrag.startdatum|date_format:"%A"|truncate:2:""}{$eintrag.startdatum|date_format:",&nbsp;%d.%m."}&nbsp;{if $eintrag.enddatum!= ""}&nbsp;-&nbsp;{$eintrag.enddatum|date_format:"%A"|truncate:2:""}{$eintrag.enddatum|date_format:",&nbsp;%d.%m."}{/if}</div>
		<div class="snk-eintrag-zeit col-sm-2 col-md-1">{$eintrag.startzeit|date_format:"%H:%M"}{if $eintrag.endzeit!= ""}&nbsp;-&nbsp;{$eintrag.endzeit|date_format:"%H:%M"}{/if}</div>
		<div class="snk-eintrag-titel col-sm-4 col-md-5">
			{if $eintrag.Description || $eintrag.plz || $eintrag.ort || $eintrag.Organizer || $eintrag.Target_Group || $eintrag.URL}
			<a
				href="#snk-termin-{$eintrag.id}" class="snk-termin-link"
				onclick="if(snk_show_termin) return snk_show_termin({$eintrag.id},this); "
			>
				{$eintrag.titel|htmlentities|nl2br}
			</a>{else}{$eintrag.titel|htmlentities|nl2br}{/if}
		</div>
		<div class="snk-eintrag-stufe col-sm-1 col-md-1">
			{foreach from=$eintrag.stufe.records item=stufe}
				<img src="{$SNK_URL}2.0/images/{$stufe.id}.gif" alt="{$stufe.bezeichnung|htmlentities|nl2br}"{$xhtmlend}>
			{/foreach}			
		</div>
		<div class="snk-eintrag-kategorien col-sm-2 col-md-3">{$eintrag.kategorie|htmlentities|nl2br}</div>
	</div>
	{if $eintrag.Description || $eintrag.plz || $eintrag.ort || $eintrag.Organizer || $eintrag.Target_Group || $eintrag.URL}
	<div id="snk-termin-{$eintrag.id}" class="snk-termin-infos row">
		<div class="col-sm-12 col-md-2">
			<dl>
					{if $eintrag.Description}<dt class="snk-eintrag-beschreibung">Beschreibung</dt><dd>{$eintrag.Description|nl2br}</dd>{/if}
					{if $eintrag.plz || $eintrag.ort}<dt class="snk-eintrag-ort">Ort</dt><dd>{$eintrag.plz|htmlentities|nl2br} {$eintrag.ort|htmlentities|nl2br}</dd>{/if}
					{if $eintrag.Organizer}<dt class="snk-eintrag-veranstalter">Veranstalter</dt><dd>{$eintrag.Organizer|htmlentities|nl2br}</dd>{/if}
					{if $eintrag.Target_Group}<dt class="snk-eintrag-zielgruppe">Zielgruppe</dt><dd>{$eintrag.Target_Group|htmlentities|nl2br}</dd>{/if}
					{if $eintrag.URL}<dt class="snk-eintrag-url">Link</dt><dd><a {if $smarty.get.link_target}target="{$smarty.get.link_target}" {/if}href="{$eintrag.URL}">{if $eintrag.URL_Text|htmlentities|nl2br}{$eintrag.URL_Text}{else}{$eintrag.URL|htmlentities|nl2br}{/if}</a></dd>{/if}
					<dt class="snk-eintrag-autor">Eingetragen von</dt><dd>{if $eintrag.autor.vorname || $eintrag.autor.nachname}{$eintrag.autor.vorname|htmlentities|nl2br}&nbsp;{$eintrag.autor.nachname|htmlentities|nl2br}{else}{$eintrag.autor.nickname|htmlentities|nl2br}{/if}</dd>
			</dl>
		</div>
	</div>
	{/if}
	{/foreach} 
	{/foreach} 
</div>
</div>
</div>
<div class="snk-footer">
	<div class="snk-hinzufuegen">
		<a href="https://www.scoutnet.de/community/kalender/events.html?task=create&amp;SSID={$kalender.id}" target="_top">Termin&nbsp;hinzufügen</a>
	</div>
	<div class="snk-powered-by">
		Powered by <span><a href="http://kalender.scoutnet.de/" target="_top">ScoutNet.DE</a></span>
	</div>
</div>
</div>

<!--  color:#3333FF; background-color: #FF9933; -->
{* Inhalt Ende *}

{* Fußbereich *}
{if !isset($urlparameters.onlybody)}
</body>
</html>
{/if}
{* Fußbereich ENDE *}

{* Captured Daten ausgeben *}
{/capture}{if !isset($smarty.request.nostrip)}{$smarty.capture.content|strip}{else}{$smarty.capture.content}{/if}
