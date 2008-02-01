{capture name=dummy}{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}
{*
	Name : ScoutNet Standard Template
	Autor : Scoutnet Kalender-Team (Christopher Vogt)
	Letzte Änderung : 01.02.2008
	Version : 1
*}
{* Anleitung *}

	Dieses Template stellt den Kalender als Tabelle bereit.	
	Folgende Parameter können in der URL (per get oder post) übergeben werden, um das Verhalten des templates zu verändern:

	&onlybody  -  Zum Einbinden in eine existierende Webseite, werden hiermit nur der Inhalt des <body> tags ausgegeben.
	
	&xhtml - Passt den Doctype an und erzeugt schließende / bei tags wo das nötig ist.
	
	&css=http://deineseite.de/dein-stylesheet.css - um ein eigenes stylesheet anzugeben

{* Anleitung ENDE *}

{* Initialisierung *}
	{* Zuweisung der richtigen Gruppe (nur nötig, wenn man den URL-Parameter groupby nicht übergibt) *}
	{if $groups.jahrmonat}
		{assign var="groups" value="`$groups.jahrmonat`"}
	{/if}
	{if isset($smarty.request.css)}
		{assign var="css" value=`$smarty.request.css`}
	{else}
		{assign var="php_self" value=$smarty.server.PHP_SELF|dirname}
		{assign var="css" value="`$php_self`/templates/scoutnet/style.css"}
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
	<title>ScoutNet-Kalender f&uuml;r {$kalender.ebene} {$kalender.name}</title>
	<link rel="stylesheet" type="text/css" href="{$css}" media="screen"{$xhtmlend}>
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
			<select
				id="snk-auswahlbox"
				name="ebenenup"
				onchange="location.href='{$smarty.server.PHP_SELF}?{$smarty.server.QUERY_STRING|htmlentities}&amp;ebenenup='+getElementById('snk-auswahlbox').options[getElementById('snk-auswahlbox').selectedIndex].value; return false;"
			>
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
					{$temp_kalender.ebene}
				</option>
				{/if}
			{assign var="temp_kalender" value=$temp_kalender.gehoertzu}
		{/section}
	    </select>
	    	<noscript><input type="submit" value="anzeigen"{$xhtmlend}></noscript>
	    	<script type="text/javascript">document.write('anzeigen');</script>
	    </form>
	{/if}
</div>

<div class="snk-termine">
<table>
	<caption>ScoutNet-Kalender f&uuml;r {$kalender.ebene}&nbsp;{$kalender.name}</caption>
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
				href="#snk-termin-{$eintrag.id}"
				{literal}onclick="x=document.getElementById('snk-termin-{/literal}{$eintrag.id}{literal}');if(!this.putstyle)this.putstyle='table-row';this.putstyle2='block'; if(x.style.display == this.putstyle || x.style.display == this.putstyle2) {x.style.display = 'none';this.style.color = 'blue'; } else {try{x.style.display =this.putstyle;}catch(e){x.style.display =this.putstyle2;}this.style.color = 'red'; } return false;"{/literal}
			>
				{$eintrag.titel}
			</a>{else}{$eintrag.titel}{/if}
		</td>
		<td class="snk-eintrag-stufe">
			{foreach from=$eintrag.stufe.records item=stufe}
				<img src="http://kalender.scoutnet.de/2.0/images/{$stufe.id}.gif" alt="{$stufe.bezeichnung}"{$xhtmlend}>
			{/foreach}			
		</td>
		<td class="snk-eintrag-kategorien">{$eintrag.kategorie}</td>
		<td class="snk-eintrag-ebene">{$eintrag.kalender.ebene}</td>
	</tr>
	<tr id="snk-termin-{$eintrag.id}" class="snk-termin-infos">
		<td colspan="6">
			<dl>
					{if $eintrag.Description}<dt class="snk-eintrag-beschreibung">Beschreibung</dt><dd>{$eintrag.Description|nl2br}</dd>{/if}
					{if $eintrag.plz && $eintrag.ort}<dt class="snk-eintrag-ort">Ort</dt><dd>{$eintrag.plz} {$eintrag.ort}</dd>{/if}
					{if $eintrag.Organizer}<dt class="snk-eintrag-veranstalter">Veranstalter</dt><dd>{$eintrag.Organizer}</dd>{/if}
					{if $eintrag.Target_Group}<dt class="snk-eintrag-zielgruppe">Zielgruppe</dt><dd>{$eintrag.Target_Group}</dd>{/if}
					{if $eintrag.URL}<dt class="snk-eintrag-zielgruppe">Link</dt><dd><a href="{$eintrag.URL}">{if $eintrag.URL_Text}{$eintrag.URL_Text}{else}{$eintrag.URL}{/if}</a></dd>{/if}
					<dt class="snk-eintrag-autor">Eingetragen von</dt><dd>{if $eintrag.autor.vorname || $eintrag.autor.nachname}{$eintrag.autor.vorname}&nbsp;{$eintrag.autor.nachname}{else}{$eintrag.autor.nickname}{/if}</dd>
			</dl>
		</td>
	</tr>
	<script type="text/javascript">document.getElementById('snk-termin-{$eintrag.id}').style.display = 'none';</script>
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

{/capture}{$smarty.capture.content|strip}


{capture name=dummy}{literal}
<SCRIPT language="javascript" type="text/javascript">
<!-- Begin
  function infoszeigen(id)
	{
	{/literal}{strip}
	popupWin = window.open('
	
	http://{$smarty.server.SERVER_NAME}{$smarty.server.PHP_SELF}?
	
	entryids='+id+'&
	template={$template_path}/infos_zeigen.tpl&
	bgcolor={$bgcolor}&
	{if $background&&$background!="false"}background={$background}&{/if}
	{if $bgproperties&&$bgproperties!="false"}bgproperties={$bgproperties}&{/if}
	fontcolor={$fontcolor}&fontsize={$fontsize}&
	{if $fontface}fontface={$fontface}&{/if}
	{if $kursiv&&$kursiv!="false"}fett={$fett}&{/if}
	{if $kursiv&&$kursiv!="false"}kursiv={$kursiv}{/if}
	
	','windy','toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no,copyhistory=no,scrollbars=yes,width=500,height=350,top='+((screen.height/2)-100)+',left='+((screen.width/2)-250)+'');
	{/strip}{literal}
	  if (parseFloat(navigator.appVersion) < 3) {
	  } else {
		popupWin.focus();
	  }
	}
//-->
</script>
{/literal}{/capture}