--
-- File generated with SQLiteStudio v3.4.21 on Sun May 31 06:29:13 2026
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: audit_log
CREATE TABLE IF NOT EXISTS audit_log (
    id         INTEGER PRIMARY KEY,
    table_name TEXT,
    row_id     INTEGER,
    action     TEXT,-- INSERT, UPDATE, DELETE
    changed_at TEXT,
    old_values TEXT,
    new_values TEXT
);


-- Table: categories
CREATE TABLE IF NOT EXISTS categories (
    id            INTEGER PRIMARY KEY,
    dictionary_id INTEGER REFERENCES dictionaries (id) ON DELETE RESTRICT
                                                       ON UPDATE CASCADE
                          UNIQUE
                          NOT NULL
);


-- Table: club_communities
CREATE TABLE IF NOT EXISTS club_communities (
    zip_id  INTEGER REFERENCES communities (zip_id) ON DELETE NO ACTION
                                                    ON UPDATE NO ACTION,
    bfs_id  INTEGER REFERENCES communities (city) ON DELETE NO ACTION
                                                  ON UPDATE NO ACTION,
    club_id INTEGER REFERENCES clubs (id) ON DELETE CASCADE
                                          ON UPDATE CASCADE,
    FOREIGN KEY (
        zip_id,
        bfs_id
    )
    REFERENCES communities (zip_id,
    bfs_id) 
);


-- Table: clubs
CREATE TABLE IF NOT EXISTS clubs (
    id       INTEGER PRIMARY KEY AUTOINCREMENT,
    ssv      TEXT,
    name     TEXT    NOT NULL
                     UNIQUE,
    bfs_name TEXT
);


-- Table: communities
CREATE TABLE IF NOT EXISTS communities (
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
    PRIMARY KEY (
        zip_id,
        bfs_id
    )
);


-- Table: competitive_groups
CREATE TABLE IF NOT EXISTS competitive_groups (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    dictionary_id INTEGER REFERENCES dictionaries (id) ON DELETE CASCADE
                                                       ON UPDATE CASCADE
                          NOT NULL
                          UNIQUE
);


-- Table: contact_types
CREATE TABLE IF NOT EXISTS contact_types (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    dictionary_id INTEGER REFERENCES dictionaries (id) ON DELETE RESTRICT
                                                       ON UPDATE CASCADE
                          NOT NULL
                          UNIQUE
);


-- Table: contacts
CREATE TABLE IF NOT EXISTS contacts (
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    person_id INTEGER REFERENCES people (id) ON DELETE CASCADE
                                             ON UPDATE CASCADE,
    type_id   INTEGER REFERENCES contact_types (id) ON DELETE SET DEFAULT
                                                    ON UPDATE CASCADE
                      DEFAULT (1),
    detail    TEXT    NOT NULL
);


-- Table: dictionaries
CREATE TABLE IF NOT EXISTS dictionaries (
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    reference TEXT
);


-- Table: dictionary_languages
CREATE TABLE IF NOT EXISTS dictionary_languages (
    dictionary_id INTEGER  REFERENCES dictionaries (id) ON DELETE CASCADE
                                                        ON UPDATE CASCADE
                           NOT NULL,
    lang          TEXT (2) REFERENCES languages (lang) ON DELETE CASCADE
                                                       ON UPDATE CASCADE
                           DEFAULT en
                           NOT NULL,
    name          TEXT,
    description   TEXT
);


-- Table: disciplines
CREATE TABLE IF NOT EXISTS disciplines (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    dictionary_id INTEGER REFERENCES dictionaries (id) ON DELETE RESTRICT
                                                       ON UPDATE CASCADE
                          UNIQUE
                          NOT NULL
);


-- Table: languages
CREATE TABLE IF NOT EXISTS languages (
    lang TEXT (2) PRIMARY KEY
                  UNIQUE,
    name TEXT
);


-- Table: members
CREATE TABLE IF NOT EXISTS members (
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    person_id INTEGER REFERENCES people (id) ON DELETE RESTRICT
                                             ON UPDATE CASCADE,
    club_id   INTEGER REFERENCES clubs (id) ON DELETE RESTRICT
                                            ON UPDATE CASCADE,
    role_id   INTEGER REFERENCES person_roles (id) ON DELETE RESTRICT
                                                   ON UPDATE CASCADE
                      DEFAULT (1),
    group_id  INTEGER REFERENCES competitive_groups (id) ON DELETE SET DEFAULT
                                                         ON UPDATE CASCADE
                      DEFAULT (4) 
);


-- Table: people
CREATE TABLE IF NOT EXISTS people (
    id         INTEGER PRIMARY KEY,
    surname    TEXT    NOT NULL,
    name       TEXT,
    ssv        INTEGER DEFAULT (0) 
                       UNIQUE,
    birth_date TEXT    DEFAULT ('1900-01-01') 
);


