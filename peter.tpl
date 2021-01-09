{strip}
    {assign var="groups" value=$groups.jahrmonat}
{/strip}
{foreach from=$groups item=monat}
{foreach from=$monat.eintraege item=eintrag}
;{$eintrag.kalender.homepage};{$eintrag.kalender.ebene};{$eintrag.id};{$eintrag.startdatum|date_format:"%d.%m.%Y"};{$eintrag.startzeit|date_format:"%H:%M"};{$eintrag.enddatum|date_format:"%d.%m.%Y"};{$eintrag.endzeit|date_format:"%H:%M"};{$eintrag.titel};{$eintrag.kategorie};{$eintrag.stufe.bezeichnungen};{$eintrag.autor.vorname};{$eintrag.autor.nachname};{$eintrag.autor.nickname}
{/foreach}
{/foreach}