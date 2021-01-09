{strip}
        {if $groups.jahrmonat}
                {assign var="groups" value=$groups.jahrmonat}
        {/if}
{/strip}<data date-time-format="iso8601">
{*debug output="html"*}
{foreach from=$groups item=monat}
{foreach from=$monat.eintraege item=eintrag}
        <event start="{$eintrag.startdatum|date_format:"%Y-%m-%d"}{if $eintrag.startzeit}{$eintrag.startzeit|date_format:"T%T%z"}{else}T12:00:00-0100{/if}"
{if $eintrag.enddatum}
		end="{$eintrag.enddatum|date_format:"%Y-%m-%d"}{if $eintrag.endzeit}{$eintrag.endzeit|date_format:"T%T%z"}{else}T12:00:00-0100{/if}"
{*		isDuration="true"*}
{else}
		end="{$eintrag.startdatum|date_format:"%Y-%m-%d"}{if $eintrag.endzeit}{$eintrag.endzeit|date_format:"T%T%z"}{else}{if $eintrag.startzeit}{$eintrag.startzeit|date_format:"T%T%z"}{else}T12:00:00-0100{/if}{/if}"
{/if}
		title="{$eintrag.titel}"
		image="{if !strpos($eintrag.stufe.bildlich_scoutnet_gross_csv,",")}{$eintrag.stufe.bildlich_scoutnet_gross_csv}{/if}"
		icon="{if !strpos($eintrag.stufe.bildlich_scoutnet_csv,",")}{$eintrag.stufe.bildlich_scoutnet_csv}{/if}"
	>
		{$eintrag.info|nl2br|escape:"html"}
        </event>
{/foreach}
{/foreach}
</data>

