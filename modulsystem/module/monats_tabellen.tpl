{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}

{*
	Name : Kalender 2.0 Template - Modul Monatstabellen für Scoutnet Modulsystem 
	Dateiname : monats_tabellen.tpl
	Autor : Scoutnet Kalender-Team - Christopher Vogt
	Letzte Änderung : 02.07.2003
	Version : 1.0
	notwendige Konfiguration : overlib_required muss im modulsystem auf true gesetzt werden
	anforderungen an die URL : 	der durch monate_im_voraus und monate_im_nachhinein (siehe unten) 
								abgedeckte bereich muss im durch die URL-Parameter startdate und enddate 
								gegebenen Zeitraum leigen, sonst werden natürlich keine oder nicht alle 
								Termine angezeigt
	W3C konformität : nicht konform, aufgrund der Zeilen 203-205 "<script[...]box_[...]/script>"
	Bemerkungen : 	Diese Template ist als Modul für das ScoutNet Modulsystem gedacht und
					stellt eine grafische Visualisierung des Kalenders dar
 *}

{*********           START DES KONFIGURATIONS-BEREICHS       *********}
	{* zeitbereich *}
		{* selbsterklärend *}	
		{assign var="monate_im_nachhinein" value=1}
		{assign var="monate_im_voraus" value=4}

	{* design - grobes *}
		{* Gibt an in wieviel Monatstabellen pro Zeile angezeigt werden sollen *}	
		{assign var="monats_spalten" value=3}
	
		{* 6 Zeilen pro Monatstabelle erzwingen Höhe der Monatstabellen, damit alle Monatstabellen die selbe Höhe haben *}
		{assign var="monatstabellen_hoehe_anpassen" value=true} {* mögliche Werte: true false *}

		{* Die Einträge in der Zeile mit den Wochentagsbeschriftungen (getrennt durch ;) *}
		{assign_array var="wochentags_beschriftungen" values="M;D;M;D;F;S;S" delimiter=";"}

	{* design - feines *}
		{* Zellenart und zusätzliche Tags für Wochentagsbeschriftungen *}
		{assign var="starttags_wochentagsbeschriftungen" value="<td align=\"center\"><b><font face=\"verdana,arial,helvetica\" size=\"1\" color=\"#000000\">"}
		{assign var="endtags_wochentagsbeschriftungen" value="</font></b></td>"}

		{* leere Zellen zum Füllen der Monats-Tabelle vor dem ersten und nach dem letzten Tag des Monats *}
		{assign var="emptycell" value="<td bgcolor=\"#319AFF\">&nbsp;</td>"}

		{* Zellenart aller Daten, ausser dem aktuellen Datum *}
		{assign var="zellenstart_irgendein_datum" value="<TD bgcolor=\"#DFDFDF\"><font face=\"verdana,arial,helvetica\" size=\"3\">"}
		{assign var="zellenende_irgendein_datum" value="</font></TD>"}

		{* Zusätzliche Tags für Daten an denen Termine sind, ausser dem aktuellen Datum *}
		{assign var="starttags_existierendes_datum" value="<font color=\"#0000FF\"><u>"}
		{assign var="endtags_existierendes_datum" value="</u></font>"}
				
		{* Zellenart des aktuellen Datums *}
		{assign var="zellenstart_aktuelles_datum" value="<TD bgcolor=\"#FF0033\"><font face=\"Verdana\" size=\"3\">"}
		{assign var="zellenende_aktuelles_datum" value="</font></TD>"}
				
		{* Zusätzliche Tags wenn am aktuellen Datum Termine sind *}
		{assign var="starttags_aktuelles_existierendes_datum" value="<font color=\"#0000FF\"><u>"}
		{assign var="endtags_aktuelles_existierendes_datum" value="</u></font>"}
{*********          ENDE DES KONFIGURATIONS-BEREICHS         *********}


{********* START DES BEREICHS MIT DEN AUTOMATISCHEN VORBEREITUNGEN    *********}
{* Zuweisung der richtigen Gruppe*} 
	{if $groups.jahrmonattag}
		{assign var="groups" value="`$groups.jahrmonattag`"}
	{/if}

