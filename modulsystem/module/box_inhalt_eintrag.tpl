{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}

{*
	Name : Kalender 2.0 Template - Benötigt in den Modulen "Heutige Termine" für Scoutnet Modulsystem 
	Dateiname : heutige.tpl
	Autor : Scoutnet Kalender-Team - Christopher Vogt
	Letzte Änderung : 16.07.2003
	Version : 1.0.1
	Änderungen in Version 1.0.1 - 16.07.2003:
		- Als Autor wird jetzt entweder Vor- und/oder Nachname angezeigt (wenn in der Community eingegeben) und sonst der Nickname des Autors
 *}

<ul>
	<li>
		<b>{$eintrag.titel}</b>
			<br>
			{if $eintrag.enddatum != ""}
				<b>Zeitraum:</b>&nbsp;{$eintrag.startdatum|date_format:"%x"}&nbsp;bis&nbsp;{$eintrag.enddatum|date_format:"%x"}, 
			{else}
				<b>Zeit:</b>&nbsp;{$eintrag.startdatum|date_format:"%x"}
			{/if}
			{if $eintrag.endzeit != ""}
				&nbsp;{$eintrag.startzeit|date_format:"%X"}&nbsp;bis&nbsp;{$eintrag.endzeit|date_format:"%X"}
			{else}
				&nbsp;{$eintrag.startzeit|date_format:"%X"}
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
			<b>Infos:</b>&nbsp;{$eintrag.info}
		{/if}
	</li>
</ul>
{/strip}