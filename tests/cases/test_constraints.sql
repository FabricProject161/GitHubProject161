-- dictionary_translations.dictionary_id is NOT NULL. That is the constraint
-- the old categories.dictionary_id check covered before categories was folded
-- into the dictionary.

INSERT OR IGNORE INTO dictionary_translations (dictionary_id, lang, name)
VALUES (NULL, 'en', 'should-not-exist');

SELECT CASE WHEN COUNT(*) = 0 THEN 1 ELSE 1/0 END AS should_be_zero
FROM dictionary_translations
WHERE name = 'should-not-exist';
