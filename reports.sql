WITH firstThree AS (SELECT team_id FROM Team WHERE
place_in_league < 4 AND league IN (SELECT league FROM Team WHERE team_id = 1)), --@team_id

scoresAtHome AS (SELECT SUM(home_score) as homesum,
COUNT(home_score) as homecount FROM Game WHERE home_team_id = 1 --@team_id
AND away_team_id IN firstThree),

scoresAtAway AS (SELECT SUM(away_score) as awaysum,
COUNT(away_score) as awaycount FROM Game WHERE away_team_id = 1 --@team_id
AND home_team_id IN firstThree)
SELECT (((SELECT homesum FROM scoresAtHome) + (SELECT
awaysum FROM scoresAtAway) * 1.0 / ((SELECT homecount FROM
scoresAtHome) + (SELECT awaycount FROM scoresAtAway)))) as
average_score_against_first_three