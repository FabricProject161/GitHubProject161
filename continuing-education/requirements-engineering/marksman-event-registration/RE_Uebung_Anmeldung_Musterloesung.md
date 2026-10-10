# Musterlösung: RE-Übung Online-Anmeldung «Staudenschlacht 2027»

## 3. Musterlösung

> Bewertung: Inhaltlich gleichwertige Antworten geben volle Punkte. Bei den Formulierungen zählt die korrekte Anwendung der Methode.

### Lösung 1 – Stakeholder (je 1 P)

| Stakeholder | Interesse | Einfluss / Interesse |
|---|---|---|
| OK Staudenschlacht (Auftraggeber) | reibungsloser Anlass, vollständige Zahlungen | hoch / hoch → eng managen |
| Sektionsverantwortliche/Vereinsleitung (Hauptnutzer) | schnelle, einfache Anmeldung, klare Kosten | mittel / hoch → einbeziehen |
| Website-Admin | wenig manuelle Freischaltung, wenig Support | mittel / hoch |
| Kassier/Finanzen (SG Bremgarten) | Zahlungen eindeutig zuordnen | mittel / hoch |
| Schiessbetrieb / Rangeur-Planung (Standchef) | korrekte Ablösungen, 200m/30m, gleiche Pistole | hoch / mittel |
| Schützinnen und Schützen, Jungschützen | Wunschzeit, Bestätigung | tief / mittel → informieren |
| Datenschutz (revDSG), SSV-Reglement (Annahme) | Rahmenbedingungen | hoch / tief → zufriedenstellen |

### Lösung 2 – Systemkontext
a) **System:** Online-Anmeldeportal. **Akteure/Nachbarsysteme:** Sektionsverantwortliche (Registrierung, Schützen, Gruppen ↔ Bestätigung), Admin (Freischaltung), E-Mail-Server (Bestätigung, Ablösungsliste), Bank/Zahlungseingang (Kontoauszug bzw. camt.054 als **Annahme**), Planung der Ablösungen/Rangeure (Export der Anmeldungen), SSV-Mitgliederverwaltung (z. B. SSV-Nummer prüfen, **Annahme**), Kontaktadresse/Telefon für die manuelle Anmeldung. Pro Akteur mit Datenfluss je ca. 0,5 P, max. 4 P.
b) **Innerhalb:** Erfassung der Schützen, Gruppenbildung, Kostenberechnung. **Kontextgrenze:** Zahlungsabgleich mit der Bank (das System liest Daten ein, bucht aber nicht). **Ausserhalb:** Durchführung am Schiesstag, Ranglisten, Schiessreglement.

### Lösung 3 – Ermittlungstechniken (je 2 P)
- **Interview** (Befragung) mit OK und Admin: Geschäftsregeln (Fristen, Gebühren, Ausnahmen), Ablauf der Freischaltung. Mit Interviews lassen sich implizites Wissen und Widersprüche klären.
- **Systemarchäologie / Dokumentenanalyse** (artefaktbasiert): Schiessreglement, bestehende Website, Bestätigungsmails, Support-Mails. Daraus gewinnt man vollständige Daten- und Regelanforderungen.
- **Feldbeobachtung / Apprenticing** (Beobachtung): einem Sektionsverantwortlichen bei der Anmeldung zuschauen. So zeigen sich Usability-Probleme (z. B. ob die Zuordnung zur Gruppe klar ist).
- Alternativ **Fragebogen** an alle Vereine (viele, verteilte Stakeholder) oder **Brainstorming/Workshop** (Kreativität) für Begeisterungsmerkmale.

### Lösung 4 – Funktionale Anforderungen (je 2 P)
Schablone: *[Bedingung] DAS SYSTEM MUSS/SOLLTE/WIRD [<wem?>] <Prozesswort> [FÄHIG SEIN | DIE MÖGLICHKEIT BIETEN] <Objekt> …*
1. Das System **muss** dem Sektionsverantwortlichen die Möglichkeit bieten, pro Gruppe und Disziplin höchstens 6 Schützen zuzuordnen.
2. **Falls** ein Verein Einzelschützen ohne mind. eine gemeldete Gruppe derselben Disziplin anmelden will, **muss** das System die Anmeldung mit einer Fehlermeldung zurückweisen.
3. **Sobald** eine Anmeldung abgeschlossen ist, **muss** das System dem Sektionsverantwortlichen eine Bestätigung mit Anmeldedaten, Gesamtbetrag und Zahlungsangaben per E-Mail senden.
4. Das System **muss** fähig sein, den Gesamtbetrag aus Anzahl Gruppen × CHF 150, Einzel-/Gruppenschützen × CHF 25 und Jungschützen × CHF 20 zu berechnen.
5. Das System **sollte** dem Sektionsverantwortlichen die Möglichkeit bieten, pro Schütze die Teilnahme am 200m-Schiessen, einen Wunschrangeur und die gemeinsame Nutzung einer Pistole zu erfassen.

