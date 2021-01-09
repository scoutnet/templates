{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}

{* START - Überschreiben der STANDARDKONFIGURATION durch Parameter *}
	{assign_array var="configvars" values="bgcolor;background;bgproperties;fontcolor;fontsize;fontface;fett;kursiv" delimiter=";"} 
	{foreach item=configvar from=$configvars}
		{if isset($urlparameters.$configvar)}
			{assign var=$configvar value=$urlparameters.$configvar} 
			{assign var="configvars.$configvar" value=$urlparameters.$configvar}
        {else}
            {assign var=$configvar value=""}
            {assign var="configvars.$configvar" value=""}
        {/if}
	{/foreach}
		
{*  ENDE - Überschreiben der STANDARDKONFIGURATION durch Parameter *}


	{* Sonstiges *}
    {assign var="starttags" value=""}
    {assign var="endtags" value=""}

	{if $fett && $fett != "false"}
		{assign var="starttags" value="<b>"}
		{assign var="endtags" value="</b>"}
	{/if}

	{if $kursiv && $kursiv!="false"}
		{assign var="starttags" value="$starttags<i>"}
		{assign var="endtags" value="</i>$endtags"}
	{/if}




{/strip}<html>

<head>
<title>Termin &quot;{$eintrag.titel}&quot;, {$eintrag.startdatum|date_format:"%A"|truncate:2:""}{$eintrag.startdatum|date_format:", %d.%m."} {if $eintrag.enddatum!= ""}&nbsp;-&nbsp;{$eintrag.enddatum|date_format:"%A"|truncate:2:""}{$eintrag.enddatum|date_format:", %d.%m."}{/if}, {$eintrag.startzeit|date_format:"%H:%M"} {if $eintrag.endzeit!= ""}&nbsp;-&nbsp;{$eintrag.endzeit|date_format:"%H:%M"} {/if} für {$eintrag.kalender.ebene} {$eintrag.kalender.name}</title>
<base target=_blank>
</head>

<body bgcolor=#{$bgcolor} {if $background&&$background!="false"}background={$background} {/if}{if $bgproperties&&$bgproperties!="false"}bgproperties={$bgproperties} {/if}link=#{$fontcolor} vlink=#{$fontcolor} alink=#{$fontcolor}>

{strip}<table border=0 cellspacing=0 cellpadding=3>
  <tr>
    <td valign="top"><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if} color="#{$fontcolor}"><b>Titel:</b></font></td>
    <td width=20></td>
    <td><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if} color="#{$fontcolor}">{$starttags}{$eintrag.titel}{$endtags}</font></td>
  </tr>
  <tr>
    <td valign="top"><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if} color="#{$fontcolor}"><b>Stufen:</b></font></td>
    <td width=20></td>
    <td><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if} color="#{$fontcolor}">{$starttags}{$eintrag.stufe.bezeichnungen}{$endtags}</font></td>
  </tr>
  <tr>
    <td valign="top"><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if} color="#{$fontcolor}"><b>Kategorie:</font></td>
    <td width=20></td>
    <td><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if} color="#{$fontcolor}">{$starttags}{$eintrag.kategorie}{$endtags}</b></font></td>
  </tr>
  <tr>
    <td valign="top"><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if} color="#{$fontcolor}"><b>Datum:</font></td>
    <td width=20></td>
    <td><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if} color="#{$fontcolor}">{$starttags}{$eintrag.startdatum|date_format:"%A"|truncate:2:""}{$eintrag.startdatum|date_format:"., %d.%m.%y"} {if $eintrag.enddatum!= ""}&nbsp;-&nbsp;{$eintrag.enddatum|date_format:"%A"|truncate:2:""}{$eintrag.enddatum|date_format:"., %d.%m.%y"}{/if}{$endtags}</font></td>
  </tr>
{if isset($eintrag.startzeit) && $eintrag.startzeit}
  <tr>
    <td valign="top"><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if} color="#{$fontcolor}"><b>Uhrzeit:</b></font></td>
    <td width=20></td>
    <td><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if} color="#{$fontcolor}">{$starttags}{$eintrag.startzeit|date_format:"%H:%M"} {if $eintrag.endzeit!= ""}&nbsp;-&nbsp;{$eintrag.endzeit|date_format:"%H:%M"} {/if} Uhr{$endtags}</font></td>
  </tr>
{/if}
  <tr>
    <td><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if} color="#{$fontcolor}"><b>Autor:</b></font></td>
    <td width=20></td>
    <td><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if} color="#{$fontcolor}">{$starttags}{if $eintrag.autor.vorname || $eintrag.autor.nachname}{$eintrag.autor.vorname}&nbsp;{$eintrag.autor.nachname}{else}{$eintrag.autor.nickname}{/if}{$endtags}</font></td>
  </tr>
  <tr>
    <td valign="top"><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if} color="#{$fontcolor}"><b>Infos:</b></font></td>
    <td width=20></td>
    <td><font size="{$fontsize}" {if $fontface}face="{$fontface}" {/if} color="#{$fontcolor}">{$starttags}{$eintrag.info|nl2br}{$endtags}</font></td>
  </tr>
</table>{/strip}

</body>

</html>