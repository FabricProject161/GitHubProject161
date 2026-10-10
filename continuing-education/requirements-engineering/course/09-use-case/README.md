# Anleitung: Use Case

[← Vorheriger Aufgabentyp](../08-validation/) · [Kursübersicht](../README.md) · [Vorlage](vorlage.md)

## Lernziel
Du kannst einen Use Case tabellarisch mit Haupt-, Alternativ- und Ausnahmeszenarien beschreiben.

## Typische Aufgabenstellungen
- «Beschreiben Sie den Use Case ‹X› tabellarisch: Akteur, Vorbedingung, Auslöser, Hauptszenario (mind. *n* Schritte), Alternativ-/Ausnahmeszenarien, Nachbedingung.»
- «Zeichnen Sie ein UML-Use-Case-Diagramm mit include/extend.»
- «Grenzen Sie Use Case und User Story ab.»

## Theorie kompakt
- **Use-Case-Schablone:** Name (Verb + Objekt) · Primärakteur · weitere Akteure · Vorbedingung · Auslöser · Hauptszenario (Erfolgsfall) · Alternativszenarien (anderer Weg zum Ziel) · Ausnahmeszenarien (Ziel nicht erreicht) · Nachbedingung (Erfolg/Fehler).
- Schritte wechseln zwischen **Akteur** und **System** ab: «1. Akteur …, 2. System …».
- Nummerierung der Abzweigungen: «3a» = Abweichung bei Schritt 3, mit Rücksprung oder Abbruch.
- **UML:** «include» = immer enthalten, «extend» = optional unter Bedingung.

## Beispiel (Webshop: «Bestellung aufgeben», gekürzt)
| Element | Inhalt |
|---|---|
| Primärakteur | Kundin |
| Vorbedingung | Warenkorb enthält mind. 1 Artikel |
| Auslöser | Kundin klickt «Zur Kasse» |
| Hauptszenario | 1. Kundin gibt Lieferadresse ein. 2. System prüft die Adresse. 3. Kundin wählt Zahlungsart. 4. System zeigt Zusammenfassung mit Total. 5. Kundin bestätigt. 6. System speichert die Bestellung und sendet eine Bestätigung. |
| Alternativ / Ausnahme | 2a. Adresse ungültig → Hinweis, zurück zu 1. 3a. Zahlung abgelehnt → Abbruch mit Meldung. |
| Nachbedingung | Bestellung gespeichert, Status «bezahlt» |

## Vorgehen
1. Übernimm den **Namen** aus der Aufgabe und bestimme den **Primärakteur**.
2. Vorbedingung: Was muss vorher erfüllt sein (Login, Daten vorhanden, Frist offen)?
3. Auslöser: Welches Ereignis startet den Use Case?
4. Hauptszenario: Erfolgsfall in mind. verlangter Schrittzahl, abwechselnd Akteur/System. Baue die **Regeln des Falls** als Systemprüfungen ein.
5. Alternativ/Ausnahme: Nimm die Regeln und Fehlermöglichkeiten (Grenzwert überschritten, Daten fehlen, Technik versagt) und hänge sie mit Nummer an den passenden Schritt, inkl. Rücksprung oder Abbruch.
6. Nachbedingung: Welcher Zustand gilt nach Erfolg?

## Punktefallen
- Weniger Schritte oder Szenarien als verlangt.
- Nur Akteurschritte, keine Systemreaktionen.
- Vorbedingung und Auslöser verwechselt.
- Alternativen ohne Bezug zum Schritt und ohne Rücksprung/Abbruch.
- Nachbedingung fehlt oder beschreibt eine Aktion statt eines Zustands.

## Checkliste
- [ ] Alle verlangten Elemente der Schablone
- [ ] Hauptszenario mit genug Schritten, Akteur/System abwechselnd
- [ ] Verlangte Anzahl Alternativ-/Ausnahmeszenarien mit Schrittnummer
- [ ] Regeln des Falls eingebaut, Nachbedingung als Zustand

## Zeitbudget
1 Punkt ≈ 1 Minute. Bei 6 P: 1 Min. Kopfteil, 3 Min. Hauptszenario, 2 Min. Alternativen/Nachbedingung.
