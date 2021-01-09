{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}
{*
	Name : Kalender 2.0 Template - Old Style
	Dateiname : old_style.tpl
	Autor : Scoutnet Kalender-Team - Christopher Vogt
	Letzte Änderung : 16.02.2008
	Version : 1.2
*}

{* START - STANDARDKONFIGURATIONSBEREICH entsprechend denen im Adminbereich des Kalender 1.0*}
	{* Hintergrundfarbe *}
	{assign var="bgcolor" value="ffffff"}
	{* Hintergrundbild *} {* für ein Hintergrundbild z.B. value="http://gandalf.wtal.de/grafik/haupthintergrund.gif" *}
	{assign var="background" value="false"}
	{* Hintergrundbild Eigenschaften *}	{* für ein fixiertes Hintergrundbild (Wasserzeichen) value="fixed" *}
	{assign var="bgproperties" value="false"} 
	{* Schriftfarbe *}
	{assign var="fontcolor" value="000000"}
	{* Schriftgröße *}
	{assign var="fontsize" value="2"}
	{* Schriftart *}
	{assign var="fontface" value="false"}
	{* Schrift Fett? *}
	{assign var="fett" value="false"} 
	{* Schrift Kursiv? *}
	{assign var="kursiv" value="false"} 
	{* Link und Überschrift verwenden? *}
	{assign var="link" value="true"} 
{*  ENDE - STANDARDKONFIGURATIONSBEREICH *}

{* START - Überschreiben der STANDARDKONFIGURATION durch Parameter *}
	{assign_array var="configvars" values="bgcolor;background;bgproperties;fontcolor;fontsize;fontface;link;fett;kursiv" delimiter=";"} 
	{foreach item=configvar from=$configvars}
		{if isset($urlparameters.$configvar)}
			{assign var=$configvar value=$urlparameters.$configvar}
		{/if}
	{/foreach}
		
{*  ENDE - Überschreiben der STANDARDKONFIGURATION durch Parameter *}


{* Sonstiges *}
{assign var="ueberschriftsize" value=$fontsize|math:"x+1"}
{assign var="ueberschriftface" value="Arial"}
{assign var="monatsface" value="Arial Black"}

{assign var="starttags" value=""}
{assign var="endtags" value=""}
{if $fett && $fett != "false"}
    {assign var="starttags" value="<b>"}
    {assign var="endtags" value="</b>"}
{/if}
{if $kursiv && $kursiv != "false"}
    {assign var="starttags" value="$starttags<i>"}
    {assign var="endtags" value="</i>$endtags"}
{/if}
	


{* Zuweisung der richtigen Gruppe (nur nötig, wenn man den URL-Parameter groupby nicht übergibt) *}
	{if $groups.jahrmonat}
		{assign var="groups" value=$groups.jahrmonat}
	{/if}
{/strip}{if !isset($urlparameters.onlybody)}<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ScoutNet-Kalender für {$kalender.ebene} {$kalender.name}</title>
{/if}
{literal}
<SCRIPT language="javascript" type="text/javascript">
<!-- Begin
  function infoszeigen(id)
    {
	{/literal}{strip}
    popupWin = window.open('
	
	https://{$smarty.server.SERVER_NAME}{$smarty.server.PHP_SELF}?
	
	entryids='+id+'&
	template={$template_path}/infos_zeigen.tpl&
	bgcolor={$bgcolor}&
	{if $background&&$background!="false"}background={$background}&{/if}
	{if $bgproperties&&$bgproperties!="false"}bgproperties={$bgproperties}&{/if}
	fontcolor={$fontcolor}&fontsize={$fontsize}&
	{if $fontface}fontface={$fontface}&{/if}
	{if $kursiv&&$kursiv!="false"}fett={$fett}&{/if}
	{if $kursiv&&$kursiv!="false"}kursiv={$kursiv}{/if}
	
	','windy','toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no,copyhistory=no,scrollbars=yes,width=500,height=350,top='+((screen.height/2)-100)+',left='+((screen.width/2)-250)+'');
	{/strip}{literal}
	  if (parseFloat(navigator.appVersion) < 3) {
	  } else {
		popupWin.focus();
	  }
    }
//-->
</script>
{/literal}{if !isset($urlparameters.onlybody)}
</head>
<body bgcolor=#{$bgcolor} {if $background&&$background!="false"}background={$background} {/if}{if $bgproperties&&$bgproperties!="false"}bgproperties={$bgproperties} {/if}link=#{$fontcolor} vlink=#{$fontcolor} alink=#{$fontcolor}>{/if}

{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}
{assign var="parameters" value=$parameters|default:""}
{foreach from=$url_parameters key=name item=value}
	{if $name != "ebenenup" && $name != "groupby"}
		{assign var="parameters" value="$parameters$name=$value&"}
	{/if}
{/foreach}

<table width=100% border=0 cellspacing=0 cellpadding=0>
  <tr>
    <td width=30%><div align=left><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if}color="#{$fontcolor}">{$smarty.now|date_format:"Heute ist %A, der %d.%m.%Y.<br>Es ist %H:%M Uhr."}</font></div></td>
	<td align=center width=40%>{if (($link==true)&&($link!="false"))}<div align="center"><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if}>{if $kalender.homepage}<a href="{$kalender.homepage}" target="_parent">{/if}{$kalender.ebene}&nbsp;{$kalender.name}{if $kalender.homepage}</a>{/if}</font></div>{/if}</td>
    <td width=30%><div align=right>
	{if $kalender.id != 3}
		{assign var="temp_kalender" value=$kalender}
		<FORM method=get action=/><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if}color="#{$fontcolor}">Termine bis </font>
		<SELECT name=gotourl onChange='location.href=this.form.gotourl.options[this.form.gotourl.selectedIndex].value; return false;'>
		{section loop=10 name="menu"}
			{if $temp_kalender}
				<option value="{$smarty.server.PHP_SELF}?{$parameters|htmlentities}groupby=startdatum.%Y-%m&amp;ebenenup={$smarty.section.menu.index}"{if isset($url_parameters.ebenenup) && $url_parameters.ebenenup == $smarty.section.menu.index} selected{/if}> {$temp_kalender.ebene}</option>
                {assign var="temp_kalender" value=$temp_kalender.gehoertzu}
			{/if}
		{/section}
	    </SELECT><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if}color="#{$fontcolor}"> anzeigen...</font>
	    </form>
	{/if}</div>
    </td>
  </tr>
