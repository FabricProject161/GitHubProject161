DELIMITER $$

CREATE PROCEDURE create_user_with_fields(
	IN user_name       VARCHAR(255),
    IN user_user       VARCHAR(150),
    IN user_email      VARCHAR(255),
    IN user_pass_hashed VARCHAR(255),
    IN usergroup       VARCHAR(255),
    IN user_code       VARCHAR(255),
    IN user_place      VARCHAR(255),
    IN user_road       VARCHAR(255),
    IN user_phone      VARCHAR(255)
)
BEGIN
    DECLARE user_param   TEXT;
    DECLARE item_id      INT;
    DECLARE usergroup_id INT;
    DECLARE field_code   INT;
    DECLARE field_place  INT;
    DECLARE field_road   INT;
    DECLARE field_phone  INT;

    DECLARE sql_state CHAR(5);
    DECLARE errno     INT;
    DECLARE errmsg    TEXT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 sql_state = RETURNED_SQLSTATE,
			errno = MYSQL_ERRNO, errmsg = MESSAGE_TEXT;
        SELECT CONCAT('SQL ERROR: ', sql_state, ' / ', errno, ' / ', errmsg) AS error;
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Copies the existing params from another user.  There is always at least one user.
    SELECT params INTO user_param
    FROM jml_users
    LIMIT 1;

    -- Creating a user with the given hashed password
    INSERT INTO jml_users (name, username, email, password, params, registerDate)
    VALUES (user_name, user_user, user_email, user_pass_hashed, user_param, NOW());

    SET item_id = LAST_INSERT_ID(); -- New user id

    -- Gets the permissions the user is assigned to.  The user group spelling must match the system language.
    SELECT id INTO usergroup_id
    FROM jml_usergroups
    WHERE title = usergroup
    LIMIT 1;

    IF usergroup_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Usergroup not found';
    END IF;

    INSERT INTO jml_user_usergroup_map (user_id, group_id)
    VALUES (item_id, usergroup_id);

	--The following updates custom user fields in the user profile.

    -- User's postal code
    SELECT id INTO field_code FROM jml_fields WHERE name = 'postcode' LIMIT 1;
    IF field_code IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Field postcode not found'; END IF;
    INSERT INTO jml_fields_values (field_id, item_id, value) VALUES (field_code, item_id, user_code);

	-- User's city
    SELECT id INTO field_place FROM jml_fields WHERE name = 'place' LIMIT 1;
    IF field_place IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Field place not found'; END IF;
    INSERT INTO jml_fields_values (field_id, item_id, value) VALUES (field_place, item_id, user_place);

	-- User's street address
    SELECT id INTO field_road FROM jml_fields WHERE name = 'street' LIMIT 1;
    IF field_road IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Field street not found'; END IF;
    INSERT INTO jml_fields_values (field_id, item_id, value) VALUES (field_road, item_id, user_road);

	-- User's phone number
    SELECT id INTO field_phone FROM jml_fields WHERE name = 'phone' LIMIT 1;
    IF field_phone IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Field phone not found'; END IF;
    INSERT INTO jml_fields_values (field_id, item_id, value) VALUES (field_phone, item_id, user_phone);

    COMMIT;

    SELECT CONCAT('User created with ID ', item_id) AS success;
END$$

DELIMITER ;
