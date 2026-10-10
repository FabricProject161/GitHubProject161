# Musterlösung: RE-Übung Chargenrückverfolgbarkeit «Bärgmüesli AG» (fiktiv)

## 3. Musterlösung

> Bewertung: Inhaltlich gleichwertige Antworten geben volle Punkte. Bei den Formulierungen zählt die korrekte Anwendung der Methode. Technische ERP-Details, die nicht im Fall stehen, sind als **Annahme** zu kennzeichnen.

### Lösung 1 – Stakeholder (je 1 P)

| Stakeholder | Interesse | Einfluss / Interesse |
|---|---|---|
| Geschäftsleitung (Auftraggeber) | Rückrufkosten senken, Rechtssicherheit, Go-Live 1.7.2027 | hoch / hoch → eng managen |
| Leiterin Qualitätssicherung | schnelle, vollständige Verfolgung für Audits und Rückrufe | hoch / hoch → eng managen |
| Produktion (Produktionsleiter, Schichtleiter, Linienmitarbeitende) | wenig Zusatzaufwand beim Erfassen, kein Bandstillstand | mittel / hoch → einbeziehen |
| Logistik/Lager (Leiter Logistik, Wareneingang, Versand) | schneller Wareneingang, korrekte Auslagerung (FEFO), Scanning statt Tippen | mittel / hoch → einbeziehen |
| Verkauf / Grossverteiler als Kunden | Restlaufzeit, schnelle Rückrufinformation, Chargen auf Lieferschein bzw. EDI | hoch / mittel → zufriedenstellen |
| Lieferanten (Nüsse, Hafer, Verpackung) | Chargenetiketten nach GS1-128 liefern, Rückrufmeldungen weitergeben | tief / mittel → informieren |
| Kantonale Vollzugsbehörde (Lebensmittelinspektorat) | Auskunft nach LGV Art. 83, Information bei Rückruf nach LGV Art. 84 | hoch / tief → zufriedenstellen |
| IT / ERP-Key-User, externer ERP-Berater | Standard von D365 nutzen, wenig Anpassungen | mittel / hoch |
| Endkonsumentinnen und -konsumenten (Allergiker!) | sichere Produkte, rasche Information bei Rückruf | tief / hoch → informieren |

Externer Stakeholder (Pflicht): z. B. Vollzugsbehörde, Grossverteiler, Lieferant oder Konsumenten. Fehlt er, max. 5 P.

### Lösung 2 – Systemkontext
a) **System:** Chargenverwaltung und Rückverfolgbarkeit in D365 F&SCM (Lager, Produktion, Qualität, Verkauf). **Akteure/Nachbarsysteme mit Datenflüssen:**
- Lieferanten → Lieferschein bzw. Lieferavis mit Lieferantencharge, MHD, SSCC (GS1-128-Etikett; elektronischer Lieferavis = **Annahme**)
- Mitarbeitende Wareneingang/Produktion/Versand ↔ Handscanner mit Warehouse-Management-App (Scan von GTIN, Charge, MHD)
- Abfüllanlage/Etikettendrucker ← Fertigwarencharge und MHD vom ERP (Schnittstelle = **Annahme**, heute manuell)
- Silos/Silo-Füllstand → Einfüllmenge pro Lieferung (Sensor/Waage = **Annahme**)
- Kunden (Grossverteiler) ← Lieferschein mit Charge/SSCC, Rückrufinformation (EDI = **Annahme**)
- Leiterin QS ↔ Verfolgungsbericht, Chargensperre
- Kantonale Vollzugsbehörde ← Auskunft/Rückrufmeldung (nicht automatisiert)
- Labor (intern/extern) → Analyseergebnisse, Freigabe der Charge

Pro Akteur mit korrektem Datenfluss je ca. 0,5 P, max. 4 P.

