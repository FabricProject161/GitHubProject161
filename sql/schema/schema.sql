--
-- File generated with SQLiteStudio v3.4.21 on Mon Jun 1 07:51:57 2026
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: audit_log
CREATE TABLE audit_log (
    id INTEGER PRIMARY KEY,
    table_name TEXT,
    row_id INTEGER,
    action TEXT, -- INSERT, UPDATE, DELETE
    changed_at TEXT,
    old_values TEXT,
    new_values TEXT
);

-- Table: club_communities
CREATE TABLE club_communities (zip_id INTEGER REFERENCES communities (zip_id) ON DELETE NO ACTION ON UPDATE NO ACTION, bfs_id INTEGER REFERENCES communities (city) ON DELETE NO ACTION ON UPDATE NO ACTION, club_id INTEGER REFERENCES clubs (id) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (zip_id, bfs_id) REFERENCES communities (zip_id, bfs_id));

-- Table: clubs
CREATE TABLE clubs (id INTEGER PRIMARY KEY AUTOINCREMENT, ssv TEXT, name TEXT NOT NULL UNIQUE, bfs_name TEXT);

-- Table: communities
CREATE TABLE communities (
    city     TEXT,
    code     INTEGER,
    ext      INTEGER,
    zip_id   INTEGER,
    name     TEXT,
    bfs_id   INTEGER,
    canton   TEXT,
    shared   TEXT,
    east     INTEGER,
    north    INTEGER,
    lang     TEXT,
    validity TEXT,
    PRIMARY KEY (zip_id, bfs_id)
);

-- Table: contacts
CREATE TABLE contacts (id INTEGER PRIMARY KEY AUTOINCREMENT, person_id INTEGER REFERENCES people (id) ON DELETE CASCADE ON UPDATE CASCADE, type_id INTEGER DEFAULT (1), detail TEXT NOT NULL);

-- Table: dictionaries
CREATE TABLE dictionaries (id INTEGER PRIMARY KEY AUTOINCREMENT, parent_id INTEGER REFERENCES dictionaries (id) ON DELETE CASCADE ON UPDATE CASCADE);

-- Table: dictionary_parameters
CREATE TABLE dictionary_parameters (expired TEXT, category_id INTEGER REFERENCES dictionaries (id) ON DELETE SET NULL ON UPDATE CASCADE, group_id INTEGER REFERENCES dictionaries (id) ON DELETE SET NULL ON UPDATE CASCADE, contact_type_id INTEGER REFERENCES dictionaries (id) ON DELETE SET NULL ON UPDATE CASCADE, discipline_id INTEGER REFERENCES dictionaries (id) ON DELETE SET NULL ON UPDATE CASCADE, person_role_id INTEGER REFERENCES dictionaries (id) ON DELETE SET DEFAULT ON UPDATE CASCADE);

-- Table: dictionary_translations
CREATE TABLE dictionary_translations (id INTEGER PRIMARY KEY AUTOINCREMENT, dictionary_id INTEGER NOT NULL, lang TEXT (2) REFERENCES languages (lang) ON DELETE CASCADE ON UPDATE CASCADE DEFAULT en NOT NULL, name TEXT, description TEXT);

-- Table: languages
CREATE TABLE languages (lang TEXT (2) PRIMARY KEY UNIQUE, name TEXT);

-- Table: members
CREATE TABLE members (id INTEGER PRIMARY KEY AUTOINCREMENT, person_id INTEGER REFERENCES people (id) ON DELETE RESTRICT ON UPDATE CASCADE, club_id INTEGER REFERENCES clubs (id) ON DELETE RESTRICT ON UPDATE CASCADE, role_id INTEGER DEFAULT (1), group_id INTEGER DEFAULT (4));

-- Table: people
CREATE TABLE people (id INTEGER PRIMARY KEY, surname TEXT NOT NULL, name TEXT, ssv INTEGER DEFAULT (0) UNIQUE, birth_date TEXT DEFAULT ('1900-01-01'));

-- Table: sections
CREATE TABLE sections (id INTEGER PRIMARY KEY AUTOINCREMENT, club_id INTEGER NOT NULL REFERENCES clubs (id) ON DELETE RESTRICT ON UPDATE CASCADE, discipline_id INTEGER NOT NULL DEFAULT (1), category_id INTEGER);

-- Index: idx_people_ssv
CREATE INDEX idx_people_ssv ON people (ssv);

-- Index: idx_people_surname_name
CREATE INDEX idx_people_surname_name ON people (surname, name);

-- View: club_communities_view
CREATE VIEW club_communities_view AS
SELECT clubs.name AS club, communities.name AS community, 
    communities.canton, communities.code, bfs_name AS bfs
FROM clubs
    LEFT JOIN club_communities ON club_communities.club_id = clubs.id
    LEFT JOIN communities ON communities.zip_id = club_communities.zip_id
        AND communities.bfs_id = club_communities.bfs_id;

