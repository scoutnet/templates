				{* Karte(n) mit den Details zu einem Termin *}
				<card id="_{$eintrag.id}" title="{$kalender.ebene} {$kalender.name}">
					<p><b>
						{if $erster_eintrag.id != $aktueller_eintrag.id}<a href='#_{$erster_eintrag.id}'>|&lt;</a>{else}|&lt;{/if}
						{if $vorheriger_eintrag}<a href='#_{$vorheriger_eintrag.id}'>&lt;</a>{else}&lt;{/if}
						<a href='#'>^</a>
						{if $naechster_eintrag}<a href='#_{$naechster_eintrag.id}'>&gt;</a>{else}&gt;{/if}
						{if $letzter_eintrag.id != $aktueller_eintrag.id}<a href='#_{$letzter_eintrag.id}'>&gt;|</a>{else}&gt;|{/if}
					</b></p>
					<p>
{*					{$eintrag.x}*}
						{$eintrag.startdatum|date_format:"%A"|truncate:2:""} 
						<b>{$eintrag.startdatum|date_format:"%d.%m."}</b> 
						{if $eintrag.startzeit!= ""}
							{$eintrag.startzeit|date_format:"%H:%M"} 
						{/if}
						{if $eintrag.enddatum != "" || $eintrag.endzeit != ""}
							- 
							{if $eintrag.enddatum != ""}
								{$eintrag.enddatum|date_format:"%A"|truncate:2:""} 
								<b>{$eintrag.enddatum|date_format:"%d.%m."}</b> 
							{/if}		       		
							{if $eintrag.endzeit != ""}
							{$eintrag.endzeit|date_format:"%H:%M"} 
							{/if}
						{/if}
						<br/>
					
						<b>{$eintrag.titel}</b>
						
						<br/>{$eintrag.kalender.ebene}    {$eintrag.kalender.name}
						
						{if $eintrag.stufe.bezeichnungen != ""}
							<br/>Stufe(n): {$eintrag.stufe.bezeichnungen}
						{/if}
						    
						
						{if $eintrag.ort != ""}
							<br/>Ort: {$eintrag.ort}
						{/if}
						
						{if $eintrag.kategorie != ""}
							<br/>Kategorie: {$eintrag.kategorie}
						{/if}
						
						{if $eintrag.Description != ""}
							<br/>Info: {$eintrag.Description|nl2br}
						{/if}
						
						{* <br/>ID: {$eintrag.id} *}
						
						{assign var="LastID" value=$eintrag.id}
					</p>
				</card>