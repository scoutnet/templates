{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}

{*
	Name : Kalender 2.0 Template - Modul "Link Footer" für Scoutnet Modulsystem 
	Dateiname : kalender_banner.tpl
	Autor : Scoutnet Kalender-Team - Christopher Vogt
	Letzte Änderung : 02.07.2003
	Version : 1.0
	notwendige Konfiguration : keine
	W3C konformität : Transitional
	Bemerkungen : 	Dieses Template ist als Modul für das ScoutNet Modulsystem gedacht und
					beinhaltet einen Link zur Community um Termine einzutragen und einen zuz dne KalenderInfos
 *}

<table border=0 cellspacing=0 cellpadding=3>
  <tr>
    <td width=10><p align=center><font size="2" face="Arial" color=#000000>[</font></td>
            <td><p><a href="https://www.scoutnet.de/technik/kalender/" target="_blank"><font size="2" face="Arial" color=#000000>Infos&nbsp;zum&nbsp;ScoutNet-Kalender</font></a></p>
                </td>
    <td width=10><p align=center><font size="2" face="Arial" color=#000000>|</font></td>
    <td width=10><p align=center><font size="2" face="Arial" color=#000000>|</font></td>
            <td><a href="https://www.scoutnet.de/community/kalender/termine-bearbeiten/structure/{$kalender.id}/new" target="_blank"><font size="2" face="Arial" color=#000000>Termin&nbsp;hinzufügen</font></a></td>
    <td width=10><p align=center><font size="2" face="Arial" color=#000000>]</font></td>
  </tr>
</table>

{/strip}