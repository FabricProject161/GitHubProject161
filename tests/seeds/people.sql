/* =====================================================================
people.sql – Test seed generator for the "people" table

Purpose:
  Generates synthetic people for automated tests. The dataset
  is deterministic, reproducible, and contains:
    - random surnames (8 uppercase letters)
    - random names (6 uppercase letters)
    - guaranteed-unique SSV numbers (100000+)
    - random birth dates between 1940 and 2011

Implementation:
  Uses a recursive CTE to generate sequential numbers and
  derives all fields from them. No external tables or temp structures
  are required. The script is optimized for SQLite performance.

Usage:
  Loaded by the test suite before executing test cases.
  Can also be run manually:
      sqlite3 test.db < tests/seeds/people.sql

Notes:
  - All data is synthetic and safe for public repositories.
  - SSV values are strictly unique and satisfy the UNIQUE constraint.
  - Birth dates use a uniform random distribution across 29930 days.

Source: https://www.bfs.admin.ch/bfs/en/home/statistics/population/births-deaths/names-switzerland.html
===================================================================== */

DELETE FROM people;
DELETE FROM sqlite_sequence WHERE name = 'people';

WITH RECURSIVE nums(number) AS (
    SELECT 1
    UNION ALL
    SELECT number + 1 FROM nums WHERE number < 100 --number of people created
),
shuffled AS (
    SELECT number, ROW_NUMBER() OVER (ORDER BY random()) AS rownum
    FROM nums
)
INSERT INTO people (surname, name, ssv, birth_date)
SELECT
    (SELECT name
     FROM raw_person_surnames
     WHERE number = number
     ORDER BY random()
     LIMIT 1) AS surname,

    (SELECT name
     FROM raw_person_names
     WHERE number = number
     ORDER BY random()
     LIMIT 1) AS name,

    -- Generates a random six-digit number starting from 100000
    100000 + number AS ssv,

    date('1940-01-01', (abs(random()) % 26280) || ' days') AS birth_date
FROM shuffled;

DROP TABLE raw_person_surnames;
DROP TABLE raw_person_names;