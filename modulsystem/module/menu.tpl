{strip}
{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}

{*
	Name : Kalender 2.0 Template - Modul Menu_1 für Scoutnet Modulsystem 
	Dateiname : menu.tpl
	Autor : Scoutnet Kalender-Team - Christopher Vogt
	Letzte Änderung : 02.07.2003
	Version : 1.0
	notwendige Konfiguration : keine
	W3C konformität : Transitional (nur wenn im Modulsystem $force_w3c true ist)
	Bemerkungen : 	Diese Template ist als Modul für das Scoutnet Modulsystem gedacht und
					stellt ein simples Menü zur Auswahl der angezeigten Kategorien Stufen und Ebenen (Stamm, Bezirk,etc.) dar
 *}

{*********          START DES KONFIGURATIONS-BEREICHS        *********}
	{* Anzahl der Ebenen die nach oben angeboten werden sollen
		für einen Stamm der DPSG beispielsweise 3 um auch Bezirk, Diözese und Verband anzubieten *}
	{assign var="ebenen" value=3}
	{* Anzahl der Zeilen der Auswahlmenüs, Standard ist die Anzahl der Stufen ($existing.stufen_ids|@count) *}
	{assign var="zeilen" value=$existing.stufen_ids|@count}
{*********          ENDE DES KONFIGURATIONS-BEREICHS         *********}

{if $force_w3c} <form name="form1" method="get" action=""> {/if}
<table border="0" cellspacing="0" cellpadding="3">
	<tr>
		<td>
			{if not $force_w3c} <form name="form1" method="get" action=""> {/if}
			{foreach from=$url_parameters key=name item=value}
				{if $name != "Submit" && $name != "stufen[]" && $name != "kategorien[]" &&$name != "stufen" && $name != "kategorien" && $name != "addids[]"}
					<input name="{$name}" type="hidden" value="{$value}">
				{/if}
			{/foreach}
			<select name="stufen[]" size="{$existing.stufen_ids|@count}" multiple id="stufen">
				{foreach from=$existing.stufen_ids item=stufen_id}
					<option value="{$stufen_id}" 
						{if in_array($stufen_id,$used.stufen_ids)}
							selected
						{/if}
						>
						{$existing.stufen.$stufen_id.bezeichnung}
					</option>
				{/foreach}
			</select>
		</td>
		<td>
			<select name="kategorien[]" size="{$existing.stufen_ids|@count}" multiple id="kategorien">
				{foreach from=$existing.kategorien_ids item=kategorien_id}
					<option value="{$kategorien_id}"
						{if in_array($kategorien_id,$used.kategorien_ids)}
							selected
						{/if}
						>{$existing.kategorien.$kategorien_id}</option>
				{/foreach}
			</select>
		</td>
		{if $kalender.id>3}
		<td>
			<select name="addids[]" size="{$existing.stufen_ids|@count}" multiple id="addids">
				{if isset($kalender.gehoertzu.gehoertzu.gehoertzu.id)&&$kalender.gehoertzu.gehoertzu.id>3}
					<option value="{$kalender.gehoertzu.gehoertzu.gehoertzu.id}" 
						{if in_array($kalender.gehoertzu.gehoertzu.gehoertzu.id,$used.kalender_ids)}
							selected
						{/if}
					>{$kalender.gehoertzu.gehoertzu.gehoertzu.ebene}&nbsp;{$kalender.gehoertzu.gehoertzu.gehoertzu.name}</option>
				{/if}
				{if isset($kalender.gehoertzu.gehoertzu.id)&&$kalender.gehoertzu.id>3}
					<option value="{$kalender.gehoertzu.gehoertzu.id}" 
						{if in_array($kalender.gehoertzu.gehoertzu.id,$used.kalender_ids)}
							selected
						{/if}
					>{$kalender.gehoertzu.gehoertzu.ebene}&nbsp;{$kalender.gehoertzu.gehoertzu.name}</option>
				{/if}
				{if isset($kalender.gehoertzu.id)&&$kalender.id>3}
					<option value="{$kalender.gehoertzu.id}" 
						{if in_array($kalender.gehoertzu.id,$used.kalender_ids)}
							selected
						{/if}
					>{$kalender.gehoertzu.ebene}&nbsp;{$kalender.gehoertzu.name}</option>
				{/if}
			</select>
		</td>
		{/if}
		<td>
			<input type="submit" name="Submit" value="aktualisieren">
			{if not $force_w3c} </form> {/if}
		</td>
	</tr>
</table>
{if $force_w3c} </form> {/if}
{/strip}