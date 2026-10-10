-- Fresh databases have the table but no active parameter row. Every dictionary
-- seed updates that row, so create it before touching category_id.
INSERT INTO dictionary_parameters (expired)
SELECT NULL
WHERE NOT EXISTS (
    SELECT 1 FROM dictionary_parameters WHERE expired IS NULL
);

DELETE FROM dictionaries WHERE id = (SELECT category_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1);

INSERT INTO dictionaries DEFAULT VALUES;
UPDATE dictionaries SET parent_id = last_insert_rowid() WHERE id = last_insert_rowid();
UPDATE dictionary_parameters SET category_id = last_insert_rowid();

INSERT INTO dictionary_translations (dictionary_id, lang, name, description)
SELECT category_id, 'en', 'Category', 'Official performance and club classification maintained in the internal administration system of the Swiss Shooting Sports Federation (SSV)' FROM dictionary_parameters WHERE expired IS NULL UNION ALL
SELECT category_id, 'de', 'Kategorie', 'Offizielle Leistungs‑ und Vereinsklassifikation, die im internen Verwaltungssystem des Schweizer Schiesssportverbands (SSV) geführt wird' FROM dictionary_parameters WHERE expired IS NULL UNION ALL
SELECT category_id, 'fr', 'Catégorie', 'Classification officielle des performances et des sociétés, gérée dans le système administratif interne de la Fédération sportive suisse de tir (FST/SSV)' FROM dictionary_parameters WHERE expired IS NULL UNION ALL
SELECT category_id, 'it', 'Categoria', 'Classificazione ufficiale delle prestazioni e delle società, gestita nel sistema amministrativo interno della Federazione Svizzera di Tiro (FST/SSV)' FROM dictionary_parameters WHERE expired IS NULL;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT category_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', '1', 'Lowest - Smaller clubs, less competition'),
((SELECT id FROM temp_dictionaries), 'de', '1', 'Tiefste - Kleinere Vereine, weniger Wettkampfbetrieb'),
((SELECT id FROM temp_dictionaries), 'fr', '1', 'La plus basse - Clubs plus petits, moins de compétition'),
((SELECT id FROM temp_dictionaries), 'it', '1', 'Più bassa - Club più piccoli, meno competizione');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT category_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', '2', 'Middle - Solid, active clubs'),
((SELECT id FROM temp_dictionaries), 'de', '2', 'Mittlere - Solide, aktive Vereine'),
((SELECT id FROM temp_dictionaries), 'fr', '2', 'Moyenne - Clubs solides et actifs'),
((SELECT id FROM temp_dictionaries), 'it', '2', 'Media - Club solidi e attivi');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT category_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', '3', 'Strong - Above-average performance level'),
((SELECT id FROM temp_dictionaries), 'de', '3', 'Starke - Überdurchschnittliche Leistungsstufe'),
((SELECT id FROM temp_dictionaries), 'fr', '3', 'Forte - Niveau de performance supérieur à la moyenne'),
((SELECT id FROM temp_dictionaries), 'it', '3', 'Forte - Livello di prestazione superiore alla media');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT category_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', '4', 'Highest - Very strong, competition-tested clubs'),
((SELECT id FROM temp_dictionaries), 'de', '4', 'Höchste - Sehr starke, wettkampferprobte Vereine'),
((SELECT id FROM temp_dictionaries), 'fr', '4', 'La plus élevée - Clubs très forts, éprouvés en compétition'),
((SELECT id FROM temp_dictionaries), 'it', '4', 'Più alta - Club molto forti, collaudati in competizione');
DROP TABLE temp_dictionaries;