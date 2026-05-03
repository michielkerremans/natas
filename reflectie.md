# Reflectie op de NATAS-wargame

Na het afronden van de NATAS-wargame heb ik vooral geleerd dat webbeveiliging meestal niet breekt door één grote fout. Meestal gaat het mis door kleine verkeerde aannames. Er wordt vertrouwd op iets dat de gebruiker kan zien, aanpassen of misbruiken. En net daar zit het probleem.

Ik heb ook een duidelijke aanpak ontwikkeld om kwetsbaarheden te vinden. Eerst keek ik naar de broncode, HTML, cookies, headers en parameters. Daarna probeerde ik te achterhalen welke input vertrouwd werd. En vooral waar die input terechtkwam. In een include. In een shell-commando. In een SQL-query. In een sessie. Of in een bestand. Zodra dat duidelijk was, kon ik gericht testen. In de eenvoudigere levels deed ik dat manueel. In de blind SQL-, timing- en brute force-levels heb ik dat geautomatiseerd met scripts. Ik gebruikte daarbij ook vaak `curl` en kleine `PHP` scripts. Veel walkthroughs doen dat niet op die manier, maar voor mij was dat duidelijker en handiger in de CLI. Zeker `curl` vroeg wel extra werk, zoals werken met cookie jars en heel voorzichtig quoten van requests. Maar juist daardoor heb ik er ook veel uit geleerd. Hetzelfde gold voor kleine `PHP` scripts om dingen snel te testen of om bewerkingen om te keren.

AI heeft mij hier ook veel bij geholpen, zeker bij het schrijven van scripts en het sneller testen van ideeën. Maar bij uitleg en redenering ging het ook vaak fout. Soms bleef het in cirkels draaien of bleef het verkeerde pistes herhalen. Daardoor moest ik nog altijd veel zelf uitzoeken en alles goed proberen te begrijpen. Net dat kostte veel tijd, maar daar heb ik ook het meeste uit geleerd.

Per reeks levels heb ik vooral dit geleerd:

### Levels 0-10
Hier leerde ik dat informatielekken en client-side controles geen echte beveiliging zijn. HTML-comments, publieke directories, robots.txt, cookies en referer-headers zijn allemaal onbetrouwbaar. Ik zag ook hoe gevaarlijk file inclusion en command injection zijn als user input rechtstreeks gebruikt wordt. De belangrijkste les hier was dat blacklisting zwak is. Je blokkeert enkele tekens, maar meestal blijft er nog een bypass over.

### Levels 11-20
Hier werd duidelijk dat iets dat “beschermd” lijkt, nog altijd fout kan zitten. XOR op cookies was breekbaar. Hidden fields en uploads konden misbruikt worden om code op de server te krijgen. SQL-injectie bleef mogelijk in gewone, blind en time-based vorm. Ook sessiebeheer bleek een groot zwak punt. Voorspelbare sessie-ID’s en zwakke sessielogica maakten privilege escalation mogelijk.

Level 17 vond ik persoonlijk een van de interessantste levels. De timing attack met SLEEP() vond ik een heel mooie aanpak. Er kwam geen directe output terug, maar je kon nog altijd informatie afleiden uit de responstijd. Dat maakte heel duidelijk dat een applicatie ook data kan lekken zonder iets expliciet te tonen.

De belangrijkste les hier was dat goede beveiliging begint bij het ontwerp. Niet bij losse filters achteraf.

### Levels 21-25
In deze reeks zag ik vooral logische fouten en PHP-valkuilen. Gedeelde sessiestorage. Redirects zonder de uitvoering echt te stoppen. Type juggling. Fout gebruik van strcmp(). Zwakke include-bescherming. Dit waren geen klassieke injecties, maar ze waren wel even misbruikbaar. De belangrijkste les hier was dat kleine logische fouten genoeg kunnen zijn om de hele beveiliging te breken.

### Levels 26-30
Hier kwamen vooral gevaarlijke server-side mechanismen naar voren. unserialize() op onbetrouwbare data maakte object injection mogelijk. Inconsistente verwerking van usernames leidde tot identity mismatch. ECB liet block swapping toe. In Perl zag ik ook command injection en SQL-injectie via onverwacht inputgedrag.

Level 28 vond ik veruit een van de moeilijkste levels. Daar heb ik meer dan 10 uur op vastgezeten. Zelfs met hulp van AI was het moeilijk om echt te begrijpen wat er gebeurde. Ook de meeste walkthroughs vond ik niet echt duidelijk. Die van Learn Hacking hielp uiteindelijk wel, maar zelfs dan moest ik het nog stap voor stap zelf proberen te begrijpen om echt te snappen wat er gebeurde.

### Levels 31-34
In deze laatste reeks kwam datzelfde patroon gewoon opnieuw terug. User input die file input sources beïnvloedt, kan leiden tot informatielekken of code execution. In level 33 zag ik hoe bestandspaden, stream wrappers en deserialisatie samen tot code execution kunnen leiden, zelfs zonder expliciete unserialize(). Level 34 was dan gewoon het einde. De belangrijkste les hier was dat code execution ook via omwegen mogelijk kan zijn. Niet alleen via de voor de hand liggende functies.

Wat ik uit NATAS vooral meeneem, is dat kleine fouten in inputverwerking, sessiebeheer of applicatielogica vaak al genoeg zijn om een systeem breekbaar te maken. In deze wargame zat de kwetsbaarheid zelden in iets complex. Meestal zat ze gewoon in een verkeerde aanname of een inconsistente controle. Voor het voorkomen van dit soort problemen heb ik vooral geleerd dat losse filters of snelle fixes meestal niet genoeg zijn. Veilige keuzes in inputvalidatie, sessiebeheer, bestandsverwerking en authenticatie moeten van in het begin juist zitten.