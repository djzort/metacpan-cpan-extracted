��    9      �  O   �      �      �     
  X     &   u     �     �  
   �     �     �  �   �  �   h  Y   �  u   O     �     �     �      �  3   �  :   /  O   j  a   �  f   	  f   �	     �	  4   �	  
   $
     /
  	   L
     V
     ^
  (   l
     �
  <   �
  7   �
  '     >   9  5   x     �  ;   �  (     +   +     W  #   s     �  �   �  "  3  ?   V     �  +   �  +   �  f   �  @   e     �  a   �  [     ^   l    �  '   �       �     &   �          &  
   /     :     H  �   X  �   �  Y   �  �   C     �     �            E   &  Y   l  c   �  s   *  z   �  z        �  E   �  
   �  #   �          $     +  ,   9     f  K   m  L   �  5     6   <  .   s     �  ;   �  $   �  *         J     k  	   �  �   �    I  �   ^     �  3   �  1   %  �   W  D   	     N  �   V  z   �  }   V      ,               5                 !   '      -      8      
              (   *   )                       "          2                  9                 0         #                4                            1   3       %   +   7             .      &      /      $   6      	        

   Level	Number of log entries %8s	%5d entries.
 --level must be one of CRITICAL, ERROR, WARNING, NOTICE, INFO, DEBUG, DEBUG2 or DEBUG3.
 --ns must be a name or a name/ip pair. ======= =======  =========  ============  ==============  A name/ip string giving a nameserver for undelegated tests, or just a name which will be looked up for IP addresses. Can be given multiple times. As soon as a message at this level or higher is logged, execution will stop. Must be one of CRITICAL, ERROR, WARNING, NOTICE, INFO or DEBUG. At the end of a run, print a summary of the times the zone's name servers took to answer. Boolean flag for activity indicator. Defaults to on if STDOUT is a tty, off if it is not. Disable with --no-progress. CRITICAL DEBUG ERROR Failed to recognize stop level ' Flag indicating if output should be in JSON or not. Flag indicating if output should be streaming JSON or not. Flag indicating if output should be translated to human language or dumped raw. Flag indicating if streaming JSON output should include the translated message of the tag or not. Flag to permit or deny queries being sent via IPv4. --ipv4 permits IPv4 traffic, --no-ipv4 forbids it. Flag to permit or deny queries being sent via IPv6. --ipv6 permits IPv6 traffic, --no-ipv6 forbids it. INFO Instead of running a test, list all available tests. Level      Loading profile from {path}. Looks OK. Message Module        Must give the name of a domain to test.
 NOTICE Name of a file to restore DNS data from before running test. Name of a file to save DNS data to after running tests. Name of profile file to load. (DEFAULT) Name of the character encoding used for command line arguments Print a count of the number of messages at each level Print level on entries. Print the effective profile used in JSON format, then exit. Print the name of the module on entries. Print the name of the test case on entries. Print timestamp on entries. Print version information and exit. Seconds  Source IP address used to send queries. Setting an IP address not correctly configured on a local network interface causes cryptic error messages. Specify test to run. Should be either the name of a module, or the name of a module and the name of a method in that module separated by a "/" character (Example: "Basic/basic1"). The method specified must be one that takes a zone object as its single argument. This switch can be repeated. Strings with DS data on the form "keytag,algorithm,type,digest" Testcase        The domain name contains consecutive dots.
 The locale to use for messages translation. The minimum severity level to display. Must be one of CRITICAL, ERROR, WARNING, NOTICE, INFO or DEBUG. The name of the nameserver '{nsname}' contains consecutive dots. WARNING Warning: Zonemaster::LDNS not compiled with IDN support, cannot handle non-ASCII names correctly. Warning: setting locale category LC_CTYPE to %s failed (is it installed on this system?).

 Warning: setting locale category LC_MESSAGES to %s failed (is it installed on this system?).

 Project-Id-Version: 0.0.5
Report-Msgid-Bugs-To: 
PO-Revision-Date: 2022-05-25 08:56+0000
Last-Translator: sami.salmensuo@traficom.fi
Language-Team: Traficom domain team
Language: fi
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
 

   Taso	Lokimerkintöjen lukumäärä %8s	%5d merkintää.
 --level (taso) täytyy olla yksi seuraavista: CRITICAL (kriittinen), ERROR (virhe), WARNING (varoitus), NOTICE (huomautus), INFO (tiedotus), DEBUG (virheenkorjaus), DEBUG2 (virheenkorjaus2) tai DEBUG3 (virheenkorjaus3).
 --ns:n on oltava nimi tai nimi/ip-pari ======= =======  =========  ============  ==============  Nimi/IP-merkkijono, joka antaa nimipalvelimen testeille, joita ei ole delegoitu, tai pelkkä nimi, jolla haetaan IP-osoitteita. Voidaan antaa useita kertoja. Heti kun lokiin kirjataan tämän tasoinen tai tätä korkeamman tasoinen viesti, suoritus lakkaa. Sen on oltava yksi näistä: CRITICAL (kriittinen), ERROR (virhe), WARNING (varoitus), NOTICE (huomio), INFO (info) tai DEBUG (virheenkorjaus). Ajon lopussa tulosta yhteenveto vyöhykkeen nimipalvelinten tarvitsemista vastausajoista. Looginen lippu toiminnan merkitsemiseen. Oletusarvoisesti päällä, jos STDOUT on tty, muussa tapauksessa poissa päältä. Poistetaan käytöstä parametrilla --no-progress. CRITICAL DEBUG ERROR Ei tunnistettu lopetustasoa ' Lippu, joka ilmoittaa pitääkö tulosteen olla JSON-muodossa vai ei. Lippu, joka ilmoittaa pitääkö tulosteen olla suoratoistettavassa JSON-muodossa vai ei. Lippu, joka ilmoittaa pitääkö tuloste kääntää ihmiskielelle vai annetaanko se raakamuodossa. Lippu, joka ilmoittaa pitääkö suoratoistettavan JSON-tulosteen sisältää tunnisteen käännetty viesti vai ei. Lippu, joka sallii tai kieltää IPv4:n kautta lähetetyt kyselyt. --ipv4 sallii IPv4-liikenteen, --no-ipv4 kieltää sen. Lippu, joka sallii tai kieltää IPv6:n kautta lähetetyt kyselyt. --ipv6 sallii IPv6-liikenteen, --no-ipv6 kieltää sen. INFO Listaa kaikki käytettävissä olevat testit testin ajamisen sijasta. Taso       Ladataan profiili kohteesta {path}. Näyttää olevan OK. Viesti Moduuli       Testattavan verkkoalueen nimi on annettava.
 NOTICE Sen tiedoston nimi, josta testiä edeltävät DNS-tiedot voidaan palauttaa. Sen tiedoston nimi, johon DNS-tiedot tallennetaan testien ajamisen jälkeen. Ladattavan profiilitiedoston nimi. (DEFAULT (oletus)) Komentorivin parametreissä käytetty merkistökoodaus Tulosta viestien lukumäärä kullakin tasolla Tulosta merkintöihin taso. Tulosta käytössä oleva profiili JSON-muodossa ja poistu. Tulosta merkintöihin moduulin nimi. Tulosta merkintöihin testitapauksen nimi. Tulosta merkintöihin aikaleima. Tulosta versiotiedot ja poistu. Sekuntia  Kyselyjen lähettämiseen käytetty IP-lähdeosoite. IP-osoitetta ei ole määritetty oikein määriteltynä paikalliseen verkkoliitäntään aiheuttaa poikkeuksellisia virheitä. Määritä ajettava testi. Sen tulisi olla joko moduulin nimi tai moduulin nimi ja moduulissa olevan metodin nimi erotettuna ”/”-merkillä (esimerkki: "Basic/basic1"). Määritetyn metodin on otettava ainoaksi parametrikseen vyöhykeobjekti. Tämä vaihto voidaan toistaa. Merkkijonot, jotka sisältävät DS-tietoja muodossa "keytag,algorithm,type,digest” (avaintunniste, algoritmi, tyyppi, tiiviste) Testitapaus     Verkkotunnus sisältää peräkkäisiä pisteitä.
 Viestien kääntämisessä käytettävä lokaali. Näytettävä minimivakavuusaste. Sen on oltava yksi näistä: CRITICAL (kriittinen), ERROR (virhe), WARNING (varoitus), NOTICE (huomio), INFO (info) tai DEBUG (virheenkorjaus). Nimipalvelimen nimi "{nsname}" sisältää peräkkäisiä pisteitä. WARNING Varoitus: Zonemaster::LDNS ei ole käännetty IDN tuella, joten se ei pysty käsittelemään Ei ASCII-muodossa olevia nimiä oikein. Varoitus: arvoa %s ei voitu asettaa lokaalikategorian LC_CTYPE arvoksi (onko sitä asennettu tähän järjestelmään?).

 Varoitus: arvoa %s ei voitu asettaa lokaalikategorian LC_MESSAGES arvoksi (onko sitä asennettu tähän järjestelmään?).

 