b) **Innerhalb:** Erfassung der Lieferantencharge beim Wareneingang, Chargenverbrauch in der Produktion, Vorwärts-/Rückwärtsverfolgung, Chargensperre. **Kontextgrenze:** Lieferanten-Etiketten bzw. Lieferavis (das System verarbeitet sie, kann deren Qualität aber nicht bestimmen) oder Abfüllanlage (liefert/empfängt Daten, wird aber nicht neu gebaut). **Ausserhalb:** Laboranalyse selbst, Kommunikation mit Medien und Konsumenten beim Rückruf, Rezepturentwicklung, Systeme der Grossverteiler.

### Lösung 3 – Ermittlungstechniken (je 2 P)
- **Feldbeobachtung / Apprenticing** (Beobachtung, Pflicht Produktion): in beiden Schichten am Wägeplatz und an der Abfüllung mitarbeiten. Stakeholder: Schichtleiter, Linienmitarbeitende. Erwartete Anforderungen: wann genau welche Charge verbraucht wird, Umgang mit Restmengen, Bruchware und Silo, Bedienbarkeit des Scanners mit Handschuhen, Zeitdruck.
- **Interview** (Befragung) mit Leiterin QS, Leiter Logistik, Produktionsleiter, ERP-Berater: Geschäftsregeln wie Chargendefinition, Sperrlogik, FIFO/FEFO, Aufbewahrungsfrist, Ablauf eines Rückrufs. Interviews eignen sich, um widersprüchliche Aussagen gezielt zu klären.
- **Dokumentenanalyse / Systemarchäologie** (artefaktbasiert): Papierprotokolle, Lieferscheine, Rückrufdokumentation März 2026, Auditberichte, LGV Art. 83/84, Kundenvorgaben der Grossverteiler, D365-Standardfunktionen. Daraus ergeben sich vollständige Datenanforderungen (welche Felder) und rechtliche Randbedingungen.
- Alternativ: **Workshop/Brainstorming** (Kreativität) für den Soll-Rückrufprozess oder ein **Mock-Recall** als Szenario-Workshop.

### Lösung 4 – Funktionale Anforderungen (je 2 P)
Schablone: *[Bedingung] DAS SYSTEM MUSS/SOLLTE/WIRD [<wem?>] <Prozesswort> [FÄHIG SEIN | DIE MÖGLICHKEIT BIETEN] <Objekt> …*
1. **Wareneingang:** Das ERP-System **muss** dem Mitarbeitenden Wareneingang die Möglichkeit bieten, pro Eingangsposition GTIN, Lieferantencharge, MHD und Menge durch Scannen des GS1-128-Etiketts (AI 01, 10, 15/17, 37) zu erfassen.
2. **Produktion:** **Sobald** ein Mitarbeitender eine Zutat für einen Produktionsauftrag abwiegt, **muss** das ERP-System die verbrauchte Menge mit der internen bzw. Lieferantencharge der Zutat und der entstehenden Fertigwarencharge verknüpfen.
3. **Sperre:** **Falls** eine Charge den Status «gesperrt» hat, **muss** das ERP-System die Kommissionierung, den Produktionsverbrauch und den Versand dieser Charge verhindern.
4. **Verfolgung:** Das ERP-System **muss** der Leiterin QS die Möglichkeit bieten, zu einer Lieferantencharge alle daraus hergestellten Fertigwarenchargen mit Kunden, Liefermengen und Lieferdaten anzuzeigen (Vorwärtsverfolgung).
5. **Rückwärts:** Das ERP-System **muss** der Leiterin QS die Möglichkeit bieten, zu einer Fertigwarencharge alle eingesetzten Zutatenchargen mit Lieferanten anzuzeigen.
6. **Silo:** Das ERP-System **muss** fähig sein, für jedes Silo die Zuordnung der eingefüllten Lieferantenchargen zu Zeiträumen zu führen (z. B. Silocharge pro Befüllung).
7. **Ausblick:** Das ERP-System **wird** fähig sein, Rückrufmeldungen an Grossverteiler per EDI zu übermitteln.

Abzüge: fehlendes Systemsubjekt, unklare Verbindlichkeit, vage Prozesswörter wie «verwalten» oder «unterstützen», mehrere Anforderungen in einem Satz ohne Struktur.

