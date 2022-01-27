/*#1*/
SELECT DISTINCT
s.Sid AS Student_ID,
s2.Sid AS Classmate_ID
FROM STUDENT AS s
LEFT JOIN ENROLLMENT AS e
ON s.Sid = e.Sid
LEFT JOIN ENROLLMENT AS e2
ON e.Cid = e2.Cid
AND e.Sid <> e2.Sid
LEFT JOIN STUDENT AS s2
ON e2.Sid = s2.Sid
ORDER BY s.Sid;

/*#2*/
SELECT s.StudentIDs AS Student_ID,
count(DISTINCT s.Classmates) AS Number_Of_Classmates
FROM
(SELECT
s.Sid AS StudentIDs,
s2.Sname AS Classmates,
s.Sname AS StudentName
FROM STUDENT AS s
LEFT JOIN ENROLLMENT AS e
ON s.Sid = e.Sid
LEFT JOIN ENROLLMENT AS e2
ON e.Cid = e2.Cid
AND e.Sid <> e2.Sid
LEFT JOIN STUDENT AS s2
ON e2.Sid = s2.Sid
) AS s
GROUP BY s.StudentIDs;

/*#3*/
SELECT 
d.Dname AS DepartmentName,
AVG(coalesce(w.Hours,0)) AS AverageHours
FROM WORKS_ON AS w
FULL JOIN PROJECT AS p
ON w.Pno = p.Pnumber
FULL JOIN DEPARTMENT AS d
ON p.Dnum = d.Dnumber
GROUP BY d.Dname

/*#4*/
SELECT Lname,Fname
FROM EMPLOYEE
WHERE NOT EXISTS(SELECT * FROM WORKS_ON B
WHERE (B.PNO IN (SELECT Pnumber
FROM PROJECT
WHERE Dnum = (SELECT TOP 1
a.dnumb AS departmentnumber
FROM 
(SELECT
sum(w.hours) as sumhours,
d.Dnumber as dnumb
FROM
WORKS_ON as w
inner join PROJECT as p
on p.Pnumber = w.Pno
inner join DEPARTMENT as d
on p.Dnum = d.Dnumber
GROUP BY d.Dnumber
) a
GROUP BY a.dnumb
ORDER BY MAX(a.sumhours) DESC)
AND
NOT EXISTS(SELECT * FROM WORKS_ON C
WHERE C.Essn = Ssn
AND C.Pno = B.Pno))));

/*5*/
ALTER TABLE EMPLOYEE
ADD Rank INT NULL

SELECT 
b.jbcount,b.social
INTO #job_count
FROM
(SELECT
count(w.Pno) AS jbcount,
e.Ssn AS social
FROM WORKS_ON AS w
INNER JOIN EMPLOYEE AS e
ON e.Ssn = w.Essn
GROUP BY e.Ssn
) b
GROUP BY b.jbcount, b.social

SELECT
RANK () OVER( PARTITION BY a.dno ORDER BY a.jcount DESC)AS ranking,
a.social
INTO #rankingg
FROM
(SELECT
j.jbcount AS jcount,
j.social AS social,
e.Dno AS dno
FROM #job_count AS j
INNER JOIN EMPLOYEE AS e
ON e.Ssn = j.social
INNER JOIN DEPARTMENT AS d
ON e.Dno = d.Dnumber
) a

UPDATE EMPLOYEE
SET Rank = te.ranking
FROM #rankingg AS te
INNER JOIN EMPLOYEE AS e
ON e.Ssn = te.social