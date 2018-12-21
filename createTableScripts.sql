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
PRIMARY KEY (customer_id)) 