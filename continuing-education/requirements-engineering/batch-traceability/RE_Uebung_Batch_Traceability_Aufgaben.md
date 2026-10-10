# RE-Übung: Chargenrückverfolgbarkeit im ERP «Bärgmüesli AG»

**Berufsprüfung Wirtschaftsinformatik (eidg. FA) – Handlungsfeld Requirements Engineering**
Bearbeitungszeit: **60 Minuten** · Total: **60 Punkte** · Hilfsmittel: keine

> **Fiktiver Fall.** Die Bärgmüesli AG, ihre Personen, Zahlen und Ereignisse sind frei erfunden. Real sind nur die zitierten Rechtsgrundlagen (Stand Oktober 2026) und die allgemein bekannten Standards (GS1-128, Microsoft Dynamics 365). Technische Details zum ERP, die nicht im Fall stehen, dürfen Sie als **Annahme** kennzeichnen.

---

## 1. Ausgangsfall (Ist-Zustand)

Die **Bärgmüesli AG** (fiktiv) ist ein Schweizer Lebensmittelhersteller mit rund **160 Mitarbeitenden** und einem Werk im Mittelland. Sie produziert Müesli, Granola und Müesliriegel in zwei Schichten. Rund **85 %** des Umsatzes gehen an zwei Schweizer Grossverteiler, an Bäckereien und an den Fachhandel, rund **15 %** werden nach Deutschland exportiert.

**Rohstoffe und Verpackung:** Haferflocken (lose per Silo-LKW, Lagerung in **zwei Silos**), Haselnüsse und Mandeln (Allergene), Trockenfrüchte, Honig, Schokolade, Verpackungsmaterial. Fertigware: Beutel à 500 g → Karton à 12 Beutel → Palette mit SSCC-Etikett.

**ERP:** Seit 2024 ist **Microsoft Dynamics 365 Finance & Supply Chain Management** im Einsatz (Einkauf, Verkauf, Lager, Finanzen). Die Produktion wird heute ausserhalb des ERP über Papier-Produktionsprotokolle und eine Excel-Liste gesteuert. Chargen werden im ERP nur für Fertigware geführt.

**Ablauf heute:**
1. **Wareneingang:** Der Lagermitarbeiter bucht die Bestellung im ERP ein. Die Lieferantencharge wird auf dem Lieferschein von Hand notiert, der Lieferschein wird abgelegt.
2. **Silo:** Haferflocken werden laufend in Silo 1 oder 2 eingeblasen. Das Silo wird nie ganz leer, neue Lieferungen werden auf den Restbestand gefüllt.
3. **Produktion:** Der Schichtleiter druckt den Produktionsauftrag mit der Rezeptur aus. Die Mitarbeitenden wägen die Zutaten ab und schreiben die Lieferantencharge der Zutaten (ausser Hafer) ins Protokoll. Bruchware und Fehlabfüllungen werden in späteren Aufträgen wieder eingemischt.
4. **Verpackung:** Die Abfüllanlage druckt MHD und Fertigwarencharge auf den Beutel. Das MHD beträgt je nach Produkt 9 bis 12 Monate.
5. **Lager und Versand:** Paletten werden mit SSCC etikettiert und im ERP auf einen Lagerplatz gebucht. Die Lieferscheine an die Kunden enthalten die Fertigwarencharge.

**Anlass für das Projekt:** Im März 2026 meldete ein Nusslieferant eine Haselnuss-Charge mit überschrittenem Aflatoxin-Grenzwert. Die Bärgmüesli AG brauchte **drei Arbeitstage**, um die betroffenen Produkte über Papierprotokolle zu ermitteln. Weil die Zuordnung unsicher war, wurde die gesamte Nuss-Müesli-Produktion von sechs Wochen zurückgerufen statt der vermutlich drei betroffenen Fertigwarenchargen. Schaden: rund CHF 400'000.–.

**Ziele der Geschäftsleitung:**
- Lückenlose Chargenrückverfolgbarkeit vom Wareneingang bis zum Kunden im ERP (Rückwärts- und Vorwärtsverfolgung).
- Die betroffenen Kunden sollen bei einem Rückruf **innert eines Arbeitstags** bekannt sein.
- Barcode-Scanning (GS1-128) beim Wareneingang, in der Produktion und im Versand mit der Warehouse-Management-App auf Handscannern.
- Lückenloser Audit Trail für alle Chargenbuchungen.
- Go-Live der Rückverfolgbarkeit: **1. Juli 2027**.

**Aussagen aus ersten Gesprächen:**
- **Leiterin Qualitätssicherung:** «Bei einem Audit oder einem Rückruf muss ich die Verfolgung über alle Stufen in höchstens **4 Stunden** auf dem Tisch haben. Die Daten müssen ausreichend lange aufbewahrt werden.»
- **Leiter Logistik:** «Beim Wareneingang muss die Lieferantencharge ein Pflichtfeld sein – ohne Charge keine Einbuchung. Im Lager lagern wir konsequent nach **FIFO** aus.»
- **Lagerchef (Wareneingang):** «Wenn auf einer Palette das Chargenetikett fehlt, lagern wir sie trotzdem ein und tragen die Charge nach, sobald der Lieferant sie mailt. Der LKW-Fahrer kann nicht warten.»
- **Verkaufsleiter:** «Die Grossverteiler verlangen bei der Anlieferung eine Restlaufzeit von mindestens zwei Dritteln des MHD. Deshalb muss immer die Ware mit dem kürzesten MHD zuerst raus.»
- **Produktionsleiter:** «Für uns ist eine Charge das, was eine Schicht auf einer Linie produziert.»
- **ERP-Berater (extern):** «Im Standard ist eine Fertigwarencharge ein Produktionsauftrag.» (Produktionsaufträge laufen oft über zwei Schichten.)
- **Geschäftsführer:** «Das System soll den Rückruf möglichst schnell und benutzerfreundlich unterstützen. Rechtlich müssen wir das Schweizer Lebensmittelrecht einhalten.»

