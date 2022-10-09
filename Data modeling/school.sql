-- 생성자 Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   위치:        2022-10-07 21:30:17 KST
--   사이트:      Oracle Database 12cR2
--   유형:      Oracle Database 12cR2

drop type info force;
drop type number_info force;

DROP VIEW Dept_info CASCADE CONSTRAINTS 
;

DROP VIEW Prof_of_CS CASCADE CONSTRAINTS 
;

DROP TABLE class CASCADE CONSTRAINTS;

DROP TABLE classroom CASCADE CONSTRAINTS;

DROP TABLE dean CASCADE CONSTRAINTS;

DROP TABLE department CASCADE CONSTRAINTS;

DROP TABLE lecturetime CASCADE CONSTRAINTS;

DROP TABLE professor CASCADE CONSTRAINTS;

DROP TABLE student CASCADE CONSTRAINTS;

DROP TABLE student_of_class CASCADE CONSTRAINTS;

DROP TABLE subject CASCADE CONSTRAINTS;

DROP TABLE teachingassistant CASCADE CONSTRAINTS;

DROP TABLE time CASCADE CONSTRAINTS;

CREATE OR REPLACE TYPE number_info AS OBJECT (
    phone  CHAR(20),
    home   CHAR(20),
    office CHAR(20)
) NOT FINAL;
/

CREATE OR REPLACE TYPE info AS OBJECT (
    name        VARCHAR2(50),
    phoneno     number_info,
    homeaddress VARCHAR2(30)
) NOT FINAL;
/

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE class (
    sname    VARCHAR2(50) NOT NULL,
    sclassid VARCHAR2(10) NOT NULL,
    cno      NUMBER(20) NOT NULL,
    cname    VARCHAR2(50) NOT NULL
);

ALTER TABLE class
    ADD CONSTRAINT class_pk PRIMARY KEY ( sname,
                                          sclassid,
                                          cno,
                                          cname );

CREATE TABLE classroom (
    classroomno NUMBER(20) NOT NULL,
    bname       VARCHAR2(50) NOT NULL,
    flour       NUMBER(20),
    fullmemeber NUMBER(20)
);

ALTER TABLE classroom ADD CONSTRAINT classroom_pk PRIMARY KEY ( classroomno,
                                                                bname );

CREATE TABLE dean (
    id          NUMBER(20) NOT NULL,
    designation CHAR(20)
);

ALTER TABLE dean ADD CONSTRAINT dean_pk PRIMARY KEY ( id );

CREATE TABLE department (
    name VARCHAR2(50) NOT NULL
);

ALTER TABLE department ADD CONSTRAINT department_pk PRIMARY KEY ( name );

CREATE TABLE lecturetime (
    id        NUMBER(20) NOT NULL,
    days      VARCHAR2(50) NOT NULL,
    starttime NUMBER NOT NULL
);

ALTER TABLE lecturetime ADD CONSTRAINT classtime_pk PRIMARY KEY ( id );

CREATE TABLE professor (
    id             NUMBER(20) NOT NULL,
    info           info NOT NULL,
    major          VARCHAR2(50) NOT NULL,
    office         VARCHAR2(30),
    departmentname VARCHAR2(50) NOT NULL,
    CHECK ( info.name IS NOT NULL )
);

ALTER TABLE professor ADD CONSTRAINT professor_pk PRIMARY KEY ( id );

CREATE TABLE student (
    id       NUMBER(20) NOT NULL,
    info     info NOT NULL,
    type     VARCHAR2(50) NOT NULL,
    major    VARCHAR2(50) NOT NULL,
    submajor VARCHAR2(50),
    CHECK ( info.name IS NOT NULL )
);

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( id );

CREATE TABLE student_of_class (
    stdid    NUMBER(20) NOT NULL,
    sname    VARCHAR2(50) NOT NULL,
    sclassid VARCHAR2(10) NOT NULL
);

ALTER TABLE student_of_class
    ADD CONSTRAINT student_of_class_pk PRIMARY KEY ( stdid,
                                                     sname,
                                                     sclassid );

