**Deutsche Version: siehe unten**

---
*English:*

*This is the sourcecode of the website at [amazing-aces-bs.de](http://amazing-aces-bs.de). It is a website for a local meetup of people on the asexual spectrum.*

*If you're interested in using a similar design for your own website, please look at my personal website [metakiki.net](http://metakiki.net) for reference, because I don't provide documentation in English language for this site here*

---

Dies ist der Quellcode zur Website der Amazing Aces Braunschweig - Stammtisch für Menschen im asexuellen Spektrum.

Die Website ist aktuell unter [amazing-aces-bs.de](http://amazing-aces-bs.de) und [braunschweig.amazing-aces.de](http://braunschweig.amazing-aces.de) erreichbar.

Wer Interesse daran hat, für eine asexuelle Community einer anderen Stadt ebenfalls einen Amazing-Aces-Stammtisch zu gründen, kann mich gerne kontaktieren und nach Absprache eine Website etc. im gleichen Design erstellen - dafür kann dann ein Fork von diesem Repository erstellt werden und ich kann eine Subdomain mit *stadtname.amazing-aces.de* für euch einrichten. :)

Für eine weitere Stadt ist aktuell (Ende 2019) bereits ein solches Projekt in Arbeit, was mich sehr freut!

Die Website ist komplett statisch, kommt also ohne Browser-seitige Skripte aus.

Sie wird mit [nanoc](http://nanoc.ws) generiert. Um Änderungen zu veröffentlichen, ist folgendes Vorgehen nötig:

0. Voraussetzung: Alle Quelldateien sind entsprechend angepasst worden (Inhalte, Links, etc. - *Info dazu wird später an dieser Stelle ergänzt*).
1. Im Hauptverzeichnis der Seite wird einmal der Befehl `nanoc` ausgeführt. Damit werden alle geänderten Dateien neu kompiliert.
2. Mit dem Befehl `nanoc view` wird eine lokale Vorschau gestart, die unter *http://localhost:3000* im Browser erreichbar ist. Dann können die Änderungen geprüft und ggf. nochmal angepasst werden (Schritte 0 und 1 wiederholen, dann die Seite im Browser neu laden). Wenn alles richtig aussieht, kann der Vorschau-Prozess z.B. mit *Strg+C* beendet werden.
3. Um die Änderungen zu veröffentlichen, wird `nanoc deploy` ausgeführt (der Pfad zum Verzeichnis auf dem Webserver muss dazu in der Datei *nanoc.yaml* unter `dst:` (Zeile 17) richtig angegeben sein, und die Zugriffsrechte für den Server müssen auf dem Rechner vorhanden sein, der dafür verwendet wird.)
