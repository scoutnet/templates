{*
	Name : Kalender 2.0 Template - Old Style
	Dateiname : old_style.tpl
	Autor : Scoutnet Kalender-Team - Christopher Vogt
	Letzte Änderung : 02.07.2003
	Version : 1.0
	notwendige Konfiguration : keine
	Bemerkungen : Dieses Template bietet das Design des Kalender 1.0
 *}

{* Zuweisung der richtigen Gruppe *}
	{if $groups.jahrmonat}
		{assign var="groups" value="`$groups.jahrmonat`"}
	{/if}
<html>
<head>
<title>ScoutNet-Kalender für {$kalender.ebene} {$kalender.name}</title>
{*foreach from=$url_parameters key=name item=value}
	{if $name != "Submit" && $name != "addids"}
		{assign var="url_parameters_ohne_addids"<input name="{$name}" type="hidden" value="{$value}">
	{/if}
{/foreach}
{foreach from=$url_parameters key=name item=value}
	{if $name != "Submit" && $name != "orderby"}
		{assign var="url_parameters_ohne_orderby"<input name="{$name}" type="hidden" value="{$value}">
	{/if}
{/foreach*}

{literal}
<SCRIPT LANGUAGE=JavaScript>
<!-- Begin
  function infoszeigen(id)
    {
    popupWin = window.open('show.php?template={/literal}{$template_path}{literal}/infos_zeigen.tpl&entryids='+id,'windy','toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no,copyhistory=no,scrollbars=yes,width=430,height=250,top='+((screen.height/2)-100)+',left='+((screen.width/2)-250)+'');
	  if (parseFloat(navigator.appVersion) < 3) {
	  } else {
		popupWin.focus();
	  }
    }
//-->
</script>
{/literal}
</head>
<body bgcolor=#ffffff bgproperties=fixed link=#000000 vlink=#000000 alink=#000000>

{foreach from=$url_parameters key=name item=value}
	{if $name != "ebenenup" && $name != "groupby"}
		{assign var="parameters" value="$parameters$name=$value&"}
	{/if}
{/foreach}

{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}
<table width=100% border=0 cellspacing=0 cellpadding=0>
  <tr>
    <td width=30%><div align=left><font size=2 face=Arial color=#000000>{$smarty.now|date_format:"Heute ist %A, der %d.%m.%Y.<br>Es ist %H:%M Uhr."}</font></div></td>
	<td align=center width=40%><div align=middle><font size=3 face=Arial color=#ffffff>{if $kalender.homepage}<a href="{$kalender.homepage}" target="_parent">{/if}{$kalender.ebene}&nbsp;{$kalender.name}{if $kalender.homepage}</a>{/if}</font></div></td>
    <td width=30%>
	{if $kalender.id != 3}
		{assign var="temp_kalender" value=$kalender}
   		<div align=right><FORM method=get action=/redirect.asp><font size=2 face=Arial color=#000000>Termine bis </font>
		<SELECT name=gotourl onChange='location.href=this.form.gotourl.options[this.form.gotourl.selectedIndex].value; return false;'>
		{section loop=10 name="menu"}
			{if $temp_kalender.id >= 3}
				<option value="show.php?{$parameters}groupby=startdatum.%Y-%m&ebenenup={$smarty.section.menu.index}"{if !isset($url_parameters.ebenenup) || $url_parameters.ebenenup == $smarty.section.menu.index} selected{/if}> {$temp_kalender.ebene}</option>
				{assign var="temp_kalender" value=$temp_kalender.gehoertzu}
			{/if}
		{/section}
	    </SELECT><font size=2 face=Arial color=#000000> anzeigen...</font>
	    </form></div>
	{/if}
    </td>
  </tr>
</table>
<br><br>
<center><table border=0 cellspacing=0 cellpadding=5>
    <tr> 
        <td align=left><font color=#000000 size=2 face=Arial><b> Datum </b></font></td>
        <td align=left><font color=#000000 size=2 face=Arial><b> Zeit </b></font></td>
        <td align=left><font color=#000000 size=2 face=Arial><b> Titel </b></font></td>
        <td align=left><font color=#000000 size=2 face=Arial><b> Kategorie </b></font></td>
        <td align=left><font color=#000000 size=2 face=Arial><b> Autor </b></font></td>
        <td align=left><font color=#000000 size=2 face=Arial><b> Ebene </b></font></td>
    </tr>
    {foreach from=$groups item=monat} 
    <tr> 
        <td><br></td>
        <td><br></td>
        <td><br></td>
        <td><br></td>
        <td><br></td>
        <td><br></td>
    </tr>
    <tr> 
        <td><font color=#000000 face='Arial Black'><b>{$monat.startdatum|date_format:"%B 
            '%y"}</b></font></td>
        <td><br></td>
        <td><br></td>
        <td><br></td>
        <td><br></td>
        <td><br></td>
    </tr>
    {foreach from=$monat.eintraege item=eintrag} 
    <tr> 
        <td><font size="2" face="Arial" color=#000000>{$eintrag.startdatum|date_format:"%A"|truncate:2:""}{$eintrag.startdatum|date_format:".%d.%m."} {if $eintrag.enddatum!= ""}&nbsp;-&nbsp;{$eintrag.startdatum|date_format:"%A"|truncate:2:""}{$eintrag.startdatum|date_format:".%d.%m."}{/if}</font></td>
        <td><font size="2" face="Arial" color=#000000> {$eintrag.startzeit|date_format:"%H:%M"}{if $eintrag.endzeit!= ""}&nbsp;-&nbsp;{$eintrag.endzeit|date_format:"%H:%M"}{/if}</font></td>
        {if $eintrag.info != ""} 
        	<td><font size="2" face="Arial" color=#000000> <a href=JavaScript:infoszeigen('{$eintrag.id}')>{$eintrag.titel}</a> 
            </font></td>
        {else} 
        <td><font size="2" face="Arial" color=#000000> {$eintrag.titel} </font></td>
        {/if} 
        <td><font size="2" face="Arial" color=#000000> {$eintrag.kategorie} </font></td>
        <td><font size="2" face="Arial" color=#000000> {if ( isset($eintrag.autor.vorname) 
            && isset($eintrag.autor.nachname) )} {$eintrag.autor.vorname}&nbsp;{$eintrag.autor.nachname} 
            {else} {$eintrag.autor.nickname} {/if}</font></td>
        <td><font size="2" face="Arial" color=#000000> {$eintrag.kalender.ebene} </font></td>
    </tr>
    {/foreach} 
	{/foreach} 
</table>
<br><p><div align=center>
<table border=0 cellspacing=0 cellpadding=0>
  <tr>
    <td width=10><p align=center><font size="2" face="Arial" color=#000000>[</font></td>
            <td><p><a href="http://kalender.scoutnet.de/infos/index.htm" target="_blank"><font size="2" face="Arial" color=#000000>Infos&nbsp;zum&nbsp;ScoutNet-Kalender</font></a></p>
                </td>
    <td width=10><p align=center><font size="2" face="Arial" color=#000000>|</font></td>
    <td width=10><p align=center><font size="2" face="Arial" color=#000000>|</font></td>
            <td><a href="http://community.scoutnet.de/" target="_blank"><font size="2" face="Arial" color=#000000>Termin&nbsp;hinzufügen</font></a></td>
    <td width=10><p align=center><font size="2" face="Arial" color=#000000>]</font></td>
  </tr>
</table></center>
</div>{/strip}

</body>

</html>
