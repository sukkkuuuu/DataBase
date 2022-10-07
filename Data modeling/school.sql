-- 생성자 Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   위치:        2022-10-06 23:06:47 KST
--   사이트:      Oracle Database 12cR2
--   유형:      Oracle Database 12cR2

DROP TYPE info FORCE;
DROP TYPE number_info FORCE;

DROP TABLE classroom CASCADE CONSTRAINTS;

DROP TABLE classroom_of CASCADE CONSTRAINTS;

DROP TABLE dean CASCADE CONSTRAINTS;

DROP TABLE department CASCADE CONSTRAINTS;

DROP TABLE lecturetime CASCADE CONSTRAINTS;

DROP TABLE lecturetime_of CASCADE CONSTRAINTS;

DROP TABLE professor CASCADE CONSTRAINTS;

DROP TABLE professor_of_subject CASCADE CONSTRAINTS;

DROP TABLE student CASCADE CONSTRAINTS;

DROP TABLE subject CASCADE CONSTRAINTS;

DROP TABLE teachingassistant CASCADE CONSTRAINTS;

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

CREATE TABLE classroom (
    classno     NUMBER(20) NOT NULL,
    bname       VARCHAR2(50) NOT NULL,
    flour       NUMBER(20),
    fullmemeber NUMBER(20)
);

ALTER TABLE classroom ADD CONSTRAINT classroom_pk PRIMARY KEY ( classno,
                                                                bname );

CREATE TABLE classroom_of (
    subject_name      VARCHAR2(50) NOT NULL,
    subject_classid   VARCHAR2(10) NOT NULL,
    classroom_classno NUMBER(20) NOT NULL,
    classroom_bname   VARCHAR2(50) NOT NULL
);

ALTER TABLE classroom_of
    ADD CONSTRAINT classroom_of_pk PRIMARY KEY ( subject_name,
                                                 subject_classid,
                                                 classroom_classno,
                                                 classroom_bname );

CREATE TABLE dean (
    deanid NUMBER(20) NOT NULL
);

ALTER TABLE dean ADD CONSTRAINT dean_pk PRIMARY KEY ( deanid );

CREATE TABLE department (
    name VARCHAR2(50) NOT NULL
);

ALTER TABLE department ADD CONSTRAINT department_pk PRIMARY KEY ( name );

CREATE TABLE lecturetime (
    id        NUMBER(20) NOT NULL,
    days      VARCHAR2(50),
    starttime NUMBER,
    endtime   NUMBER
);

ALTER TABLE lecturetime ADD CONSTRAINT classtime_pk PRIMARY KEY ( id );

CREATE TABLE lecturetime_of (
    lecturetime_id  NUMBER(20) NOT NULL,
    subject_name    VARCHAR2(50) NOT NULL,
    subject_classid VARCHAR2(10) NOT NULL
);

ALTER TABLE lecturetime_of
    ADD CONSTRAINT lecturetime_of_pk PRIMARY KEY ( lecturetime_id,
                                                   subject_name,
                                                   subject_classid );

CREATE TABLE professor (
    id             NUMBER(20) NOT NULL,
    pinfo          info NOT NULL,
    major          VARCHAR2(50) NOT NULL,
    office         VARCHAR2(30),
    departmentname VARCHAR2(50) NOT NULL,
    CHECK ( pinfo.name IS NOT NULL )
);

ALTER TABLE professor ADD CONSTRAINT professor_pk PRIMARY KEY ( id );

CREATE TABLE professor_of_subject (
    professor_id    NUMBER(20) NOT NULL,
    subject_name    VARCHAR2(50) NOT NULL,
    subject_classid VARCHAR2(10) NOT NULL
);

ALTER TABLE professor_of_subject
    ADD CONSTRAINT professor_of_subject_pk PRIMARY KEY ( professor_id,
                                                         subject_name,
                                                         subject_classid );

CREATE TABLE student (
    classid   NUMBER(20) NOT NULL,
    sinfo     info NOT NULL,
    majorname VARCHAR2(50) NOT NULL,
    submajor  VARCHAR2(50),
    CHECK ( sinfo.name IS NOT NULL )
);

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( classid );

CREATE TABLE subject (
    classid     VARCHAR2(10) NOT NULL,
    name        VARCHAR2(50) NOT NULL,
    learntime   NUMBER(20),
    assistandid NUMBER(20) NOT NULL,
    pid         NUMBER(20) NOT NULL
);

ALTER TABLE subject ADD CONSTRAINT subject_pk PRIMARY KEY ( name,
                                                            classid );

CREATE TABLE teachingassistant (
    assistandid NUMBER(20) NOT NULL,
    ainfo       info,
    subjectname VARCHAR2(50) NOT NULL,
    CHECK ( ainfo.name IS NOT NULL )
);

ALTER TABLE teachingassistant ADD CONSTRAINT teachingassistant_pk PRIMARY KEY ( assistandid );

ALTER TABLE teachingassistant
    ADD CONSTRAINT assistant_of FOREIGN KEY ( subjectname )
        REFERENCES department ( name );

ALTER TABLE subject
    ADD CONSTRAINT assistant_ofv2 FOREIGN KEY ( assistandid )
        REFERENCES teachingassistant ( assistandid );

ALTER TABLE classroom_of
    ADD CONSTRAINT classroom_of_classroom_fk FOREIGN KEY ( classroom_classno,
                                                           classroom_bname )
        REFERENCES classroom ( classno,
                               bname );

ALTER TABLE classroom_of
    ADD CONSTRAINT classroom_of_subject_fk FOREIGN KEY ( subject_name,
                                                         subject_classid )
        REFERENCES subject ( name,
                             classid );

ALTER TABLE professor
    ADD CONSTRAINT department_of FOREIGN KEY ( departmentname )
        REFERENCES department ( name );

ALTER TABLE lecturetime_of
    ADD CONSTRAINT lecturetime_of_lecturetime_fk FOREIGN KEY ( lecturetime_id )
        REFERENCES lecturetime ( id );

ALTER TABLE lecturetime_of
    ADD CONSTRAINT lecturetime_of_subject_fk FOREIGN KEY ( subject_name,
                                                           subject_classid )
        REFERENCES subject ( name,
                             classid );

ALTER TABLE dean
    ADD CONSTRAINT professor_of_dean FOREIGN KEY ( deanid )
        REFERENCES professor ( id );

ALTER TABLE professor_of_subject
    ADD CONSTRAINT professor_of_subject_professor_fk FOREIGN KEY ( professor_id )
        REFERENCES professor ( id );

ALTER TABLE professor_of_subject
    ADD CONSTRAINT professor_of_subject_subject_fk FOREIGN KEY ( subject_name,
                                                                 subject_classid )
        REFERENCES subject ( name,
                             classid );

ALTER TABLE subject
    ADD CONSTRAINT student_of_class FOREIGN KEY ( pid )
        REFERENCES student ( classid );

ALTER TABLE student
    ADD CONSTRAINT student_of_department FOREIGN KEY ( majorname )
        REFERENCES department ( name );

ALTER TABLE student
    ADD CONSTRAINT submajor FOREIGN KEY ( submajor )
        REFERENCES department ( name );



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             0
-- ALTER TABLE                             24
-- CREATE VIEW                              0
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
