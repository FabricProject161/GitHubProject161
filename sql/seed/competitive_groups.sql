DELETE FROM dictionaries WHERE id = (SELECT group_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1);

INSERT INTO dictionaries DEFAULT VALUES;
UPDATE dictionaries SET parent_id = last_insert_rowid() WHERE id = last_insert_rowid();
UPDATE dictionary_parameters SET group_id = last_insert_rowid();

INSERT INTO dictionary_translations (dictionary_id, lang, name, description)
SELECT group_id, 'en', 'Group', 'Officially registered teams formed by shooting clubs to participate in Swiss shooting competitions' FROM dictionary_parameters WHERE expired IS NULL UNION ALL
SELECT group_id, 'de', 'Gruppe', 'Offiziell gemeldete Gruppen eines Schützenvereins, die an Wettkämpfen des Schweizer Schiesssportverbands teilnehmen' FROM dictionary_parameters WHERE expired IS NULL UNION ALL
SELECT group_id, 'fr', 'Groupe', 'Équipes officiellement enregistrées par les sociétés de tir pour participer aux compétitions suisses' FROM dictionary_parameters WHERE expired IS NULL UNION ALL
SELECT group_id, 'it', 'Gruppo', 'Aquadre ufficialmente registrate dalle società di tiro per partecipare alle competizioni svizzere' FROM dictionary_parameters WHERE expired IS NULL;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT group_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', '1', 'Strongest shooters'),
((SELECT id FROM temp_dictionaries), 'de', '1', 'Stärkste Schützen'),
((SELECT id FROM temp_dictionaries), 'fr', '1', 'Tireurs les plus fort'),
((SELECT id FROM temp_dictionaries), 'it', '1', 'Tiratori più forti');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT group_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', '2', 'Good shooters'),
((SELECT id FROM temp_dictionaries), 'de', '2', 'Gute Schützen'),
((SELECT id FROM temp_dictionaries), 'fr', '2', 'Bons tireurs'),
((SELECT id FROM temp_dictionaries), 'it', '2', 'Buoni tiratori');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT group_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', '3', 'Solid shooters'),
((SELECT id FROM temp_dictionaries), 'de', '3', 'Solide Schützen'),
((SELECT id FROM temp_dictionaries), 'fr', '3', 'Tireurs solides'),
((SELECT id FROM temp_dictionaries), 'it', '3', 'Buoni tiratori');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT group_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', '4', 'unior / Senior / Occasional shooters'),
((SELECT id FROM temp_dictionaries), 'de', '4', 'Nachwuchs / Senioren / Gelegenheitsschützen'),
((SELECT id FROM temp_dictionaries), 'fr', '4', 'Jeunes / Seniors / Tireurs occasionnels'),
((SELECT id FROM temp_dictionaries), 'it', '4', 'Giovani / Seniores / Tiratori occasionali');
DROP TABLE temp_dictionaries;