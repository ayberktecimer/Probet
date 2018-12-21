CREATE TABLE Customer ( 
customer_id INT NOT NULL, 
fav_team VARCHAR(255), 
phone_number  NUMERIC(11,0), 
iban CHAR(26), 
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL, 
email VARCHAR(255) NOT NULL, 
password  VARCHAR(255) NOT NULL, 
profile_pic VARCHAR(255), 
rank INT DEFAULT 0, 
birth_date DATE, 
PRIMARY KEY (customer_id));

CREATE TABLE Message ( 
message_id INT AUTO_INCREMENT,
message_text VARCHAR(255) NOT NULL, 
date  DATE,
customer_id INT NOT NULL, 
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id), 
PRIMARY KEY (message_id));

CREATE TABLE Receives ( 
message_id INT NOT NULL, 
customer_id INT NOT NULL, 
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id),
FOREIGN KEY(message_id) REFERENCES Message(message_id), 
PRIMARY KEY (message_id, customer_id));

CREATE TABLE Post ( 
post_id INT NOT NULL, 
date  DATE NOT NULL, 
pmessage VARCHAR(255), 
customer_id INT NOT NULL, 
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id), 
PRIMARY KEY (post_id));

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

CREATE TABLE BetSlip ( 
bet_slip_id INT NOT NULL, 
customer_id INT NOT NULL, 
bet_amount DOUBLE NOT NULL, 
num_of_games  INT NOT NULL,
date_created DATE NOT NULL, 
status VARCHAR(10) NOT NULL, 
PRIMARY KEY (bet_slip_id, customer_id), 
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id));

CREATE TABLE Game ( 
game_id  INT NOT NULL, 
date DATE,
home_score INT, 
away_score INT, 
min_bet_number INT, 
start_time DATE, 
end_time DATE, 
home_team_id INT NOT NULL, 
away_team_id INT NOT NULL, 
PRIMARY KEY (game_id), 
FOREIGN KEY(home_team_id) REFERENCES Team(team_id), 
FOREIGN KEY(away_team_id) REFERENCES Team(team_id));

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

CREATE TABLE Odd ( 
game_id INT NOT NULL, 
odd_type VARCHAR(10), 
odd_amount DOUBLE, 
PRIMARY KEY (game_id, odd_type), 
FOREIGN KEY(game_id) REFERENCES Game(game_id));

CREATE TABLE Includes ( 
game_id INT NOT NULL, 
odd_type VARCHAR(10), 
customer_id INT NOT NULL, 
bet_slip_id INT NOT NULL, 
PRIMARY KEY (game_id, odd_type, customer_id, bet_slip_id), 
FOREIGN KEY(game_id, odd_type) REFERENCES Odd, 
FOREIGN KEY(customer_id, bet_slip_id) REFERENCES BetSlip);

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

CREATE TABLE Team ( 
team_id INT NOT NULL, 
name VARCHAR(20) NOT NULL, 
league VARCHAR(20), 
place_in_league INT, 
country VARCHAR(20), 
PRIMARY KEY (team_id));