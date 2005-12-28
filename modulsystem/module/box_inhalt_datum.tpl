{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}

{*
	Name : Kalender 2.0 Template - Benötigt in den Modulen "Heutige Termine" und "Monas Tabellen" für Scoutnet Modulsystem 
	Dateiname : heutige.tpl
	Autor : Scoutnet Kalender-Team - Christopher Vogt
	Letzte Änderung : 04.11.2005
	Version : 1.0.4
	Änderungen in Version 1.0.4 - 04.11.2005:
		- Zeit jetzt ohne Sekunden :).
	Änderungen in Version 1.0.3 - 19.01.2005:
		- Termintitel ist unterstrichen
	Änderungen in Version 1.0.2 - 20.05.2004:
		- Modifier für Umwandlung und Entfernen der Zeilenumbrüche in den Infos, da sonst u.U. Javascriptfehler
	Änderungen in Version 1.0.1 - 16.07.2003:
		- Als Autor wird jetzt entweder Vor- und/oder Nachname angezeigt (wenn in der Community eingegeben) und sonst der Nickname des Autors
 *}

<ul>
{foreach from=$groups.$inhalt_datum.eintraege item=eintrag}
	<li>
		<b><u>{$eintrag.titel}</u></b>
			<br>
			{if $eintrag.enddatum != ""}
				<b>Zeitraum:</b>&nbsp;{$eintrag.startdatum|date_format:"%x"}&nbsp;bis&nbsp;{$eintrag.enddatum|date_format:"%x"}, 
			{else}
				<b>Zeit:</b>&nbsp;{$eintrag.startdatum|date_format:"%x"}
			{/if}
			{if $eintrag.endzeit != ""}
				&nbsp;{$eintrag.startzeit|date_format:"%H:%M"}&nbsp;bis&nbsp;{$eintrag.endzeit|date_format:"%H:%M"}
			{else}
				&nbsp;{$eintrag.startzeit|date_format:"%H:%M"}
			{/if}
		<br>
		<i>
		<b>Ort:</b>	{$eintrag.ort}
		</i>
		<br>
			<b>Autor:</b>&nbsp;{if $eintrag.autor.vorname || $eintrag.autor.nachname}{$eintrag.autor.vorname}&nbsp;{$eintrag.autor.nachname}{else}{$eintrag.autor.nickname}{/if}
		<br>
		<i>
		<b>Kategorie:</b>&nbsp;{$eintrag.kategorie}
		</i>
		<br>
			<b>Stufen:</b>&nbsp;{$eintrag.stufe.bildlich_scoutnet}
		<br>
		<i>
		<b>Kalender:</b>&nbsp;{$eintrag.kalender.ebene}&nbsp;{$eintrag.kalender.name} 
		</i>
	 	{if $eintrag.info != ""}
			<br>
			<b>Infos:</b>&nbsp;{$eintrag.info|nl2br|nolb}
		{/if}
	</li>
{/foreach}
</ul>
{/strip}
