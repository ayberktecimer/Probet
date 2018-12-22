-- customer
INSERT INTO Customer VALUES (353, 'Fenerbahçe', 5321234567, 'TR12345678901234567890', 'Özgür', 'Ulusoy',
            'ozgur.ulusoy@ug.bilkent.edu.tr', 'sifre', 'ozgur.jpg', 7, 80668800);

-- message
INSERT INTO Message VALUES(300, "Hello John! How are you?", 1544889600, 353);
INSERT INTO Message VALUES(301, "Hi Ozgur. I'm fine...", 1544983200, 2);
INSERT INTO Message VALUES(302, "Son mesaj", 1544889600, 353);

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

-- follows
INSERT INTO Follows VALUES(1, 353);
INSERT INTO Follows VALUES(353, 1);
INSERT INTO Follows VALUES(2, 1);

-- blocks
INSERT INTO Blocks VALUES(353, 2);

-- post like
INSERT INTO Post_like VALUES(40, 353);
INSERT INTO Post_like VALUES(40, 2);
INSERT INTO Post_like VALUES(41, 353);

-- flags
INSERT INTO Flags VALUES(42, 2);

-- wallet
INSERT INTO Wallet VALUES(1, 21, 550.3, 'credit', '1111222233334444', '123', 1669896000);
INSERT INTO Wallet VALUES(2, 22, 2000, 'credit', '9999888877776666', '987', 1641038400);
INSERT INTO Wallet VALUES(353, 23, 180, 'credit', '6666555544443333', '654', 1648814400);

-- receives
INSERT INTO Receives VALUES(300, 2);
INSERT INTO Receives VALUES(301, 353);
INSERT INTO Receives VALUES(302, 2);

CREATE TABLE Comment (
post_id INT NOT NULL,
c_id INT NOT NULL,
c_message   VARCHAR(255) NOT NULL,
date DATE NOT NULL,
customer_id INT NOT NULL,
FOREIGN KEY(post_id) REFERENCES Post(post_id),
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id),
PRIMARY KEY (post_id, c_id));

-- comment
INSERT INTO Comment VALUES(40, 700, "This is a comment", 1541188800, 353);
INSERT INTO Comment VALUES(41, 701, "Another comment", 1542791700, 353);
INSERT INTO Comment VALUES(42, 702, "A comment", 1543150860, 1);

-- comment like
INSERT INTO Comment_like VALUES(1, 40, 700);

-- suggestion
INSERT INTO Suggestion VALUES(800, "Banko maç... Gençlerbirliği alır.", 1544864400);

-- editor
INSERT INTO Editor VALUES(90, 'Erman', 'Şafak');
INSERT INTO Editor VALUES(91, 'Rıdvan', 'Yılmaz');
INSERT INTO Editor VALUES(92, 'İbrahim', 'Sezen');

-- suggests
INSERT INTO Suggests VALUES(83, 800, 90);

-- statistics
INSERT INTO Statistics VALUES(400, 83, 92);
INSERT INTO Statistics VALUES(401, 80, 91);

-- pre statistics
INSERT INTO PreStat VALUES(400, 5, 3, 'Mert Nobre', 4);

-- post statistics
INSERT INTO PostStat VALUES(401, 63, 40, 3, 65, 7);