### Lösung 5 – Nichtfunktionale Anforderungen (je 2 P)
- **Performance/Effizienz (Pflicht Rückverfolgung):** Die vollständige Vorwärts- und Rückwärtsverfolgung einer Charge über alle Stufen (Lieferant → Fertigware → Kunde) muss in höchstens **4 Stunden** als Bericht vorliegen (inkl. Prüfung durch QS). Nachweis: Mock-Recall zweimal pro Jahr. Die Systemabfrage selbst muss in höchstens 60 Sekunden antworten.
- **Benutzbarkeit:** Ein eingeschulter Mitarbeitender muss einen Wareneingang mit 10 Paletten inkl. Chargenerfassung in höchstens 5 Minuten buchen können. Mindestens 95 % der Scans müssen ohne manuelle Nacherfassung gelingen (auch mit Arbeitshandschuhen).
- **Zuverlässigkeit/Integrität:** Die Mengenbilanz pro Produktionsauftrag (Zutaten-Input vs. Fertigware + Ausschuss + Bruchware) muss innerhalb einer Toleranz von ±2 % liegen (Toleranz = **Annahme**). Abweichungen müssen vor dem Auftragsabschluss begründet werden.
- **Sicherheit/Nachvollziehbarkeit:** Jede Änderung an Chargendaten muss mit Benutzer, Zeitstempel, altem und neuem Wert protokolliert werden. Das Protokoll darf von Benutzenden nicht geändert oder gelöscht werden.
- **Randbedingung (rechtlich):** Die Rückverfolgbarkeitsdaten müssen mindestens bis MHD + 12 Monate aufbewahrt werden (Frist = **Annahme**; LGV Art. 83 Abs. 4 verlangt «bis angenommen werden kann, dass das Produkt konsumiert worden ist»).
- **Randbedingung (technisch):** Die Lösung muss mit Standardfunktionen von D365 F&SCM umgesetzt werden (keine Eigenentwicklung im Kern).

«Möglichst schnell» oder «benutzerfreundlich» ohne Messgrösse gibt 0 P.

### Lösung 6 – User Stories (Story je 1 P, Kriterien je 1,5 P bei 2 Kriterien, gerundet; total max. 10 P)
**US1 – Rückruf (Pflicht):** Als Leiterin Qualitätssicherung möchte ich zu einer Lieferantencharge sofort alle betroffenen Kunden mit Mengen sehen, damit ich einen Rückruf auf die wirklich betroffenen Chargen beschränken und die Behörde rasch informieren kann.
- *Given* Haselnuss-Charge L-4711 wurde in den Fertigwarenchargen F-101 und F-102 verbraucht und an Kunde A und B geliefert, *When* ich die Vorwärtsverfolgung für L-4711 starte, *Then* zeigt das System F-101, F-102, Kunde A und B mit Liefermengen, Lieferdaten und Lieferscheinnummern.
- *Given* die Verfolgung ist abgeschlossen, *When* ich «Export» wähle, *Then* erzeugt das System eine Liste (Excel/PDF) mit Kunden, Kontaktadressen, Chargen, MHD und Mengen.
- *Given* F-102 ist noch teilweise an Lager, *When* die Verfolgung läuft, *Then* zeigt das System den Lagerbestand von F-102 separat an und bietet die Sperre an.

**US2 – Wareneingang:** Als Mitarbeiter Wareneingang möchte ich Lieferantencharge und MHD per Scan des GS1-128-Etiketts erfassen, damit ich schnell und ohne Tippfehler einbuchen kann.
- *Given* eine Palette mit GS1-128-Etikett (AI 01, 10, 15), *When* ich das Etikett scanne, *Then* füllt das System Artikel, Charge und MHD aus und ich muss nur die Menge bestätigen.
- *Given* eine Palette ohne Chargenetikett, *When* ich die Position einbuche, *Then* bucht das System sie mit Status «gesperrt – Charge fehlt» ein und sie kann nicht in die Produktion.

