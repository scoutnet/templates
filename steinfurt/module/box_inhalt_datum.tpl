{strip}
<ul>
{foreach from=$groups.$inhalt_datum.eintraege item=eintrag}
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
			<b>Autor:</b>&nbsp;{$eintrag.autor.vorname}&nbsp;{$eintrag.autor.nachname}
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
{/foreach}
</ul>
{/strip}