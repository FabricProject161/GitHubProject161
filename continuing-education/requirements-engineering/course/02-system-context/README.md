# Anleitung: Systemkontext und Systemgrenze

[← Vorheriger Aufgabentyp](../01-stakeholder-analysis/) · [Kursübersicht](../README.md) · [Vorlage](vorlage.md) · [Nächster Aufgabentyp →](../03-elicitation-techniques/)

## Lernziel
Du kannst den Systemkontext darstellen und Systemgrenze, Kontextgrenze und irrelevante Umgebung unterscheiden.

## Typische Aufgabenstellungen
- «Zeichnen Sie ein Kontextdiagramm mit mind. *n* Akteuren/Nachbarsystemen und den Datenflüssen.»
- «Nennen Sie je einen Aspekt innerhalb der Systemgrenze, im Graubereich und ausserhalb. Begründen Sie.»
- «Erklären Sie den Unterschied zwischen Systemgrenze und Kontextgrenze.»

## Theorie kompakt (IREB CPRE)
- **Systemkontext:** der Teil der Umgebung, der für die Anforderungen relevant ist (Personen, Systeme, Prozesse, Dokumente).
- **Systemgrenze:** trennt, was das System selbst leistet, von seiner Umgebung (gestaltbar).
- **Kontextgrenze:** trennt den relevanten Kontext von der irrelevanten Umgebung. Im **Graubereich** liegen noch ungeklärte oder teilweise relevante Aspekte.
- **Kontextdiagramm:** System als Kasten in der Mitte, Akteure/Nachbarsysteme rundherum, **beschriftete, gerichtete** Datenflüsse. Kein Innenleben des Systems.

## Beispiel (Online-Ausleihe einer Bibliothek)
```text
 [Leserin] --Reservation--> [ Ausleihsystem ] --Abholbestätigung--> [E-Mail-Server]
 [Bibliothekar] <--Rückgabeliste-- [ Ausleihsystem ] <--Katalogdaten-- [Bibliothekskatalog]
```
Innerhalb: Reservation verwalten. Graubereich: Mahngebühren (bucht das System oder die Stadtkasse?). Ausserhalb: Bücherankauf, weil er die Ausleihe nicht beeinflusst.

## Vorgehen
1. Zeichne das **zu bauende System** als Kasten in die Mitte und benenne es.
2. Übernimm die Stakeholder aus der Stakeholderanalyse: Wer **interagiert direkt** mit dem System?
3. Geh den Prozess durch und suche **technische Nachbarsysteme** (E-Mail, Zahlung, Stammdaten, Export). Annahmen markieren.
4. Zeichne pro Akteur mind. einen **beschrifteten, gerichteten** Datenfluss.
5. Abgrenzung: Wähle je einen Aspekt aus dem Fall und begründe in einem Satz die Zuordnung.

## Punktefallen
- Zu wenige Akteure oder Pfeile ohne Beschriftung/Richtung.
- Interne Funktionen (z. B. «Login-Maske») als Nachbarsystem.
- System- und Kontextgrenze verwechseln.
- Begründung bei der Abgrenzung fehlt.

## Checkliste
- [ ] System benannt
- [ ] Verlangte Anzahl Akteure/Nachbarsysteme
- [ ] Jeder Pfeil beschriftet und gerichtet
- [ ] Innerhalb / Graubereich / ausserhalb je mit Begründung

## Zeitbudget
1 Punkt ≈ 1 Minute. Bei 6 P: 4 Min. Diagramm, 2 Min. Abgrenzung.