-- Table: person_roles
CREATE TABLE IF NOT EXISTS person_roles (
    id            INTEGER PRIMARY KEY,
    dictionary_id INTEGER REFERENCES dictionaries (id) ON DELETE RESTRICT
                                                       ON UPDATE CASCADE
                          NOT NULL
                          UNIQUE
);


-- Table: sections
CREATE TABLE IF NOT EXISTS sections (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    club_id       INTEGER NOT NULL
                          REFERENCES clubs (id) ON DELETE RESTRICT
                                                ON UPDATE CASCADE,
    discipline_id INTEGER REFERENCES disciplines (id) ON DELETE RESTRICT
                                                      ON UPDATE CASCADE
                          NOT NULL
                          DEFAULT (1),
    category_id   INTEGER REFERENCES categories (id) ON DELETE RESTRICT
                                                     ON UPDATE CASCADE
                          DEFAULT (4) 
);


-- Index: idx_people_ssv
CREATE INDEX IF NOT EXISTS idx_people_ssv ON people (
    ssv
);


-- Index: idx_people_surname_name
CREATE INDEX IF NOT EXISTS idx_people_surname_name ON people (
    surname,
    name
);


-- View: categories_view
CREATE VIEW IF NOT EXISTS categories_view AS
    SELECT categories.id,
           dictionary_languages.name,
           dictionary_languages.description,
           dictionary_languages.lang
      FROM categories
           JOIN
           dictionary_languages ON dictionary_languages.dictionary_id = categories.dictionary_id;


-- View: club_communities_view
CREATE VIEW IF NOT EXISTS club_communities_view AS
    SELECT clubs.name AS club,
           communities.name AS community,
           communities.canton,
           communities.code,
           bfs_name AS bfs
      FROM clubs
           LEFT JOIN
           club_communities ON club_communities.club_id = clubs.id
           LEFT JOIN
           communities ON communities.zip_id = club_communities.zip_id AND
                          communities.bfs_id = club_communities.bfs_id;


-- View: competitive_groups_view
CREATE VIEW IF NOT EXISTS competitive_groups_view AS
    SELECT competitive_groups.id,
           dictionary_languages.name,
           dictionary_languages.description,
           dictionary_languages.lang
      FROM competitive_groups
           JOIN
           dictionary_languages ON dictionary_languages.dictionary_id = competitive_groups.dictionary_id;


-- View: contact_types_view
CREATE VIEW IF NOT EXISTS contact_types_view AS
    SELECT contact_types.id,
           dictionary_languages.name,
           dictionary_languages.description,
           dictionary_languages.lang
      FROM contact_types
           JOIN
           dictionary_languages ON dictionary_languages.dictionary_id = contact_types.dictionary_id;


-- View: dictionaries_view
CREATE VIEW IF NOT EXISTS dictionaries_view AS
    SELECT dictionaries.id,
           dictionaries.reference,
           dictionary_languages.lang,
           dictionary_languages.name,
           dictionary_languages.description
      FROM dictionaries
           JOIN
           dictionary_languages ON dictionary_languages.dictionary_id = dictionaries.id;


-- View: disciplines_view
CREATE VIEW IF NOT EXISTS disciplines_view AS
    SELECT disciplines.id,
           dictionary_languages.name,
           dictionary_languages.description,
           dictionary_languages.lang
      FROM disciplines
           JOIN
           dictionary_languages ON dictionary_languages.dictionary_id = disciplines.dictionary_id;


-- View: members_view
CREATE VIEW IF NOT EXISTS members_view AS
    SELECT members.id,
           clubs.name AS club,
           people.name,
           people.surname,
           people.ssv,
           people.birth_date,
           dictionary_languages.name AS role,
           members.group_id AS Gruppe
      FROM members
           JOIN
           people ON people.id = members.person_id
           JOIN
           clubs ON clubs.id = members.club_id
           JOIN
           person_roles ON person_roles.id = members.role_id
           JOIN
           dictionary_languages ON dictionary_languages.dictionary_id = person_roles.dictionary_id;


-- View: person_roles_view
CREATE VIEW IF NOT EXISTS person_roles_view AS
    SELECT person_roles.id,
           dictionary_languages.name,
           dictionary_languages.description,
           dictionary_languages.lang
      FROM person_roles
           JOIN
           dictionary_languages ON dictionary_languages.dictionary_id = person_roles.dictionary_id;


-- View: sections_view
CREATE VIEW IF NOT EXISTS sections_view AS
    SELECT clubs.ssv,
           clubs.name AS club,
           dictionary_languages.name AS discipline,
           categories.id AS category
      FROM sections
           JOIN
           clubs ON clubs.id = sections.club_id
           JOIN
           disciplines ON disciplines.id = sections.discipline_id
           JOIN
           dictionary_languages ON dictionary_languages.dictionary_id = disciplines.dictionary_id
           JOIN
           categories ON categories.id = sections.category_id;


