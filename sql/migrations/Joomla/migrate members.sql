DROP TABLE temp_members;
CREATE TEMP TABLE temp_members AS
SELECT ROW_NUMBER() OVER (ORDER BY REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, 'Ä', 'Ae'),'ä', 'ae'),'Ö', 'Oe'),'ö', 'oe'),'Ü', 'Ue'),'ü', 'ue'), Vorname, Geb, Plz, Ort, SSV) id,
    CASE WHEN name LIKE '% %' THEN name ELSE UPPER(substr(name, 1, 1)) || LOWER(substr(name, 2)) END name, Vorname first, Geb birth, MAX(Plz) postcode, MAX(Ort) place, MAX(SSV) ssv
FROM (
    SELECT 'G2026' File, TRIM(Name) Name, TRIM(Vorname) Vorname, TRIM(Geb) Geb, TRIM(Plz) Plz, NULLIF(TRIM(Ort), '') Ort, NULLIF(SSV, 0) SSV, Sektion, Gruppe FROM G2026.TJahr UNION
    SELECT 'GStauden' File, TRIM(Name) Name, TRIM(Vorname) Vorname, TRIM(Geb) Geb, TRIM(Plz) Plz, NULLIF(TRIM(Ort), '') Ort, NULLIF(SSV, 0) SSV, Sektion, 0 Gruppe FROM GStauden.TMitglied UNION
    SELECT 'PStauden' File, TRIM(Name) Name, TRIM(Vorname) Vorname, TRIM(Geb) Geb, TRIM(Plz) Plz, NULLIF(TRIM(Ort), '') Ort, NULLIF(SSV, 0) SSV, Sektion, 0 Gruppe FROM PStauden.TMitglied UNION
    SELECT 'P2026' File, TRIM(Name) Name, TRIM(Vorname) Vorname, TRIM(Geb) Geb, TRIM(Plz) Plz, NULLIF(TRIM(Ort), '') Ort, NULLIF(SSV, 0) SSV, Sektion, Gruppe FROM P2026.TJahr) A
GROUP BY Name, Vorname, Geb
ORDER BY REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, 'Ä', 'Ae'),'ä', 'ae'),'Ö', 'Oe'),'ö', 'oe'),'Ü', 'Ue'),'ü', 'ue'), Vorname, Geb;
SELECT * 
    -- CONCAT('INSERT INTO stau_visforms_11 (created, published, F164, F162, F163, F165, F166, F167) VALUES (NOW(), 1, ''', Name, ''', ''', SSV, ''', ''', Vorname, ''', ''', Geb, ''', ''',Plz,''', ''',Ort,''');') AS Inserts
FROM temp_members;

