INSERT INTO clubs (ssv, name, bfs_name)
VALUES ('100', 'Testclub', 'BFS-Old');

UPDATE clubs
SET name='Testclub Neu', bfs_name='BFS-New'
WHERE name='Testclub';

SELECT CASE
    WHEN json_extract(new_values, '$.name') = 'Testclub Neu' THEN 1
    ELSE 1/0
END
FROM audit_log
WHERE table_name='clubs' AND action='UPDATE'
ORDER BY id DESC
LIMIT 1;
