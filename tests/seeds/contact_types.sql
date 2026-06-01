/* =====================================================================
File: contact_types.sql
Purpose:
    Populate the `contacts` table with test data by assigning each person
    one mobile number (type_id = 12) and one email address (type_id = 13).

Description:
    This script selects all people from the `people` table and generates
    two contact entries per person:

      • Mobile (type_id = 12)
          A valid-looking Swiss mobile number in the format:
              07x xxx xx xx
          constructed using SQLite’s random() function and printf() for
          proper digit padding.

      • Email (type_id = 13)
          A synthetic email address based on:
              lower(firstname.lastnameNN@example.com)
          where NN is a two‑digit random suffix to ensure uniqueness.

    The script CROSS JOINs the dictionary of contact types so that each
    person receives one entry for every supported type_id defined in the
    dictionary (currently Mobile and Email). The CASE expression generates
    the appropriate detail value depending on the contact type.

Result:
    • Exactly two contacts per person.
    • Mobile numbers follow Swiss formatting conventions.
    • Email addresses are deterministic, lowercase, and unique enough for
      test scenarios.
    • Suitable for automated test cases requiring complete contact data.

Notes:
    • This file is intended for test data only.
    • All randomness uses SQLite’s built‑in random() function.
 ===================================================================== */

INSERT INTO contacts (person_id, type_id, detail)
SELECT id AS people_id,
    types.dictionary_id AS type_id,
    CASE WHEN types.Name = 'Mobile' 
        THEN '07' || (abs(random()) % 8) || ' ' ||  -- Swiss mobile number: 07x xxx xx xx  
        	printf('%03d', abs(random()) % 1000) || ' ' || 
        	printf('%02d', abs(random()) % 100) || ' ' || 
        	printf('%02d', abs(random()) % 100)
        ELSE lower(people.name || '.' || people.surname) || 
        	printf('%02d', abs(random()) % 100) || '@test.ch' 
        END AS detail
FROM people
    CROSS JOIN (
        SELECT dictionary_id, name
        FROM dictionary_contact_type_view
        WHERE lang = 'en' AND header = 0
    ) types;