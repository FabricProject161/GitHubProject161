-- Generate password: php -r "echo password_hash('>>text password<<', PASSWORD_BCRYPT) . PHP_EOL;"

SELECT DISTINCT 'CALL create_user_with_fields(''' || Name || ''', ''' || Login || ''', ''' 
    || Email || ''', ''' || '>>hash password<<' 
    || ''', ''' || Permissions || ''', ''' || Postcode || ''', ''' || Place || ''', ''' 
    || Street || ''', ''' || Phone || ''');' AS SQL 
FROM (
SELECT UPPER(SUBSTR(President, INSTR(President, ' ') + 1, 1)) || SUBSTR(President, 1, INSTR(President, ' ') - 1) AS Login, 
    President AS Name, Mail_P AS Email, 'Registered' AS Permissions, PLZ_P AS Postcode, Ort_P AS Place, Str_P AS Street, Tel1 AS Phone 
    FROM GStauden.Sektion_view UNION ALL
SELECT UPPER(SUBSTR(President, INSTR(President, ' ') + 1, 1)) || SUBSTR(President, 1, INSTR(President, ' ') - 1) AS Login, 
    President AS Name, Mail_P AS Email, 'Registered' AS Permissions, PLZ_P AS Postcode, Ort_P AS Place, Str_P AS Street, Tel1 AS Phone 
    FROM PStauden.Sektion_view
) A ORDER BY Place, Name;