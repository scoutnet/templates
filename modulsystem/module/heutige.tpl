{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}

{*
	Name : Kalender 2.0 Template - Modul "Heutige Termine" für Scoutnet Modulsystem 
	Dateiname : heutige.tpl
	Autor : Scoutnet Kalender-Team - Christopher Vogt
	Letzte Änderung : 08.07.2003
	Version : 1.0.1
	benötigte andere Dateien : box_inhalt_datum.tpl ; box_inhalt_eintrag.tpl
	notwendige Konfiguration : overlib_required muss im modulsystem auf true gesetzt werden
	W3C konformität : Transitional (nur wenn im Modulsystem $force_w3c true ist)
	Bemerkungen : 	Diese Template ist als Modul für das Scoutnetn Modulsystem gedacht und
					zeigt eine Liste der Termine des aktuellen Tages an
 *}
{* Zuweisung der richtigen Gruppe*} 
	{if $groups.jahrmonattag}
		{assign var="groups" value="`$groups.jahrmonattag`"}
	{/if}
<table border="0" cellspacing="0" cellpadding="3">
	<tr>
		<td align=center>	
			{if in_array($aktuelles_datum,$used.dates)}
				{include file="`$modulpfad`/box_inhalt_datum.tpl" assign="box_inhalt" inhalt_datum=$aktuelles_datum}
				<script>
					box_heutige_inhalt='{$box_inhalt|nl2br|nolb|html_entity_decode|escape:"quotes"}';
				</script>
				<a onmouseover="return overlib(box_heutige_inhalt, STICKY, CAPTION, 'Termine am {$aktueller_tag}.{$aktueller_monat}.{$aktuelles_jahr}', CENTER);" onmouseout="nd();">
					<font face="verdana,arial,helvetica" size="1"  color="#000000">
						<u>Heutige Termine</u>
					</font>
				</a>
				<br>
				{if $force_w3c} <ul compact> {/if}
					{foreach from=$groups[$aktuelles_datum].eintraege item=eintrag}
						<li>
							{include file="`$modulpfad`/box_inhalt_eintrag.tpl" assign="box_inhalt" eintrag=$eintrag}
                        	<script>
								box_eintrag{$eintrag.id}_inhalt='{$box_inhalt|nl2br|nolb|html_entity_decode|escape:"quotes"}';
							</script>
							<a onmouseover="return overlib(box_eintrag{$eintrag.id}_inhalt, STICKY, CAPTION, '{$eintrag.titel}', CENTER);" onmouseout="nd();">
								<font face="verdana,arial,helvetica" size="1"  color="#008800">
									<u>{$eintrag.titel}</u>
								</font>
							</a>
						</li>
					{/foreach}
				{if $force_w3c} </ul> {/if}
			{else}
				<font face="verdana,arial,helvetica" size="1"  color="#000000">
					<u>Heutige Termine</u>
				</font>
				{if $force_w3c} <ul compact> {/if}
					<li>
						<font face="verdana,arial,helvetica" size="1"  color="#008800">
							<i>keine</i>
						</font>
					</li>
				{if $force_w3c} </ul> {/if}
			{/if}
		</td>
    </tr>
</table>
{/strip}