-- customer
INSERT INTO Customer VALUES (353, 'Fenerbahçe', 5321234567, 'TR12345678901234567890', 'Özgür', 'Ulusoy',
            'ozgur.ulusoy@ug.bilkent.edu.tr', 'sifre', 'ozgur.jpg', 7, 80668800);

INSERT INTO Customer VALUES (10042167494, 'Arsenal', 5548964444, 'TR09876543210987654321', 'Eray', 'Şahin',
            'eray.sahin@outlook.com.tr', 'benimsifre', 'eray.jpg', 1, 873273600);

INSERT INTO Customer VALUES(12345678901, 'Atletico Madrid', 5421234567, 'TR11223344551122334455', 'İbrahim', 'Sezen',
            'ibrahim.sezen@xmail.com', 'sezen1971', 'ibrahim.jpg', 1, 41418000);

INSERT INTO Customer VALUES(11111111111, 'Galatasaray', 5548002381, 'TR11111111112222222222', 'Yakup', 'Yazar',
            'yakup_yazar_81@ymail.com', 'y1a2k3u4p5', 'yakup.jpg', 8, 360406800);


-- follows
INSERT INTO Follows VALUES(1, 353);
INSERT INTO Follows VALUES(353, 1);
INSERT INTO Follows VALUES(2, 1);


-- blocks
INSERT INTO Blocks VALUES(353, 2);


-- message
INSERT INTO Message (message_text, date, customer_id) VALUES("Hello John! How are you?", 1544889600, 353);
INSERT INTO Message (message_text, date, customer_id) VALUES("Hi Ozgur. I'm fine...", 1544983200, 2);
INSERT INTO Message (message_text, date, customer_id) VALUES("Son mesaj", 1544889600, 353);


-- receives
INSERT INTO Receives VALUES(1, 2);
INSERT INTO Receives VALUES(2, 353);
INSERT INTO Receives VALUES(3, 2);


-- team
INSERT INTO Team (name, league, place_in_league, country, team_pic)
            VALUES('Gençlerbirliği', 'TFF 1.Lig', 1, 'Turkey', '1.jpg');

INSERT INTO Team (name, league, place_in_league, country, team_pic)
            VALUES('Denizlispor', 'TFF 1.Lig', 2, 'Turkey', '2.jpg');

INSERT INTO Team (name, league, place_in_league, country, team_pic)
            VALUES('Fenerbahçe', 'Süper Lig', 11, 'Turkey', '3.jpg');

INSERT INTO Team (name, league, place_in_league, country, team_pic)
            VALUES('Beşiktaş', 'Süper Lig', 9, 'Turkey', '4.jpg');

INSERT INTO Team (name, league, place_in_league, country, team_pic)
            VALUES('Manchester United', 'Premier League', 20, 'England', '5.jpg');

INSERT INTO Team (name, league, place_in_league, country, team_pic)
            VALUES('Anadolu Efes', 'Tahincioğlu Basketbol Süper Lig', 3, 'Turkey', '6.jpg');

INSERT INTO Team (name, league, place_in_league, country, team_pic)
            VALUES('Türk Telekom', 'Tahincioğlu Basketbol Süper Lig', 4, 'Turkey', '7.jpg');

INSERT INTO Team (name, league, place_in_league, country, team_pic)
            VALUES('Tofaş', 'Tahincioğlu Basketbol Süper Lig', 2, 'Turkey', '8.jpg');


-- game

-- (football games)
INSERT INTO Game (date, home_score, away_score, min_bet_number, start_time, end_time, home_team_id, away_team_id)
            VALUES(1525197600, 3, 2, 4, 1525197600, 1525204800, 4, 3);

INSERT INTO Game (date, home_score, away_score, min_bet_number, start_time, end_time, home_team_id, away_team_id)
            VALUES(1534093200, 1, 1, 6, 1534093200, 1534100400, 1, 2);

INSERT INTO Game (date, home_score, away_score, min_bet_number, start_time, end_time, home_team_id, away_team_id)
            VALUES(1521547200, 1, 1, 6, 1521547200, 1521554400, 4, 5);

INSERT INTO Game (date, home_score, away_score, min_bet_number, start_time, end_time, home_team_id, away_team_id)
            VALUES(1546333200, NULL, NULL, 3, 1546333200, 1546344000, 1, 2);

-- (basketball games)
INSERT INTO Game (date, home_score, away_score, min_bet_number, start_time, end_time, home_team_id, away_team_id)
            VALUES(1545555600, 81, 93, 5, 1545571800, 1545579000, 8, 6);

INSERT INTO Game (date, home_score, away_score, min_bet_number, start_time, end_time, home_team_id, away_team_id)
            VALUES(1546419600, NULL, NULL, 2, 1546443000, 1546450200, 7, 6);


-- odd
INSERT INTO Odd VALUES(1, 'MS0', 1.4);
INSERT INTO Odd VALUES(1, 'MS1', 2.1);
INSERT INTO Odd VALUES(1, 'MS2', 3.6);

