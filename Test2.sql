
-- Sa se selecteze toti angajatii care au acelasi grad salarial cu seffi lor,
-- care au venit in firma in anul 1981 si au un salariu mai mare decat 
-- 2 treimi din salariul sefilor lor, doar angajatii care primesc comision
-- se va afisa numele angajatului, numele sefului, comisionul angajatului,
-- data de angajare, gradul salarial al angajatului
-- Se va rezolva prin doua metode, doua selecturi, rezolvare completa
-- Intre cele doua metode trebuie sa existe cel putin 3 diferente
-- modul de realizare al join-ului obligatoriu

SELECT A.ENAME, S.ENAME, A.COMM, A.HIREDATE, GA.GRADE 
FROM EMP A
	JOIN EMP S ON A.MGR = S.EMPNO
	JOIN SALGRADE GA ON (A.SAL BETWEEN GA.LOSAL AND GA.HISAL)
	JOIN SALGRADE GS ON (S.SAL BETWEEN GS.LOSAL AND GS.HISAL)
WHERE
	GS.GRADE = GA.GRADE
	AND
	TO_CHAR(A.HIREDATE, 'YYYY') = '1981'
	AND
	NVL(A.COMM , 0) = 0
	AND
	A.SAL > 2/3 * S.SAL;

SELECT A.ENAME, S.ENAME, A.COMM, A.HIREDATE, GA.GRADE 
FROM EMP A, EMP S, SALGRADE GA, SALGRADE GS
WHERE
	A.MGR = S.EMPNO
	AND
	A.SAL BETWEEN GA.LOSAL AND GA.HISAL
	AND
	S.SAL BETWEEN GS.LOSAL AND GS.HISAL
	AND
	GS.GRADE = GA.GRADE
	AND
	(A.HIREDATE BETWEEN
	TO_DATE('01-01-1981', 'DD-MM-YYYY') 
	AND TO_DATE('31-12-1981', 'DD-MM-YYYY')
	)
	AND (
		A.COMM IS NULL
		OR
		A.COMM = 0
	)
	AND
	A.SAL > 2/3 * S.SAL;