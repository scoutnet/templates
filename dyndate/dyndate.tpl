{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}
{*
	Name : Kalender 2.0 Template - DynDate
	Dateiname : dyndate.tpl
	Autor : Scoutnet Kalender-Team - Christopher Vogt
	Letzte Änderung : 29.09.2003
	Version : 1.0
	notwendige Konfiguration : keine
	Bemerkungen : Diese Template wird einem anderen Template vorgeschoben um das Datum dynamisch anzupassen,
	              falls etwas nicht funktioniert bitte erst im neuen Forum (kalender.scoutnet.de) lesen, 
				  erst dann mail an uns, Gut Pfad, Christopher, Kalender-Team ScoutNet
	              P.S. Vielen Dank an Rocky (rocky@dpsg-lh.de) für die Idee für dieses Template.
*}

{********************************************************************************************}
{*                                       EINSTELLUNGEN                                      *}
{********************************************************************************************}
{**}                                                                                      {**}
{**}              {* Template über das der Kalender aufgerufen werden soll *}             {**}
{**}    {assign var="template" value="`$template_path`/../modulsystem/modulsystem.tpl"}   {**}
{**}                                                                                      {**}
{**}                               {* Datums-Einstellungen *}                             {**}
{**}            {* (Entsprechende Zeile löschen um Begrenzung abzuschalten) *}            {**}
{**}	                  {assign var="monate_im_nachhinein" value=2}                     {**}
{**}                        {assign var="monate_im_voraus" value=5}                       {**}
{**}                                                                                      {**}
{********************************************************************************************}


{* automatische Datumsbestimmungen *}
	{assign var="aktuelles_datum" value=$smarty.now|date_format:"%Y-%m-%d" }
	{assign var="aktueller_tag" value=$aktuelles_datum|date_format:"%d"|intval}
	{assign var="aktueller_monat" value=$aktuelles_datum|date_format:"%m"|intval}
	{assign var="aktuelles_jahr" value=$aktuelles_datum|date_format:"%Y"|intval}
{if isset($monate_im_voraus)}
	{* Bestimmung des Startmonats und Startjahres des Templates anhand der obigen Konfigurationseinstellungen *}
	{if ($aktueller_monat-$monate_im_nachhinein) < 1}
		{math equation="((a - b) % 12) + 12" a=$aktueller_monat b=$monate_im_nachhinein assign="start_monat"}
		{math equation="ceil((abs(a - b)+1) / 12)" a=$aktueller_monat b=$monate_im_nachhinein assign="jahre_im_nachhinein"}
		{math equation="a - b" a=$aktuelles_jahr b=$jahre_im_nachhinein assign="start_jahr"}
	{else}
		{math equation="a - b" a=$aktueller_monat b=$monate_im_nachhinein assign="start_monat"}
		{assign var="start_jahr" value=$aktuelles_jahr}
	{/if}
	{assign var="start_jahr" value=$start_jahr|string_format:"%02s"}
	{assign var="start_monat" value=$start_monat|string_format:"%02s"}
	{assign var="startdate" value="`$start_jahr`-`$start_monat`-01"}
{/if}

{if isset($monate_im_nachhinein)}
	{* Bestimmung des Endmonats und Endjahres des Templates anhand der obigen Konfigurationseinstellungen *}
	{if ($aktueller_monat + $monate_im_voraus) > 12}
		{math equation="((a + b) % 12)" a=$aktueller_monat b=$monate_im_voraus assign="end_monat"}
		{math equation="floor((a + b - 1) / 12)" a=$aktueller_monat b=$monate_im_voraus assign="jahre_im_voraus"}
		{math equation="a + b" a=$aktuelles_jahr b=$jahre_im_voraus assign="end_jahr"}
	{else}
		{math equation="a + b" a=$aktueller_monat b=$monate_im_voraus assign="end_monat"}
		{assign var="end_jahr" value=$aktuelles_jahr}
	{/if}
	{assign var="end_jahr" value=$end_jahr|string_format:"%02s"}
	{assign var="end_monat" value=$end_monat|string_format:"%02s"}
	{assign var="enddate" value="`$end_jahr`-`$end_monat`-01"}
{/if}


{* automatische Linkerstellung *}
{assign var="link" value="http://kalender.scoutnet.de/2.0/show.php?id=`$url_parameters.id`&template=`$template`&groupby=startdatum.%Y-%m&ebenenup=0"}


{if $startdate}{assign var="link" value="`$link`&startdate=`$startdate`"}{/if}
{if $enddate}{assign var="link" value="`$link`&enddate=`$enddate`"}{/if}




{* HTML CODE *}{/strip}
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<title>Scoutnet-Kalender für {$kalender.ebene} {$kalender.name}</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<frameset rows="*,0" frameborder="NO" border="0" framespacing="0">
    <frame src="{$link}" name="Kalender">
    <frame src="UntitledFrame-27" scrolling="NO" noresize >
</frameset>
<noframes>
		<body>
			<div align="center"><center>
			Ihr Browser unterstützt keine Frames!<br><br>
			<a href="{$link}" target="_self">Hier gehts weiter zum Scoutnet-Kalender für {$kalender.ebene} {$kalender.name}!</a>
			</center></div>
		</body>
</noframes>
</html>

</html>