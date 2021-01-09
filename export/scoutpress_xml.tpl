{strip}{* Entfernt alle unn�tigen Leerzeichen und Leerzeilen bis {/strip} *}
{*
	Name:         ScoutPress XML
	Version:      0.0.2
	Beschreibung: Erstellt eine einfache XML-Datei mit allen Informationen eines Termins.
	              Die XML-Datei wird dann in ScoutPress umgewandelt, gecached und weiterverarbeitet.
	              Vergleiche Delitious-XML-Api: http://del.icio.us/api/posts/all
	Autor:        Tobias Jordans
	Letzte �nderung: 27.11.2006 (Tobias Jordans)
	
	notwendige Konfiguration: erfolgt in ScoutPress
	
	Hilfe zu Smarty: http://smarty.php.net/manual/de/

	<posts update="2006-04-22T13:13:42Z" user="tordans">
	  <post href="http://www.asdf.com/" description="asdf" extended="asdf" hash="3f73499f1ccc233e7f2141c35cf28e4b" tag="suchen copyright" time="2006-04-22T13:13:42Z" />
*}
	{if $groups.jahrmonat}
		{assign var="groups" value=$groups.jahrmonat}
	{/if}
	{assign var="startdate" value=$url_parameters.startdate|default:''}
	{assign var="enddate" value=$url_parameters.enddate|default:''}

{/strip}<?xml version='1.0' encoding="ISO-8859-1" standalone='yes'?>
<calendar>
	<head>
		<id>{$kalender.id}</id>
		<title>{$kalender.Ident}</title>
		<association>{$eintrag.kalender.verband}</association>
		<level>{$eintrag.kalender.ebene}</level>
		<name>{$eintrag.kalender.name}</name>
		<update>{$smarty.now|date_format:"%Y-%m-%dT%H:%M:%SZ"}</update>
		<datestart>{$startdate|date_format:"%Y-%m-%d"}</datestart>
		<dateend>{$enddate|date_format:"%Y-%m-%d"}</dateend>
	</head>
	<dates>
{foreach from=$groups item=monat}
{foreach from=$monat.eintraege item=eintrag}
		<date id="{$eintrag.id}">
			<title>{$eintrag.titel}</title>
			<timestart>{$eintrag.startdatum|date_format:"%Y-%m-%d"}{$eintrag.startzeit|date_format:"T%H:%M:%SZ"}</timestart>
			<timeend>{if $eintrag.enddatum}{$eintrag.enddatum|date_format:"%Y-%m-%d"}{else}{$eintrag.startdatum|date_format:"%Y-%m-%d"}{/if}{$eintrag.endzeit|date_format:"T%H:%M:%SZ"}</timeend>
			<place>{$eintrag.ort}</place>
			<zipcode>{$eintrag.plz}</zipcode>
			<createdby>{if $eintrag.autor.vorname || $eintrag.autor.nachname}{$eintrag.autor.vorname} {$eintrag.autor.nachname}{else}{$eintrag.autor.nickname}{/if}</createdby>
			<updatedby>{$eintrag.changedby}</updatedby>
			<timecreated>{$eintrag.created|date_format:"%Y-%m-%dT%H:%M:%SZ"}</timecreated>
			<timeupdated>{$eintrag.changed|date_format:"%Y-%m-%dT%H:%M:%SZ"}</timeupdated>
			<categories>{$eintrag.kategorie}</categories>
			<groups>{$eintrag.stufe.bezeichnungen}{* zu jeder Stufe koennte ma noch speichern: Verband, Name, Alter, Farbe *}</groups>
			<organizer>{$eintrag.Organizer}</organizer>
			<targetgroup>{$eintrag.Target_Group}</targetgroup>
			<linkurl>{$eintrag.URL|htmlspecialchars}</linkurl>
			<linktext>{$eintrag.URL_Text|htmlspecialchars}</linktext>
			<description><![CDATA[{$eintrag.Description}]]></description>
		</date>
{/foreach}
{/foreach}
	</dates>
</calendar>