**US3 – Auslagerung nach MHD:** Als Kommissionierer möchte ich vom System die Charge mit dem kürzesten MHD vorgeschlagen bekommen, damit die Restlaufzeit für Grossverteiler eingehalten wird.
- *Given* Charge F-200 (MHD 1.3.2028) und F-210 (MHD 1.5.2028) sind an Lager, *When* ich einen Auftrag kommissioniere, *Then* schlägt das System F-200 vor (FEFO).
- *Given* die Restlaufzeit von F-200 liegt unter 2/3 des MHD, *When* ich für einen Grossverteiler kommissioniere, *Then* schlägt das System F-200 nicht vor und zeigt einen Hinweis.

(Weitere Möglichkeiten: Chargenverbrauch in der Produktion scannen, Silobefüllung erfassen, Bruchware als eigene Charge wieder einsetzen, Mock-Recall-Bericht.)

### Lösung 7 – Priorisierung (5 P)
- **Must:** US1 (Kernziel, Rechtspflicht nach LGV Art. 83/84, Anlass des Projekts), US2 (ohne Lieferantencharge keine Rückwärtsverfolgung), Chargenverbrauch in der Produktion (sonst Lücke zwischen Wareneingang und Fertigware).
- **Should:** US3 FEFO (Kundenanforderung, aber organisatorisch kurzfristig überbrückbar), Silochargen.
- **Could:** Export der Rückrufliste direkt als E-Mail an Kunden, Dashboard mit Mengenbilanz.
- **Won't (dieses Release):** EDI-Rückrufmeldung an Grossverteiler, automatische Meldung an die Behörde.
- **Kano:** Vorwärts-/Rückwärtsverfolgung = **Basismerkmal** (wird vorausgesetzt, Fehlen = grosse Unzufriedenheit). Antwortzeit der Verfolgung = **Leistungsmerkmal**. Automatische Rückrufliste mit Kundenkontakten auf Knopfdruck = **Begeisterungsmerkmal**.

### Lösung 8 – Validierung
a) (je 1 P, vier Mängel genügen)

| Mangel im Ausgangsfall | Qualitätskriterium | Korrektur |
|---|---|---|
| Ziel «Kunden innert eines Arbeitstags» vs. Leiterin QS «Verfolgung in höchstens 4 Stunden» | widerspruchsfrei / konsistent | eine verbindliche, messbare Zeit festlegen (inkl. Start- und Endzeitpunkt) |
| Leiter Logistik «Lieferantencharge Pflichtfeld, ohne Charge keine Einbuchung» vs. Lagerchef «einlagern und später nachtragen» | widerspruchsfrei | Regel klären, z. B. Einbuchung erlaubt, aber automatisch gesperrt bis Charge erfasst ist |
| Leiter Logistik «konsequent FIFO» vs. Verkaufsleiter «kürzestes MHD zuerst» (= FEFO) | widerspruchsfrei | FEFO als Regel festlegen, FIFO nur bei gleichem MHD |
| «Charge» = eine Schicht (Produktion) vs. ein Produktionsauftrag (ERP-Berater), Aufträge laufen über zwei Schichten | eindeutig / konsistent (Glossar fehlt) | Chargenbegriff im Glossar definieren. Je kleiner die Charge, desto kleiner der Rückrufumfang |
| Silo wird nie leer, neue Lieferungen auf Restbestand. Keine Regel, wie Silochargen verfolgt werden | vollständig | Silocharge pro Befüllung oder Zeitfenster definieren, ggf. Silo periodisch ganz leeren |
| Bruchware wird in späteren Aufträgen wieder eingemischt, ohne Chargenregel | vollständig | Bruchware als eigene Charge mit Herkunft führen und beim Wiedereinsatz verbrauchen |
| «Daten ausreichend lange aufbewahren» | eindeutig / prüfbar | konkrete Frist festlegen (z. B. MHD + 12 Monate, abgeleitet aus LGV Art. 83 Abs. 4) |
| «möglichst schnell und benutzerfreundlich» | eindeutig / prüfbar | messbare Werte (Zeit, Fehlerquote) festlegen |
| 15 % Export nach Deutschland, aber nur Schweizer Recht genannt | vollständig (Randbedingungen) | EU-Recht ergänzen, v. a. VO (EG) Nr. 178/2002 Art. 18 und 19 sowie Anforderungen der deutschen Kunden |
| Hafer: Lieferantencharge wird heute nicht protokolliert, Ziel «lückenlos» | vollständig / realisierbar | Silo-Lösung verbindlich festlegen (siehe oben) |

