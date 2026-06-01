DELETE FROM dictionaries WHERE id = (SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1);

INSERT INTO dictionaries DEFAULT VALUES;
UPDATE dictionaries SET parent_id = last_insert_rowid() WHERE id = last_insert_rowid();
UPDATE dictionary_parameters SET person_role_id = last_insert_rowid();

INSERT INTO dictionary_translations (dictionary_id, lang, name, description)
SELECT person_role_id, 'en', 'Club roles', 'Responsibilities and functions assigned to members who help manage and operate the shooting club.' FROM dictionary_parameters WHERE expired IS NULL UNION ALL
SELECT person_role_id, 'de', 'Vereinsfunktionen', 'Aufgaben und Zuständigkeiten, die Vereinsmitgliedern zur Führung und Organisation des Schützenvereins übertragen werden.' FROM dictionary_parameters WHERE expired IS NULL UNION ALL
SELECT person_role_id, 'fr', 'Fonctions au sein du club', 'Responsabilités et tâches confiées aux membres pour la gestion et le fonctionnement de la société de tir.' FROM dictionary_parameters WHERE expired IS NULL UNION ALL
SELECT person_role_id, 'it', 'Funzioni del club', 'Responsabilità e compiti assegnati ai membri per la gestione e il buon funzionamento della società di tiro.' FROM dictionary_parameters WHERE expired IS NULL;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'Member', 'A natural person who has joined the club, is listed in the membership register, and may participate in activities, events, and decision-making processes'),
((SELECT id FROM temp_dictionaries), 'de', 'Mitglied', 'Eine natürliche Person, die dem Verein beigetreten ist, im Mitgliederverzeichnis geführt wird und an Aktivitäten, Veranstaltungen und Entscheidungsprozessen des Vereins teilnehmen darf'),
((SELECT id FROM temp_dictionaries), 'fr', 'Membre', 'Une personne physique ayant adhéré au club, inscrite au registre des membres et autorisée à participer aux activités, événements et processus décisionnels'),
((SELECT id FROM temp_dictionaries), 'it', 'Membro', 'Una persona fisica che ha aderito al club, iscritta nel registro dei membri e autorizzata a partecipare ad attività, eventi e processi decisionali');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'President', 'Overall responsibility for the club'),
((SELECT id FROM temp_dictionaries), 'de', 'Präsidium', 'Gesamtverantwortung für den Verein'),
((SELECT id FROM temp_dictionaries), 'fr', 'Président', 'Responsabilité générale du club'),
((SELECT id FROM temp_dictionaries), 'it', 'Presidente', 'Responsabilità generale del club');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'Vice President', 'Deputy to the president'),
((SELECT id FROM temp_dictionaries), 'de', 'Vizepräsidium', 'Stellvertretung des Präsidenten'),
((SELECT id FROM temp_dictionaries), 'fr', 'Vice-président', 'Adjoint du président'),
((SELECT id FROM temp_dictionaries), 'it', 'Vicepresidente', 'Vice del presidente');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'Finance', 'Finances, accounting, budgeting, membership fees, settlements with associations and authorities'),
((SELECT id FROM temp_dictionaries), 'de', 'Finanzen', 'Finanzen, Buchhaltung, Budget, Mitgliederbeiträge, Abrechnung mit Verbänden und Behörden'),
((SELECT id FROM temp_dictionaries), 'fr', 'Finances', 'Finances, comptabilité, budget, cotisations des membres, décomptes avec les associations et les autorités'),
((SELECT id FROM temp_dictionaries), 'it', 'Finanze', 'Finanze, contabilità, budget, quote dei membri, rendicontazioni con associazioni e autorità');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'Secretary', 'Minutes, correspondence, administration, club register, invitations, general meeting documents'),
((SELECT id FROM temp_dictionaries), 'de', 'Aktuariat', 'Protokolle, Korrespondenz, Administration, Vereinsregister, Einladungen, GV-Unterlagen'),
((SELECT id FROM temp_dictionaries), 'fr', 'Secrétaire', 'Procès-verbaux, correspondance, administration, registre du club, invitations, documents pour l’assemblée générale'),
((SELECT id FROM temp_dictionaries), 'it', 'Segreteria', 'Verbali, corrispondenza, amministrazione, registro del club, inviti, documenti per l’assemblea generale');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'Range Officer', 'Responsible for shooting operations, safety supervision, organization of training and events, and maintenance of the shooting range'),
((SELECT id FROM temp_dictionaries), 'de', 'Schützenmeisteramt', 'Verantwortlich für den Schiessbetrieb, Sicherheitsaufsicht, Organisation von Trainings und Schiessanlässen, Betreuung der Schiessanlage'),
((SELECT id FROM temp_dictionaries), 'fr', 'Responsable du tir', 'Responsable du tir, supervision de la sécurité, organisation des entraînements et des manifestations, gestion du stand de tir'),
((SELECT id FROM temp_dictionaries), 'it', 'Responsabile del tiro', 'Responsabile del tiro, supervisione della sicurezza, organizzazione degli allenamenti e delle manifestazioni, gestione del poligono di tiro');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'Youth Coach', 'Training of young shooters, courses, training sessions, competitions, cooperation with SSV / KSV'),
((SELECT id FROM temp_dictionaries), 'de', 'Jungschützenleitung', 'Ausbildung der Jungschützen, Kurse, Trainings, Wettkämpfe, Zusammenarbeit mit SSV / KSV'),
((SELECT id FROM temp_dictionaries), 'fr', 'Responsable jeunes tireurs', 'Formation des jeunes tireurs, cours, entraînements, compétitions, collaboration avec la FST / AST'),
((SELECT id FROM temp_dictionaries), 'it', 'Responsabile giovani tiratori', 'Formazione dei giovani tiratori, corsi, allenamenti, competizioni, collaborazione con FST / AST');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'Equipment Manager', 'Weapons, targets, ammunition, equipment, maintenance and inventory'),
((SELECT id FROM temp_dictionaries), 'de', 'Materialverwaltung', 'Waffen, Scheiben, Munition, Ausrüstung, Unterhalt und Inventar'),
((SELECT id FROM temp_dictionaries), 'fr', 'Responsable matériel', 'Armes, cibles, munitions, équipement, entretien et inventaire'),
((SELECT id FROM temp_dictionaries), 'it', 'Responsabile materiale', 'Armi, bersagli, munizioni, attrezzatura, manutenzione e inventario');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'Range Operations', 'Operation and maintenance of the shooting range, opening hours, supervision, technical systems'),
((SELECT id FROM temp_dictionaries), 'de', 'Standbetrieb', 'Betrieb und Unterhalt der Schiessanlage, Öffnungszeiten, Aufsicht, Technik'),
((SELECT id FROM temp_dictionaries), 'fr', 'Exploitation du stand', 'Exploitation et entretien du stand de tir, horaires d’ouverture, surveillance, systèmes techniques'),
((SELECT id FROM temp_dictionaries), 'it', 'Gestione del poligono', 'Gestione e manutenzione del poligono di tiro, orari di apertura, sorveglianza, sistemi tecnici');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'Catering & Events', 'Organization of catering, events, and volunteer assignments'),
((SELECT id FROM temp_dictionaries), 'de', 'Festwirtschaftsleitung', 'Organisation von Festwirtschaft, Events, Helfereinsätzen'),
((SELECT id FROM temp_dictionaries), 'fr', 'Restauration & événements', 'Organisation de la restauration, des événements et des engagements des bénévoles'),
((SELECT id FROM temp_dictionaries), 'it', 'Ristorazione & eventi', 'Organizzazione della ristorazione, degli eventi e degli incarichi dei volontari');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'Media & Communications', 'Reports, media relations, social media'),
((SELECT id FROM temp_dictionaries), 'de', 'Medien', 'Berichte, Medien, Social Media'),
((SELECT id FROM temp_dictionaries), 'fr', 'Médias & communication', 'Rapports, relations avec les médias, réseaux sociaux'),
((SELECT id FROM temp_dictionaries), 'it', 'Media & comunicazione', 'Rapporti, relazioni con i media, social media');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'IT & Systems', 'Website, results, communication systems'),
((SELECT id FROM temp_dictionaries), 'de', 'Systemverantwortung', 'Website, Resultate, Kommunikation'),
((SELECT id FROM temp_dictionaries), 'fr', 'Informatique & systèmes', 'Site web, résultats, systèmes de communication'),
((SELECT id FROM temp_dictionaries), 'it', 'IT & sistemi', 'Sito web, risultati, sistemi di comunicazione');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'Board Member', 'Supports projects and represents sections or groups'),
((SELECT id FROM temp_dictionaries), 'de', 'Beisitz', 'Unterstützen Projekte, Vertreten Sektionen oder Gruppen'),
((SELECT id FROM temp_dictionaries), 'fr', 'Membre du comité', 'Soutient les projets et représente des sections ou des groupes'),
((SELECT id FROM temp_dictionaries), 'it', 'Membro del comitato', 'Supporta i progetti e rappresenta sezioni o gruppi');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'Ammunition Manager', 'Ordering, storage, and distribution of ammunition'),
((SELECT id FROM temp_dictionaries), 'de', 'Munitionsverwaltung', 'Bestellung, Lagerung, Abgabe'),
((SELECT id FROM temp_dictionaries), 'fr', 'Responsable munitions', 'Commande, stockage et distribution des munitions'),
((SELECT id FROM temp_dictionaries), 'it', 'Responsabile munizioni', 'Ordine, stoccaggio e distribuzione delle munizioni');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'Safety Officer', 'Safety concepts, supervision training, enforcement of safety regulations'),
((SELECT id FROM temp_dictionaries), 'de', 'Sicherheitsverantwortung', 'Sicherheitskonzepte, Aufsichtsschulung, Kontrolle der Sicherheitsvorschriften'),
((SELECT id FROM temp_dictionaries), 'fr', 'Responsable sécurité', 'Concepts de sécurité, formation des surveillants, contrôle des règles de sécurité'),
((SELECT id FROM temp_dictionaries), 'it', 'Responsabile sicurezza', 'Concetti di sicurezza, formazione della sorveglianza, controllo delle norme di sicurezza');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'Auditor', 'Financial oversight and audit of the annual accounts'),
((SELECT id FROM temp_dictionaries), 'de', 'Revisionsstelle', 'Finanzkontrolle, Prüfung der Jahresrechnung'),
((SELECT id FROM temp_dictionaries), 'fr', 'Organe de révision', 'Contrôle financier et vérification des comptes annuels'),
((SELECT id FROM temp_dictionaries), 'it', 'Revisore', 'Controllo finanziario e revisione del bilancio annuale');
DROP TABLE temp_dictionaries;

CREATE TEMP TABLE temp_dictionaries (id INTEGER);
INSERT INTO dictionaries (parent_id) SELECT person_role_id FROM dictionary_parameters WHERE expired IS NULL LIMIT 1;
INSERT INTO temp_dictionaries VALUES (last_insert_rowid());
INSERT INTO dictionary_translations (dictionary_id, lang, name, description) VALUES
((SELECT id FROM temp_dictionaries), 'en', 'Association Delegate', 'Represents the club at KSV/SSV assemblies'),
((SELECT id FROM temp_dictionaries), 'de', 'Verbandsvertretung', 'Vertretung des Vereins an KSV/SSV-Versammlungen'),
((SELECT id FROM temp_dictionaries), 'fr', 'Délégué de l’association', 'Représente le club aux assemblées du KSV/SSV'),
((SELECT id FROM temp_dictionaries), 'it', 'Delegato dell’associazione', 'Rappresenta il club alle assemblee KSV/SSV');
DROP TABLE temp_dictionaries;