-- View: dictionary_categories_view
CREATE VIEW dictionary_categories_view AS SELECT dictionary_translations.dictionary_id,
    dictionary_translations.name,
    dictionary_translations.description,
    dictionary_translations.lang,
    dictionaries.id = dictionaries.parent_id AS header
FROM dictionaries
    JOIN dictionary_parameters ON dictionary_parameters.category_id = dictionaries.parent_id
    JOIN dictionary_translations ON dictionary_translations.dictionary_id = dictionaries.id;

-- View: dictionary_contact_type_view
CREATE VIEW dictionary_contact_type_view AS
SELECT dictionary_translations.dictionary_id,
    dictionary_translations.name,
    dictionary_translations.description,
    dictionary_translations.lang,
    dictionaries.id = dictionaries.parent_id AS header
FROM dictionaries
    JOIN dictionary_parameters ON dictionary_parameters.contact_type_id = dictionaries.parent_id
    JOIN dictionary_translations ON dictionary_translations.dictionary_id = dictionaries.id;

-- View: dictionary_discipline_view
CREATE VIEW dictionary_discipline_view AS
SELECT dictionary_translations.dictionary_id,
    dictionary_translations.name,
    dictionary_translations.description,
    dictionary_translations.lang,
    dictionaries.id = dictionaries.parent_id AS header
FROM dictionaries
    JOIN dictionary_parameters ON dictionary_parameters.discipline_id = dictionaries.parent_id
    JOIN dictionary_translations ON dictionary_translations.dictionary_id = dictionaries.id;

-- View: dictionary_group_view
CREATE VIEW dictionary_group_view AS SELECT dictionary_translations.dictionary_id,
    dictionary_translations.name,
    dictionary_translations.description,
    dictionary_translations.lang,
    dictionaries.id = dictionaries.parent_id AS header
FROM dictionaries
    JOIN dictionary_parameters ON dictionary_parameters.group_id = dictionaries.parent_id
    JOIN dictionary_translations ON dictionary_translations.dictionary_id = dictionaries.id;

-- View: dictionary_person_role_view
CREATE VIEW dictionary_person_role_view AS
SELECT dictionary_translations.dictionary_id,
    dictionary_translations.name,
    dictionary_translations.description,
    dictionary_translations.lang,
    dictionaries.id = dictionaries.parent_id AS header
FROM dictionaries
    JOIN dictionary_parameters ON dictionary_parameters.person_role_id = dictionaries.parent_id
    JOIN dictionary_translations ON dictionary_translations.dictionary_id = dictionaries.id;

-- View: members_view
CREATE VIEW members_view AS
SELECT members.id,
    clubs.name AS club,
    people.name,
    people.surname,
    people.ssv,
    people.birth_date,
    role.name,
    grp.name,
    grp.lang
FROM members
    JOIN people ON people.id = members.person_id
    JOIN clubs ON clubs.id = members.club_id
    JOIN dictionary_translations role ON role.dictionary_id = members.role_id
    JOIN dictionary_translations grp ON grp.dictionary_id = members.group_id
        AND grp.lang = role.lang;

-- View: sections_view
CREATE VIEW sections_view AS
SELECT clubs.name AS club,
    discipline.name AS discipline,
    discipline.description,
    category.name AS category,
    discipline.lang
FROM sections
    JOIN clubs ON clubs.id = sections.club_id
    JOIN dictionary_translations discipline ON discipline.dictionary_id = sections.discipline_id
    JOIN dictionary_translations category ON category.dictionary_id = sections.category_id
        AND category.lang = discipline.lang;

-- Trigger: club_communities_audit_delete
CREATE TRIGGER club_communities_audit_delete BEFORE DELETE ON club_communities FOR EACH ROW BEGIN INSERT INTO audit_log (table_name, row_id, action, changed_at, old_values, new_values) VALUES ('club_communities', OLD.id, 'DELETE', datetime('now'), json_object('club_id', OLD.club_id), NULL); END;

-- Trigger: club_communities_audit_update
CREATE TRIGGER club_communities_audit_update
         AFTER UPDATE
            ON club_communities
      FOR EACH ROW
BEGIN
    INSERT INTO audit_log (
                              table_name,
                              row_id,
                              action,
                              changed_at,
                              old_values,
                              new_values
                          )
                          VALUES (
                              'club_communities',
                              OLD.id,
                              'UPDATE',
                              datetime('now'),
                              json_object('club_id', OLD.club_id),
                              json_object('club_id', NEW.club_id) 
                          );
END;

-- Trigger: clubs_audit_delete
CREATE TRIGGER clubs_audit_delete BEFORE DELETE ON clubs FOR EACH ROW BEGIN INSERT INTO audit_log (table_name, row_id, action, changed_at, old_values, new_values) VALUES ('clubs', OLD.id, 'DELETE', datetime('now'), json_object('ssv', OLD.ssv, 'name', OLD.name, 'bfs_name', OLD.bfs_name), NULL); END;

