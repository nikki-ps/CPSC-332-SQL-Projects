CREATE TABLE STUDENT (
Sid CHAR(2) NOT NULL,
Sname VARCHAR(15) NOT NULL,
CONSTRAINT PK_STUDENT PRIMARY KEY (Sid)
)

CREATE TABLE COURSE (
Cid CHAR(3) NOT NULL,
Cname VARCHAR(30) NOT NULL,
CONSTRAINT PK_COURSE PRIMARY KEY (Cid)
)

CREATE TABLE ENROLLMENT (
Sid CHAR(2) NOT NULL,
Cid CHAR(3) NOT NULL,
CONSTRAINT FK_Sid_STUDENT FOREIGN KEY (Sid) REFERENCES STUDENT (Sid),
CONSTRAINT FK_Cid_COURSE FOREIGN KEY (Cid) REFERENCES COURSE (Cid)
)

INSERT INTO STUDENT (Sid, Sname) VALUES
(01, 'Tim'),
(02, 'Jim'),
(03, 'Sally'),
(04, 'Pete'),
(05, 'Michael'),
(06, 'Dwight'),
(07, 'Pam'),
(08, 'Kelly'),
(09, 'Ryan'),
(10, 'Toby');


INSERT INTO COURSE (Cid, Cname) VALUES
(332, 'Databases'),
(311, 'Writing'),
(270, 'Math Structures 2'),
(323, 'Compilers'),
(100, 'English');

INSERT INTO ENROLLMENT (Cid, Sid) VALUES
(332, 01),
(332, 03),
(332, 04),
(311, 02),
(311, 04),
(311, 05),
(270, 10),
(270,4),
(270, 8),
(323, 9),
(323,1),
(323,6),
(100, 1),
(100, 7),
(100, 5);

DELETE FROM ENROLLMENT;