/* =====================================================================
File: sections.sql
Purpose:
    Populate the `sections` table with deterministic test data by assigning
    every club a full set of disciplines, each paired with a randomly
    selected category.

Description:
    For every club in the `clubs` table, this script inserts one row per
    available discipline from `dictionary_discipline_view` (lang='en',
    header=0). The CROSS JOIN ensures that each club receives all
    disciplines defined in the dictionary.

    The category_id is selected randomly for each (club, discipline) pair
    from `dictionary_categories_view` (lang='en', header=0). The expression:

        MIN(dictionary_id) + (abs(random()) % COUNT(*))

    generates a uniformly distributed category_id within the available
    category range. The correlated condition (clubs.id = clubs.id) forces
    SQLite to re-evaluate the subquery for each row, ensuring that each
    discipline receives an independently randomized category.

Result:
    • One row per (club_id × discipline_id) combination.
    • discipline_id is deterministic and complete for each club.
    • category_id is randomized per discipline.
    • Suitable for automated test cases requiring full discipline coverage.

Notes:
    • This script is intended for test data only; no uniqueness constraints
      are enforced.
    • Randomness uses SQLite’s built-in random() function.
===================================================================== */

INSERT INTO sections (club_id, discipline_id, category_id)
SELECT id AS club_id,
    disciplines.dictionary_id AS discipline_id,
    (    SELECT MIN(dictionary_id) + (abs(random()) % COUNT(*)) 
         FROM dictionary_categories_view 
         WHERE lang = 'en' AND header = 0 AND clubs.id = clubs.id 
         ORDER BY random() 
         LIMIT 1
    ) AS category_id
FROM clubs
    CROSS JOIN (
        SELECT dictionary_id
        FROM dictionary_discipline_view
        WHERE lang = 'en' AND header = 0
    ) disciplines;