{strip}
{assign var="groups" value="`$groups.jahrmonat`"}
{/strip}
{foreach from=$groups item=monat}
{foreach from=$monat.eintraege item=eintrag}
<hr />
<p><strong>{$eintrag.titel}</strong></p>
<p>{$eintrag.startdatum|date_format:"%d.%m.%Y"} {$eintrag.startzeit|date_format:"%H:%M"} - {$eintrag.enddatum|date_format:"%d.%m.%Y"} {$eintrag.endzeit|date_format:"%H:%M"} in {$eintrag.ort}</p>
{/foreach}
{/foreach}
<hr />