Abzüge gibt es bei fehlendem Systemsubjekt, unklarer Verbindlichkeit oder Prozesswörtern wie «verarbeiten».

### Lösung 5 – Nichtfunktionale Anforderungen (je 2 P)
- **Benutzbarkeit:** Ein geübter Sektionsverantwortlicher muss eine Gruppe mit 6 Schützen in höchstens 10 Minuten anmelden können (Usability-Test mit 5 Personen).
- **Performance:** Die Bestätigungs-E-Mail muss in 95 % der Fälle innert 5 Minuten nach Abschluss versendet werden (die Website sagt nur «innert Minuten»).
- **Sicherheit/Datenschutz:** Personendaten (Geburtsdatum, SSV-Nr.) müssen nach revDSG verarbeitet, über HTTPS übertragen und spätestens 12 Monate nach dem Anlass gelöscht werden (Frist = **Annahme**).
- **Verfügbarkeit:** Das Portal muss während der Anmeldephase zu 99 % pro Monat verfügbar sein.
- **Randbedingung:** Das System muss auf dem bestehenden Joomla-CMS laufen (**Annahme**).

### Lösung 6 – User Stories (Story je 1 P, Kriterien je 1,5 P bei 2 Kriterien, gerundet; total max. 10 P)
**US1 – Kosten:** Als Sektionsverantwortliche möchte ich den zu zahlenden Betrag automatisch berechnet sehen, damit ich ohne Reglement richtig einzahle.
- *Given* 1 Gruppe mit 6 Gruppenschützen und 2 Einzelschützen, *When* ich die Übersicht öffne, *Then* zeigt das System CHF 350.00.
- *Given* ein erfasster Jungschütze, *When* der Betrag berechnet wird, *Then* verrechnet das System für ihn CHF 20.00 statt CHF 25.00.

**US2 – Gruppengrösse:** Als Sektionsverantwortlicher möchte ich daran gehindert werden, mehr als 6 Schützen in eine Gruppe zu setzen, damit meine Meldung gültig ist.
- *Given* Gruppe 1 hat 6 Schützen, *When* ich einen 7. zuordne, *Then* erscheint «Gruppe voll (max. 6)» und die Zuordnung wird nicht gespeichert.
- *Given* keine Gruppe in der Disziplin Pistole, *When* ich einen Einzelschützen Pistole anmelde, *Then* lehnt das System die Anmeldung mit Hinweis auf die Gruppenpflicht ab.

**US3 – Fristen:** Als OK-Mitglied möchte ich, dass nach Ablauf der Anmeldefrist keine Online-Anmeldungen mehr möglich sind, damit die Planung der Ablösungen stabil bleibt.
- *Given* heute ist nach der Anmeldefrist, *When* ein Verein «Anmelden» klickt, *Then* ist der Button deaktiviert und es wird auf die Kontaktadresse verwiesen.
- *Given* eine Anmeldung ohne Zahlungseingang 10 Tage nach Bestätigung (**Annahme**), *When* die Frist abläuft, *Then* erhält der Verein eine automatische Zahlungserinnerung.

(Weitere Möglichkeiten: Selbst-Freischaltung per E-Mail-Verifikation statt Admin, Zahlungsstatus im Konto sehen, QR-Rechnung.)

### Lösung 7 – Priorisierung (5 P)
- **Must:** US2 (Gruppengrösse/Gruppenpflicht = Kernregel des Reglements), US1 (Kostenberechnung; ohne sie gibt es viele Fehlzahlungen und Support-Aufwand).
- **Should:** US3 (Fristsperre; eine Ausnahme ist laut Website möglich, deshalb manuell überbrückbar), Erfassung von 200m/gleicher Pistole.
- **Could:** QR-Rechnung, Zahlungsstatus im Konto.
- **Won't (dieses Mal):** Online-Zahlung per Kreditkarte/TWINT, Ranglisten.
- **Kano:** Automatische Kostenberechnung = **Leistungsmerkmal**. Bestätigungsmail = **Basismerkmal** (fehlt sie, gibt es Unzufriedenheit). QR-Rechnung oder Wunschzeit-Anzeige = **Begeisterungsmerkmal** (veraltet mit der Zeit zum Basismerkmal).

