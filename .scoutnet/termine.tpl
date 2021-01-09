{strip}
{assign var="monate" value=$groups.jahrmonattag}
{/strip}{foreach from=$monate item=totem}
{foreach from=$totem.eintraege item=eintrag}{strip}
{* Kalender-ID, Kalender-Name, Eintrag-ID, Kategorie, Startdatum, Startzeit, Enddatum, Endzeit, Titel, URL, Ort, Autor, Verband, Ebene, Beschreibung (info) *}
{*$eintrag|@print_r *}

{/strip}{$eintrag.kalender.id}	{$eintrag.kalender.name}	{$eintrag.id}	{$eintrag.kategorie}	{$eintrag.startdatum|date_format:"%Y-%m-%d"}	{$eintrag.startzeit|date_format:"%H:%M:00"}	{$eintrag.enddatum|date_format:"%Y-%m-%d"}	{$eintrag.endzeit|date_format:"%H:%M:00"}	{$eintrag.titel}	{$eintrag.URL}	{$eintrag.ort}	{if $eintrag.autor.vorname || $eintrag.autor.nachname}{$eintrag.autor.vorname} {$eintrag.autor.nachname}{else}{$eintrag.autor.nickname}{/if}	{$eintrag.kalender.verband}	{$eintrag.kalender.ebene}	{$eintrag.Description|replace:"\r\n":"\\n"}{strip}
{*
{$eintrag.URL}|{if $eintrag.stufe.records|@count == 1 && $eintrag.stufe.ids != 5}{$eintrag.stufe.bezeichnungen}{else}{$eintrag.kalender.name}{/if}|{$eintrag.titel}|{$eintrag.startdatum|date_format:"%x"}{if !empty($eintrag.startzeit)}-{$eintrag.startzeit|date_format:"%H.%M"}{/if}|{$eintrag.enddatum|date_format:"%x"}{if !empty($eintrag.endzeit)}-{$eintrag.endzeit|date_format:"%H.%M"}{/if}|{$eintrag.ort}
*}{/strip}
{/foreach}{/foreach}
