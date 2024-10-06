ALTER SESSION SET 
NLS_DATE_FORMAT = 'DD-MON-YYYY'
NLS_DATE_LANGUAGE = 'english'; 
SELECT sysdate FROM dual; 

-- Actors Table ID Sequence
CREATE SEQUENCE actor_id_sequence
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE
  NOCACHE
  NOCYCLE;

-- Actors Table
CREATE TABLE Actors (
    actor_id NUMBER(9) DEFAULT actor_id_sequence.NEXTVAL,
    a_name VARCHAR2(30) NOT NULL,
    a_surname VARCHAR2(35) NOT NULL,
    a_gender CHAR(1),
    a_email VARCHAR2(50) NOT NULL,
    a_address VARCHAR2(30),
    a_city VARCHAR2(30),
    a_country VARCHAR2(30),
    a_birthdate DATE,
    a_contact_num VARCHAR2(30) NOT NULL
);

-- Series Table ID Sequence
CREATE SEQUENCE series_id_sequence
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE
  NOCACHE;


-- Series Table
CREATE TABLE Series (
    series_id NUMBER(8) DEFAULT series_id_sequence.NEXTVAL,
    title VARCHAR2(50) NOT NULL,
    description VARCHAR2(400),
    production_year DATE,
    num_of_seasons NUMBER(2),
    genre VARCHAR2(30)
);


-- Episodes Table ID Sequence
CREATE SEQUENCE episode_id_sequence
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE
  NOCACHE
  NOCYCLE;

-- Episodes Table
CREATE TABLE Episodes (
    episode_id NUMBER(9) DEFAULT episode_id_sequence.NEXTVAL,
    title VARCHAR2(50) NOT NULL,
    season_num NUMBER(2),
    episode_num NUMBER(5),
    duration NUMBER(5),
    summary VARCHAR2(400)
);


-- Viewers Table ID Sequence
CREATE SEQUENCE viewer_id_sequence
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE
  NOCACHE;

-- Viewers Table
CREATE TABLE Viewers (
    viewer_id NUMBER(10) DEFAULT viewer_id_sequence.NEXTVAL,
    v_name VARCHAR2(30) NOT NULL,
    v_surname VARCHAR2(35) NOT NULL,
    v_gender CHAR(1),
    v_email VARCHAR2(50) NOT NULL,
    v_address VARCHAR2(30),
    v_city VARCHAR2(30),
    v_country VARCHAR2(30),
    v_birthdate DATE,
    v_contact_num VARCHAR2(30) NOT NULL
);


-- Casting Table ID Sequence
CREATE SEQUENCE casting_id_sequence
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE
  NOCACHE
  NOCYCLE;


-- Casting Table
CREATE TABLE Casting (
    casting_id NUMBER(9) DEFAULT casting_id_sequence.NEXTVAL,
    actor_id NUMBER(9),
    series_id NUMBER(9),
    c_role VARCHAR2(30)
);


-- Viewership Table ID Sequence
CREATE SEQUENCE viewership_id_sequence
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE
  NOCACHE;


-- Viewership Table
CREATE TABLE Viewership (
    viewership_id NUMBER(10) DEFAULT viewership_id_sequence.NEXTVAL,
    episode_id NUMBER(9),
    viewer_id NUMBER(9),
    first_view_date DATE
);


-- Series-Episodes Junction Table ID Sequence
CREATE SEQUENCE series_episode_id_sequence
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE
  NOCACHE
  NOCYCLE;

-- Series-Episodes Junction Table
CREATE TABLE Series_Episodes (
    series_episode_id NUMBER(10) DEFAULT series_episode_id_sequence.NEXTVAL,
    series_id NUMBER(8),
    episode_id NUMBER(9)
);


commit;
