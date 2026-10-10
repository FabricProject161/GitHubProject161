INSERT INTO dictionary_parameters (expired)
SELECT NULL
WHERE NOT EXISTS (
    SELECT 1 FROM dictionary_parameters WHERE expired IS NULL
);

DELETE FROM dictionaries WHERE id = (SELECT contact_type_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1);

INSERT INTO dictionaries DEFAULT VALUES;
UPDATE dictionaries SET parent_id = last_insert_rowid() WHERE id = last_insert_rowid();
UPDATE dictionary_parameters SET contact_type_id = last_insert_rowid();

INSERT INTO dictionary_translations (dictionary_id, lang, name, description)
SELECT contact_type_id, 'en', 'Contact methods', '' FROM dictionary_parameters WHERE expired IS NULL UNION ALL
SELECT contact_type_id, 'de', 'Kontaktmethoden', '' FROM dictionary_parameters WHERE expired IS NULL UNION ALL
SELECT contact_type_id, 'fr', 'Modes de contact', '' FROM dictionary_parameters WHERE expired IS NULL UNION ALL
SELECT contact_type_id, 'it', 'Metodi di contatto', '' FROM dictionary_parameters WHERE expired IS NULL;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT contact_type_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'Mobile', ''),
((SELECT id FROM temp_dictionaries), 'de', 'Handy', ''),
((SELECT id FROM temp_dictionaries), 'fr', 'Portable', ''),
((SELECT id FROM temp_dictionaries), 'it', 'Cellulare', '');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT contact_type_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'Email', ''),
((SELECT id FROM temp_dictionaries), 'de', 'E-Mail', ''),
((SELECT id FROM temp_dictionaries), 'fr', 'Courriel', ''),
((SELECT id FROM temp_dictionaries), 'it', 'E-mail', '');
DROP TABLE temp_dictionaries;
