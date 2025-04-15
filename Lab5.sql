-- Data curenta
-- Cand nu avem coloana intr-o baza de date
SELECT SYSDATE FROM SYS.DUAL;

-- Select se duce pe FROM si ia din DEPT
-- Vede in select daca exista vreo coloana pe care vrea sa o foloseasca
-- Pune cate un 1
-- Se poate indica orice altceva
SELECT 1 FROM DEPT;

-- Concatenare de siruri
-- Folosind operatorul de concatenare
SELECT 'ANGAJATUL '||ENAME||' ESTE IN DEPARTAMNETUL '||DNAME "FACE PARTE", JOB
FROM EMP A JOIN DEPT B
    ON A.DEPTNO = B.DEPTNO;

-- Functii pentru valori numerice
-- MOD(M, 2)
-- CEIL(M) -> N
-- FLOOR(M) -> N
-- ROUND(A, B)
-- TRUNC(A, B)

SELECT CEIL(14.2) FROM SYS.DUAL;
SELECT ROUND(6789.6789, 2) FROM SYS.DUAL;
SELECT ROUND(6789.6789, -2) FROM SYS.DUAL;
SELECT ROUND(6789.6789, -1) FROM SYS.DUAL;

-- SA SE SELECTEZE pentru fiecare angajat care are salariul mai mare decat 1000
-- Numele, Salariul, Salariul / 3, Valoarea intreaga a salariului / 3, val rotunjita
-- la sute a salariului / 3, valoarea rotunjita la sutimi a salariului /3

SELECT ENAME, SAL, SAL / 3, FLOOR(SAL / 3), ROUND(SAL / 3, -2), ROUND(SAL / 3, 2)
FROM EMP
WHERE SAL > 1000
ORDER BY SAL ASC;

-- Creati o lista in care ssa fie calculata o prima pentru angajatii care nu
-- comision, nu au functia de manager si s-au angajt inainte de Allen
-- Prima este calculata ca fiind 23% din venitul lunar al angajatului
-- in valoare rotunjita la intregi
-- Afisat angajatul, functia, comisionul, data angajarii, data angajarii lui
-- Allen si prima calculata
-- Venit = sal + nvl(comm, 0)

SELECT A.ENAME, A.JOB, A.COMM, A.HIREDATE, AL.HIREDATE,
        ROUND(0.23 * (A.SAL + NVL(A.COMM, 0))) PRIMA
FROM EMP A, EMP AL
WHERE
    AL.ENAME LIKE 'ALLEN'
    AND
    A.HIREDATE < AL.HIREDATE
    AND
    NVL(A.COMM, 0) = 0
    AND
    A.JOB NOT LIKE 'MANAGER';

-- Functii pe siruri de caractere
-- LENGTH(SIR) -> DIM
-- CONCAT(A, B) -> C, alternativa la ||
-- CONCAT(CONCAT(A, B), C)
-- SUBSTR(SIR, n, x)
-- SUBSTR(SIR, -1) -> ultima litera
-- REPLACE(SIR1, SIR2, SIR3) -> inlocuieste sir cu sir3 in sir1
-- TRANSLATE(SIR1, SIR2, SIR3) -> se uita litera cu litera si inlocuieste

SELECT REPLACE('FACULTATE', 'TA', 'XY') FROM SYS.DUAL;

SELECT TRANSLATE('FACULTATE', 'TA', 'XY') FROM SYS.DUAL;

-- Selectati toti angajatii din departamentele diferite de o valoare citita
-- de la tastatura, Angajatii care contin in numele lor litera C si care nu primesc
-- comision, numele angajatului se va concatena cu den departamentului sau in
-- forma in departamentul DNAME lucreaza ENAME si se va afisa alaturi de sala-
-- riu si comision in valori rotunjite la zeci.

-- SELECT CONCAT('In departamentul', CONCAT(DNAME, CONCAT('lucreaza', ENAME))), 
--         ROUND(SAL, -1), ROUND(COMM, -1)
-- FROM EMP A JOIN DEPT B
--     ON A.DEPTNO = B.DEPTNO
-- WHERE 
--     DNAME NOT LIKE '&NUME'
--     AND
--     NVL(A.COMM, 0) = 0
--     AND
--     A.ENAME NOT LIKE REPLACE(A.ENAME, 'C', '');

-- Sa se selecteze pentru fiecare angajat numele job-ul si numarul de app
-- in job a grupului format din ultimele 2 litere din nume

SELECT ENAME, JOB, SUBSTR(ENAME, -2) "ULTIMELE", REPLACE(JOB, SUBSTR(ENAME, -2)
        , '') "JOB2", (LENGTH(JOB) - LENGTH(REPLACE(JOB, SUBSTR(ENAME, -2),
        ''))) / 2 "NR"
FROM EMP;

-- Functii pentru operatii cu date
-- ADD_MONTHS(D1, N) -> D2
-- MONTHS_BETWEEN(D1, D2) -> nr. luni
-- LAST_DAY(D1) -> D2
-- NEXT_DAY(D1) -> D2
-- ZI_SAPT: 'MONDAY', 'TUESDAY', ...
-- EXTRACT(YEAR    FROM D1) -> { 2025
--          MONTH              { 4
--          DAY                { 3

SELECT EXTRACT(YEAR FROM SYSDATE) FROM SYS.DUAL;

-- Faceti o lista cu data testarii anagajatilor din departamentul sales
-- testarea va avea loc dupa doua luni de la angajare in ultima zi din
-- saptamana respectiva. Se va afissa numele angajatului, departamentul,
-- data angajarii si data testarii

SELECT ENAME, DNAME, HIREDATE, NEXT_DAY(ADD_MONTHS(HIREDATE, 2), 'SUNDAY')
FROM EMP A JOIN DEPT B
    ON A.DEPTNO = B.DEPTNO
WHERE
    B.DNAME LIKE 'SALES'
ORDER BY A.ENAME ASC;

-- Selectati angajatii care au litera e in interiorul numelui afisand
-- numele angajatului intre caracterul = (ex.: = Lake =,= King = ), vechimea
-- in ani rotunjita la intregi si salariul formatat la un sir de 6 caractere
-- umplut dinspre stanga cu caracterul x (ex.: xx1500, xxx950)
-- Se va afisa numele formatat, vechimea in ani, salariului formatat

SELECT CONCAT('=', CONCAT(ENAME, '=')) "NUME",
        ROUND(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIREDATE)) "VECHIME",
        LPAD(SAL, 6, 'X') "SALARIU"
FROM EMP;