-- Alterations for the Actors Table
ALTER TABLE Actors ADD
(
CONSTRAINT pk_actor_id PRIMARY KEY (actor_id),
CONSTRAINT upper_a_name CHECK (a_name = UPPER(a_name)),
CONSTRAINT upper_a_surname CHECK (a_surname = UPPER(a_surname)),
CONSTRAINT check_a_gender CHECK (a_gender IN ('M', 'F', 'O')),
CONSTRAINT upper_a_email CHECK (a_email = UPPER(a_email)),
CONSTRAINT unique_a_email UNIQUE (a_email),
CONSTRAINT upper_a_address CHECK (a_address = UPPER(a_address)),
CONSTRAINT upper_a_city CHECK (a_city = UPPER(a_city)),
CONSTRAINT upper_a_country CHECK (a_country = UPPER(a_country)),
CONSTRAINT unique_a_contact_num UNIQUE (a_contact_num)
);
/

--------------------------------------------------------------------------------
-- SOURCES FOR THE TRIGGER MECHANISM
-- https://docs.oracle.com/cd/B28359_01/appdev.111/b28370/triggers.htm#LNPLS2004
-- https://stackoverflow.com/questions/8424900/check-constraint-on-date-of-birth
-- https://stackoverflow.com/questions/994242/cant-create-trigger-using-sqlplus-in-oracle
--------------------------------------------------------------------------------

-- Trigger to enforce age constraint
CREATE OR REPLACE TRIGGER check_actor_age_trigger
BEFORE INSERT OR UPDATE ON Actors
FOR EACH ROW
DECLARE
    age NUMBER;
BEGIN
    -- Calculate age
    age := EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM :NEW.a_birthdate);

    -- Check if age is within the limit
    IF age > 130 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Actor age cannot exceed 130 years.');
    END IF;
END;
/


-- Alterations for the Series Table
ALTER TABLE Series ADD
(
CONSTRAINT pk_series_id PRIMARY KEY (series_id),
CONSTRAINT upper_title CHECK (title = UPPER(title)),
CONSTRAINT upper_description CHECK (description = UPPER(description)),
CONSTRAINT check_production_year CHECK (production_year >= TO_DATE('11-SEP-1928', 'DD-MON-YYYY')),
CONSTRAINT upper_genre CHECK (genre = UPPER(genre))
);
/

-- Alterations for the Episodes Table
ALTER TABLE Episodes ADD
(
CONSTRAINT pk_episode_id PRIMARY KEY (episode_id),
CONSTRAINT upper_episode_title CHECK (title = UPPER(title)),
CONSTRAINT upper_summary CHECK (summary = UPPER(summary))
);
/

-- Alterations for the Viewers Table
ALTER TABLE Viewers ADD
(
CONSTRAINT pk_viewer_id PRIMARY KEY (viewer_id),
CONSTRAINT upper_v_name CHECK (v_name = UPPER(v_name)),
CONSTRAINT upper_v_surname CHECK (v_surname = UPPER(v_surname)),
CONSTRAINT check_v_gender CHECK (v_gender IN ('M', 'F', 'O')),
CONSTRAINT upper_v_email CHECK (v_email = UPPER(v_email)),
CONSTRAINT unique_v_email UNIQUE (v_email),
CONSTRAINT upper_v_address CHECK (v_address = UPPER(v_address)),
CONSTRAINT upper_v_city CHECK (v_city = UPPER(v_city)),
CONSTRAINT upper_v_country CHECK (v_country = UPPER(v_country)),
CONSTRAINT unique_v_contact_num UNIQUE (v_contact_num)
);
/

--------------------------------------------------------------------------------
-- SOURCES FOR THE TRIGGER MECHANISM
-- https://docs.oracle.com/cd/B28359_01/appdev.111/b28370/triggers.htm#LNPLS2004
-- https://stackoverflow.com/questions/8424900/check-constraint-on-date-of-birth
-- https://stackoverflow.com/questions/994242/cant-create-trigger-using-sqlplus-in-oracle
--------------------------------------------------------------------------------

-- Trigger to enforce age constraint
CREATE OR REPLACE TRIGGER check_viewer_age_trigger
BEFORE INSERT OR UPDATE ON Viewers
FOR EACH ROW
DECLARE
    age NUMBER;
BEGIN
    -- Calculate age
    age := EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM :NEW.v_birthdate);

    -- Check if age is within the limit
    IF age > 130 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Viewer age cannot exceed 130 years.');
    END IF;
END;
/


-- Alterations for the Casting Table
ALTER TABLE Casting ADD
(
CONSTRAINT pk_casting_id PRIMARY KEY (casting_id),    
CONSTRAINT fk_actor_id FOREIGN KEY (actor_id) REFERENCES Actors(actor_id),
CONSTRAINT fk_series_id FOREIGN KEY (series_id) REFERENCES Series(series_id),
CONSTRAINT upper_c_role CHECK (c_role = UPPER(c_role))
);
/

-- Alterations for the Viewership Table
ALTER TABLE Viewership ADD
(
CONSTRAINT pk_viewership_id PRIMARY KEY (viewership_id),
CONSTRAINT fk_episode_id FOREIGN KEY (episode_id) REFERENCES Episodes(episode_id),
CONSTRAINT fk_viewer_id FOREIGN KEY (viewer_id) REFERENCES Viewers(viewer_id)
);
/

-- Alterations for the Series-Episodes Junction Table
ALTER TABLE Series_Episodes ADD
(
CONSTRAINT pk_series_episode_id PRIMARY KEY (series_episode_id),
CONSTRAINT fk_series_id_series_episode FOREIGN KEY (series_id) REFERENCES Series(series_id),
CONSTRAINT fk_episode_id_series_episode FOREIGN KEY (episode_id) REFERENCES Episodes(episode_id)
);
/
--------------------------------------------------------------------------------
-- SOURCES FOR THE TRIGGER MECHANISM
-- https://docs.oracle.com/cd/B28359_01/appdev.111/b28370/triggers.htm#LNPLS2004
-- https://stackoverflow.com/questions/8424900/check-constraint-on-date-of-birth
-- https://stackoverflow.com/questions/994242/cant-create-trigger-using-sqlplus-in-oracle
--------------------------------------------------------------------------------


-- Trigger to enforce first_view_date constraint
CREATE OR REPLACE TRIGGER check_first_view_trigger
BEFORE INSERT OR UPDATE ON Viewership
FOR EACH ROW
DECLARE
    Series_production_year DATE;
BEGIN
    -- Extract the production year using the Series_Episodes table
    SELECT s.production_year INTO series_production_year
    FROM Series_Episodes se
    JOIN Series s ON se.series_id = s.series_id
    WHERE se.episode_id = :NEW.episode_id;

    -- Check if the first_view_date is within the valid range
    IF :NEW.first_view_date <= series_production_year OR :NEW.first_view_date > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'Invalid first view date. It must be after the series production year and before or equal to the current date.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Invalid episode_id. No corresponding episode found.');
END;
/

commit;