-- Trigger: categories_audit_delete
CREATE TRIGGER IF NOT EXISTS categories_audit_delete
                      BEFORE DELETE
                          ON categories
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
                              'categories',
                              OLD.id,
                              'DELETE',
                              datetime('now'),
                              json_object('dictionary_id', OLD.dictionary_id),
                              NULL
                          );
END;


-- Trigger: categories_audit_update
CREATE TRIGGER IF NOT EXISTS categories_audit_update
                       AFTER UPDATE
                          ON categories
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
                              'categories',
                              OLD.id,
                              'UPDATE',
                              datetime('now'),
                              json_object('dictionary_id', OLD.dictionary_id),
                              json_object('dictionary_id', NEW.dictionary_id) 
                          );
END;


-- Trigger: club_communities_audit_delete
CREATE TRIGGER IF NOT EXISTS club_communities_audit_delete
                      BEFORE DELETE
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
                              'DELETE',
                              datetime('now'),
                              json_object('club_id', OLD.club_id),
                              NULL
                          );
END;


-- Trigger: club_communities_audit_update
CREATE TRIGGER IF NOT EXISTS club_communities_audit_update
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
CREATE TRIGGER IF NOT EXISTS clubs_audit_delete
                      BEFORE DELETE
                          ON clubs
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
                              'clubs',
                              OLD.id,
                              'DELETE',
                              datetime('now'),
                              json_object('ssv', OLD.ssv, 'name', OLD.name, 'bfs_name', OLD.bfs_name),
                              NULL
                          );
END;


-- Trigger: clubs_audit_update
CREATE TRIGGER IF NOT EXISTS clubs_audit_update
                       AFTER UPDATE
                          ON clubs
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
                              'clubs',
                              OLD.id,
                              'UPDATE',
                              datetime('now'),
                              json_object('ssv', OLD.ssv, 'name', OLD.name, 'bfs_name', OLD.bfs_name),
                              json_object('ssv', NEW.ssv, 'name', NEW.name, 'bfs_name', NEW.bfs_name) 
                          );
END;


-- Trigger: competitive_groups_audit_delete
CREATE TRIGGER IF NOT EXISTS competitive_groups_audit_delete
                      BEFORE DELETE
                          ON competitive_groups
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
                              'competitive_groups',
                              OLD.id,
                              'DELETE',
                              datetime('now'),
                              json_object('dictionary_id', OLD.dictionary_id),
                              NULL
                          );
END;


-- Trigger: competitive_groups_audit_update
CREATE TRIGGER IF NOT EXISTS competitive_groups_audit_update
                       AFTER UPDATE
                          ON competitive_groups
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
                              'competitive_groups',
                              OLD.id,
                              'UPDATE',
                              datetime('now'),
                              json_object('dictionary_id', OLD.dictionary_id),
                              json_object('dictionary_id', NEW.dictionary_id) 
                          );
END;


-- Trigger: contact_types_audit_delete
CREATE TRIGGER IF NOT EXISTS contact_types_audit_delete
                      BEFORE DELETE
                          ON contact_types
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
                              'contact_types',
                              OLD.id,
                              'DELETE',
                              datetime('now'),
                              json_object('dictionary_id', OLD.dictionary_id),
                              NULL
                          );
END;


-- Trigger: contact_types_audit_update
CREATE TRIGGER IF NOT EXISTS contact_types_audit_update
                       AFTER UPDATE
                          ON contact_types
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
                              'contact_types',
                              OLD.id,
                              'UPDATE',
                              datetime('now'),
                              json_object('dictionary_id', OLD.dictionary_id),
                              json_object('dictionary_id', NEW.dictionary_id) 
                          );
END;


-- Trigger: contacts_audit_delete
CREATE TRIGGER IF NOT EXISTS contacts_audit_delete
                      BEFORE DELETE
                          ON contacts
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
                              'contacts',
                              OLD.id,
                              'DELETE',
                              datetime('now'),
                              json_object('person_id', OLD.person_id, 'type_id', OLD.type_id, 'detail', OLD.detail),
                              NULL
                          );
END;


-- Trigger: contacts_audit_update
CREATE TRIGGER IF NOT EXISTS contacts_audit_update
                       AFTER UPDATE
                          ON contacts
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
                              'contacts',
                              OLD.id,
                              'UPDATE',
                              datetime('now'),
                              json_object('person_id', OLD.person_id, 'type_id', OLD.type_id, 'detail', OLD.detail),
                              json_object('person_id', NEW.person_id, 'type_id', NEW.type_id, 'detail', NEW.detail) 
                          );
END;


