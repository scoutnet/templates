{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}
{*
	Name : Kalender 2.0 Template - psv
	Dateiname : modulsystem.tpl
	Autor : Scoutnet Kalender-Team - Christopher Vogt
	Letzte Änderung : 29.11.2003
	Version : 1.0
	notwendige Konfiguration : keine
	Bemerkungen : 
 *}
{assign var="monate" value=$groups.jahrmonattag}
{/strip}
{foreach from=$monate item=totem}
{foreach from=$totem.eintraege item=eintrag}
{$eintrag.url}|{if $eintrag.stufe.records|@count == 1 && $eintrag.stufe.ids != 5}{$eintrag.stufe.bezeichnungen}{else}{$eintrag.kalender.name}{/if}|{$eintrag.titel}|{$eintrag.startdatum|date_format:"%x"}{if !empty($eintrag.startzeit)}-{$eintrag.startzeit|date_format:"%H.%M"}{/if}|{$eintrag.enddatum|date_format:"%x"}{if !empty($eintrag.endzeit)}-{$eintrag.endzeit|date_format:"%H.%M"}{/if}|{$eintrag.ort}
{/foreach}{/foreach}
