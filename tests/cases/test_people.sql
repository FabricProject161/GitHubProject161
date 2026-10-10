INSERT INTO people (surname, name, ssv, birth_date)
VALUES ('Muster', 'Max', 12345, '1980-01-01');

DELETE FROM people WHERE id = (SELECT MAX(id) FROM people);

SELECT CASE
    WHEN json_extract(old_values, '$.surname') = 'Muster' THEN 1
    ELSE 1/0
END
FROM audit_log
WHERE table_name='people' AND action='DELETE'
ORDER BY id DESC
LIMIT 1;