-- Trigger: disciplines_audit_delete
CREATE TRIGGER IF NOT EXISTS disciplines_audit_delete
                      BEFORE DELETE
                          ON disciplines
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
                              'disciplines',
                              OLD.id,
                              'DELETE',
                              datetime('now'),
                              json_object('dictionary_id', OLD.dictionary_id),
                              NULL
                          );
END;


-- Trigger: disciplines_audit_update
CREATE TRIGGER IF NOT EXISTS disciplines_audit_update
                       AFTER UPDATE
                          ON disciplines
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
                              'disciplines',
                              OLD.id,
                              'UPDATE',
                              datetime('now'),
                              json_object('dictionary_id', OLD.dictionary_id),
                              json_object('dictionary_id', NEW.dictionary_id) 
                          );
END;


-- Trigger: members_audit_delete
CREATE TRIGGER IF NOT EXISTS members_audit_delete
                      BEFORE DELETE
                          ON members
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
                              'members',
                              OLD.id,
                              'DELETE',
                              datetime('now'),
                              json_object('person_id', OLD.person_id, 'club_id', OLD.club_id, 'role_id', OLD.role_id, 'group_id', OLD.group_id),
                              NULL
                          );
END;


-- Trigger: members_audit_update
CREATE TRIGGER IF NOT EXISTS members_audit_update
                       AFTER UPDATE
                          ON members
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
                              'members',
                              OLD.id,
                              'UPDATE',
                              datetime('now'),
                              json_object('person_id', OLD.person_id, 'club_id', OLD.club_id, 'role_id', OLD.role_id, 'group_id', OLD.group_id),
                              json_object('person_id', NEW.person_id, 'club_id', NEW.club_id, 'role_id', NEW.role_id, 'group_id', NEW.group_id) 
                          );
END;


-- Trigger: people_audit_delete
CREATE TRIGGER IF NOT EXISTS people_audit_delete
                      BEFORE DELETE
                          ON people
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
                              'people',
                              OLD.id,
                              'DELETE',
                              datetime('now'),
                              json_object('surname', OLD.surname, 'name', OLD.name, 'ssv', OLD.ssv, 'birth_date', OLD.birth_date),
                              NULL
                          );
END;


-- Trigger: people_audit_update
CREATE TRIGGER IF NOT EXISTS people_audit_update
                       AFTER UPDATE
                          ON people
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
                              'people',
                              OLD.id,
                              'UPDATE',
                              datetime('now'),
                              json_object('surname', OLD.surname, 'name', OLD.name, 'ssv', OLD.ssv, 'birth_date', OLD.birth_date),
                              json_object('surname', NEW.surname, 'name', NEW.name, 'ssv', NEW.ssv, 'birth_date', NEW.birth_date) 
                          );
END;


-- Trigger: person_roles_audit_delete
CREATE TRIGGER IF NOT EXISTS person_roles_audit_delete
                      BEFORE DELETE
                          ON person_roles
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
                              'person_roles',
                              OLD.id,
                              'DELETE',
                              datetime('now'),
                              json_object('dictionary_id', OLD.dictionary_id),
                              NULL
                          );
END;


-- Trigger: person_roles_audit_update
CREATE TRIGGER IF NOT EXISTS person_roles_audit_update
                       AFTER UPDATE
                          ON person_roles
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
                              'person_roles',
                              OLD.id,
                              'UPDATE',
                              datetime('now'),
                              json_object('dictionary_id', OLD.dictionary_id),
                              json_object('dictionary_id', NEW.dictionary_id) 
                          );
END;


-- Trigger: sections_audit_delete
CREATE TRIGGER IF NOT EXISTS sections_audit_delete
                      BEFORE DELETE
                          ON sections
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
                              'sections',
                              OLD.id,
                              'DELETE',
                              datetime('now'),
                              json_object('club_id', OLD.club_id, 'discipline_id', OLD.discipline_id, 'category_id', OLD.category_id),
                              NULL
                          );
END;


-- Trigger: sections_audit_update
CREATE TRIGGER IF NOT EXISTS sections_audit_update
                       AFTER UPDATE
                          ON sections
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
                              'sections',
                              OLD.id,
                              'UPDATE',
                              datetime('now'),
                              json_object('club_id', OLD.club_id, 'discipline_id', OLD.discipline_id, 'category_id', OLD.category_id),
                              json_object('club_id', NEW.club_id, 'discipline_id', NEW.discipline_id, 'category_id', NEW.category_id) 
                          );
END;


-- Trigger: update_members_view
CREATE TRIGGER IF NOT EXISTS update_members_view
                  INSTEAD OF UPDATE
                          ON members_view
BEGIN
    UPDATE members
       SET group_id = NEW.Gruppe,
           role_id = NEW.Funktion
     WHERE id = (
                    SELECT id
                      FROM members
                     WHERE id = OLD.Kennung
                );
END;


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
