SELECT routines.id AS routine_id,
SUM(groups.times * intervals.duration * routines.times) AS total
FROM routines
JOIN groups ON routines.id = groups.routine_id
JOIN intervals ON groups.id = intervals.group_id
GROUP BY routines.id, routines.name;
