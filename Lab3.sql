set pagesize 400;

-- Se lucreaza cu tabele predefinite
-- DEPT, EMP, SALGRADE

SELECT DNAME, LOC
FROM DEPT
WHERE LOC = 'CHICAGO';

-- Operator natural pentru siruri de caractere este LIKE

-- % Inlocuieste orice inclusiv sirul vid

SELECT DNAME, LOC
FROM DEPT
WHERE LOC LIKE 'C%';

-- _ Inlocuieste un caracter, dar trebuie sa existe
-- Merge doar cu LIKE

SELECT *
FROM DEPT
WHERE
	LOC LIKE '_______';

-- Sa se selecteze toti angajatii care au un nume format
-- din mai mult de 4 caractere si nu au in job-ul lor 
-- litera 'C' se afiseaza numele angajatului, job-ul si 
-- id-ul din care face parte angajatii vor fi sortati CRESC 
-- dupa id-ul departamentului si descrescator dupa numele 
-- angajatului

SELECT ENAME, JOB, DEPTNO
FROM EMP
WHERE 
	ENAME LIKE '_____%'
	AND
	JOB NOT LIKE '%C%'
ORDER BY DEPTNO ASC, ENAME DESC;

-- Format de date:
-- DD-MM-YYYY
-- DD-MON-YYYY
-- DD-MON-YY

-- Sa se selecteze toti angajatii care au venit in firma inainte de 1982

SELECT ENAME, EMPNO, HIREDATE
FROM EMP
WHERE
	HIREDATE < TO_DATE('01-01-1982', 'DD-MM-YYYY');

--
-- Sau
-- TO_CHAR(DATE, '<FORMAT>') < <DATE_IN_FORMAT>
--

SELECT ENAME, EMPNO, HIREDATE
FROM EMP
WHERE
	TO_CHAR(HIREDATE, 'YYYYMMDD') < '19820101';

-- Sa se selecteze toti angajatii care au venit in firma in anul 1981
-- si care au mai mult de 5 caractere in nume
-- se sorteaza dupa data angajarii desc rezultatul

SELECT *
FROM EMP
WHERE
	ENAME LIKE '______%'
	AND
	TO_CHAR(HIREDATE, 'DDMMYYYY')
		BETWEEN
			'01011981'
			AND
			'30121981'
ORDER BY HIREDATE DESC;

SELECT *
FROM EMP
WHERE
	ENAME LIKE '______%'
	AND
	HIREDATE > TO_DATE('01-01-1981', 'DD-MM-YYYY')
ORDER BY HIREDATE DESC;

--
--
--

SELECT ENAME, SAL, COMM
FROM EMP
WHERE
	COMM IS NULL
	OR
	COMM = 0;

SELECT ENAME, SAL, COMM
FROM EMP
WHERE
	NVL(COMM, 0) = 0;

-- Sa se selecteze toti angajatii care au un comision
-- care au nume diferit de 5 caractere
-- si au venit in firma dupa 1980
-- se va rez prin 2 metode intre cele doua metode trebuie sa fie
-- cel putin 2 diferente
-- sortare dupa ce criteriu vrem

SELECT *
FROM EMP
WHERE
	ENAME NOT LIKE '_____'
	AND 
	HIREDATE > TO_DATE('01-01-1980', 'DD-MM-YYYY')
	AND
	NVL(COMM, 0) != 0
ORDER BY ENAME DESC;

SELECT *
FROM EMP
WHERE
	ENAME NOT LIKE '_____'
	AND 
	TO_CHAR(HIREDATE, 'DDMMYYYY') > '01011980'
	AND (
		COMM IS NOT NULL
		AND
		COMM != 0
	)
ORDER BY ENAME DESC;

--
--
--

SELECT ENAME, LOC
FROM EMP, DEPT
WHERE
	EMP.DEPTNO = DEPT.DEPTNO;

SELECT ENAME, LOC
FROM EMP ANG, DEPT D
WHERE
	ANG.DEPTNO = D.DEPTNO;