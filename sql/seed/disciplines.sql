DELETE FROM dictionaries WHERE id = (SELECT discipline_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1);

INSERT INTO dictionaries DEFAULT VALUES;
UPDATE dictionaries SET parent_id = last_insert_rowid() WHERE id = last_insert_rowid();
UPDATE dictionary_parameters SET discipline_id = last_insert_rowid();

INSERT INTO dictionary_translations (dictionary_id, lang, name, description)
SELECT discipline_id, 'en', 'Disciplines', 'Competitive categories in Swiss shooting sports, defined by weapon type and distance (e.g., rifle 300?m, rifle 50?m, air rifle 10?m, pistol 25?m, pistol 50?m). Each discipline has its own rules, scoring system, and competition formats.' FROM dictionary_parameters WHERE expired IS NULL UNION ALL
SELECT discipline_id, 'de', 'Disziplinen', 'Wettkampfkategorien im Schweizer Schiesssport, festgelegt nach Waffenart und Distanz (z.?B. Gewehr 300?m, Gewehr 50?m, Luftgewehr 10?m, Pistole 25?m, Pistole 50?m). Jede Disziplin besitzt eigene Regeln, Wertungen und Wettkampfformen.' FROM dictionary_parameters WHERE expired IS NULL UNION ALL
SELECT discipline_id, 'fr', 'Disciplines', 'Catégories de compétition dans le tir sportif suisse, définies par le type d’arme et la distance (p.?ex. carabine 300?m, carabine 50?m, air comprimé 10?m, pistolet 25?m, pistolet 50?m). Chaque discipline possède ses propres règles et formats de compétition.' FROM dictionary_parameters WHERE expired IS NULL UNION ALL
SELECT discipline_id, 'it', 'Discipline', 'Categorie competitive del tiro sportivo svizzero, definite dal tipo di arma e dalla distanza (ad es. carabina 300?m, carabina 50?m, aria compressa 10?m, pistola 25?m, pistola 50?m). Ogni disciplina ha regolamenti e formati di gara propri.' FROM dictionary_parameters WHERE expired IS NULL;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT discipline_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'G300', 'Rifle 300 m'),
((SELECT id FROM temp_dictionaries), 'de', 'G300', 'Gewehr 300 m'),
((SELECT id FROM temp_dictionaries), 'fr', 'G300', 'Carabine 300 m'),
((SELECT id FROM temp_dictionaries), 'it', 'G300', 'Carabina 300 m');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT discipline_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'G50', 'Smallbore rifle 50 m'),
((SELECT id FROM temp_dictionaries), 'de', 'G50', 'Kleinkaliber 50 m'),
((SELECT id FROM temp_dictionaries), 'fr', 'G50', 'Carabine petit calibre 50 m'),
((SELECT id FROM temp_dictionaries), 'it', 'G50', 'Carabina piccolo calibro 50 m');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT discipline_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'G10', 'Air rifle 10 m'),
((SELECT id FROM temp_dictionaries), 'de', 'G10', 'Luftgewehr 10 m'),
((SELECT id FROM temp_dictionaries), 'fr', 'G10', 'Carabine à air 10 m'),
((SELECT id FROM temp_dictionaries), 'it', 'G10', 'Carabina ad aria 10 m');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT discipline_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'P50', 'Pistol 50 m'),
((SELECT id FROM temp_dictionaries), 'de', 'P50', 'Pistole 50 m'),
((SELECT id FROM temp_dictionaries), 'fr', 'P50', 'Pistolet 50 m'),
((SELECT id FROM temp_dictionaries), 'it', 'P50', 'Pistola 50 m');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT discipline_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'P25', 'Pistol 25 m'),
((SELECT id FROM temp_dictionaries), 'de', 'P25', 'Pistole 25 m'),
((SELECT id FROM temp_dictionaries), 'fr', 'P25', 'Pistolet 25 m'),
((SELECT id FROM temp_dictionaries), 'it', 'P25', 'Pistola 25 m');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT discipline_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'P10', 'Air pistol 10 m'),
((SELECT id FROM temp_dictionaries), 'de', 'P10', 'Luftpistole 10 m'),
((SELECT id FROM temp_dictionaries), 'fr', 'P10', 'Pistolet à air 10 m'),
((SELECT id FROM temp_dictionaries), 'it', 'P10', 'Pistola ad aria 10 m');
DROP TABLE temp_dictionaries;