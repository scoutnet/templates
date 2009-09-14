{strip}
{if $groups.jahrmonat}
	{assign var="groups" value="`$groups.jahrmonat`"}
{/if}
{assign var="lastmodified" value="1970-01-01 00:00:00"}
{foreach from=$groups item=monat}
	{foreach from=$monat.eintraege item=eintrag}
		{if not $eintrag.changed}
			{assign var="changed" value=$eintrag.created}
		{else}
			{assign var="changed" value=$eintrag.changed}
		{/if}
		{if $lastmodified < $changed }
			{assign var="lastmodified" value=$changed}
		{/if}
	{/foreach}
{/foreach}

{/strip}BEGIN:VCALENDAR
VERSION:2.0
X-WR-CALNAME:{$kalender.ebene} {$kalender.name}
PRODID:-//Apple Computer\, Inc//iCal 2.0//EN
X-WR-RELCALID:44BAD25C-E159-4774-A8DA-E75D6686A88D-{$kalender.id}
X-WR-TIMEZONE:Europe/Berlin
CALSCALE:GREGORIAN
METHOD:PUBLISH
BEGIN:VTIMEZONE
TZID:Europe/Berlin
LAST-MODIFIED:{$lastmodified|date_format:"%Y%m%dT%H%M%SZ"}
BEGIN:STANDARD
DTSTART:20051030T010000
TZOFFSETTO:+0100
TZOFFSETFROM:+0000
TZNAME:CET
END:STANDARD
BEGIN:DAYLIGHT
DTSTART:20060326T030000
TZOFFSETTO:+0200
TZOFFSETFROM:+0100
TZNAME:CEST
END:DAYLIGHT
END:VTIMEZONE
{foreach from=$groups item=monat}
{foreach from=$monat.eintraege item=eintrag}
BEGIN:VEVENT
{if $eintrag.startzeit}
DTSTART;TZID=Europe/Berlin:{$eintrag.startdatum|date_format:"%Y%m%d"}T{$eintrag.startzeit|date_format:"%H%M%S"}
{else}
DTSTART;VALUE=DATE:{$eintrag.startdatum|date_format:"%Y%m%d"}
{/if}
{if $eintrag.startzeit || $eintrag.endzeit}
DTEND;TZID=Europe/Berlin:{if $eintrag.enddatum}{$eintrag.enddatum|date_format:"%Y%m%d"}{else}{$eintrag.startdatum|date_format:"%Y%m%d"}{/if}T{if $eintrag.endzeit}{$eintrag.endzeit|date_format:"%H%M%S"}{elseif $eintrag.startzeit}{$eintrag.startzeit|date_format:"%H%M%S"}{else}235900{/if}

{else}
DTEND;VALUE=DATE:{if $eintrag.enddatum}{assign var="foooo" value="`$eintrag.enddatum`"|strtotime}{$foooo+86400|date_format:"%Y%m%d"}{else}{assign var="foooo" value="`$eintrag.startdatum`"|strtotime}{$foooo+86400|date_format:"%Y%m%d"}{/if}

{/if}
{if $eintrag.ort}LOCATION:{$eintrag.ort}
{/if}
SUMMARY:{$eintrag.titel}
UID:{$eintrag.id}
SEQUENCE:1
{if $entrag.changed}DTSTAMP:{$eintrag.changed|date_format:"%Y%m%dT%H%M%SZ"}{else}DTSTAMP:{$eintrag.created|date_format:"%Y%m%dT%H%M%SZ"}{/if}
END:VEVENT
{/foreach}
{/foreach}
END:VCALENDAR

