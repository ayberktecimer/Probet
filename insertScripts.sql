-- customer
INSERT INTO Customer VALUES (353, 'Fenerbahçe', 5321234567, 'TR12345678901234567890', 'Özgür', 'Ulusoy',
            'ozgur.ulusoy@ug.bilkent.edu.tr', 'sifre', 'ozgur.jpg', 7, 80668800);

-- message
INSERT INTO Message VALUES(NULL, "Hello John! How are you?", 1544889600, 353);
INSERT INTO Message VALUES(NULL, "Hi Ozgur. I'm fine...", 1544983200, 2);
INSERT INTO Message VALUES(NULL, "Son mesaj", 1544889600, 353);

-- team
INSERT INTO Team VALUES(3, 'Fenerbahçe', 'Süper Lig', 11, 'Türkiye', '3.jpg');
INSERT INTO Team VALUES(4, 'Beşiktaş', 'Süper Lig', 9, 'Türkiye', '4.jpg');
INSERT INTO Team VALUES(5, 'Manchester United', 'Premier League', 20, 'İngiltere', '5.jpg');

-- odd
INSERT INTO Odd VALUES(80, 'oddtype0', 4.5);
INSERT INTO Odd VALUES(81, 'oddtype1', 6.7);
INSERT INTO Odd VALUES(82, 'oddtype2', 1.2);

-- game
INSERT INTO Game VALUES(80, 1525197600, 3, 2, 4, 1525197600, 1525204800, 4, 3);
INSERT INTO Game VALUES(81, 1534093200, 1, 1, 6, 1534093200, 1534100400, 1, 2);
INSERT INTO Game VALUES(82, 1521547200, 1, 1, 6, 1521547200, 1521554400, 4, 5);