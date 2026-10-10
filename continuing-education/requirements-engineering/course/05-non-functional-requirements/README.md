# Anleitung: Nichtfunktionale Anforderungen

[← Vorheriger Aufgabentyp](../04-functional-requirements/) · [Kursübersicht](../README.md) · [Vorlage](vorlage.md) · [Nächster Aufgabentyp →](../06-user-stories/)

## Lernziel
Du kannst Qualitätsanforderungen und Randbedingungen aus verschiedenen Kategorien messbar formulieren.

## Typische Aufgabenstellungen
- «Formulieren Sie *n* messbare nichtfunktionale Anforderungen aus unterschiedlichen Kategorien (z. B. ISO 25010).»
- «Unterscheiden Sie Qualitätsanforderung und Randbedingung an je einem Beispiel.»
- «Machen Sie die folgende Anforderung messbar: ‹Das System muss schnell sein.›»

## Theorie kompakt
- **Anforderungsarten (IREB):** funktional, **Qualitätsanforderung** (wie gut?), **Randbedingung** (Vorgabe, die den Lösungsraum einschränkt: rechtlich, technisch, organisatorisch).
- **ISO/IEC 25010 Produktqualität:** funktionale Eignung, Leistungseffizienz, Kompatibilität, Benutzbarkeit (Interaktionsfähigkeit), Zuverlässigkeit (inkl. Verfügbarkeit), Sicherheit, Wartbarkeit, Übertragbarkeit (Flexibilität).
- **Messbar** heisst: Messgrösse + Zielwert + Bedingung/Messmethode. Muster: *«[Objekt] muss [Messgrösse] von [Zielwert] unter [Bedingung] erreichen, geprüft durch [Methode].»*

## Beispiel (Webshop)
| Kategorie | Anforderung |
|---|---|
| Leistungseffizienz | Die Produktsuche muss in 95 % der Anfragen innert 2 Sekunden Resultate anzeigen (bei 200 gleichzeitigen Nutzern). |
| Randbedingung (rechtlich) | Der Shop muss Personendaten gemäss revDSG bearbeiten. |

## Vorgehen
1. Suche im Fall nach **vagen Qualitätsaussagen** («schnell», «einfach», «innert Minuten») und nach Vorgaben (Technik, Recht, Organisation).
2. Wähle so viele **verschiedene Kategorien** wie verlangt.
3. Ergänze pro Anforderung **Messgrösse, Zielwert und Messbedingung**. Erfundene Werte als **Annahme** markieren.
4. Nenne die Kategorie explizit.
5. Test: Könnte ein Tester mit Ja/Nein entscheiden, ob die Anforderung erfüllt ist?

## Punktefallen
- Nicht messbar («benutzerfreundlich», «sicher»).
- Zwei Anforderungen aus derselben Kategorie.
- Eine funktionale Anforderung als nichtfunktional verkaufen.
- Kategorie nicht genannt.

## Checkliste
- [ ] Verlangte Anzahl, verschiedene Kategorien
- [ ] Je Messgrösse + Zielwert + Bedingung
- [ ] Kategorie genannt, Annahmen markiert

## Zeitbudget
1 Punkt ≈ 1 Minute. Bei 3 Anforderungen / 6 P: je 2 Min.
