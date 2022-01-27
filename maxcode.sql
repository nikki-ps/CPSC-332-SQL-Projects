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