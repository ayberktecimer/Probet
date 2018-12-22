-- customer
INSERT INTO Customer VALUES (353, 'Fenerbahçe', 5321234567, 'TR12345678901234567890', 'Özgür', 'Ulusoy',
            'ozgur.ulusoy@ug.bilkent.edu.tr', 'sifre', 'ozgur.jpg', 7, 80668800);

-- message
INSERT INTO Message VALUES(NULL, "Hello John! How are you?", 1544889600, 353);
INSERT INTO Message VALUES(NULL, "Hi Ozgur. I'm fine...", 1544983200, 2);
INSERT INTO Message VALUES(NULL, "Son mesaj", 1544889600, 353);

-- team
INSERT INTO Team VALUES(3, 'Fenerbahçe', 'Süper Lig', 11, 'Turkey', '3.jpg');
INSERT INTO Team VALUES(4, 'Beşiktaş', 'Süper Lig', 9, 'Turkey', '4.jpg');
INSERT INTO Team VALUES(5, 'Manchester United', 'Premier League', 20, 'England', '5.jpg');

-- odd
INSERT INTO Odd VALUES(80, 'MS0', 4.5);
INSERT INTO Odd VALUES(80, 'MS1', 8.2);
INSERT INTO Odd VALUES(80, 'MS2', 9.1);

INSERT INTO Odd VALUES(81, 'MS0', 0.7);
INSERT INTO Odd VALUES(81, 'MS1', 3.4);
INSERT INTO Odd VALUES(81, 'MS2', 5.5);

INSERT INTO Odd VALUES(82, 'MS0', 1.2);
INSERT INTO Odd VALUES(82, 'MS1', 7.4);
INSERT INTO Odd VALUES(82, 'MS2', 10.23);

INSERT INTO Odd VALUES(83, 'MS0', 1.1);
INSERT INTO Odd VALUES(83, 'MS1', 2.2);
INSERT INTO Odd VALUES(83, 'MS2', 3.3);

-- game
INSERT INTO Game VALUES(80, 1525197600, 3, 2, 4, 1525197600, 1525204800, 4, 3);
INSERT INTO Game VALUES(81, 1534093200, 1, 1, 6, 1534093200, 1534100400, 1, 2);
INSERT INTO Game VALUES(82, 1521547200, 1, 1, 6, 1521547200, 1521554400, 4, 5);
INSERT INTO Game VALUES(83, 1546333200, NULL, NULL, 3, 1546333200, 1546344000, 1, 2);

-- bet slip
INSERT INTO BetSlip VALUES(100, 1, 250.75, 2, 1522612800, 'lose');
INSERT INTO BetSlip VALUES(101, 2, 12.5, 3, 1532804400, 'win');
INSERT INTO BetSlip VALUES(102, 353, 50.5, 4, 1519999200, 'win');
INSERT INTO BetSlip VALUES(103, 1, 20, 2, 1543665600, 'waiting');

-- includes
INSERT INTO Includes VALUES(80, 'MS1', 1, 100);
INSERT INTO Includes VALUES(82, 'MS2', 2, 101);
INSERT INTO Includes VALUES(80, 'MS0', 353, 102);
INSERT INTO Includes VALUES(83, 'MS1', 1, 103);

-- post
INSERT INTO Post VALUES(40, 1541167200, "This is a post...", 1);
INSERT INTO Post VALUES(41, 1542790800, "Another post...", 2);
INSERT INTO Post VALUES(42, 1543136400, "A post...", 353);

/*
CREATE TABLE Receives (
message_id INT NOT NULL,
customer_id INT NOT NULL,
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id),
FOREIGN KEY(message_id) REFERENCES Message(message_id),
PRIMARY KEY (message_id, customer_id));

CREATE TABLE Post_like (
post_id INT NOT NULL,
customer_id INT NOT NULL,
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id),
FOREIGN KEY(post_id) REFERENCES Post(post_id),
PRIMARY KEY (post_id, customer_id));

CREATE TABLE Flags (
post_id INT NOT NULL,
customer_id INT NOT NULL,
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id),
FOREIGN KEY(post_id) REFERENCES Post(post_id),
PRIMARY KEY (post_id, customer_id));

CREATE TABLE Comment (
post_id INT NOT NULL,
c_id INT AUTO_INCREMENT,
c_message   VARCHAR(255) NOT NULL,
date DATE NOT NULL,
customer_id INT NOT NULL,
FOREIGN KEY(post_id) REFERENCES Post(post_id),
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id),
PRIMARY KEY (post_id, c_id));

CREATE TABLE Comment_like (
customer_id INT NOT NULL,
post_id   INT NOT NULL,
c_id INT NOT NULL,
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id),
FOREIGN KEY(c_id) REFERENCES Comment(c_id),
FOREIGN KEY(post_id) REFERENCES Post(post_id),
PRIMARY KEY (customer_id, post_id, c_id));

CREATE TABLE Follows (
customer_id INT NOT NULL,
customer2_id INT NOT NULL,
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id),
FOREIGN KEY(customer2_id) REFERENCES Customer(customer_id),
PRIMARY KEY (customer_id, customer2_id));

CREATE TABLE Blocks (
customer_id INT NOT NULL,
customer2_id INT NOT NULL,
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id),
FOREIGN KEY(customer2_id) REFERENCES Customer(customer_id),
PRIMARY KEY (customer_id, customer2_id));

CREATE TABLE Wallet (
customer_id INT NOT NULL,
wallet_id INT NOT NULL,
balance DOUBLE,
payment_method VARCHAR(10),
card_number CHAR(16),
cvc CHAR(3),
expire_date DATE,
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id),
PRIMARY KEY (customer_id, wallet_id));

CREATE TABLE Editor (
editor_id INT NOT NULL,
editor_first_name VARCHAR(255) NOT NULL,
editor_last_name VARCHAR(255) NOT NULL,
PRIMARY KEY (editor_id));

CREATE TABLE Suggestion (
sug_id INT AUTO_INCREMENT,
text VARCHAR(255),
date DATE,
PRIMARY KEY (sug_id));

CREATE TABLE Suggests (
game_id INT NOT NULL,
sug_id INT NOT NULL,
editor_id INT NOT NULL,
PRIMARY KEY (game_id, sug_id, editor_id),
FOREIGN KEY(sug_id) REFERENCES Suggestion(sug_id),
FOREIGN KEY(editor_id) REFERENCES Editor(editor_id),
FOREIGN KEY(game_id) REFERENCES Game(game_id));

CREATE TABLE Statistics (
sta_id INT NOT NULL,
game_id INT NOT NULL,
editor_id INT NOT NULL,
FOREIGN KEY(game_id) REFERENCES Game(game_id),
FOREIGN KEY(editor_id) REFERENCES Editor(editor_id),
PRIMARY KEY (sta_id));

CREATE TABLE PreStat (
sta_id INT NOT NULL,
num_of_suspended_players INT,
num_of_suspended_injuries INT,
top_scorer VARCHAR(20),
shots_per_game INT,
FOREIGN KEY(sta_id) REFERENCES Statistics,
PRIMARY KEY (sta_id));

CREATE TABLE PostStat (
sta_id INT NOT NULL,
possession INT,
dribbles INT,
fouls INT,
pass_success INT,
tackles INT,
FOREIGN KEY(sta_id) REFERENCES Statistics,
PRIMARY KEY (sta_id));
*/