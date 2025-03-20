CREATE TABLE BIBLIOTECI (
	COD_BIB NUMBER(2) PRIMARY KEY,
	DENUMIRE VARCHAR2(20),
	LOCALITATE VARCHAR2(20),
	DIRECTOR VARCHAR2(20)
);

ALTER TABLE BIBLIOTECI
ADD 
	NR_ANG NUMBER(3);

CREATE TABLE CARTI (
	COD_CARTE NUMBER(3),
	COD_BIB NUMBER(2),
	TITLU VARCHAR2(20),
	AUTOR VARCHAR2(20),
	NR_PAG NUMBER(4),
	CONSTRAINT PK_CARTI
	PRIMARY KEY(COD_CARTE, COD_BIB),
	CONSTRAINT FK_CARTI_BIBLIOTECI
	FOREIGN KEY(COD_BIB)
	REFERENCES BIBLIOTECI(COD_BIB)
);

INSERT INTO BIBLIOTECI values(1, 'Mihailesti', 'Iasi', 'Daniel', 41);
INSERT INTO BIBLIOTECI values(2, 'Constantinescu', 'Bucuresti', 'Rares', 31);
INSERT INTO BIBLIOTECI values(3, 'Popesti', 'Timisoara', 'Klaus', 20);

INSERT INTO CARTI values(10, 1, 'Moara cu Noroc', 'Ioan Slavici', 256);
INSERT INTO CARTI values(31, 1, 'Ciresari', 'Ion Creanga', 314);
INSERT INTO CARTI values(25, 1, 'Dumbrava Minunata', 'Mihail Sadoveanu', 513);

INSERT INTO CARTI values(12, 2, 'Moara', 'Mihaila Stefan', 256);
INSERT INTO CARTI values(29, 2, 'Ciresari', 'Ion Creanga', 314);
INSERT INTO CARTI values(17, 2, 'Dumbrava Minunata', 'Mihail Sadoveanu', 513);

INSERT INTO CARTI values(8, 3, 'Baltagul', 'Mihail Sadoveanu', 346);
INSERT INTO CARTI values(23, 3, 'Tata bogat', 'Robert Kiosaki', 210);
INSERT INTO CARTI values(5, 3, 'Enigma Otiliei', 'George Calinescu', 498);

-- DESC BIBLIOTECI
-- DESC CARTI

-- Sa se adauge o coloana la tabela carti intitulata note, VARCHAR2(10)

ALTER TABLE BIBLIOTECI
ADD 
	NOTE VARCHAR2(10);

SELECT *
FROM BIBLIOTECI;

SELECT *
FROM CARTI;

-- Sa se selecteze toate cartile care indeplinesc in acelasi timp urm cond:
-- Nr de pagini sa fie mai mare decat o val substituita
-- Codul de carte sa fie diferit de o val substituita
-- Autorul sa fie cel indicat de o valoare stabilita de o val substituita
-- Se va afisa codul_cartii, titlu, autor si numar pagini
-- Trebuie rezolvata prin 3 metode de var substituite


-- 50 11 Ioan Slavici
SELECT COD_CARTE, TITLU, AUTOR, NR_PAG
FROM CARTI
WHERE
	NR_PAG > &1
	AND 
	COD_CARTE != &2
	AND
	AUTOR = '&3';

DEFINE NR = 30;
DEFINE COD_CARTE = 11;
DEFINE AUTOR = 'Ioan Slavici';

SELECT COD_CARTE, TITLU, AUTOR, NR_PAG
FROM CARTI
WHERE
	NR_PAG > &NR
	AND 
	COD_CARTE != &COD_CARTE
	AND
	AUTOR = '&AUTOR';

UNDEFINE NR;
UNDEFINE COD_CARTE;
UNDEFINE AUTOR;

SELECT COD_CARTE, TITLU, AUTOR, NR_PAG
FROM CARTI
WHERE
	NR_PAG > &NR10
	AND 
	COD_CARTE != &COD_CARTE1
	AND
	AUTOR = '&AUTOR1';

DROP TABLE CARTI;
DROP TABLE BIBLIOTECI;