</table>
<br><br>
<center><table border=0 cellspacing=0 cellpadding=5>
    <tr> 
        <td align=left><font color="#{$fontcolor}" size="{$ueberschriftsize}" face="{$ueberschriftface}"><b> Datum </b></font></td>
        <td align=left><font color="#{$fontcolor}" size="{$ueberschriftsize}" face="{$ueberschriftface}"><b> Zeit </b></font></td>
        <td align=left><font color="#{$fontcolor}" size="{$ueberschriftsize}" face="{$ueberschriftface}"><b> Titel </b></font></td>
        <td align=left><font color="#{$fontcolor}" size="{$ueberschriftsize}" face="{$ueberschriftface}"><b> Kategorie </b></font></td>
        <td align=left><font color="#{$fontcolor}" size="{$ueberschriftsize}" face="{$ueberschriftface}"><b> Autor </b></font></td>
        <td align=left><font color="#{$fontcolor}" size="{$ueberschriftsize}" face="{$ueberschriftface}"><b> Ebene </b></font></td>
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
        <td><font color="#{$fontcolor}" face="{$monatsface}"><b>{$monat.startdatum|date_format:"%B 
            '%y"}</b></font></td>
        <td><br></td>
        <td><br></td>
        <td><br></td>
        <td><br></td>
        <td><br></td>
    </tr>
    {foreach from=$monat.eintraege item=eintrag} 
    <tr> 
        <td><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if}color="#{$fontcolor}">{$starttags}{$eintrag.startdatum|date_format:"%A"|truncate:2:""}{$eintrag.startdatum|date_format:", %d.%m."} {if $eintrag.enddatum!= ""}&nbsp;-&nbsp;{$eintrag.enddatum|date_format:"%A"|truncate:2:""}{$eintrag.enddatum|date_format:", %d.%m."}{/if}{$endtags}</font></td>
        <td><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if}color="#{$fontcolor}">{$starttags}{$eintrag.startzeit|date_format:"%H:%M"}{if $eintrag.endzeit!= ""}&nbsp;-&nbsp;{$eintrag.endzeit|date_format:"%H:%M"}{/if}{$endtags}</font></td>
        <td><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if}color="#{$fontcolor}">{$starttags}<a href="javascript:infoszeigen('{$eintrag.id}');">{$eintrag.titel}</a>{$endtags}</font></td>
        <td><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if}color="#{$fontcolor}">{$starttags}{$eintrag.kategorie}{$endtags}</font></td>
        <td><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if}color="#{$fontcolor}">{$starttags}{if $eintrag.autor.vorname || $eintrag.autor.nachname}{$eintrag.autor.vorname}&nbsp;{$eintrag.autor.nachname}{else}{$eintrag.autor.nickname}{/if}{$endtags}</font></td>
        <td><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if}color="#{$fontcolor}">{$starttags}{$eintrag.kalender.ebene}{$endtags}</font></td>
    </tr>
    {/foreach} 
	{/foreach} 
</table>
<br><p><div align=center>
<table border=0 cellspacing=0 cellpadding=0>
  <tr>
    <td width=10><p align=center><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if}color="#{$fontcolor}">[</font></td>
            <td><p><a href="https://www.scoutnet.de/technik/kalender/" target="_blank"><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if}color="#{$fontcolor}"><b>Infos&nbsp;zum&nbsp;ScoutNet-Kalender</b></font></a></p>
                </td>
    <td width=10><p align=center><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if}color="#{$fontcolor}">|</font></td>
    <td width=10><p align=center><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if}color="#{$fontcolor}">|</font></td>
            <td><a href="https://www.scoutnet.de/community/kalender/termine-bearbeiten/structure/{$kalender.id}/new" target="_blank"><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if}color="#{$fontcolor}"><b>Termin&nbsp;hinzufügen</b></font></a></td>
    <td width=10><p align=center><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if}color="#{$fontcolor}">]</font></td>
  </tr>
</table></div></center>
{/strip}
{if !isset($urlparameters.onlybody)}
</body>

</html>{/if}
