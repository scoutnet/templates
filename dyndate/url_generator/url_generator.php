<?php
$__VARS=array_merge($_POST,$_GET);

if(!isset($__VARS[changed]))
	{
	$__VARS[monate_im_voraus]=1;
	$__VARS[monate_im_nachhinein]=10;
	}		

$id=6;
	 $url="http://kalender.scoutnet.de/2.0/show.php?id=6&template=dyndate/dyndate.tpl";
if($__VARS[monate_im_nachhinein])$url.="&monate_im_nachhinein=".$__VARS[monate_im_nachhinein];
if($__VARS[monate_im_voraus])$url.="&monate_im_voraus=".$__VARS[monate_im_voraus];

	 $entity_url=htmlentities($url);

echo'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>dyndate URL Generator</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<p align="center"><font size="2" face="Arial, Helvetica, sans-serif"><strong>DynDate-URL-Generator</strong></font></p>
<form name="urlgenerator" method="GET" action="">
    <table width="95%" border="1" cellspacing="0" cellpadding="2">
        <tr align="center" valign="middle"> 
            <td><strong></strong></td>
            <td> <div align="center">Monate im Nachhinein</div></td>
            <td>Monate im Voraus</td>
        </tr>
        <tr align="center" valign="middle"> 
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Wert</font></strong></td>
            <td> <div align="center"> 
                    <input name="monate_im_nachhinein" type="text" value="'.$__VARS[monate_im_nachhinein].'" size="6" maxlength="6">
                </div></td>
            <td><input name="monate_im_voraus" type="text" size="15" value="'.$__VARS[monate_im_voraus].'"></td>
        </tr>
        <tr align="center" valign="middle"> 
            <td colspan="3"> <div align="center"> 
                    <input name=changed type="submit" value="link erzeugen">
                    <font size="2" face="Arial, Helvetica, sans-serif"> (Um mit 
                    preview ein geändertes Design anzuzeigen, muss nach der Änderung 
                    erst der link erzeugt werden.) </font> </div></td>
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