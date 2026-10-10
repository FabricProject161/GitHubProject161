# Anleitung: Validierung und Qualitätskriterien

[← Vorheriger Aufgabentyp](../07-prioritization/) · [Kursübersicht](../README.md) · [Vorlage](vorlage.md) · [Nächster Aufgabentyp →](../09-use-case/)

## Lernziel
Du kannst Mängel in Anforderungen oder Falltexten finden, das verletzte Qualitätskriterium benennen, Korrekturen vorschlagen und Validierungstechniken einsetzen.

## Typische Aufgabenstellungen
- «Finden Sie im Text *n* Mängel (Widerspruch, Unvollständigkeit, Mehrdeutigkeit). Nennen Sie das verletzte Qualitätskriterium und eine Korrektur.»
- «Nennen Sie *n* Validierungstechniken und beschreiben Sie den Einsatz einer davon.»
- «Grenzen Sie Validierung und Verifikation ab.»

## Theorie kompakt
- **Qualitätskriterien** für einzelne Anforderungen (IEEE 830 / ISO/IEC/IEEE 29148, IREB): **eindeutig**, **vollständig**, **konsistent/widerspruchsfrei**, **prüfbar**, **korrekt/notwendig**, **realisierbar**, **verfolgbar**. Für die Spezifikation als Ganzes zusätzlich: vollständig, konsistent, strukturiert.
- **Validierungstechniken:** Review (Stellungnahme, Walkthrough, Inspektion), perspektivenbasiertes Lesen, Prototyp, Checklisten, Testfälle vorab ableiten.
- **Validierung** = Sind es die richtigen Anforderungen? **Verifikation** = Wurde richtig umgesetzt?

## Beispiel (Bibliothek)
| Mangel | Kriterium | Korrektur |
|---|---|---|
| Ausleihfrist «4 Wochen» auf der Website, «30 Tage» im Reglement | konsistent | eine Frist festlegen und nur an einer Stelle pflegen |
| «Mahnungen werden zeitnah versendet» | eindeutig / prüfbar | «spätestens 1 Tag nach Fristablauf» |

## Vorgehen
1. Lies den Text mit einer **Suchliste**: Termine, Uhrzeiten, Zahlen, Beträge, Grenzwerte, Rollenbezeichnungen.
2. **Vergleiche jede Angabe mit allen anderen Stellen** (Seite A vs. Seite B, Text vs. Tabelle). Widersprüche notieren.
3. Markiere **vage Wörter**: «zeitnah», «möglichst», «gegebenenfalls», «in der Regel», «benutzerfreundlich».
4. Suche **Lücken**: Begriffe ohne Definition, Regeln ohne Zuständigkeit, Pflichtangaben ohne Erfassungsort.
5. Pro Mangel: Zitat/Fundstelle → Kriterium → konkrete Korrektur.
6. Technik: wähle eine und beschreibe **wer, womit, wie, Ergebnis** (z. B. Inspektion mit Checkliste, Befundprotokoll).

## Punktefallen
- Mangel nur benennen, ohne Kriterium oder ohne Korrektur.
- Kriterium falsch zugeordnet (Widerspruch ≠ Mehrdeutigkeit).
- Mehrmals denselben Mangeltyp aus derselben Stelle zählen.
- Techniken nur aufzählen, Einsatz im Fall nicht beschreiben.

## Checkliste
- [ ] Verlangte Anzahl unterschiedlicher Mängel mit Fundstelle
- [ ] Je Kriterium und konkrete Korrektur
- [ ] Verlangte Anzahl Techniken
- [ ] Einsatz einer Technik: wer, womit, wie, Ergebnis

## Zeitbudget
1 Punkt ≈ 1 Minute. Bei 7 P: 4 Min. Mängel, 3 Min. Techniken.
