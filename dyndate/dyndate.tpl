{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}
{*
	Name : Kalender 2.0 Template - DynDate
	Dateiname : dyndate.tpl
	Autor : Scoutnet Kalender-Team - Christopher Vogt
	Letzte Änderung : 29.09.2003
	Version : 1.1.3
	notwendige Konfiguration : keine
	W3C konformität : keine Relevanz da keine Ausgabe
	Bemerkungen : Diese Template wird einem anderen Template vorgeschoben um das Datum dynamisch anzupassen,
	              falls etwas nicht funktioniert bitte erst im neuen Forum (kalender.scoutnet.de) lesen, 
				  erst dann mail an uns, Gut Pfad, Christopher, Kalender-Team ScoutNet
	              P.S. Vielen Dank an Rocky (rocky@dpsg-lh.de) für die Idee für dieses Template.
	Änderungen in Version 1.1.5 - 14.11.2003:
		- Fehler wegen nicht angezeigten Daten im letzten angezeigten Monat behoben
	Änderungen in Version 1.1.4 - 29.09.2003:
		- Fehler in den Datumsgrenzen behoben
	Änderungen in Version 1.1.3 - 29.09.2003:
		- Wahl eines anderen Templates per link
	Änderungen in Version 1.1.2 - 29.09.2003:
		- Kleine Fehlerkorrektur im Link
	Änderungen in Version 1.1.1 - 29.09.2003:
		- Monatseinstellungen über die URL möglich
	Änderungen in Version 1.1 - 29.09.2003:
		- Direktes Einbinden statt über Frames
*}


{********************************************************************************************}
{*                                       EINSTELLUNGEN                                      *}
{********************************************************************************************}
{**}                                                                                      {**}
{**}              {* Template über das der Kalender aufgerufen werden soll *}             {**}
{**}    {assign var="template" value="modulsystem/modulsystem.tpl"}   {**}
{**}                                                                                      {**}
{**}                               {* Datums-Einstellungen *}                             {**}
{**}            {* (Entsprechende Zeile löschen um Begrenzung abzuschalten) *}            {**}
{**}	                  {assign var="monate_im_nachhinein" value=1}                     {**}
{**}                        {assign var="monate_im_voraus" value=4}                       {**}
{**}                   {assign var="url_parameter_vorziehen" value=true}                  {**}
{**}                                                                                      {**}
{********************************************************************************************}

{if isset($url_parameters.monate_im_nachhinein)}
	{assign var="monate_im_nachhinein" value=$url_parameters.monate_im_nachhinein}
{/if}
{if isset($url_parameters.monate_im_voraus)}
	{assign var="monate_im_voraus" value=$url_parameters.monate_im_voraus}
{/if}
{if isset($url_parameters.other_template)}
	{assign var="template" value=$url_parameters.other_template}
{/if}

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
	
	{if $end_monat==4||$end_monat==6||$end_monat==9||$end_monat==11}
		{assign var="end_tag" value="30"}
	{elseif $end_monat==2 && $end_jahr%4 && (!$end_jahr%100 || $end_jahr%1000)}
		{assign var="end_tag" value="29"}
	{elseif $end_monat==2}
		{assign var="end_tag" value="28"}
	{else}
		{assign var="end_tag" value="31"}
	{/if}

	{math equation="a + b" a=$aktuelles_jahr b=$jahre_im_voraus assign="end_jahr"}

	{assign var="enddate" value="`$end_jahr`-`$end_monat`-`$end_tag`"}
{/if}

{* automatische Linkerstellung *}
{assign var="link" value="http://kalender.scoutnet.de/2.0/show.php?id=`$url_parameters.id`&template=`$template`"}

{if $startdate}{assign var="link" value="`$link`&startdate=`$startdate`"}{/if}
{if $enddate}{assign var="link" value="`$link`&enddate=`$enddate`"}{/if}

{* HTML CODE *}{/strip}
{fetch file=$link}