INSERT INTO Odd VALUES(2, 'MS0', 2.5);
INSERT INTO Odd VALUES(2, 'MS1', 2.1);
INSERT INTO Odd VALUES(2, 'MS2', 2.0);

INSERT INTO Odd VALUES(3, 'MS0', 1.2);
INSERT INTO Odd VALUES(3, 'MS1', 2.4);
INSERT INTO Odd VALUES(3, 'MS2', 3.7);

INSERT INTO Odd VALUES(4, 'MS0', 2.7);
INSERT INTO Odd VALUES(4, 'MS1', 2.3);
INSERT INTO Odd VALUES(4, 'MS2', 2.0);

INSERT INTO Odd VALUES(4, 'MS0', 2.7);
INSERT INTO Odd VALUES(4, 'MS1', 2.3);
INSERT INTO Odd VALUES(4, 'MS2', 2.0);

INSERT INTO Odd VALUES(5, 'MS1', 1.7);
INSERT INTO Odd VALUES(5, 'MS2', 1.7);

INSERT INTO Odd VALUES(6, 'MS1', 1.7);
INSERT INTO Odd VALUES(6, 'MS2', 1.7);


-- editor
INSERT INTO Editor VALUES(12345678901);
INSERT INTO Editor VALUES(11111111111);


-- suggestion
INSERT INTO Suggestion (text, date) VALUES("Banko maç... Gençlerbirliği alır.", 1544864400);


-- suggests
INSERT INTO Suggests VALUES(4, 1, 12345678901);


-- statistics
INSERT INTO Statistics (game_id, editor_id) VALUES(5, 12345678901);
INSERT INTO Statistics (game_id, editor_id) VALUES(1, 11111111111);


-- pre statistics
INSERT INTO PreStat VALUES(1, 3, 1, 'Shane D.Larkin', 16);


-- post statistics
INSERT INTO PostStat VALUES(2, 61, 40, 3, 47, 32);


-- post
INSERT INTO Post (date, pmessage, customer_id, bet_slip_id ) VALUES(1541167200, "This is a post...", 1, 1);
INSERT INTO Post (date, pmessage, customer_id, bet_slip_id ) VALUES(1542790800, "Another post...", 2, 2);
INSERT INTO Post (date, pmessage, customer_id, bet_slip_id ) VALUES(1543136400, "A post...", 353, 3);


-- post like
INSERT INTO Post_like VALUES(1, 353);
INSERT INTO Post_like VALUES(1, 2);
INSERT INTO Post_like VALUES(2, 353);


-- flags
INSERT INTO Flags VALUES(3, 2);


-- wallet *
INSERT INTO Wallet (customer_id, balance, payment_method, card_number, cvc, expire_date)
            VALUES(1, 550.3, 'credit', '1111222233334444', '123', 1669896000);

INSERT INTO Wallet (customer_id, balance, payment_method, card_number, cvc, expire_date)
            VALUES(2, 2000, 'credit', '9999888877776666', '987', 1641038400);

INSERT INTO Wallet (customer_id, balance, payment_method, card_number, cvc, expire_date)
            VALUES(353, 180, 'credit', '6666555544443333', '654', 1648814400);


-- comment
INSERT INTO Comment (post_id, c_message, date, customer_id) VALUES(1, "This is a comment", 1541188800, 353);
INSERT INTO Comment (post_id, c_message, date, customer_id) VALUES(2, "Another comment", 1542791700, 353);
INSERT INTO Comment (post_id, c_message, date, customer_id) VALUES(3, "A comment", 1543150860, 1);


-- comment like
INSERT INTO Comment_like VALUES(1, 1, 1);
INSERT INTO Comment_like VALUES(6, 1, 1);


-- bet slip
INSERT INTO BetSlip (customer_id, bet_amount, num_of_games, date_created, status)
            VALUES(1, 250.75, 2, 1522612800, 'lose');

INSERT INTO BetSlip (customer_id, bet_amount, num_of_games, date_created, status)
            VALUES(2, 12.5, 3, 1532804400, 'win');

INSERT INTO BetSlip (customer_id, bet_amount, num_of_games, date_created, status)
            VALUES(353, 50.5, 4, 1519999200, 'win');

INSERT INTO BetSlip (customer_id, bet_amount, num_of_games, date_created, status)
            VALUES(1, 20, 2, 1543665600, 'waiting');

INSERT INTO BetSlip (customer_id, bet_amount, num_of_games, date_created, status)
            VALUES(10042167494, 12, 1, 1522612800, 'lose');


-- includes
INSERT INTO Includes VALUES(80, 'MS1', 1, 100);
INSERT INTO Includes VALUES(82, 'MS2', 2, 101);
INSERT INTO Includes VALUES(80, 'MS0', 353, 102);
INSERT INTO Includes VALUES(83, 'MS1', 1, 103);
INSERT INTO Includes VALUES(80, 'MS1', 10042167494, 104);