<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
{capture name=wmlcontent}

	{assign var="last_displayed_year" value="1900"}
	
	{* Zuweisung der richtigen Gruppe (nur nötig, wenn man den URL-Parameter groupby nicht übergibt) *}
	{if $groups.jahrmonat}
		{assign var="groups" value="`$groups.jahrmonat`"}
	{/if}
	

<wml>
	{* Karte mit der Liste der Termineinträge *}
	<card id="start" title="{$kalender.ebene} {$kalender.name}">
		
			{* Schleife ueber die Monate*}
			{foreach from=$groups item=monat}
				{if $last_displayed_year != $monat.startdatum|date_format:"%Y"}
					<p><b>{$monat.startdatum|date_format:"%Y"}</b></p>
					{assign var="last_displayed_year" value=$monat.startdatum|date_format:"%Y"}
				{/if}
				
				<p><b>{$monat.startdatum|date_format:"%B '%y"}</b>
				
				{* Schleife ueber die Termineintraege eines Monats *}
				{foreach from=$monat.eintraege item=eintrag}
				
					{* Termineintrag *} 
					<br/>{$eintrag.startdatum|date_format:"%A"|truncate:2:""} 
					<b>{$eintrag.startdatum|date_format:"%d.%m."}</b> 
					{if $eintrag.startzeit!= ""}
						{$eintrag.startzeit|date_format:"%H:%M"} 
					{/if}
					{if $eintrag.enddatum != "" || $eintrag.endzeit != ""}
						- 
						{if $eintrag.enddatum != ""}
							{$eintrag.enddatum|date_format:"%A"|truncate:2:""} 
							<b>{$eintrag.enddatum|date_format:"%d.%m."}</b> 
						{/if}		       		
						{if $eintrag.endzeit != ""}
						{$eintrag.endzeit|date_format:"%H:%M"} 
						{/if}
					{/if}
					
					<b><a href='#_{$eintrag.id}'>{$eintrag.titel}</a></b>
					
					
				{/foreach} {* Termineintraege eines Monats *}
				</p>
			{/foreach} {* Monate *}

		</card>
		
		
		{* Schleife ueber die Monate*}
		{foreach from=$groups item=monat}
			{* Schleife ueber die Termineintraege eines Monats *}
			{foreach from=$monat.eintraege item=eintrag}
			
			{* Karte(n) mit den Details zu einem Termin *}
				<card id="_{$eintrag.id}" title="{$kalender.ebene} {$kalender.name}">		
					<p>
						{$eintrag.startdatum|date_format:"%A"|truncate:2:""} 
						<b>{$eintrag.startdatum|date_format:"%d.%m."}</b> 
						{if $eintrag.startzeit!= ""}
							{$eintrag.startzeit|date_format:"%H:%M"} 
						{/if}
						{if $eintrag.enddatum != "" || $eintrag.endzeit != ""}
							- 
							{if $eintrag.enddatum != ""}
								{$eintrag.enddatum|date_format:"%A"|truncate:2:""} 
								<b>{$eintrag.enddatum|date_format:"%d.%m."}</b> 
							{/if}		       		
							{if $eintrag.endzeit != ""}
							{$eintrag.endzeit|date_format:"%H:%M"} 
							{/if}
						{/if}
						<br/>
					
						<b>{$eintrag.titel}</b>
						
						<br/>{$eintrag.kalender.ebene}    {$eintrag.kalender.name}
						
						{if $eintrag.stufe.bezeichnungen != ""}
							<br/>Stufe(n): {$eintrag.stufe.bezeichnungen}
						{/if}
						    
						
						{if $eintrag.ort != ""}
							<br/>Ort: {$eintrag.ort}
						{/if}
						
						{if $eintrag.kategorie != ""}
							<br/>Kategorie: {$eintrag.kategorie}
						{/if}
						
						{if $eintrag.Description != ""}
							<br/>Info: {$eintrag.Description|nl2br}
						{/if}
						
						{* <br/>ID: {$eintrag.id} *}
						
						{assign var="LastID" value=$eintrag.id}
					</p>
				</card>
				
			{/foreach} 
		{/foreach} 

</wml> 
		
{/capture}
{$smarty.capture.wmlcontent|strip}