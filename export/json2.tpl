{* Entfernt alle unnötigen Leerzeichen und Leerzeilen bis {/strip} *}{strip}
{*
        Name : Kalender 2.0 Template - JSON
        Dateiname : json.tpl
        Autor : Stefan Motz
        Version : 0.0.1
        notwendige Konfiguration : keine
*}
        {if $groups.jahrmonat}
                {assign var="groups" value=$groups.jahrmonat}
        {/if}
{/strip}
{strip}
{$smarty.get.varname|default:'calendar'}
{/strip} = [
{foreach from=$groups item=monat name=groups}
{foreach from=$monat.eintraege item=eintrag name=entries}
{literal}{{/literal}
	Id : {$eintrag.id},
    CId : {$kalender.id},
    SDate : "{$eintrag.startdatum|date_format:"%y-%m-%d"|escape:"javascript"}",
    STime : "{$eintrag.startzeit|date_format:"%H:%M:00"|escape:"javascript"}",
    EDate : "{$eintrag.enddatum|date_format:"%y-%m-%d"|escape:"javascript"}",
    ETime : "{$eintrag.endzeit|date_format:"%H:%M:00"|escape:"javascript"}",
    Title : "{$eintrag.titel|escape:"javascript"}",
    Place : "{$eintrag.ort|escape:"javascript"}",
    Category : "{$eintrag.kategorie|escape:"javascript"}",
    Section : "{$eintrag.stufe.bildlich_scoutnet|escape:"javascript"}",
{if $eintrag.autor.vorname || $eintrag.autor.nachname}
    Author : "{$eintrag.autor.vorname|escape:"javascript"} {$eintrag.autor.nachname|escape:"javascript"}",
{else}
    Author : "{$eintrag.autor.nickname|escape:"javascript"}",
{/if}
    Association : "{$eintrag.kalender.verband|escape:"javascript"}",
    Level : "{$eintrag.kalender.ebene|escape:"javascript"}",
    Info : "{$eintrag.info|nl2br|escape:"javascript"}"
{if $smarty.foreach.groups.last && $smarty.foreach.entries.last}
{literal}}{/literal}
{else}
{literal}},{/literal}
{/if}
{/foreach}
{/foreach}
];