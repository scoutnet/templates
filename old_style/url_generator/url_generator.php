<?php
$__VARS=array_merge($_POST,$_GET);

if(!isset($__VARS[changed]))
	{
	$__VARS[fontface]="Times New Roman, Times, serif";
	$__VARS[bgcolor]="FFFFFF";
	$__VARS[background]="";
	$__VARS[bgproperties]=false;
	$__VARS[fontcolor]="000000";
	$__VARS[fontsize]="2";
	$__VARS[use_bgcolor]=true;
	//$__VARS[use_backgound]=true;
	//$__VARS[use_bgproperties]=true;
	$__VARS[use_fontcolor]=true;
	$__VARS[use_fontface]=true;
	$__VARS[use_fontsize]=true;
	//$__VARS[use_bold]=true;
	//$__VARS[use_italic]=true;
	$__VARS[use_link]=true;
	}		

$id=6;
	 $url="http://kalender.scoutnet.de/2.0/show.php?id=".$id."&template=old_style/old_style.tpl";
if($__VARS[use_bgcolor])$url.="&bgcolor=".$__VARS[bgcolor];
if($__VARS[use_background]) $url.="&background=".$__VARS[background]; 
else $url.="&background=false";
if($__VARS[use_bgproperties]) $url.="&bgproperties=fixed"; else $url.="&bgproperties=false";
if($__VARS[use_fontcolor])$url.="&fontcolor=".$__VARS[fontcolor];
if($__VARS[use_fontsize]) $url.="&fontsize=".$__VARS[fontsize];
if($__VARS[use_fontface]) $url.="&fontface=".urlencode($__VARS[fontface]);
if($__VARS[use_bold]) $url.="&fett=true";
if($__VARS[use_italic]) $url.="&kursiv=true";
if($__VARS[use_link]) $url.="&link=true";
else $url.="&link=false";

	 $entity_url=htmlentities($url);

echo'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>old_style URL Generator</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<p align="center"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Old_Style-URL-Generator</strong></font></p>
<form name="urlgenerator" method="GET" action="">
    <table width="95%" border="1" cellspacing="0" cellpadding="2">
        <tr align="center" valign="middle"> 
            <td rowspan="2"><strong><font size="2" face="Arial, Helvetica, sans-serif">Was</font></strong></td>
            <td colspan="5"> <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">Hintergrund</font></strong></div></td>
            <td colspan="7"><strong><font size="2" face="Arial, Helvetica, sans-serif">Schrift</font></strong><strong></strong><strong></strong></td>
            <td rowspan="2"><strong><font size="2" face="Arial, Helvetica, sans-serif">zeige 
                Link und &Uuml;berschrift?</font></strong></td>
        </tr>
        <tr align="center"> 
            <td colspan="3"> <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">Farbe</font></strong></div></td>
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Bild</font></strong></td>
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">fixiert</font></strong></td>
            <td colspan="3"> <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">Farbe</font></strong></div></td>
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Gr&ouml;&szlig;e</font></strong></td>
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Art</font></strong></td>
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">fett</font></strong></td>
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">kursiv</font></strong></td>
        </tr>
        <tr align="center" valign="middle"> 
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">An/Aus</font></strong></td>
            <td colspan="3"> <div align="center"> 
                    <input name="use_bgcolor" type="checkbox" value="checkbox"'.(isset($__VARS[use_bgcolor])?" checked":"").'>
                </div></td>
            <td> <input type="checkbox" name="use_background" value="checkbox"'.(isset($__VARS[use_background])?" checked":"").'> </td>
            <td rowspan="2"> <input type="checkbox" name="use_bgproperties" value="checkbox"'.(isset($__VARS[use_bgproperties])?" checked":"").'> 
            </td>
            <td colspan="3"> <div align="center"> 
                    <input name="use_fontcolor" type="checkbox" id="use_fontcolor" value="checkbox"'.(isset($__VARS[use_fontcolor])?" checked":"").'>
                </div></td>
            <td> <input name="use_fontsize" type="checkbox" id="use_fontsize" value="checkbox"'.(isset($__VARS[use_fontsize])?" checked":"").'> 
            </td>
            <td> <input name="use_fontface" type="checkbox" id="use_fontface" value="checkbox"'.(isset($__VARS[use_fontface])?" checked":"").'> 
            </td>
            <td rowspan="2"> <input type="checkbox" name="use_bold" value="checkbox"'.(isset($__VARS[use_bold])?" checked":"").'> 
            </td>
            <td rowspan="2"> <input type="checkbox" name="use_italic" value="checkbox"'.(isset($__VARS[use_italic])?" checked":"").'> 
            </td>
            <td rowspan="2"> <input type="checkbox" name="use_link" value="checkbox"'.(isset($__VARS[use_link])?" checked":"").'> 
            </td>
        </tr>
        <tr align="center" valign="middle"> 
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Wert</font></strong></td>
            <td colspan="3"> <div align="center"> <input name="bgcolor" type="text" value="'.$__VARS[bgcolor].'" size="6" maxlength="6">
                </div></td>
            <td><input name="background" type="text" size="15" value="'.$__VARS[background].'"></td>
            <td colspan="3"> <div align="center"><input name="fontcolor" type="text" id="fontcolor" value="'.$__VARS[fontcolor].'" size="6" maxlength="6">
                </div></td>
            <td> <select name="fontsize" id="fontsize">'."\n";
$signs=array("","+","-"); 
foreach($signs as $sign) 
	for($i=1;$i<=7;$i++) 
		echo '                    <option value="'.$sign.$i.'"'.((strval($__VARS[fontsize])===strval("".$sign.$i))?" selected":"").'>'.$sign.$i.'</option>'."\n";
echo '           </select> </td>
            <td> <input name="fontface" type="text" id="fontface" value="'.$__VARS[fontface].'" size="8"></td>
        </tr>
        <tr align="center" valign="middle"> 
            <td colspan="14"> <div align="center"> 
                    <input name=changed type="submit" value="link erzeugen"><font size="2" face="Arial, Helvetica, sans-serif"> (Um mit preview ein geändertes Design anzuzeigen, muss nach der Änderung erst der link erzeugt werden.) </font>
                </div></td>
        </tr>
    </table>
    </form>
	
<div align="center">
<font size="2" face="Arial, Helvetica, sans-serif">Aktuelle URL: </font>
    <input name="link" type="text" id="link" size="120" value="'.$url.'">
    <br>
	<font size="2" face="Arial, Helvetica, sans-serif">(Um den Link verwenden zu können, müsst ihr nur noch die ID durch eure ersetzen. Dieses Feld hat jedoch keinen Einfluss auf den preview-link weiter unten.)</font>
    <br>
	<br>
    <font size="2" face="Arial, Helvetica, sans-serif"><a href="'.$url.'" target="kalenderFrame">preview</a> mit dem Beispielkalender</font><div>
</body>
</html>';
?>