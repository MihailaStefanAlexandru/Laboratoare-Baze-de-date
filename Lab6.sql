-- Functii care simuleaza if-then-else

-- DECODE(EXPR, V1, R1, V2, R2, ..., VN, RN, RD)
-- Sa se selecteze pentru toti angajatii care sunt in departament diferit
-- fata de seful lor: numele, numele sefului, venitul si o apreciere a venitului astfel
-- Daca venitul e mai mic de 2500 se va afisa slabut
-- daca e egal cu 2500 se va afisa bunicel
-- si daca e mai mare se va afisa bun

SELECT A.ENAME, S.ENAME, A.SAL + NVL(A.COMM, 0) VENIT,
        DECODE(SIGN(A.SAL + NVL(A.COMM, 0) - 2500), 
            -1, 'slabut',
            0, 'bunicel',
            -- sau puteam sa scriu direct bun
            1, 'bun') CALIF
FROM EMP A JOIN EMP S ON A.MGR = S.EMPNO
WHERE A.DEPTNO = S.DEPTNO;

-- CASE(EXPR)
--    WHEN V1 THEN R1
--    WHEN V2 THEN R2
--    ...
--    ELSE RD
-- END

-- Reformulati cerinta de mai inainte cu CASE
-- Pentru toti angajatii care au grad salarial diferit de cel al sefului
-- sa se afiseze numele angajatului, numele sefului, gradul salarial al angajatului
-- si cel al sefului, job-ul angajatului si o traducere in limba romana a job-ului
-- angajatului
-- Rezolvare si prin DECODE si rpin CASE

SELECT A.ENAME, S.ENAME, A.SAL + NVL(A.COMM, 0) VENIT,
        CASE SIGN(A.SAL + NVL(A.COMM, 0) - 2500) 
            WHEN -1 THEN 'slabut'
            WHEN 0 THEN 'bunicel'
            -- sau puteam sa scriu direct bun
            WHEN 1 THEN 'bun' 
        END CALIF
FROM EMP A JOIN EMP S ON A.MGR = S.EMPNO
WHERE A.DEPTNO <> S.DEPTNO;

SELECT A.ENAME, S.ENAME, A.SAL + NVL(A.COMM, 0) VENIT,
        A.SAL, S.SAL, A.JOB,
        CASE A.JOB
            WHEN 'CLERK' THEN  'functionar'
            WHEN 'MANAGER' THEN 'manager'
            WHEN 'ANALYST' THEN 'analist'
            WHEN 'PRESIDENT' THEN 'presedinte'
            WHEN 'SALESMAN' THEN 'vanzator'
            ELSE 'necunoscut'
        END TRADUCERE
FROM EMP A
JOIN EMP S ON A.MGR = S.EMPNO
JOIN SALGRADE S ON A.SAL BETWEEN S.LOSAL AND S.HISAL
JOIN SALGRADE GS ON S.SAL BETWEEN GS.LOSAL AND GS.HISAL
WHERE S.GRADE <> GS.GRADE;

SELECT A.ENAME, S.ENAME, A.SAL + NVL(A.COMM, 0) VENIT,
        A.SAL, S.SAL, A.JOB,
        DECODE (LOWER(A.JOB),
            'SALESMAN', 'vanzator',
            'CLERK', 'functionar',
            'MANAGER', 'manager',
            'ANALYST', 'analist',
            'PRESIDENT', 'presedinte',
            'NECUNOSCUT') TRADUCERE
FROM EMP A
JOIN EMP S ON A.MGR = S.EMPNO
JOIN SALGRADE S ON A.SAL BETWEEN S.LOSAL AND S.HISAL
JOIN SALGRADE GS ON S.SAL BETWEEN GS.LOSAL AND GS.HISAL
WHERE S.GRADE <> GS.GRADE; 

-- CASE
--  WHEN EXPR1 THEN R1
--  WHEN EXPR2 THEN R2
--  ...
--  ELSE RD
-- END

-- Pentru toti angajatii care au venit in firma dupa sefii lor si care nu fac parte
-- din accounting, sa se afiseze, o lista de premiere astfel:
-- daca angajatul a venit inainte de anul 1981, prima va fi 1500,
-- daca a venit in 1981 aU 1982, prima ete de 1000,
-- daca a venit incepand cu 1983, prima este de 500,
-- directorii si presedintele nu vor castiga nici o prima

SELECT A.ENAME, S.ENAME, A.JOB, A.HIREDATE,
        CASE
            WHEN A.JOB IN ('PRESIDENT', 'MANAGER') THEN 0
            WHEN EXTRACT(YEAR FROM A.HIREDATE) < 1981 THEN 1500
            WHEN EXTRACT(YEAR FROM A.HIREDATE) IN (1981, 1982) THEN 1000
            WHEN EXTRACT(YEAR FROM A.HIREDATE) >= 1983 THEN 500
        END PRIMA
FROM EMP A
JOIN EMP S ON A.MGR = S.EMPNO
JOIN DEPT B ON A.DEPTNO = B.DEPTNO
WHERE 
    A.HIREDATE > S.HIREDATE
    AND
    B.DNAME NOT LIKE 'ACCOUNTING'

-- Sa se evalueze toti angajatii din punctul de vedere al anotimpului cand sau angajat
-- afisand numele angajatului, data angajarii si o descriere astfel
-- luna de vara -> scriem vara
-- daca este vorba de presedinte nu vom afisa nimic

SELECT A.ENAME, A.HIREDATE,
        CASE 
            WHEN A.JOB IN ('PRESIDENT') THEN ''
            WHEN EXTRACT(MONTH FROM A.HIREDATE) IN (6, 7, 8) THEN 'VARA'
            WHEN EXTRACT(MONTH FROM A.HIREDATE) IN (9, 10, 11) THEN 'TOAMNA'
            WHEN EXTRACT(MONTH FROM A.HIREDATE) IN (12, 1, 2) THEN 'IARNA'
            -- ELSE 'PRIMAVARA'
            WHEN EXTRACT(MONTH FROM A.HIREDATE) IN (3, 4, 5) THEN 'PRIMAVARA'
        END ANOTIMP
FROM EMP A;

-- Functii de grupare
SELECT COUNT(*) FROM EMP;
-- MAX, MIN, COUNT, SUM, AVG;

SELECT B.DNAME, COUNT(*), MAX(A.SAL), MIN(A.SAL)
FROM EMP A
JOIN DEPT B ON A.DEPTNO = B.DEPTNO
WHERE 
    NVL(A.COMM, 0) = 0
GROUP BY B.DNAME;

-- HAVING

SELECT B.DNAME, B.DEPTNO, COUNT(*), MAX(A.SAL), MIN(A.SAL)
FROM EMP A
JOIN DEPT B ON A.DEPTNO = B.DEPTNO
WHERE 
    NVL(A.COMM, 0) = 0
GROUP BY B.DNAME, B.DEPTNO
HAVING COUNT(*) > 3;

-- Pentru toti angajatii care nu fac parte din accounting
-- Afisati: pentru fiecare luna calendaristica, numarul lunii si numarul de angajati
-- care au venit in departamentele ramase

SELECT EXTRACT(MONTH FROM A.HIREDATE) LUNA, COUNT(*)
FROM EMP A
JOIN DEPT B ON A.DEPTNO = B.DEPTNO
WHERE
    B.DNAME NOT LIKE 'ACCOUNTING'
GROUP BY EXTRACT(MONTH FROM A.HIREDATE);