-- Trigger: clubs_audit_update
CREATE TRIGGER clubs_audit_update AFTER UPDATE ON clubs FOR EACH ROW BEGIN INSERT INTO audit_log (table_name, row_id, action, changed_at, old_values, new_values) VALUES ('clubs', OLD.id, 'UPDATE', datetime('now'), json_object('ssv', OLD.ssv, 'name', OLD.name, 'bfs_name', OLD.bfs_name), json_object('ssv', NEW.ssv, 'name', NEW.name, 'bfs_name', NEW.bfs_name)); END;

-- Trigger: contacts_audit_delete
CREATE TRIGGER contacts_audit_delete BEFORE DELETE ON contacts FOR EACH ROW BEGIN INSERT INTO audit_log (table_name, row_id, action, changed_at, old_values, new_values) VALUES ('contacts', OLD.id, 'DELETE', datetime('now'), json_object('person_id', OLD.person_id, 'type_id', OLD.type_id, 'detail', OLD.detail), NULL); END;

-- Trigger: contacts_audit_update
CREATE TRIGGER contacts_audit_update AFTER UPDATE ON contacts FOR EACH ROW BEGIN INSERT INTO audit_log (table_name, row_id, action, changed_at, old_values, new_values) VALUES ('contacts', OLD.id, 'UPDATE', datetime('now'), json_object('person_id', OLD.person_id, 'type_id', OLD.type_id, 'detail', OLD.detail), json_object('person_id', NEW.person_id, 'type_id', NEW.type_id, 'detail', NEW.detail)); END;

-- Trigger: members_audit_delete
CREATE TRIGGER members_audit_delete BEFORE DELETE ON members FOR EACH ROW BEGIN INSERT INTO audit_log (table_name, row_id, action, changed_at, old_values, new_values) VALUES ('members', OLD.id, 'DELETE', datetime('now'), json_object('person_id', OLD.person_id, 'club_id', OLD.club_id, 'role_id', OLD.role_id, 'group_id', OLD.group_id), NULL); END;

-- Trigger: members_audit_update
CREATE TRIGGER members_audit_update AFTER UPDATE ON members FOR EACH ROW BEGIN INSERT INTO audit_log (table_name, row_id, action, changed_at, old_values, new_values) VALUES ('members', OLD.id, 'UPDATE', datetime('now'), json_object('person_id', OLD.person_id, 'club_id', OLD.club_id, 'role_id', OLD.role_id, 'group_id', OLD.group_id), json_object('person_id', NEW.person_id, 'club_id', NEW.club_id, 'role_id', NEW.role_id, 'group_id', NEW.group_id)); END;

-- Trigger: people_audit_delete
CREATE TRIGGER people_audit_delete BEFORE DELETE ON people FOR EACH ROW BEGIN INSERT INTO audit_log (table_name, row_id, action, changed_at, old_values, new_values) VALUES ('people', OLD.id, 'DELETE', datetime('now'), json_object('surname', OLD.surname, 'name', OLD.name, 'ssv', OLD.ssv, 'birth_date', OLD.birth_date), NULL); END;

-- Trigger: people_audit_update
CREATE TRIGGER people_audit_update AFTER UPDATE ON people FOR EACH ROW BEGIN INSERT INTO audit_log (table_name, row_id, action, changed_at, old_values, new_values) VALUES ('people', OLD.id, 'UPDATE', datetime('now'), json_object('surname', OLD.surname, 'name', OLD.name, 'ssv', OLD.ssv, 'birth_date', OLD.birth_date), json_object('surname', NEW.surname, 'name', NEW.name, 'ssv', NEW.ssv, 'birth_date', NEW.birth_date)); END;

-- Trigger: sections_audit_delete
CREATE TRIGGER sections_audit_delete BEFORE DELETE ON sections FOR EACH ROW BEGIN INSERT INTO audit_log (table_name, row_id, action, changed_at, old_values, new_values) VALUES ('sections', OLD.id, 'DELETE', datetime('now'), json_object('club_id', OLD.club_id, 'discipline_id', OLD.discipline_id, 'category_id', OLD.category_id), NULL); END;

-- Trigger: sections_audit_update
CREATE TRIGGER sections_audit_update AFTER UPDATE ON sections FOR EACH ROW BEGIN INSERT INTO audit_log (table_name, row_id, action, changed_at, old_values, new_values) VALUES ('sections', OLD.id, 'UPDATE', datetime('now'), json_object('club_id', OLD.club_id, 'discipline_id', OLD.discipline_id, 'category_id', OLD.category_id), json_object('club_id', NEW.club_id, 'discipline_id', NEW.discipline_id, 'category_id', NEW.category_id)); END;

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
