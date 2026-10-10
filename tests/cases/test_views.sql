-- categories_view was replaced by dictionary_categories_view.
SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 1/0 END FROM dictionary_categories_view;
SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 1/0 END FROM members_view;
SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 1/0 END FROM sections_view;
