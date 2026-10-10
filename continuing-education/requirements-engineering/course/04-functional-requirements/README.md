# Anleitung: Funktionale Anforderungen (Satzschablone)

[← Vorheriger Aufgabentyp](../03-elicitation-techniques/) · [Kursübersicht](../README.md) · [Vorlage](vorlage.md) · [Nächster Aufgabentyp →](../05-non-functional-requirements/)

## Lernziel
Du kannst funktionale Anforderungen korrekt nach der Satzschablone von Rupp/SOPHIST formulieren und Geschäftsregeln aus einem Fall abdecken.

## Typische Aufgabenstellungen
- «Formulieren Sie *n* funktionale Anforderungen nach der Satzschablone (Rupp).»
- «Verwenden Sie die Verbindlichkeiten MUSS/SOLLTE/WIRD korrekt und mind. einmal eine Bedingung.»
- «Korrigieren Sie die folgende Anforderung, sodass sie der Schablone entspricht.»

## Theorie kompakt
**Satzschablone (Rupp/SOPHIST):**
`[Bedingung] DAS SYSTEM  MUSS | SOLLTE | WIRD  [<wem?>]  <Objekt>  <Prozesswort>` mit einem von drei Funktionalitätstypen:
- **selbständige Systemaktivität:** «… <Objekt> <Prozesswort>.»
- **Benutzerinteraktion:** «… <wem> DIE MÖGLICHKEIT BIETEN, <Objekt> zu <Prozesswort>.»
- **Schnittstellenanforderung:** «… FÄHIG SEIN, <Objekt> von/an <System> zu <Prozesswort>.»

Verbindlichkeit: **MUSS** = verbindlich, **SOLLTE** = dringend empfohlen, **WIRD** = Absicht/künftig.
Bedingung: logisch «Falls …», zeitlich «Sobald …» bzw. «Nachdem …».
Prozesswort: präzises Verb (erfassen, berechnen, senden), nicht «verarbeiten», «handhaben».

## Beispiel (Bibliothek)
- Das System **muss** der Leserin **die Möglichkeit bieten**, ein ausgeliehenes Medium höchstens zweimal zu verlängern.
- **Falls** ein Medium 7 Tage überfällig ist, **muss** das System der Leserin eine Mahnung per E-Mail senden.
- Das System **sollte fähig sein**, Katalogdaten vom Verbundkatalog zu importieren.

## Vorgehen
1. Markiere im Fall alle **Geschäftsregeln** (Grenzwerte, Pflichten, Abhängigkeiten, Berechnungen, Benachrichtigungen).
2. Wähle so viele Regeln wie verlangt, möglichst unterschiedliche.
3. Wähle pro Regel den **Funktionalitätstyp** (selbständig / Benutzer / Schnittstelle).
4. Setze die Schablone zusammen: Bedingung? → System → Verbindlichkeit → wem → Objekt → Prozesswort.
5. Prüfe die Vorgaben der Aufgabe (z. B. Verbindlichkeiten gemischt, mind. eine Bedingung).
6. Konkrete Werte (Zahlen, Grenzen) aus dem Fall übernehmen, damit die Anforderung prüfbar ist.

## Punktefallen
- Kein Systemsubjekt («Der Benutzer kann …»).
- Vage Prozesswörter, Passiv, mehrere Anforderungen in einem Satz.
- Verbindlichkeit fehlt oder falsch eingesetzt (überall MUSS, obwohl gemischt verlangt).
- Lösungsdetails (Button-Farbe) statt Anforderung.

## Checkliste
- [ ] Verlangte Anzahl
- [ ] Jede Anforderung: System + Verbindlichkeit + Objekt + Prozesswort
- [ ] Verlangte Verbindlichkeiten und Bedingung(en) vorhanden
- [ ] Je eine Anforderung pro Satz, Werte konkret

## Zeitbudget
1 Punkt ≈ 1 Minute. Bei 4 Anforderungen / 8 P: je 2 Min.
