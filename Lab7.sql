-- Sa se selecteze pentru fiecare angajat care are un venit mai mare decat Blacke,
-- numele angajatului, denumirea departamentului si

SELECT A.ENAME, D.DNAME, A.SAL + NVL(A.COMM, 0) VENIT
FROM EMP A
JOIN DEPT D ON A.DEPTNO = D.DEPTNO,
EMP BL
WHERE 
    BL.ENAME LIKE 'BLAKE'
    and
    A.SAL + NVL(A.COMM, 0) > BL.SAL + NVL(BL.COMM, 0);

/*
*/

SELECT A.ENAME, D.DNAME, A.SAL + NVL(A.COMM, 0) VENIT
FROM EMP A
JOIN DEPT D ON A.DEPTNO = D.DEPTNO
WHERE
    A.SAL + NVL(A.COMM, 0) > 
    (SELECT SAL + NVL(COMM, 0)
     FROM EMP
     WHERE ENAME LIKE 'BLAKE');

/*
    Sa se slecteze toti angajtii care au venit in frima in alta luna calanderistica
    fata de sefii lor si au un venit peste media veniturilor din firma
*/

SELECT A.ENAME, A.SAL+NVL(A.COMM, 0) VENIT
FROM EMP A
JOIN EMP B ON A.MGR = B.EMPNO
WHERE
    EXTRACT(MONTH FROM A.HIREDATE) != EXTRACT(MONTH FROM B.HIREDATE)
    AND
    A.SAL + NVL(A.COMM, 0) >
    (SELECT AVG(SAL + NVL(COMM, 0))
     FROM EMP);

/*
    Sa se selecteze toti angajatii care sunt in acelasi departament cu sefii lor
    si care au un venit peste media veniturilor din departamentul lor
*/

SELECT A.ENAME, S.ENAME, A.DEPTNO, S.DEPTNO
FROM EMP A
JOIN EMP S ON A.MGR = S.EMPNO
WHERE
    A.DEPTNO = S.DEPTNO
    AND
    A.SAL + NVL(A.COMM, 0) >
    (SELECT AVG(C.SAL + NVL(C.COMM, 0))
     FROM EMP C
     WHERE C.DEPTNO = A.DEPTNO);

/*
    Sa se selcteze toti angajtii care au acelsi grad salarial cu sefii lor
    si ai caror salarii sunt mai mici decat media veniturilor angajatilor cu 
    aceeasi functie ca ai lor
*/

SELECT A.ENAME, G.GRADE, S.ENAME, GS.GRADE
FROM EMP A
JOIN EMP S ON S.EMPNO = A.MGR
JOIN SALGRADE G ON A.SAL BETWEEN G.LOSAL AND G.HISAL
JOIN SALGRADE GS ON S.SAL BETWEEN GS.LOSAL AND GS.HISAL
WHERE
    G.GRADE = GS.GRADE
    AND
    A.SAL < 
    (SELECT AVG(C.SAL + NVL(C.COMM, 0))
     FROM EMP C
     WHERE C.JOB LIKE A.JOB);

/*

*/

SELECT A.ENAME, A.SAL
FROM EMP A 
WHERE
    A.SAL = 
    (SELECT MAX(SAL)
     FROM EMP);

SELECT A.ENAME, A.SAL
FROM EMP A 
WHERE
    A.SAL = 
    (SELECT MAX(SAL)
     FROM EMP
     WHERE 
        SAL != 
        (SELECT MAX(SAL)
         FROM EMP));

SELECT A.ENAME, A.SAL
FROM EMP A
WHERE
    3 = 
    (SELECT COUNT(DISTINCT(B.SAL))
     FROM EMP B
     WHERE
        B.SAL > A.SAL);

/*
    Pentru toti angajtii care au al 3, al 4, sau al 5, salariu distinct din
    firma, si care au venit in firma in acelasi an cu seful lor, sa se
    afiseze numele angajatului, numele sefului, anul de angajare al ang,
    al sefului
*/

SELECT A.ENAME, S.ENAME, A.SAL, EXTRACT(YEAR FROM A.HIREDATE), 
        EXTRACT(YEAR FROM S.HIREDATE)
FROM EMP A
JOIN EMP S ON A.MGR = S.EMPNO
WHERE
    EXTRACT(YEAR FROM A.HIREDATE) = EXTRACT(YEAR FROM S.HIREDATE)
    AND
    (SELECT COUNT(DISTINCT(B.SAL))
     FROM EMP B
     WHERE 
        B.SAL > A.SAL) BETWEEN 2 AND 4;

/*
    Sa se selecteze toti angjatii care au un venit superior lui Blake si nu
    fac parte din departamentul lui afisand numele angajtului, denumirea
    departamenutului, venitul angajatului si venitul lui Blake
*/

SELECT A.ENAME, B.DNAME, A.SAL + NVL(A.COMM, 0) VENIT, BL.VENIT_BL
FROM EMP A
JOIN DEPT B ON A.DEPTNO = B.DEPTNO,
(SELECT C.DEPTNO, C.SAL + NVL(C.COMM, 0) VENIT_BL
 FROM EMP C
 WHERE
    C.ENAME LIKE 'BLAKE') BL
WHERE
    A.DEPTNO != BL.DEPTNO
    AND
    A.SAL + NVL(A.COMM, 0) > BL.VENIT_BL;

/*
    1. Sa se selcteze pentru fiecare departament in parte angajtii care au cele
    mai mari venituri din departament, afisand den departament, numele angajatului
    si numele sau

    2. Pentru toti angajtii care au venit in frima cu cel putin 3 luni dupa sefii
    lor sa se afiseze numele angajatului, numele sefului, numarul de luni
    trecute intre cele doua date de angajare si venitul sefului lui Alan.
*/

SELECT D.DNAME, A.ENAME, A.SAL + NVL(A.COMM, 0) VENIT
FROM EMP A 
JOIN DEPT D ON A.DEPTNO = D.DEPTNO
WHERE
    A.SAL = 
    (SELECT MAX(C.SAL + NVL(C.COMM, 0))
     FROM EMP C
     WHERE C.DEPTNO = A.DEPTNO);

SELECT A.ENAME, S.ENAME, ABS(MONTHS_BETWEEN(A.HIREDATE, S.HIREDATE)), AL.VENIT_SEF
FROM EMP A
JOIN EMP S ON S.EMPNO = A.MGR,
(SELECT C.SAL + NVL(C.COMM, 0) VENIT_SEF
 FROM EMP C
 WHERE 
    C.EMPNO =
    (SELECT MGR
     FROM EMP
     WHERE ENAME LIKE 'ALLEN')
) AL
WHERE
    MONTHS_BETWEEN(S.HIREDATE, A.HIREDATE) >= 3;