b) Techniken: **Review** (Stellungnahme, Walkthrough, Inspektion), **perspektivenbasiertes Lesen**, **Prototyp** (Scanner-Prototyp im Wareneingang testen), **Checklisten**, **Simulation/Mock-Recall**. Beispiel: Vor dem Go-Live wird ein **Mock-Recall** im Testsystem durchgespielt. Die QS gibt eine Lieferantencharge vor und misst, ob alle betroffenen Fertigwarenchargen und Kunden innert der vereinbarten Zeit vollständig gefunden werden. Abweichungen gehen als Befunde zurück in die Spezifikation. Alternativ: **perspektivenbasierte Inspektion**, bei der QS (Rechtspflichten), Produktion (Machbarkeit am Band) und Logistik (Wareneingang/FEFO) die Spezifikation je aus ihrer Sicht mit einer Checkliste prüfen.

### Lösung 9 – Use Case (6 P)
| Element | Inhalt |
|---|---|
| Name | Betroffene Fertigwarenchargen zu einer Lieferantencharge ermitteln und sperren |
| Primärakteur | Leiterin Qualitätssicherung |
| Sekundärakteure | Lager/Logistik (Umsetzung der Sperre), Verkauf (Kundeninformation) |
| Vorbedingung | Akteurin ist im ERP angemeldet und hat die Berechtigung «Chargensperre». Wareneingänge und Produktionsverbräuche sind chargengenau gebucht. |
| Auslöser | Lieferant meldet eine fehlerhafte Charge oder ein Laborbefund ist positiv |
| Hauptszenario | 1. Akteurin gibt Artikel und Lieferantencharge ein oder scannt sie. 2. System zeigt den Wareneingang (Lieferant, Datum, Menge). 3. Akteurin startet die Vorwärtsverfolgung. 4. System ermittelt alle Zwischen- und Fertigwarenchargen mit Verbrauchsmengen, Lagerbeständen und Lieferungen an Kunden. 5. Akteurin prüft das Ergebnis und markiert die zu sperrenden Chargen. 6. System setzt den Status «gesperrt», blockiert Kommissionierung und Verbrauch und protokolliert die Aktion im Audit Trail. 7. System erstellt die Rückrufliste (Kunden, Chargen, Mengen, Lieferdaten) zum Export. |
| Alternativ/Ausnahme | 1a. Lieferantencharge nicht gefunden → System sucht nach Lieferschein/Datum, Akteurin prüft manuell, Fall wird dokumentiert. 4a. Zutat lag in einem Silo mit mehreren Lieferantenchargen → System zeigt alle Fertigwarenchargen aus dem betroffenen Siloabschnitt. 4b. Rest der Charge noch nicht verbraucht → nur Lagerbestand sperren, keine Kunden betroffen. 6a. Ware bereits beim Kunden → Extend «Rückruf auslösen» (Information Behörde/Kunden nach LGV Art. 84). |
| Nachbedingung | Alle betroffenen Chargen sind gesperrt, die Rückrufliste liegt vor, die Aktion ist im Audit Trail protokolliert. |

---

## 4. Lernhinweise (prüfungsrelevant)

**Allgemein (gleich wie in jedem RE-Fall):** IREB-Haupttätigkeiten (Ermitteln, Dokumentieren, Validieren, Verwalten), Satzschablone nach Rupp, Qualitätskriterien (eindeutig, vollständig, konsistent, prüfbar, verfolgbar), MoSCoW und Kano immer begründen, Given/When/Then.

