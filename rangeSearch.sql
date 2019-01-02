-- given the lower and upper bounds, returns the names and pictures of the customers having
-- a rank between those limits

SELECT first_name, last_name, profile_pic, customer_id
FROM Customer
WHERE rank >= 1
  AND rank <= 6 -- replace values with @lower_bound, @upper_bound
ORDER BY rank;

------------------------------------------------------------------------------------------

-- returns the teams, IDs and dates of the games played between two particular dates

SELECT H.name, A.name, game_id, date
FROM Game INNER JOIN Team H ON H.team_id = game.home_team_id
INNER JOIN Team A ON A.team_id = Game.away_team_id
WHERE date >= 1521547200
  AND date <= 1525197600 --replace with @start_date, @end_date
ORDER BY date;

------------------------------------------------------------------------------------------

-- flexible search for finding customers

SELECT first_name, last_name, customer_id
FROM Customer
WHERE first_name LIKE 'e%'                --replace 'e' with @first_char
OR last_name LIKE 'e%'                    --replace 'e' with @first_char
OR first_name LIKE '%ith%'                --replace 'ith' with @userInput
OR last_name LIKE '%ith%'                 --replace 'ith' with @userInput
OR first_name LIKE '%r'                   --replace 'r' with @last_char
OR last_name LIKE '%r';                   --replace 'r' with @last_char