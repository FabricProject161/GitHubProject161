# Anleitung: User Stories mit Abnahmekriterien

[← Vorheriger Aufgabentyp](../05-non-functional-requirements/) · [Kursübersicht](../README.md) · [Vorlage](vorlage.md) · [Nächster Aufgabentyp →](../07-prioritization/)

## Lernziel
Du kannst User Stories im Format Rolle–Ziel–Nutzen schreiben und mit prüfbaren Abnahmekriterien (Given/When/Then) ergänzen.

## Typische Aufgabenstellungen
- «Schreiben Sie *n* User Stories mit je mind. zwei Abnahmekriterien im Format Given/When/Then.»
- «Eine Story muss den Aspekt X (z. B. Berechnung, Benachrichtigung) betreffen.»
- «Prüfen Sie die Story anhand der INVEST-Kriterien.»

## Theorie kompakt
- **Format:** «Als **<Rolle>** möchte ich **<Ziel>**, damit **<Nutzen>**.»
- **INVEST:** Independent, Negotiable, Valuable, Estimable, Small, Testable.
- **Abnahmekriterien (Gherkin):** *Given* <Ausgangszustand> *When* <Aktion/Ereignis> *Then* <erwartetes, prüfbares Ergebnis>.
- Gute Kriterien decken den **Normalfall** und einen **Grenz- oder Fehlerfall** ab und enthalten konkrete Werte.

## Beispiel (Bibliothek)
**Als** Leserin **möchte ich** ein Medium online verlängern, **damit** ich keine Mahngebühr zahle.
- *Given* ein Medium mit 0 Verlängerungen, *When* ich «Verlängern» klicke, *Then* verschiebt sich das Rückgabedatum um 28 Tage.
- *Given* ein Medium mit 2 Verlängerungen, *When* ich «Verlängern» klicke, *Then* erscheint «Maximale Verlängerungen erreicht» und das Datum bleibt gleich.

## Vorgehen
1. Wähle aus dem Fall die **Rollen** (meist aus der Stakeholderanalyse) und deren wichtigste Ziele.
2. Erfülle zuerst die **Pflichtvorgaben** der Aufgabe (z. B. «eine Story zum Thema X»).
3. Schreibe pro Story Rolle–Ziel–**Nutzen**. Der Nutzen erklärt das Warum, nicht das Was nochmals.
4. Leite aus den Regeln des Falls je **ein Normal- und ein Grenz-/Fehlerkriterium** ab.
5. Setze konkrete Werte (Zahlen, Meldungen, Zustände) ein, damit jedes Then prüfbar ist.

## Punktefallen
- Nutzen fehlt oder wiederholt das Ziel.
- Rolle «Benutzer» statt konkreter Rolle, oder Rolle «System».
- Then nicht prüfbar («funktioniert korrekt»).
- Pflichtthema vergessen, zu wenige Kriterien pro Story.

## Checkliste
- [ ] Verlangte Anzahl Stories, Pflichtthema abgedeckt
- [ ] Jede Story: Rolle, Ziel, Nutzen
- [ ] Je mind. verlangte Anzahl Given/When/Then
- [ ] Normal- und Fehler-/Grenzfall, konkrete Werte

## Zeitbudget
1 Punkt ≈ 1 Minute. Bei 3 Stories / 10 P: gut 3 Min. pro Story.
