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
  '     >   9  5   x     �  ;   �  (     +   +     W  #   s     �  �   �  "  3  ?   V     �  +   �  +   �  f   �  @   e     �  a   �  [     ^   l  �   �  "   �     �  `   �  +   V     �     �  
   �     �     �  �   �  �   M  �     �   �     *     3     9  S   ?  F   �  K   �  a   &  Z   �  �   �  �   p     �  h     
   k  =   v     �     �     �  E   �     /  �   6  �   �  J   a  U   �  i     >   l  ;   �  R   �  X   :  Y   �  O   �  	   =  �   G  �     �        �  4   �  8   �  �      F   �      �   z   �   {   t!  {   �!     ,               5                 !   '      -      8      
              (   *   )                       "          2                  9                 0         #                4                            1   3       %   +   7             .      &      /      $   6      	        

   Level	Number of log entries %8s	%5d entries.
 --level must be one of CRITICAL, ERROR, WARNING, NOTICE, INFO, DEBUG, DEBUG2 or DEBUG3.
 --ns must be a name or a name/ip pair. ======= =======  =========  ============  ==============  A name/ip string giving a nameserver for undelegated tests, or just a name which will be looked up for IP addresses. Can be given multiple times. As soon as a message at this level or higher is logged, execution will stop. Must be one of CRITICAL, ERROR, WARNING, NOTICE, INFO or DEBUG. At the end of a run, print a summary of the times the zone's name servers took to answer. Boolean flag for activity indicator. Defaults to on if STDOUT is a tty, off if it is not. Disable with --no-progress. CRITICAL DEBUG ERROR Failed to recognize stop level ' Flag indicating if output should be in JSON or not. Flag indicating if output should be streaming JSON or not. Flag indicating if output should be translated to human language or dumped raw. Flag indicating if streaming JSON output should include the translated message of the tag or not. Flag to permit or deny queries being sent via IPv4. --ipv4 permits IPv4 traffic, --no-ipv4 forbids it. Flag to permit or deny queries being sent via IPv6. --ipv6 permits IPv6 traffic, --no-ipv6 forbids it. INFO Instead of running a test, list all available tests. Level      Loading profile from {path}. Looks OK. Message Module        Must give the name of a domain to test.
 NOTICE Name of a file to restore DNS data from before running test. Name of a file to save DNS data to after running tests. Name of profile file to load. (DEFAULT) Name of the character encoding used for command line arguments Print a count of the number of messages at each level Print level on entries. Print the effective profile used in JSON format, then exit. Print the name of the module on entries. Print the name of the test case on entries. Print timestamp on entries. Print version information and exit. Seconds  Source IP address used to send queries. Setting an IP address not correctly configured on a local network interface causes cryptic error messages. Specify test to run. Should be either the name of a module, or the name of a module and the name of a method in that module separated by a "/" character (Example: "Basic/basic1"). The method specified must be one that takes a zone object as its single argument. This switch can be repeated. Strings with DS data on the form "keytag,algorithm,type,digest" Testcase        The domain name contains consecutive dots.
 The locale to use for messages translation. The minimum severity level to display. Must be one of CRITICAL, ERROR, WARNING, NOTICE, INFO or DEBUG. The name of the nameserver '{nsname}' contains consecutive dots. WARNING Warning: Zonemaster::LDNS not compiled with IDN support, cannot handle non-ASCII names correctly. Warning: setting locale category LC_CTYPE to %s failed (is it installed on this system?).

 Warning: setting locale category LC_MESSAGES to %s failed (is it installed on this system?).

 Project-Id-Version: 0.0.5
Report-Msgid-Bugs-To: 
PO-Revision-Date: 2014-08-28
Last-Translator: pion@afnic.fr
Language-Team: Zonemaster Team
Language: fr
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
 

   Niveau	Occurences dans le log %8s	%5d entrées.
 --level doit avoir pour valeur CRITICAL, ERROR, WARNING, NOTICE, INFO, DEBUG, DEBUG2 ou DEBUG3.
 --ns doit être un nom ou un couple nom/ip. ======= =======  =========  ============  ==============  Un nom ou une adresse IP correspondant à un serveur de noms pour les tests sur des zones non déléguées. Peut être utilisée plusieurs fois. Dès qu'un résultat de test avec ce niveau de gravité ou supérieur sera rencontré, l'exécution s'arrêtera. Doit avoir pour valeur CRITICAL, ERROR, WARNING, NOTICE, INFO ou DEBUG. A la fin de l'exécution, affichage d'un récapitulatif sur les temps de réponses des serveurs de noms de la eone interrogés au cours de l'analyse. Cette option permet d'activer ou non l'indicateur de progression (défaut=activé si STDOUT est un terminal). Désactiver avec --no-progress. CRITICAL DEBUG ERROR Impossible de reconnaître le niveau de gravité provoquant l'arrêt de l'analyse ' Option signalant que le format de sortie utilisé sera du JSON ou non. Option signalant que le format de sortie utilisé sera du flux JSON ou non. Option signalant que le format de sortie sera traduit en langage humain ou affiché en mode brut. Option signalant que le flux JSON sera traduit en langage humain ou affiché en mode brut. Option signalant que les requêtes pourront ou non être transmises en IPv4. --ipv4 autorise l'usage d'IPv4, alors que --no-ipv4 l'interdit. Option signalant que les requêtes pourront ou non être transmises en IPv6. --ipv6 autorise l'usage d'IPv6, alors que --no-ipv6 l'interdit. INFO Cette option permet d'afficher la liste de tous les tests disponibles. Ceux-ci ne seront pas exécutés. Niveau     Chargement de la politique de tests depuis le fichier {path}. Le résultat semble concluant. Message Module        Il est nécessaire d'indiquer un nom de domaine pour lancer le test.
 NOTICE Option avec comme argument le nom du fichier à partir duquel seront restaurés les résultats des requêtes DNS nécessaires à l'analyse de la zone. Option avec comme argument le nom du fichier dans lequel seront sauvegardés les résultats des requêtes DNS nécessaires à l'analyse de la zone. Option avec comme argument le nom du fichier profile à charger. (DEFAULT) Nom de l'encodage de caractères utilisé pour les arguments de la ligne de commande. Affichage du nombre total de résultats, pour chaque niveau de gravité, présents dans le journal (log). Affichage du niveau de gravité pour chaque résultat de test. Affichage du "profile" réellement utilisé au format JSON. Pour chaque résultat de test, affichage du nom du module qui en est à l'origine. Pour chaque résultat de test, affichage du nom du plan de test qui en est à l'origine. Affichage de l'horodatage (en secondes) pour suivre l'état de l'avancement de l'analyse. Affichage des informations sur les versions de l'outil et des modules de tests. Durée    Positionne l'adresse IP source qui sera utilisée lors de l'envoi des requêtes. Indiquer une adresse mal configurée sur une interface réseau locale peut conduire à des messages d'erreur peu compréhensibles. Permet d'indiquer quel test doit être exécuté. Peut être un nom de module seul, ou celui-ci associé à un nom de test, les deux étant séparés par le caractère "/" (Exemple: "Basic/basic1"). Cette option peut être répétée plusieurs fois. Option avec comme argument les informations pour le traitement de la DS. Le format à utiliser est "keytag,algorithm,type,digest". Plan de test    Le nom de domaine contient des points consécutifs.
 La "locale" à utiliser pour la traduction des messages. Option avec comme argument le niveau de gravité minimum qui sera affiché. Doit avoir pour valeur CRITICAL, ERROR, WARNING, NOTICE, INFO ou DEBUG. Le nom du serveur de noms '{nsname}' contient des points consécutifs. WARNING Attention: Zonemaster::LDNS n'est pas compilé avec le support IDN, impossible de traiter correctement les noms non ASCII. Attention: La "locale" positionnée %s n'est pas correctement prise en compte (Est-elle installée sur votre système ?).

 Attention: La "locale" positionnée %s n'est pas correctement prise en compte (Est-elle installée sur votre système ?).

 