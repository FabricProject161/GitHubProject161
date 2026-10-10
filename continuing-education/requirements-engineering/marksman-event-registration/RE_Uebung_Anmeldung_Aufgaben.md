# RE-Übung: Online-Anmeldung «Staudenschlacht 2027»

**Berufsprüfung Wirtschaftsinformatik (eidg. FA) – Handlungsfeld Requirements Engineering**
Bearbeitungszeit: **60 Minuten** · Total: **60 Punkte** · Hilfsmittel: keine

> Quelle: www.staudenschiessen.ch (Startseite, «Registrierung», «Anleitung», Stand 9.10.2026). Alles, was nicht auf der Website steht, ist als **Annahme** markiert.

---

## 1. Ausgangsfall (Ist-Zustand)

Das OK Staudenschlacht organisiert am **Samstag, 15. Mai 2027** das **5. Historische Erinnerungsschiessen Staudenschlacht** (Disziplinen **Gewehr** und **Pistole**). Die Anmeldung erfolgt durch die **Sektionsverantwortlichen** der Schützenvereine über eine Joomla-Website.

**Ablauf heute:**
1. **Registrierung** des Vereinskontos. Pflichtfelder: Name, Benutzername, Passwort (mind. 12 Zeichen) + Bestätigung, E-Mail, Vereinsname, SSV (Vereinsnummer), Adresse 1, Ort, PLZ, Telefon. Optional: Vereins-PLZ/-Ort, Adresse 2, Land, Website, Geburtsdatum.
2. **Manuelle Freischaltung** durch den Admin im Backend: Benutzer aktivieren und Benutzername auf die numerische User-ID setzen. Erst danach ist ein Login möglich.
3. **Login** mit User-ID und Passwort.
4. **Schützen erfassen** (Seite «Schützen»): u. a. Name, Geburtsdatum (TT.MM.JJJJ), SSV-Nummer «falls verlangt». Die Liste kann man suchen, filtern, mutieren und ein-/ausblenden.
5. **Zuordnung zu Disziplin**: Auf den Seiten «Pistolen» bzw. «Gewehr» wählt man Schütze und Gruppe (max. 6 Schützen pro Gruppe) und klickt auf «Anmelden».
6. **Bestätigungs-E-Mail** mit Anmeldedaten und Teilnahmegebühr («keine Bestätigung = keine Anmeldung»).
7. **Zahlung per Banküberweisung**. Die Anmeldung ist erst **nach Zahlungseingang** gültig.

**Regeln laut Website:**
- Gebühren (für beide Disziplinen gleich): Gruppe CHF 150.–, Einzelschütze CHF 25.–, Jungschütze CHF 20.–. Beispiel: 1 Gruppe + 6 Gruppenschützen + 2 Einzelschützen = CHF 350.–. Den Betrag muss der Verein selbst berechnen.
- Einzelschützen sind nur zusammen mit mind. einer gemeldeten (6er-)Gruppe möglich. Nicht gemeldete Schützen werden am Schiesstag nicht zugelassen.
- Schützen derselben Sektion mit **derselben Pistole** müssen bei der Anmeldung angegeben werden und kommen in unterschiedliche Ablösungen.
- Die Teilnahme am **200m-Schiessen** muss zwingend angegeben werden. 200m-Zeiten haben Vorrang vor 30m-Zeiten.
- Ablösungen werden nach Eingang der Anmeldung vergeben. Wunschrangeure werden «nach Möglichkeit» berücksichtigt. Die Ablösungsliste wird frühestens ab 4. Mai 2027 versendet.
- Ersatzweg: Anmeldung per E-Mail an anmeldung@staudenschlacht.ch.

**Termine laut Website:** Startseite: Anmeldeschluss 18. April 2027. Anleitung: Anmeldeschluss 28. April 2027. Text: erste Ablösung 08.00 Uhr. Terminbox: erste Ablösung 08:24 Uhr. Anleitung: «Sektionsleiter meldet … bis am 15. Mai 2027».

**Auftrag:** Der Schützenverein (Auftraggeber: OK Staudenschlacht) will die Anmeldung für 2028 neu bauen. Sie sind als Requirements Engineer beauftragt.

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
Nennen Sie **sechs** Stakeholder der Online-Anmeldung. Geben Sie für jeden ein zentrales Interesse an und ordnen Sie ihn in einer Einfluss-/Interesse-Matrix ein (hoch/tief).

**Aufgabe 2 – Systemkontext und Systemgrenze (6 P)**
a) Zeichnen oder beschreiben Sie den Systemkontext: System, mind. 5 Nachbarsysteme/Akteure, Schnittstellen bzw. Datenflüsse (4 P).
b) Nennen Sie je einen Aspekt, der **innerhalb**, in der **Kontextgrenze** (Graubereich) und **ausserhalb** liegt. Begründen Sie kurz (2 P).

**Aufgabe 3 – Ermittlungstechniken (6 P)**
Wählen Sie **drei** Ermittlungstechniken aus verschiedenen Kategorien (Befragung, Beobachtung, Kreativität, artefaktbasiert). Begründen Sie je, welche Stakeholder Sie damit einbeziehen und welche Anforderungen Sie sich davon erhoffen.

**Aufgabe 4 – Funktionale Anforderungen (8 P)**
Formulieren Sie **vier** funktionale Anforderungen nach der **Satzschablone (Rupp)**. Verwenden Sie die Verbindlichkeiten MUSS/SOLLTE/WIRD korrekt und mindestens einmal eine Bedingung («Falls …» / «Sobald …»). Die Anforderungen sollen die Regeln aus dem Ausgangsfall abdecken.

**Aufgabe 5 – Nichtfunktionale Anforderungen (6 P)**
Formulieren Sie **drei** nichtfunktionale Anforderungen (Qualitätsanforderungen oder Randbedingungen) aus unterschiedlichen Kategorien (z. B. ISO 25010). Sie müssen **messbar** sein.

**Aufgabe 6 – User Stories (10 P)**
Schreiben Sie **drei** User Stories («Als … möchte ich …, damit …»). Geben Sie zu jeder mind. **zwei** Abnahmekriterien im Format **Given/When/Then** an. Eine Story muss die Kostenberechnung betreffen.

**Aufgabe 7 – Priorisierung (5 P)**
Priorisieren Sie die Stories aus Aufgabe 6 sowie zwei weitere Features Ihrer Wahl nach **MoSCoW** und begründen Sie kurz. Ordnen Sie zusätzlich **ein** Feature einer **Kano-Kategorie** zu.

**Aufgabe 8 – Validierung (7 P)**
a) Finden Sie im Ausgangsfall **vier** Mängel (Widersprüche, Unvollständigkeit, Mehrdeutigkeit). Benennen Sie jeweils das verletzte Qualitätskriterium und schlagen Sie eine Korrektur vor (4 P).
b) Nennen Sie **drei** Validierungstechniken und beschreiben Sie, wie Sie eine davon hier einsetzen würden (3 P).

**Aufgabe 9 – Use Case (6 P)**
Beschreiben Sie den Use Case **«Gruppe für Disziplin anmelden»** tabellarisch: Akteur, Vorbedingung, Auslöser, Hauptszenario (mind. 5 Schritte), mind. 2 Alternativ-/Ausnahmeszenarien, Nachbedingung.

