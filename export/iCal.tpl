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
X-WR-CALNAME:{$kalender.name}
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
DTSTART;TZID=Europe/Berlin:{$eintrag.startdatum|date_format:"%Y%m%d"}T{if $eintrag.startzeit}{$eintrag.startzeit|date_format:"%H%M%S"}{else}000000{/if}

DTEND;TZID=Europe/Berlin:{if $eintrag.enddatum}{$eintrag.enddatum|date_format:"%Y%m%d"}{else}{$eintrag.startdatum|date_format:"%Y%m%d"}{/if}T{if $eintrag.endzeit}{$eintrag.endzeit|date_format:"%H%M%S"}{elseif $eintrag.startzeit}{$eintrag.startzeiti+1|date_format:"%H%M%S"}{else}000001{/if}

{if $eintrag.ort}LOCATION:{$eintrag.ort}
{/if}
SUMMARY:{$eintrag.titel}
UID:{$eintrag.id}
SEQUENCE:1
DTSTAMP:20060107T130017Z
END:VEVENT
{/foreach}
{/foreach}
END:VCALENDAR

