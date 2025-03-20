-- Creare Tabele

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

INSERT INTO CARTI values(12, 2, 'Moara cu Noroc', 'Ioan Slavici', 256);
INSERT INTO CARTI values(29, 2, 'Ciresari', 'Ion Creanga', 314);
INSERT INTO CARTI values(17, 2, 'Dumbrava Minunata', 'Mihail Sadoveanu', 513);

INSERT INTO CARTI values(8, 3, 'Baltagul', 'Mihail Sadoveanu', 346);
INSERT INTO CARTI values(23, 3, 'Tata bogat', 'Robert Kiosaki', 210);
INSERT INTO CARTI values(5, 3, 'Enigma Otiliei', 'George Calinescu', 498);

ACCEPT NR1 NUMBER PROMPT 'Introduceti numarul de angajati:'
ACCEPT NR2 NUMBER PROMPT 'Introduceti numarul de pagini:'
ACCEPT LOC1 VARCHAR2PROMPT 'Introduceti localitatea:'

SELECT * FROM BIBLIOTECI
WHERE
	NR_ANG < &NR1;

--SELECT * FORM BIBLIOTECI

DEFINE LOC = 'BACAU';

SELECT * FROM BIBLIOTECI
WHERE 
	LOCALITATE != '&LOC';

SELECT DENUMIRE
FROM BIBLIOTECI
WHERE
	DIRECTOR = '&DIR'
	AND
	LOCALITATE = '&LOC';

UNDEFINE LOC;

-- Valori substituite din sistem care se pot folosi: &1, &2, ... , &9
-- @calea_fisier 1 300 Bacau

SELECT * FROM CARTI
WHERE
	COD_CARTE == &1;

SELECT * FROM BIBLIOTECI
WHERE
	LOCALITATE = '&3';

UNDEFINE 1;
UNDEFINE 2;
UNDEFINE 3;

SELECT DENUMIRE, LOCALITATE
FROM BIBLIOTECI
WHERE
	LOCALITATE = '&&LOC';

SELECT *
FROM BIBLIOTECI
WHERE
	LOCALITATE != '&LOC'
	AND
	NR_ANG < &NR;

UNDEFINE LOC;

--SELECT * FROM CARTI;

-- Stergere Tabele

DROP TABLE CARTI;
DROP TABLE BIBLIOTECI;