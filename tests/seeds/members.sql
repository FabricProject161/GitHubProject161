/* =====================================================================
File: test_members.sql
Purpose: Populate the `members` table with randomized but valid test data.
---------------------------------------------------------------------------

This script inserts one membership record for every person in the `people`
table. Each membership receives:

  • club_id  – randomly selected from all clubs.
               The subquery is correlated (WHERE people.id = people.id)
               to force SQLite to re-evaluate ORDER BY random() for each
               person, ensuring a different random club assignment.

  • role_id  – randomly selected from dictionary_person_role_view
               (lang='en', header=0). The expression:
                   MIN(dictionary_id) + (abs(random()) % COUNT(*))
               generates a uniformly distributed random role_id within
               the available range.

  • group_id – randomly selected from dictionary_group_view
               (lang='en', header=0) using the same technique as role_id.

Notes:
  • No uniqueness constraints are enforced here; this script is intended
    for test data generation only.
  • The shuffled_clubs CTE pre-randomizes the club list, but the correlated
    subquery ensures a fresh random pick per person.
  • All randomness uses SQLite’s built-in random() function.

Result:
  One row per person in `people`, each assigned to a random club, role,
  and group, suitable for automated test cases.
===================================================================== */

WITH shuffled_clubs AS (
    SELECT id AS club_id
    FROM clubs
    ORDER BY random()
)
INSERT INTO members (person_id, club_id, role_id, group_id)
SELECT people.id AS person_id,
    (    SELECT club_id
         FROM shuffled_clubs
         WHERE people.id = people.id
         ORDER BY random()
         LIMIT 1
    ) AS club_id,
    (    SELECT MIN(dictionary_id) + (abs(random()) % COUNT(*)) 
         FROM dictionary_person_role_view 
         WHERE lang = 'en' AND header = 0 AND people.id = people.id 
         ORDER BY random() 
         LIMIT 1
    ) AS role_id,
    (    SELECT MIN(dictionary_id) + (abs(random()) % COUNT(*)) 
         FROM dictionary_group_view 
         WHERE lang = 'en' AND header = 0 AND people.id = people.id 
         ORDER BY random() 
         LIMIT 1
    ) AS group_id
FROM people;