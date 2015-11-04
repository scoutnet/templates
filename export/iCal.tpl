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
PRODID:kalender.scoutnet.de iCalTemplate V0.2
{foreach from=$groups item=monat}
{foreach from=$monat.eintraege item=eintrag}
BEGIN:VEVENT
UID:www.scoutnet.de/api/0.2/event/{$eintrag.id}/
{if $eintrag.changed}DTSTAMP:{$eintrag.changed|date_format:"%Y%m%dT%H%M%SZ"}{else}DTSTAMP:{$eintrag.created|date_format:"%Y%m%dT%H%M%SZ"}{/if}
SUMMARY:{$eintrag.titel|replace:"^":"^^"|replace:'"':"^'"|replace:"\\":"\\\\"|replace:":":"\\:"|replace:";":"\\;"|replace:",":"\\,"|replace:"\n":"\\n"|replace:"\r":""}
{if $eintrag.Description}DESCRIPTION:{$eintrag.Description|replace:"^":"^^"|replace:'"':"^'"|replace:"\\":"\\\\"|replace:":":"\\:"|replace:";":"\\;"|replace:",":"\\,"|replace:"\n":"\\n"|replace:"\r":""}
{/if}
{if $eintrag.startzeit}
DTSTART;TZID=Europe/Berlin:{$eintrag.startdatum|date_format:"%Y%m%d"}T{$eintrag.startzeit|date_format:"%H%M%S"}
DTEND;TZID=Europe/Berlin:{if $eintrag.enddatum}{$eintrag.enddatum|date_format:"%Y%m%d"}{else}{$eintrag.startdatum|date_format:"%Y%m%d"}{/if}T{if $eintrag.endzeit}{$eintrag.endzeit|date_format:"%H%M%S"}{elseif $eintrag.startzeit}{$eintrag.startzeit|date_format:"%H%M%S"}{else}235900{/if}
{else}
DTSTART;VALUE=DATE:{$eintrag.startdatum|date_format:"%Y%m%d"}
DTEND;VALUE=DATE:{if $eintrag.enddatum}{assign var="foooo" value="`$eintrag.enddatum`"|strtotime}{$foooo+86400|date_format:"%Y%m%d"}
{else}{assign var="foooo" value="`$eintrag.startdatum`"|strtotime}{$foooo+86400|date_format:"%Y%m%d"}
{/if}
{/if}
{if $eintrag.ort}LOCATION:{$eintrag.ort|replace:"^":"^^"|replace:'"':"^'"|replace:"\\":"\\\\"|replace:":":"\\:"|replace:";":"\\;"|replace:",":"\\,"|replace:"\n":"\\n"|replace:"\r":""}
{/if}
END:VEVENT
{/foreach}
{/foreach}

END:VCALENDAR

