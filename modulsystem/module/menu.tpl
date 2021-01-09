{strip}
{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}

{*
	Name : Kalender 2.0 Template - Modul Menu_1 für Scoutnet Modulsystem 
	Dateiname : menu.tpl
	Autor : Scoutnet Kalender-Team - Christopher Vogt
	Letzte Änderung : 27.01.2008
	Version : 1.0.2
	notwendige Konfiguration : keine
	Bemerkungen : 	Diese Template ist als Modul für das Scoutnet Modulsystem gedacht und
					stellt ein simples Menü zur Auswahl der angezeigten Kategorien Stufen und Ebenen (Stamm, Bezirk,etc.) dar
	W3C konformität : Transitional (nur wenn im Modulsystem $force_w3c true ist) (gilt für Version 1.0, Version 1.0.1 nicht getestet)
	Änderungen in Version 1.0.2 - 27.01.2008:
	    - BUGFIX: Bundesebene fehlt 
	Änderungen in Version 1.0.1 - 01.08.2003:
		- Hinweis zur An- und Abwahl durch Strg
 *}

{*********          START DES KONFIGURATIONS-BEREICHS        *********}
	{* Anzahl der Ebenen die nach oben angeboten werden sollen
		für einen Stamm der DPSG beispielsweise 3 um auch Bezirk, Diözese und Verband anzubieten *}
	{assign var="ebenen" value=3}
	{* Anzahl der Zeilen der Auswahlmenüs, Standard ist die Anzahl der Stufen ($existing.stufen_ids|@count) *}
	{assign var="zeilen" value=$existing.stufen_ids|@count}
{*********          ENDE DES KONFIGURATIONS-BEREICHS         *********}

{if $force_w3c} <form name="form1" method="get" action=""> {/if}
<table border="0" cellspacing="0" cellpadding="3" width="100%">
	<tr>
		<td valign="middle" align="center">
			<font size="2" face="Arial, Helvetica, sans-serif">(an- und abwählen mit<br>Strg gedrückt halten)</font></td>
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
			{assign var="temp_kalender" value=$kalender}
				{section loop=10 name="menu"}
					{if $temp_kalender}
					{if $temp_kalender.ebene_id == 8 || $temp_kalender.ebene_id == 7 || $temp_kalender.ebene_id == 5}
					<option value="{$temp_kalender.id}" 
						{if in_array($temp_kalender.id,$used.kalender_ids)}
							selected
						{/if}
					>
					{if $temp_kalender.ebene_id == 5}
					{$temp_kalender.ebene}
					{else}
					{$temp_kalender.ebene}&nbsp;{$temp_kalender.name}
					{/if}
					</option>
					{/if}
					{assign var="temp_kalender" value=$temp_kalender.gehoertzu}
					{/if}
				{/section}
			</select>
		</td>
		{/if}
		<td>
			<input type="submit" name="Submit" value="aktualisieren">{if not $force_w3c} </form> {/if}
		</td>
	</tr>
</table>
{if $force_w3c} </form> {/if}
{/strip}