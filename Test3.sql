-- Penrtu toti angajatii care au un grad salarial diferit de cel al sefului lor
-- si care au venitul egal cu cel putin 2 treimi din venitul sefului lor
-- sa se afiseze numele, numele sefului, gradul salarial al angajatului, gradul salarial al
-- sefului, si o evaluare a angajatului facuta astfel:
-- daca angajatul castiga mai mult decat seful vom scrie 'platit prea mult'
-- egal, 'platit bine'
-- daca angajatul este presedintele nu vom scrie nimic
-- iar pentru toti cei care fac parte din SALES vom scrie vanzatori

SELECT A.ENAME, S.ENAME, A.SAL + NVL(A.COMM, 0) VENIT, A.JOB,
        CASE
            WHEN A.JOB IN ('PRESIDENT') THEN  ''
            WHEN D.DNAME IN ('SALES') THEN 'vanzator'
            WHEN A.SAL + NVL(A.COMM, 0) > S.SAL + NVL(S.COMM, 0) THEN 'platit prea mult'
            WHEN A.SAL + NVL(A.COMM, 0) = S.SAL + NVL(S.COMM, 0) THEN 'platit bine'
        END EVALUARE
FROM EMP A
JOIN EMP S ON A.MGR = S.EMPNO
JOIN SALGRADE SG ON A.SAL BETWEEN SG.LOSAL AND SG.HISAL
JOIN SALGRADE S ON S.SAL BETWEEN SG.LOSAL AND SG.HISAL
JOIN DEPT D ON A.DEPTNO = D.DEPTNO
WHERE A.DEPTNO != S.DEPTNO
    AND
    (A.SAL + NVL(A.COMM, 0)) >= (2/3) * (S.SAL + NVL(S.COMM, 0));

-- Pentru toate functiile angajatilor care nu au comision si care fac parte din
-- departamentul sales sa se afiseze denumirea functiei si numarul acestor angajati care
-- au aceasta functie si respecta conditiile respective si de asemeni salariul mediu
-- pentru acestia.

SELECT A.JOB, COUNT(*), AVG(A.SAL)
FROM EMP A
JOIN DEPT B ON A.DEPTNO = B.DEPTNO
WHERE 
    NVL(A.COMM, 0) = 0
    AND
    B.DNAME LIKE 'SALES'
GROUP BY A.JOB;