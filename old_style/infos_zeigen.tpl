<html>

<head>
<title>Termin &quot;{$eintrag.titel}&quot;, {$eintrag.startdatum|date_format:"%A"|truncate:2:""}{$eintrag.startdatum|date_format:". %d.%m."} {if $eintrag.enddatum!= ""}&nbsp;-&nbsp;{$eintrag.startdatum|date_format:"%A"|truncate:2:""}{$eintrag.startdatum|date_format:". %d.%m."}{/if}, {$eintrag.startzeit|date_format:"%H:%M"} {if $eintrag.endzeit!= ""}&nbsp;-&nbsp;{$eintrag.endzeit|date_format:"%H:%M"} {/if} für {$eintrag.kalender.ebene} {$eintrag.kalender.name}</title>
<base target=_blank>
</head>

<body bgcolor=#ffffff bgproperties=fixed link=#000000 vlink=#000000 alink=#000000>
<table border=0 cellspacing=0 cellpadding=3>
  <tr>
    <td valign="top"><font size="2" face="Arial" color="#000000"><b>Titel:</b></font></td>
    <td width=20></td>
    <td><font size="2" face="Arial" color="#000000">{$eintrag.titel}</font></td>
  </tr>
  <tr>
    <td valign="top"><font size="2" face="Arial" color="#000000"><b>Stufen:</b></font></td>
    <td width=20></td>
    <td><font size="2" face="Arial" color="#000000">{$eintrag.stufe.bezeichnungen}</font></td>
  </tr>
  <tr>
    <td valign="top"><font size="2" face="Arial" color="#000000"><b>Kategorie:</font></td>
    <td width=20></td>
    <td><font size="2" face="Arial" color="#000000">{$eintrag.kategorie}</b></font></td>
  </tr>
  <tr>
    <td valign="top"><font size="2" face="Arial" color="#000000"><b>Datum:</font></td>
    <td width=20></td>
    <td><font size="2" face="Arial" color="#000000">{$eintrag.startdatum|date_format:"%A"|truncate:2:""}{$eintrag.startdatum|date_format:". %d.%m."} {if $eintrag.enddatum!= ""}&nbsp;-&nbsp;{$eintrag.startdatum|date_format:"%A"|truncate:2:""}{$eintrag.startdatum|date_format:". %d.%m."}{/if}</font></td>
  </tr>
{if isset($eintrag.startzeit) && $eintrag.startzeit}
  <tr>
    <td valign="top"><font size="2" face="Arial" color="#000000"><b>Uhrzeit:</b></font></td>
    <td width=20></td>
    <td><font size="2" face="Arial" color="#000000">{$eintrag.startzeit|date_format:"%H:%M"} {if $eintrag.endzeit!= ""}&nbsp;-&nbsp;{$eintrag.endzeit|date_format:"%H:%M"} {/if}</font></td>
  </tr>
{/if}
  <tr>
    <td><font size="2" face="Arial" color="#000000"><b>Autor:</b></font></td>
    <td width=20></td>
    <td><font size="2" face="Arial" color="#000000">{$eintrag.autor.nickname}</font></td>
  </tr>
  <tr>
    <td valign="top"><font size="2" face="Arial" color="#000000"><b>Infos:</b></font></td>
    <td width=20></td>
    <td><font size="2" face="Arial" color="#000000">{$eintrag.info}</font></td>
  </tr>
</table>
</body>

</html>