{* Bereitstellen der benötigten Datums Variablen *}
{assign var="aktueller_tag" value=$aktuelles_datum|date_format:"%d"}
{assign var="aktueller_monat" value=$aktuelles_datum|date_format:"%m"}
{assign var="aktuelles_jahr" value=$aktuelles_datum|date_format:"%Y"}

{* Bestimmung des Startmonats und Startjahres des Templates anhand der obigen Konfigurationseinstellungen *}
{if ($aktueller_monat-$monate_im_nachhinein) < 1}
	{math equation="((a - b) % 12) + 12" a=$aktueller_monat b=$monate_im_nachhinein assign="start_monat"}
	{math equation="ceil((abs(a - b)+1) / 12)" a=$aktueller_monat b=$monate_im_nachhinein assign="jahre_im_nachhinein"}
	{math equation="a - b" a=$aktuelles_jahr b=$jahre_im_nachhinein assign="start_jahr"}
{else}
	{math equation="a - b" a=$aktueller_monat b=$monate_im_nachhinein assign="start_monat"}
	{assign var="start_jahr" value=$aktuelles_jahr}
{/if}

{* Bestimmung des Endmonats und Endjahres des Templates anhand der obigen Konfigurationseinstellungen *}
{if ($aktueller_monat + $monate_im_voraus) > 12}
	{math equation="((a + b) % 12)" a=$aktueller_monat b=$monate_im_voraus assign="end_monat"}
	{math equation="floor((a + b - 1) / 12)" a=$aktueller_monat b=$monate_im_voraus assign="jahre_im_voraus"}
	{math equation="a + b" a=$aktuelles_jahr b=$jahre_im_voraus assign="end_jahr"}
{else}
	{math equation="a + b" a=$aktueller_monat b=$monate_im_voraus assign="end_monat"}
	{assign var="end_jahr" value=$aktuelles_jahr}
{/if}

{* Bestimmung der benötigten leeren Zellen am Ende für die Anordnung der Monatstabellen in mehreren Spalten (siehe auch $monats_spalten) *}
{math assign="emptycells" equation="(monats_spalten-(((12-start_monat+1)+((end_jahr-start_jahr-1)*12)+end_monat)%monats_spalten))" monats_spalten=$monats_spalten end_jahr=$end_jahr start_jahr=$start_jahr start_monat=$start_monat end_monat=$end_monat}

{*********  ENDE DES BEREICHS MIT DEN AUTOMATISCHEN VORBEREITUNGEN    *********}


