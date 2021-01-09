<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
{capture name=wmlcontent}

	{assign var="last_displayed_year" value="1900"}
	
	{* Zuweisung der richtigen Gruppe (nur nötig, wenn man den URL-Parameter groupby nicht übergibt) *}
	{if $groups.jahrmonat}
		{assign var="groups" value=$groups.jahrmonat}
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
		

		{* Ersten und letzten Termin bestimmen *}
		{foreach from=$groups item=monat name=monate}
			{* Schleife ueber die Termineintraege eines Monats *}
			{foreach from=$monat.eintraege item=eintrag name=eintraege}
				{if $smarty.foreach.monate.first && $smarty.foreach.eintraege.first}
					{assign var="erster_eintrag" value=$eintrag}
				{/if}
				
				{if $smarty.foreach.monate.last && $smarty.foreach.eintraege.last}
					{assign var="letzter_eintrag" value=$eintrag}
				{/if}
			{/foreach} 
		{/foreach} 
		
		{assign var=i value=0}
		{* Schleife ueber die Monate*}
		{foreach from=$groups item=monat name=monate}
			{* Schleife ueber die Termineintraege eines Monats *}
			{foreach from=$monat.eintraege item=eintrag name=eintraege}
				{assign var=i value=$i+1}
				{* Wir zeigen die Termine um eins verschoben an, um vorigen und nächsten schon zu kennen *}
				{assign var="vorheriger_eintrag" value=$aktueller_eintrag|default:null}
				{assign var="aktueller_eintrag" value=$naechster_eintrag|default:null}
				{assign var="naechster_eintrag" value=$eintrag}
				{if $aktueller_eintrag}
					{include file="wml/eintrag.tpl" eintrag=$aktueller_eintrag}
				{/if}
				{if $smarty.foreach.monate.last && $smarty.foreach.eintraege.last}
					{* Nach dem letzten Durchlauf noch den letzten Termin anzeigen *}
					{assign var="vorheriger_eintrag" value=$aktueller_eintrag}
					{assign var="aktueller_eintrag" value=$naechster_eintrag}
					{assign var="naechster_eintrag" value=""}
					{include file="wml/eintrag.tpl" eintrag=$aktueller_eintrag}
				{/if}
			{/foreach} 
		{/foreach} 

</wml> 
		
{/capture}
{$smarty.capture.wmlcontent|strip}