**Spezifisch für Chargenrückverfolgbarkeit:**
- **Rechtsgrundlagen sauber zitieren:** In der Schweiz verlangen LMG Art. 28 und **LGV Art. 83** die Rückverfolgbarkeit über alle Herstellungs-, Verarbeitungs- und Vertriebsstufen: Der Betrieb muss sagen können, **von wem** er bezogen und **an wen** er geliefert hat (ausser bei direkter Abgabe an Konsumenten). **LGV Art. 84** regelt Rücknahme, Rückruf und Information der kantonalen Vollzugsbehörde. In der EU verlangt **VO (EG) Nr. 178/2002 Art. 18** dasselbe Prinzip («one step back, one step forward»), Art. 19 die Rücknahme bzw. den Rückruf. Wichtig für die Prüfung: Das Gesetz verlangt die **externe** Rückverfolgbarkeit (eine Stufe zurück, eine Stufe vor). Die **interne** Verknüpfung (welche Rohstoffcharge steckt in welcher Fertigwarencharge) ist der Schlüssel, um einen Rückruf klein zu halten. Sie ist eine Geschäftsanforderung, kein Selbstzweck.
- **Rückrufzeit als messbare NFR:** «Schnell» ist nicht prüfbar. Gute Formulierung: Messgrösse (Stunden), Start (Meldung des Lieferanten), Ende (vollständige Kundenliste), Nachweis (Mock-Recall, z. B. halbjährlich). Viele Standards und Kunden verlangen solche Übungen. Die konkrete Zeit legt der Betrieb bzw. der Kunde fest, nicht das Gesetz.
- **Mengenbilanz (Mass Balance):** Prüft, ob die Verfolgung plausibel ist: Input-Menge der Charge = verbrauchte Menge + Restbestand + Ausschuss. Liegt die Abweichung ausserhalb der Toleranz, ist die Verfolgung lückenhaft (z. B. Bruchware oder Silo nicht erfasst). Eignet sich gut als Qualitätsanforderung und als Abnahmekriterium.
- **Chargengrösse = Rückrufumfang:** Die Definition der Charge (Schicht, Auftrag, Tag) ist eine fachliche Entscheidung mit grosser Kostenwirkung. Sie gehört ins **Glossar**. Typische Validierungsfrage: zwei Stakeholder meinen mit «Charge» Verschiedenes.
- **Chargensplitting und -mischung:** Kritische Stellen sind Silos und Tanks (kontinuierliche Befüllung), Nacharbeit/Bruchware (Rework) und Umpacken. Hier fehlen in Fallstudien oft Anforderungen (Unvollständigkeit).
- **Barcode/GS1-128:** Wichtige Application Identifiers: (00) SSCC der Palette, (01) GTIN, (10) Charge/Los, (15) Mindestens haltbar bis, (17) Verfallsdatum, (37) Anzahl Einheiten. Scanning ist eine Anforderung an Benutzbarkeit und Datenqualität, setzt aber auch eine **Randbedingung** bei den Lieferanten voraus (Kontextgrenze!).
- **MHD und Auslagerungsstrategie:** FIFO (First In, First Out) ≠ FEFO (First Expired, First Out). Bei Lebensmitteln mit Restlaufzeit-Vorgaben der Kunden ist FEFO üblich.
- **Chargenstatus und Sperre:** z. B. «Quarantäne», «freigegeben», «gesperrt». In D365 F&SCM etwa über Chargendispositionscodes (**Annahme** je nach Konfiguration). Eine gute Anforderung beschreibt, **was** eine Sperre verhindert (Kommissionierung, Verbrauch, Versand).
- **Audit Trail und Aufbewahrung:** Wer hat wann was geändert, nicht löschbar. Die Aufbewahrungsfrist muss konkret sein. In regulierten Branchen (Pharma: GMP/GDP, z. B. EU-GMP Annex 11 für computergestützte Systeme) sind die Anforderungen an Audit Trail und Datenintegrität noch strenger.
- **Validierung praxisnah:** Der **Mock-Recall** ist die beste Validierungs- und später Abnahmetechnik für Rückverfolgbarkeit. Er prüft Vollständigkeit und Zeit in einem Durchgang.