CREATE TABLE subject (
    classid   VARCHAR2(10) NOT NULL,
    name      VARCHAR2(50) NOT NULL,
    learntime NUMBER(20),
    aid       NUMBER(20) NOT NULL,
    pid       NUMBER(20) NOT NULL
);

ALTER TABLE subject ADD CONSTRAINT subject_pk PRIMARY KEY ( name,
                                                            classid );

CREATE TABLE teachingassistant (
    id             NUMBER(20) NOT NULL,
    info           info,
    departmentname VARCHAR2(50) NOT NULL,
    CHECK ( info.name IS NOT NULL )
);

ALTER TABLE teachingassistant ADD CONSTRAINT teachingassistant_pk PRIMARY KEY ( id );

CREATE TABLE time (
    sname    VARCHAR2(50) NOT NULL,
    sclassid VARCHAR2(10) NOT NULL,
    lid      NUMBER(20) NOT NULL
);

ALTER TABLE time
    ADD CONSTRAINT time_pk PRIMARY KEY ( sname,
                                         sclassid,
                                         lid );

ALTER TABLE teachingassistant
    ADD CONSTRAINT assistant_of FOREIGN KEY ( departmentname )
        REFERENCES department ( name );

ALTER TABLE class
    ADD CONSTRAINT class_classroom_fk FOREIGN KEY ( cno,
                                                    cname )
        REFERENCES classroom ( classroomno,
                               bname );

ALTER TABLE class
    ADD CONSTRAINT class_subject_fk FOREIGN KEY ( sname,
                                                  sclassid )
        REFERENCES subject ( name,
                             classid );

ALTER TABLE professor
    ADD CONSTRAINT department_of FOREIGN KEY ( departmentname )
        REFERENCES department ( name );

ALTER TABLE dean
    ADD CONSTRAINT professor_of_dean FOREIGN KEY ( id )
        REFERENCES professor ( id );

ALTER TABLE subject
    ADD CONSTRAINT professor_of_subject FOREIGN KEY ( pid )
        REFERENCES professor ( id );

ALTER TABLE student_of_class
    ADD CONSTRAINT student_of_class_student_fk FOREIGN KEY ( stdid )
        REFERENCES student ( id );

ALTER TABLE student_of_class
    ADD CONSTRAINT student_of_class_subject_fk FOREIGN KEY ( sname,
                                                             sclassid )
        REFERENCES subject ( name,
                             classid );

ALTER TABLE student
    ADD CONSTRAINT student_of_department FOREIGN KEY ( major )
        REFERENCES department ( name );

ALTER TABLE subject
    ADD CONSTRAINT subject_of FOREIGN KEY ( aid )
        REFERENCES teachingassistant ( id );

ALTER TABLE student
    ADD CONSTRAINT submajor FOREIGN KEY ( submajor )
        REFERENCES department ( name );

ALTER TABLE time
    ADD CONSTRAINT time_lecturetime_fk FOREIGN KEY ( lid )
        REFERENCES lecturetime ( id );

ALTER TABLE time
    ADD CONSTRAINT time_subject_fk FOREIGN KEY ( sname,
                                                 sclassid )
        REFERENCES subject ( name,
                             classid );

CREATE OR REPLACE VIEW Dept_info ( name, 교수수, 조교수 ) AS
SELECT
    department.name,
    COUNT(DISTINCT professor.id)         AS 교수수,
    COUNT(DISTINCT teachingassistant.id) AS 조교수
FROM
    department,
    professor,
    teachingassistant
WHERE
        department.name = professor.departmentname
    AND department.name = teachingassistant.departmentname
GROUP BY
    department.name
HAVING
    COUNT(DISTINCT professor.id) >= 2 
;

CREATE OR REPLACE VIEW Prof_of_CS ( pname, office, "Count_classId" ) AS
SELECT
    professor.info.name    AS "pname",
    professor.office,
    COUNT(subject.classid) AS "Count_classId"
FROM
         department
    INNER JOIN professor ON department.name = professor.departmentname
    INNER JOIN subject ON professor.id = subject.pid
WHERE
    department.name = '소프트웨어학과'
GROUP BY
    professor.info.name,
    professor.office,
    department.name 
;



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             0
-- ALTER TABLE                             24
-- CREATE VIEW                              2
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   2
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
