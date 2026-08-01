CREATE VIEW stau_special_users AS
SELECT map.user_id
FROM stau_user_usergroup_map AS map 
	JOIN stau_usergroups AS usergroup ON usergroup.id = map.group_id
   JOIN stau_viewlevels AS levels ON FIND_IN_SET(usergroup.id,
  		REPLACE(REPLACE(REPLACE(levels.rules, '[', ''), ']', ''), ' ', '')) > 0
WHERE levels.title = 'Special'