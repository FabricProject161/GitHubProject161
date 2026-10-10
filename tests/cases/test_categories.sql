-- Categories are dictionary rows under the active category root.
-- The standalone categories table, dictionaries.reference, and the old
-- dictionary_languages translation shape were removed when the schema was
-- simplified, and dictionary changes are not written to audit_log.

INSERT INTO dictionaries (parent_id)
SELECT category_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;

INSERT INTO dictionary_translations (dictionary_id, lang, name, description)
VALUES (last_insert_rowid(), 'de', 'Kategorie-Test', 'Temporäre Testkategorie');

UPDATE dictionary_translations
SET name = 'Kategorie-Test-Neu'
WHERE dictionary_id = (SELECT MAX(id) FROM dictionaries)
  AND lang = 'de';

SELECT CASE WHEN COUNT(*) = 1 THEN 1 ELSE 1/0 END
FROM dictionary_categories_view
WHERE lang = 'de' AND name = 'Kategorie-Test-Neu' AND header = 0;

DELETE FROM dictionaries WHERE id = (SELECT MAX(id) FROM dictionaries);

SELECT CASE WHEN COUNT(*) = 0 THEN 1 ELSE 1/0 END
FROM dictionary_categories_view
WHERE name = 'Kategorie-Test-Neu';
