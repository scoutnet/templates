{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}
{*
	Name : Kalender 2.0 Template - psv
	Dateiname : modulsystem.tpl
	Autor : Stefan Herfs
	Letzte Änderung : 15.06.2004
	Version : 1.0
	notwendige Konfiguration : keine
	Bemerkungen : Das Template gibt Kalenderdaten getrennt (durch Semikolon) aus.
 *}
{assign var="groups" value=$groups.jahrmonat}
{/strip}
{foreach from=$groups item=monat}
{foreach from=$monat.eintraege item=eintrag}
{$eintrag.kalender.ebene};{$eintrag.id};{$eintrag.startdatum|date_format:"%d.%m.%Y"};{$eintrag.startzeit|date_format:"%H:%M"};{$eintrag.enddatum|date_format:"%d.%m.%Y"};{$eintrag.endzeit|date_format:"%H:%M"};{$eintrag.titel};{$eintrag.kategorie};{$eintrag.stufe.bezeichnungen};{$eintrag.autor.vorname};{$eintrag.autor.nachname};{$eintrag.autor.nickname}
{/foreach}
{/foreach}
