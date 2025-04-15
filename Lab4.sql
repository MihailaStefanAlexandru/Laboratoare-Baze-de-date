-- Sa se selecteze toti angajatii care nu lucreaza in departamentul SALES afisand numele
-- angajatului, denumirea departamentului si comisionul
-- angajatii nu trebuie sa castige comision


-- Metoda clasica

SELECT ENAME, DNAME, COMM
FROM EMP A, DEPT B
WHERE
	A.DEPTNO = B.DEPTNO
	AND
	NVL(A.COMM, 0) = 0
	AND
	DNAME NOT LIKE 'SALES';

-- Metoda MAI Corecta

SELECT ENAME, DNAME, COMM
FROM EMP A JOIN DEPT B
	ON A.DEPTNO = B.DEPTNO
WHERE
	NVL(A.COMM, 0) = 0
	AND
	DNAME NOT LIKE 'SALES';
	
-- Pentru cazul particular in care Coloana are acceasi denumire
-- in ambele tabele

-- Natural Join

-- Nu putem folosi alias-uri pe coloana de legatura
-- Nu este recomandat in baze de date mari (sanse mari de coloane
-- cu acceasi denumire)

SELECT ENAME, DNAME, COMM
FROM EMP A NATURAL JOIN DEPT B
WHERE
	NVL(A.COMM, 0) = 0
	AND
	DNAME NOT LIKE 'SALES';

-- Natural JOIN prin JOIN USING

SELECT ENAME, DNAME, COMM
FROM EMP A JOIN DEPT B
	USING(DEPTNO)
WHERE
	NVL(A.COMM, 0) = 0
	AND
	DNAME NOT LIKE 'SALES';

-- sA se selecteze toti angajatii veniti in firma dupa 1980 si care
-- nu lucreaza in localitatea CHICAGO neavand un comision
-- se afis numele angajatului, comisionul, data angajarii si denumirea
-- departamentului unde lucreaza
-- toate cele patru feluri

SELECT ENAME, COMM, HIREDATE, DNAME
FROM EMP A, DEPT B
WHERE
	A.DEPTNO = B.DEPTNO
	AND
	NVL(A.COMM, 0) = 0
	AND
	B.LOC NOT LIKE 'CHICAGO'
	AND
	HIREDATE > TO_DATE('01-01-1981', 'DD-MM-YYYY');



SELECT ENAME, COMM, HIREDATE, DNAME
FROM EMP A JOIN DEPT B
	ON A.DEPTNO = B.DEPTNO
WHERE
	NVL(A.COMM, 0) = 0
	AND
	B.LOC NOT LIKE 'CHICAGO'
	AND
	HIREDATE > TO_DATE('01-01-1981', 'DD-MM-YYYY');


SELECT ENAME, COMM, HIREDATE, DNAME
FROM EMP A NATURAL JOIN DEPT B
WHERE
	NVL(A.COMM, 0) = 0
	AND
	B.LOC NOT LIKE 'CHICAGO'
	AND
	HIREDATE > TO_DATE('01-01-1981', 'DD-MM-YYYY');



SELECT ENAME, COMM, HIREDATE, DNAME
FROM EMP A JOIN DEPT B
	USING(DEPTNO)
WHERE
	NVL(A.COMM, 0) = 0
	AND
	B.LOC NOT LIKE 'CHICAGO'
	AND
	HIREDATE > TO_DATE('01-01-1981', 'DD-MM-YYYY');


-- Sa se leceteze toti angajatii care au venit in firma inainte de sefii lor


SELECT A.ENAME, S.ENAME, A.HIREDATE, S.HIREDATE
FROM EMP A, EMP S
WHERE
	A.MGR = S.EMPNO
	AND
	A.HIREDATE < S.HIREDATE;


-- NON_EQUI JOIN

SELECT * FROM EMP;
SELECT * FROM SALGRADE;
	 
-- Pnetru fiecare angajat care nu face parte din departamentul
-- sefului sau, sa se afiseze numele angajatului, numele sefului,
-- deptno, id_dept, gradul salariului angajatului

SELECT A.ENAME, S.ENAME, A.DEPTNO, S.DEPTNO, G.GRADE
FROM EMP A JOIN EMP S 
	ON A.MGR = S.EMPNO
	JOIN
	SALGRADE G 
	ON (A.SAL >= G.LOSAL
		AND
		A.SAL <= G.HISAL)
WHERE
	A.DEPTNO != S.DEPTNO;

SELECT A.ENAME, S.ENAME, A.DEPTNO, S.DEPTNO, G.GRADE
FROM EMP A JOIN EMP S 
	ON A.MGR = S.EMPNO
	JOIN
	SALGRADE G 
	ON (A.SAL BETWEEN G.LOSAL AND G.HISAL)
WHERE
	A.DEPTNO != S.DEPTNO;


-- Sa se selecteze toti angajatii care au un grad salarial diferit de
-- cel al sefilor lor, afisand, numele angajatului, numele sefului,
-- gradul angajatului si gradul sefului
-- diferenta intre salariul angajatului si salariul sefului


SELECT A.ENAME, S.ENAME, GA.GRADE, GS.GRADE, A.SAL - S.SAL "DIFERENTA SAL"
FROM EMP A 
	JOIN 
	EMP S ON A.MGR = S.EMPNO
	JOIN
	SALGRADE GA ON (A.SAL BETWEEN GA.LOSAL AND GA.HISAL)
	JOIN
	SALGRADE GS ON (S.SAL BETWEEN GS.LOSAL AND GS.HISAL)
WHERE
	GS.GRADE != GA.GRADE
ORDER BY GA.GRADE ASC;

SELECT * FROM DEPT;


-- OUTER JOIN
-- Operatorul +

-- Sa se efectueze o lista de departamente si de angajati care fac parte din
-- aceste departamente afisand in aceasta lista si departamentul OPERATIONS
-- fara angajati

SELECT A.ENAME, B.DNAME
FROM EMP A, DEPT B
WHERE
	A.DEPTNO(+) = B.DEPTNO;


SELECT A.ENAME, B.DNAME
FROM EMP A RIGHT OUTER JOIN DEPT B
	ON A.DEPTNO = B.DEPTNO;