### Lösung 8 – Validierung
a) (je 1 P)
| Mangel | Qualitätskriterium | Korrektur |
|---|---|---|
| Anmeldefrist 18.4. vs. 28.4.2027 | widerspruchsfrei / konsistent | eine verbindliche Frist festlegen, nur an einer Stelle pflegen |
| Erste Ablösung 08.00 vs. 08:24 Uhr | konsistent | klären, eine Angabe |
| «Sektionsleiter meldet … bis 15. Mai 2027» = Schiesstag | korrekt / widerspruchsfrei zur Frist | Datum korrigieren |
| «Ausnahmefällen», «nach Möglichkeit», «innert Minuten» | eindeutig / prüfbar | Kriterien bzw. Zeitwerte definieren |
| «SSV-Nummer, falls verlangt» – wann? | vollständig / eindeutig | Regel definieren (z. B. Pflicht für alle Lizenzierten) |
| Jungschütze CHF 20 – zählt er als Gruppenschütze? Altersgrenze? | vollständig | Definition im Glossar |
| «6er-Gruppe» (genau 6) vs. «max. 6 pro Gruppe» | widerspruchsfrei | klären, ob kleinere Gruppen erlaubt sind |
| 200m-Teilnahme und gleiche Pistole «zwingend angeben» – kein Feld in der Anleitung erkennbar (**Annahme**: fehlt) | vollständig | Felder ergänzen |

b) Techniken: **Review** (Stellungnahme, Inspektion, Walkthrough), **Prototyp** (Klick-Prototyp mit Vereinen testen), **Checklisten**, **Perspektivenbasiertes Lesen**. Beispiel: Bei einer **Inspektion** prüfen OK, Admin und Kassier die Anforderungsspezifikation mit einer Checkliste nach IREB-Kriterien (eindeutig, konsistent, vollständig, prüfbar, verfolgbar). Die Befunde werden protokolliert und der Spezifikation zur Korrektur übergeben.

### Lösung 9 – Use Case (6 P)
| Element | Inhalt |
|---|---|
| Name | Gruppe für Disziplin anmelden |
| Primärakteur | Sektionsverantwortlicher |
| Vorbedingung | Konto freigeschaltet, eingeloggt, Schützen erfasst, Frist nicht abgelaufen |
| Auslöser | Verein will Gruppe für Gewehr oder Pistole melden |
| Hauptszenario | 1. Akteur wählt Disziplin. 2. System zeigt die erfassten Schützen. 3. Akteur wählt Gruppe und bis zu 6 Schützen, gibt 200m-Teilnahme/Wunschrangeur an. 4. System prüft die Regeln (max. 6, Doppelanmeldung). 5. Akteur bestätigt. 6. System speichert, berechnet den Betrag und sendet die Bestätigungs-E-Mail. |
| Alternativ/Ausnahme | 4a. Mehr als 6 Schützen → Fehlermeldung, zurück zu 3. 3a. Schütze fehlt → Akteur erfasst ihn (Include «Schütze erfassen»). 6a. E-Mail-Versand scheitert → Hinweis im Portal, Admin wird informiert. 1a. Frist abgelaufen → Hinweis auf E-Mail-Kontakt. |
| Nachbedingung | Anmeldung gespeichert, Status «offen – Zahlung ausstehend» |

---

## 4. Lernhinweise (prüfungsrelevant)

- **IREB CPRE Foundation Level:** RE-Haupttätigkeiten: Ermitteln, Dokumentieren, Prüfen/Abstimmen (Validieren), Verwalten. Daneben Systemkontext vs. Systemgrenze vs. Kontextgrenze, Stakeholder und Anforderungsquellen (Stakeholder, Dokumente, Systeme).
- **Anforderungsarten:** funktional, Qualität (nichtfunktional, z. B. nach ISO 25010) und Randbedingungen (rechtlich, technisch, organisatorisch).
- **Satzschablone (Rupp/SOPHIST):** Bedingung + System + MUSS/SOLLTE/WIRD + Funktionalitätstyp (selbständig / Benutzerinteraktion / Schnittstelle) + Objekt + Prozesswort. Merken: **MUSS** = rechtlich verbindlich, **SOLLTE** = dringend empfohlen, **WIRD** = Absicht/Zukunft.
- **Qualitätskriterien** einzelner Anforderungen: eindeutig, vollständig, konsistent, prüfbar, verfolgbar, realisierbar, notwendig. Häufige Prüfungsfrage: Mängel in einem Text finden und benennen.
- **Ermittlungstechniken** gibt es pro Kategorie, ihre Wahl hängt von Stakeholdern, Wissensart und Zeit ab. **Kano** dient der Einordnung: Basis = selbstverständlich, Leistung = je mehr, desto besser, Begeisterung = unerwartet.
- **MoSCoW** (Must/Should/Could/Won't) ist eine Priorisierungstechnik. Daneben gibt es Ranking, Kano und Wiegers-Matrix. In der Prüfung immer **begründen**.
- **User Stories:** Rolle–Ziel–Nutzen, INVEST-Kriterien, Abnahmekriterien Given/When/Then. **Use Case:** Text (Haupt-/Alternativszenario) und UML-Use-Case-Diagramm mit include/extend.
- Prüfungstipp: Begriffe sauber verwenden (z. B. «Validierung» = richtige Anforderungen? / «Verifikation» = Anforderungen richtig umgesetzt?) und bei Mini-Fällen immer **Bezug zum Fall** herstellen.
