INSERT INTO people (surname, name) VALUES ('Huber', 'Anna');
CREATE TEMP TABLE tmp_test_person (id INTEGER);
INSERT INTO tmp_test_person VALUES (last_insert_rowid());

INSERT INTO clubs (ssv, name) VALUES ('200', 'Club A');
CREATE TEMP TABLE tmp_test_club (id INTEGER);
INSERT INTO tmp_test_club VALUES (last_insert_rowid());

-- Roles and groups are dictionary entries, not person_roles / competitive_groups tables.
INSERT INTO members (person_id, club_id, role_id, group_id)
VALUES (
    (SELECT id FROM tmp_test_person),
    (SELECT id FROM tmp_test_club),
    (SELECT dictionary_id FROM dictionary_person_role_view WHERE lang = 'en' AND header = 0 ORDER BY dictionary_id LIMIT 1),
    (SELECT dictionary_id FROM dictionary_group_view WHERE lang = 'en' AND header = 0 ORDER BY dictionary_id LIMIT 1)
);

UPDATE members
SET role_id = (
    SELECT dictionary_id FROM dictionary_person_role_view
    WHERE lang = 'en' AND header = 0
    ORDER BY dictionary_id
    LIMIT 1 OFFSET 1
)
WHERE person_id = (SELECT id FROM tmp_test_person);

DELETE FROM members WHERE person_id = (SELECT id FROM tmp_test_person);

SELECT CASE WHEN COUNT(*) >= 1 THEN 1 ELSE 1/0 END
FROM audit_log
WHERE table_name = 'members' AND action = 'DELETE';
