# Anleitung: Priorisierung (MoSCoW, Kano)

[← Vorheriger Aufgabentyp](../06-user-stories/) · [Kursübersicht](../README.md) · [Vorlage](vorlage.md) · [Nächster Aufgabentyp →](../08-validation/)

## Lernziel
Du kannst Anforderungen nach MoSCoW priorisieren, die Wahl begründen und Features dem Kano-Modell zuordnen.

## Typische Aufgabenstellungen
- «Priorisieren Sie die Stories/Features nach MoSCoW und begründen Sie kurz.»
- «Ordnen Sie *n* Features einer Kano-Kategorie zu.»
- «Nennen Sie weitere Priorisierungstechniken und deren Einsatzgebiet.»

## Theorie kompakt
- **MoSCoW:** **Must** (ohne geht das System/Release nicht, Pflicht durch Recht oder Kernregel) · **Should** (wichtig, aber umgehbar) · **Could** (nice to have) · **Won't (this time)** (bewusst ausgeschlossen, später möglich).
- **Kano-Modell:** **Basismerkmal** (selbstverständlich; fehlt es → Unzufriedenheit) · **Leistungsmerkmal** (je mehr, desto zufriedener) · **Begeisterungsmerkmal** (unerwartet; begeistert). Begeisterungsmerkmale werden mit der Zeit zu Basismerkmalen.
- Weitere Techniken: Ranking, Top-Ten, Wiegers-Matrix (Nutzen/Kosten/Risiko), Kosten-Wert-Ansatz.

## Beispiel (Webshop)
| Feature | MoSCoW | Begründung |
|---|---|---|
| Bezahlung mit Rechnung | Must | ohne Zahlung kein Verkauf |
| Wunschliste | Could | Mehrwert, aber für den Kauf nicht nötig |
| Produktempfehlungen per KI | Won't | Aufwand hoch, Nutzen im 1. Release unklar |

Kano: Sendungsverfolgung = Basismerkmal (Kunden erwarten sie heute).

## Vorgehen
1. Liste alle zu priorisierenden Elemente auf (z. B. eigene Stories + verlangte Zusatzfeatures).
2. Frage pro Element: Was passiert, wenn es **fehlt**? Unbrauchbar/illegal → Must; Umweg möglich → Should; kaum Auswirkung → Could; bewusst später → Won't.
3. Begründe mit Bezug zum Fall (Regel, Risiko, Aufwand, Stakeholder).
4. Verteile die Kategorien realistisch, nicht alles Must. Mind. ein Won't zeigt Verständnis.
5. Kano: Wähle ein Feature und begründe über die **Kundenerwartung**.

## Punktefallen
- Alles «Must» oder keine Begründung.
- «Won't» als «nie» verstehen.
- Kano mit MoSCoW verwechseln (Kano = Kundenzufriedenheit, MoSCoW = Umsetzungspriorität).
- Verlangte Zusatzfeatures vergessen.

## Checkliste
- [ ] Alle verlangten Elemente priorisiert
- [ ] Je Begründung mit Fallbezug
- [ ] Sinnvolle Verteilung über die Kategorien
- [ ] Kano-Zuordnung mit Begründung

## Zeitbudget
1 Punkt ≈ 1 Minute. Bei 5 P: 3 Min. MoSCoW, 1 Min. Kano, 1 Min. Checkliste.