{*********  START DES BEREICHS MIT DER EIGENTLICHEN AUSGABE    *********}
<table cellpadding="3" ><tr valign="top">
{* section-Schleife, die die Jahre durchläuft die angezeigt werden sollen *}
{section name="years" loop=$end_jahr|math:"x+1" start=$start_jahr}
	{* $this_jahr gibt das Jahr für diesen Durchlauf der "years"-section ahand des Durchlaufindex an *}
	{assign var="this_jahr" value=$smarty.section.years.index}

	{* Bestimmung des ersten Monats der im aktuellen Durchlauf der "years"-section angezeigt werden soll *}
	{if ($smarty.section.years.index eq $start_jahr)}
		{assign var="start_monat_loop" value=$start_monat}
	{else}
		{assign var="start_monat_loop" value=01}
	{/if}

	{* Bestimmung des letzten Monats der im aktuellen Durchlauf der "years"-section angezeigt werden soll *}
	{if ($smarty.section.years.index eq $end_jahr)}
		{assign var="end_monat_loop" value=$end_monat}
	{else}
		{assign var="end_monat_loop" value=12}
	{/if}

	{* section-Schleife, die die Monate des aktuellen Durchlaufs der "years"-section durchläuft, die angezeigt werden sollen *}
	{section name="months" loop=$end_monat_loop|math:"x+1" start=$start_monat_loop}

		{* $this_monat gibt den Jahr für diesen Durchlauf der "months"-section anhand des Durchlaufindex an *}
		{assign var="this_monat" value=$smarty.section.months.index|string_format:"%02d"}

		{* table_date gibt das Datum des ersten Tages des aktuellen Monats an für die spätere Bestimmung der Überschirft der Tabelle mittels date_format *}
		{assign var="table_date" value="$this_jahr-$this_monat-01"}

		<td> 

			{* Start Rahmen für Monatstabelle *}<table border="0" cellspacing="0" cellpadding="0" width="150"><tr><td bgcolor="#000000" ><table width="100%" border="0" cellspacing="1" cellpadding="3" ><tr><td bgcolor="#CECFCE" valign="top">

				{*********         START DER Monatstabellenüberschrift         *********}
				<div align="center"><center>
					{* Einbinden des Templates mit der Überschrift der Monatstabelle *}
					{* Start Rahmen für Monatsüberschrift *}<table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td bgcolor="#000000" ><table width="100%" border="0" cellspacing="1" cellpadding="3" ><tr><td bgcolor="#FFFFFF">
						<table border="0" cellspacing="0" cellpadding="1" width="100%" bgcolor="#FFFFFF" >
							<tr> 
								<td align="left" valign="middle">
									<font face="verdana, arial, helvetica" size="2" color="#000000">
										<b>{$table_date|date_format:"%B %Y"}</b>
									</font>
								</td>
								<td width="20" height="20" valign="middle" align="center">
									<img width="28" height="25" src="http://kalender.scoutnet.de/2.0/images/cal.gif" alt="Calendar" border=0> 
								</td>
							</tr>
						</table>

					{* Ende Rahmen für Monatsüberschrift *}</td></tr></table></td></tr></table>
				</center></div>
				{*********          ENDE DER Monatstabellenüberschrift         *********}


			{* Rahmen  für Monatstabelle- Neue Zeile *} </td></tr><tr><td bgcolor="#FFFFFF">

				<table bgcolor="#000000" border="0" cellpadding="4" cellspacing="1" align="center">

				{*********         START DER Monatstabellen Spaltenbeschriftung    *********}
					<tr bgcolor="#CECFCE">
						{* Zeile mit den Wochentagsbeschriftungen *}
						{foreach from=$wochentags_beschriftungen item=wochentags_beschriftung}
							{$starttags_wochentagsbeschriftungen}
							{$wochentags_beschriftung}
							{$endtags_wochentagsbeschriftungen}
						{/foreach}
					</tr>
				{*********          ENDE DER Monatstabellen Spaltenbeschriftung    *********}

				{*********          START DER Monatstabellenzellen             *********}
					<tr bgcolor="#DFDFDF">

						{* Bestimmung der Anzahl und Einfügen der benötigten leeren Zellen am Anfang der Monats-Tabelle *}
						{assign var="start_wochentag" value="$this_jahr-$this_monat-01"|date_format:"%w"|math:"x"}
						{if $start_wochentag == 0}
							{assign var="start_wochentag" value="7"}
					    {/if}
						{section name=emptystartcells loop=$start_wochentag|math:"x-1"}
							{$emptycell}
						{/section}

						{* Bestimmung der Anzahl der Tage des Monats *}
						{monthlength assign="monthlength" month=$this_monat}

						{* section-Schleife, die die Tage des aktuellen Durchlaufs der "month"-section durchläuft, die angezeigt werden sollen *}
						{section name=days loop=$monthlength}

							{* $this_day gibt den Tag für diesen Durchlauf der "days"-section anhand des Durchlaufindex an *}
							{assign var="this_day" value=$smarty.section.days.iteration|string_format:"%02d"}

							{* $this_day gibt das Datum für diesen Durchlauf der "days"-section an *}
							{assign var="this_date" value="$this_jahr-$this_monat-$this_day"}
							{* Falls das Datum dieses Durchlaufs dem aktuellen Datum entspricht wird eine andere Zellenart verwendet *}
					        {if "$this_date" == $aktuelles_datum}
								{$zellenstart_aktuelles_datum}
							{else}
								{$zellenstart_irgendein_datum}
							{/if}

							{* Falls es Termine an diesem Datum gibt ausgeben eines div mit mouseover event für overlib, sonst nur den Tag *}
							{if ( in_array($this_date, $used.dates) )}
								{* Ablegen des Template mit dem Inhalt der Overlibbox in "box_inhalt" *}
								{include file="`$modulpfad`/box_inhalt_datum.tpl" assign="box_inhalt" inhalt_datum=$this_date}
								<script type="text/javascript" language="JavaScript">
									box_{$this_jahr}{$this_monat}{$this_day}_inhalt='{$box_inhalt|html_entity_decode}';
								</script>
								<span onmouseover="return overlib(box_{$this_jahr}{$this_monat}{$this_day}_inhalt, STICKY, CAPTION, 'Termine am {$this_day}.{$this_monat}.{$this_jahr}', CENTER);" onmouseout="nd();"> 
					        	{if "$this_date" == $aktuelles_datum}
									{$starttags_aktuelles_existierendes_datum}
								{else}
									{$starttags_existierendes_datum}
								{/if}
									{$this_day} 
					        	{if "$this_date" == $aktuelles_datum}
									{$endtags_aktuelles_existierendes_datum}
								{else}
									{$endtags_existierendes_datum}
								{/if}
								</span>
							{else}
								{$this_day}			
							{/if}

					        {if "$this_date" == $aktuelles_datum}
								{$zellenende_aktuelles_datum}
							{else}
								{$zellenende_irgendein_datum}
							{/if}

							{* Zeilensprung nach sieben Zellen in einer Zeile, es sei denn der letzte Termin wurde erreicht *}
							{if not (($start_wochentag+$smarty.section.days.iteration-1) mod 7)}
			                	{if not $smarty.section.days.last}
			                        </TR><TR>
				                {/if}
			    		    {/if}
				
    					{/section}

						{* Bestimmung der Anzahl und Einfügen der benötigten leeren Zellen am Ende der Monats-Tabelle *}
						{assign var="end_wochentag" value="$this_jahr-$this_monat-$monthlength"|date_format:"%w"}
						{if $end_wochentag == 0}
							{assign var="end_wochentag" value="7"}
					    {/if}
						{section name=emptyendcells loop=$end_wochentag|math:"7-x"}
							{$emptycell}
						{/section}

						{* Bei einem Monat der weniger als 6 Zeilen hat eine weitere anfügen *}
						{if $monatstabellen_hoehe_anpassen && (($start_wochentag-1+$monthlength)<=35)}
    	                    </TR><TR>
							{section name=emptyrow1 loop=7}
								{$emptycell}
							{/section}
						{/if}
			
						{* Bei einem Monat der weniger als 5 Zeilen hat eine weitere anfügen, dies ist nur beim einem Februar mit Montag als Wochentag des 01. der Fall *}
						{if $monatstabellen_hoehe_anpassen && (($start_wochentag-1+$monthlength)==28)}
        	                </TR><TR>
							{section name=emptyrow1 loop=7}
								{$emptycell}
							{/section}
						{/if}
					</tr>
					{*********           ENDE DER Monatstabellenzellen             *********}
				</TABLE>
			{* Ende Rahmen  für Monatstabelle*}</td></tr></table></td></tr></table>
		</td>

		{* Neue Tabellen-Zeile wenn die Anzahl der Monatstabellen in der aktuellen gleich $monats_spalten ist *}
		{if (not ( $this_jahr==$end_jahr && $this_monat==$end_monat)) && not (((12-$start_monat+1)+(($this_jahr-$start_jahr-1)*12*1)+$this_monat) mod $monats_spalten) }
			</tr><tr>
		{elseif ($this_jahr==$end_jahr && $this_monat==$end_monat) && $emptycells!=$monats_spalten}
			{section name=emptymonatsendcells loop=$emptycells}
				<td></td>
			{/section}
		{/if}
	{/section}
{/section}

</tr></table>
{*********   ENDE DES BEREICHS MIT DER EIGENTLICHEN AUSGABE    *********}
{/strip}