**Rechtlicher Rahmen (Auszug):** Lebensmittelgesetz (LMG, SR 817.0) Art. 28 (Rückverfolgbarkeit), Lebensmittel- und Gebrauchsgegenständeverordnung (LGV, SR 817.02) Art. 83 (Rückverfolgbarkeit: Auskunft, von wem bezogen und an wen geliefert) und Art. 84 (Rücknahme, Rückruf, Information der kantonalen Vollzugsbehörde).

**Auftrag:** Die Geschäftsleitung der Bärgmüesli AG beauftragt Sie als Requirements Engineer, die Anforderungen an die Chargenrückverfolgbarkeit im ERP zu erheben und zu dokumentieren.

---

## 2. Aufgaben

| Nr. | Thema | Punkte | ≈ Min. |
|---|---|---|---|
| 1 | Stakeholderanalyse | 6 | 6 |
| 2 | Systemkontext und Systemgrenze | 6 | 6 |
| 3 | Ermittlungstechniken wählen und begründen | 6 | 6 |
| 4 | Funktionale Anforderungen (Satzschablone) | 8 | 8 |
| 5 | Nichtfunktionale Anforderungen | 6 | 6 |
| 6 | User Stories mit Abnahmekriterien | 10 | 10 |
| 7 | Priorisierung (MoSCoW) | 5 | 5 |
| 8 | Anforderungsvalidierung / Qualitätskriterien | 7 | 7 |
| 9 | Use Case | 6 | 6 |
| | **Total** | **60** | **60** |

**Aufgabe 1 – Stakeholderanalyse (6 P)**
Nennen Sie **sechs** Stakeholder der Chargenrückverfolgbarkeit. Geben Sie für jeden ein zentrales Interesse an und ordnen Sie ihn in einer Einfluss-/Interesse-Matrix ein (hoch/tief). Mindestens ein Stakeholder muss **ausserhalb** der Bärgmüesli AG liegen.

**Aufgabe 2 – Systemkontext und Systemgrenze (6 P)**
a) Zeichnen oder beschreiben Sie den Systemkontext der Rückverfolgbarkeitslösung: System, mind. 5 Nachbarsysteme/Akteure, Schnittstellen bzw. Datenflüsse (4 P).
b) Nennen Sie je einen Aspekt, der **innerhalb**, in der **Kontextgrenze** (Graubereich) und **ausserhalb** liegt. Begründen Sie kurz (2 P).

**Aufgabe 3 – Ermittlungstechniken (6 P)**
Wählen Sie **drei** Ermittlungstechniken aus verschiedenen Kategorien (Befragung, Beobachtung, Kreativität, artefaktbasiert). Begründen Sie je, welche Stakeholder Sie damit einbeziehen und welche Anforderungen Sie sich davon erhoffen. Eine Technik muss die Arbeit in der **Produktion** (Schichtbetrieb) erfassen.

**Aufgabe 4 – Funktionale Anforderungen (8 P)**
Formulieren Sie **vier** funktionale Anforderungen nach der **Satzschablone (Rupp)**. Verwenden Sie die Verbindlichkeiten MUSS/SOLLTE/WIRD korrekt und mindestens einmal eine Bedingung («Falls …» / «Sobald …»). Die Anforderungen sollen verschiedene Prozessschritte abdecken (z. B. Wareneingang, Produktion, Sperre, Verfolgung).

**Aufgabe 5 – Nichtfunktionale Anforderungen (6 P)**
Formulieren Sie **drei** nichtfunktionale Anforderungen (Qualitätsanforderungen oder Randbedingungen) aus unterschiedlichen Kategorien (z. B. ISO 25010). Sie müssen **messbar** sein. Eine davon muss die **Dauer der Rückverfolgung** betreffen.

**Aufgabe 6 – User Stories (10 P)**
Schreiben Sie **drei** User Stories («Als … möchte ich …, damit …»). Geben Sie zu jeder mind. **zwei** Abnahmekriterien im Format **Given/When/Then** an. Eine Story muss die **Ermittlung der betroffenen Kunden bei einem Rückruf** betreffen.

**Aufgabe 7 – Priorisierung (5 P)**
Priorisieren Sie die Stories aus Aufgabe 6 sowie zwei weitere Features Ihrer Wahl nach **MoSCoW** und begründen Sie kurz. Ordnen Sie zusätzlich **ein** Feature einer **Kano-Kategorie** zu.

**Aufgabe 8 – Validierung (7 P)**
a) Finden Sie im Ausgangsfall **vier** Mängel (Widersprüche, Unvollständigkeit, Mehrdeutigkeit). Benennen Sie jeweils das verletzte Qualitätskriterium und schlagen Sie eine Korrektur vor (4 P).
b) Nennen Sie **drei** Validierungstechniken und beschreiben Sie, wie Sie eine davon hier einsetzen würden (3 P).

**Aufgabe 9 – Use Case (6 P)**
Beschreiben Sie den Use Case **«Betroffene Fertigwarenchargen zu einer Lieferantencharge ermitteln und sperren»** tabellarisch: Akteur, Vorbedingung, Auslöser, Hauptszenario (mind. 5 Schritte), mind. 2 Alternativ-/Ausnahmeszenarien, Nachbedingung.
