-- first report
-- Return the average of scores played against teams which are in the
-- first three places of the league.
/*
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
*/

-- second report
-- The league names which never appeared in a bet slip that is played
-- by the customer and the customers that are followed by that
-- customer.

WITH customerAndFriends AS (SELECT customer2_id AS customer_id FROM Follows
WHERE customer_id = @customer_id                                                         --@customer_id
UNION
SELECT customer_id FROM Customer WHERE customer_id = @customer_id),

playedLeagues AS (SELECT DISTINCT H.league FROM (customerAndFriends NATURAL JOIN Includes NATURAL JOIN
Game INNER JOIN Team H ON H.team_id = game.home_team_id
INNER JOIN Team A ON A.team_id = Game.away_team_id))

SELECT DISTINCT league FROM Team WHERE league NOT IN playedLeagues