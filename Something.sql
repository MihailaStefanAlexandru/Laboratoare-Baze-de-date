-- CREATE TABLES

SELECT table_name
FROM user_tables;

CREATE TABLE Users (
	user_id Number(2) PRIMARY KEY,
	username VARCHAR2(50),
	password VARCHAR2(20)
);

CREATE TABLE Articles (
	article_id Number(2) PRIMARY KEY,
	title VARCHAR2(20),
	content VARCHAR2(30),
	userid Number(2),
	CONSTRAINT FK_USERI_ARTICOLE
	FOREIGN KEY(userid)
	REFERENCES Users(user_id)
);

-- Table pentru cheie primara compusa
CREATE TABLE Link (
	id_recipe Number(2),
	id_ingredient Number(2),
	quantity Number(3),
	mu VARCHAR2(40),
	CONSTRAINT PK_Link PRIMARY KEY (id_recipe, id_ingredient)
);

INSERT INTO Link values(1, 10, 100, 'nu stiu ce trebuie scris');
INSERT INTO Link values(2, 9, 125, 'stiu ce trebuie scris');

-- Selectare cheie primara (simpla sau compusa) dintr-o tabela
SELECT column_name
FROM user_cons_columns
WHERE constraint_name = (
    SELECT constraint_name 
    FROM user_constraints 
    WHERE table_name = 'LINK' 
    AND constraint_type = 'P'
);

SELECT column_name
FROM user_cons_columns
WHERE constraint_name = (
	SELECT constraint_name
	FROM user_constraints
	WHERE table_name = 'USERS'
	AND constraint_type = 'P'
);

-- Introducere date in tabelele Users si Articles

INSERT INTO Users values(2, 'pycharm', 'python');
INSERT INTO Users (user_id, username, password)
	values(1, 'admin', 'admin');
INSERT INTO Users (user_id, username)
	values(3, 'hacker');
INSERT INTO Users values(4, 'matlab', 'nuemisto');
INSERT INTO Users values(5, 'pycharm', 'copilot');

INSERT INTO Articles values(1, 'Mona Musca', 'Lucratura PSD-ista', 3);
INSERT INTO Articles (article_id, title, userid)
	values(2, 'Basescu', 4);

SELECT username, password
FROM Users
Where
	username = &user
ORDER BY password ASC;

SELECT article_id, title, username
FROM Users, Articles
WHERE 
	Users.user_id = Articles.userid
ORDER BY Articles.title DESC;

SELECT user_id, username, password
FROM Users
WHERE username<>'hacker'
ORDER BY user_id ASC, password DESC;

SELECT user_id, username, password
FROM Users
WHERE username NOT LIKE 'hacker'
ORDER BY user_id ASC, password DESC;

SELECT user_id, username, password
FROM Users
WHERE username != 'hacker'
ORDER BY user_id ASC, password DESC;

-- DROP TABLES
DROP TABLE Articles;
DROP TABLE Users;
DROP TABLE Link;