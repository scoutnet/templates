{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}
{*
   Name : Kalender 2.0 Template - Scoutnet Modulsystem
   Dateiname : modulsystem.tpl
   Autor : Scoutnet Kalender-Team - Christopher Vogt
   Letzte Änderung : 03.07.2003
   Version : 1.0
   notwendige Konfiguration : keine
   Bemerkungen : Diese Template stellt nur eine Basis zum Einbinden von beliebigen Modulen dar
 *}

{*********          START DES KONFIGURATIONS-BEREICHS        *********}
   {* verwendete Module *}
      {* Pfad in dem die Module liegen *}
      {assign var="modulpfad" value="$template_path/module"}
      {* Dateinamen der Module *}
      {assign_array var="module" values="kalender_banner.tpl;menu.tpl;heutige.tpl;monats_tabellen.tpl;link_footer.tpl" delimiter=";"}
   {*     {assign_array var="module" values="monats_tabellen.tpl" delimiter=";"}*}
      {* overlib_required muss auf true gesetzt werden wenn eins der Module die JavaScript Bibliothek Overlib benötigt,
         kann anderenfalls auf false gesetzt werden *}
      {assign var="overlib_required" value=true}
   {* sonstiges *}
      {* Einstellen des (für das Modulsystem) aktuellen Datums (für Testzwecke),
         Standardwert ist das wirkliche Datum: $smarty.now|date_format:"%Y-%m-%d" *}
      {assign var="aktuelles_datum" value=$smarty.now|date_format:"%Y-%m-%d" }
      {* Erzwingen der w3c konformität (soweit die Module das unterstützen) unter Umständen mit leichten Design-Einbußen *}
      {assign var="force_w3c" value=false}
{*********          ENDE DES KONFIGURATIONS-BEREICHS         *********}

{*********               START DES HTML-KOPFES               *********}

{strip}
{* Einbinden der Overlib-Bibliothek wenn benötigt (siehe Module) *}
{if $overlib_required}
   <script type="text/javascript" language="JavaScript" src="http://kalender.scoutnet.de/2.0/libs/overlib.js"><!-- overLIB (c) Erik Bosrup --></script>
   <div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
   {assign var="overlib_included" value=true}
{/if}

<div align="center"><center>

{*********               ENDE DES HTML-KOPFES                *********}

{*********                 START DER Modultabelle            *********}
<table border="0" cellspacing="0" cellpadding="0">
   <tr>
      <td >
         <table border="0" cellspacing="1" cellpadding="0" >
            {*********    START Einbinden der Module     *********}
            {/strip}{foreach from=$module item=modul}{strip}
               <tr>
                  <td align="center">
                     {assign var="moduldatei" value="$modulpfad/$modul"}
{/strip}


<!-- Beginn Modul: {$modul} -->
{include file=$moduldatei}

<!-- Ende Modul: {$modul} -->

{strip}
                  </td>
               </tr>
            {/strip}{/foreach}{strip}
            {*********    ENDE  Einbinden der Module     *********}
         </table>
      </td>
   </tr>
</table>
{*********                 ENDE DER Modultabelle             *********}


</center></div>
{/strip}
{*<pre>

{$urlparameters|@print_r}

{$url_parameters|@print_r}
</pre>*}