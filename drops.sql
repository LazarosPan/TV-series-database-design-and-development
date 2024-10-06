--Dropping the Series_Episodes table constraints

ALTER TABLE Series_Episodes DROP CONSTRAINT pk_series_episode_id;
ALTER TABLE Series_Episodes DROP CONSTRAINT fk_series_id_series_episode;
ALTER TABLE Series_Episodes DROP CONSTRAINT fk_episode_id_series_episode;

--Dropping the Casting table constraints

ALTER TABLE Casting DROP CONSTRAINT pk_casting_id;
ALTER TABLE Casting DROP CONSTRAINT fk_actor_id;
ALTER TABLE Casting DROP CONSTRAINT fk_series_id;
ALTER TABLE Casting DROP CONSTRAINT upper_c_role;

--Dropping the Viewership table constraints

ALTER TABLE Viewership DROP CONSTRAINT pk_viewership_id;
ALTER TABLE Viewership DROP CONSTRAINT fk_episode_id;
ALTER TABLE Viewership DROP CONSTRAINT fk_viewer_id;


--Dropping the Actors table constraints

ALTER TABLE Actors DROP CONSTRAINT pk_actor_id;
ALTER TABLE Actors DROP CONSTRAINT upper_a_name;
ALTER TABLE Actors DROP CONSTRAINT upper_a_surname;
ALTER TABLE Actors DROP CONSTRAINT check_a_gender;
ALTER TABLE Actors DROP CONSTRAINT upper_a_email;
ALTER TABLE Actors DROP CONSTRAINT unique_a_email;
ALTER TABLE Actors DROP CONSTRAINT upper_a_address;
ALTER TABLE Actors DROP CONSTRAINT upper_a_city;
ALTER TABLE Actors DROP CONSTRAINT upper_a_country;
ALTER TABLE Actors DROP CONSTRAINT unique_a_contact_num;


ALTER TABLE Series DROP CONSTRAINT pk_series_id;
ALTER TABLE Series DROP CONSTRAINT upper_title;
ALTER TABLE Series DROP CONSTRAINT upper_description;
ALTER TABLE Series DROP CONSTRAINT check_production_year;
ALTER TABLE Series DROP CONSTRAINT upper_genre;

ALTER TABLE Episodes DROP CONSTRAINT pk_episode_id;
ALTER TABLE Episodes DROP CONSTRAINT upper_episode_title;
ALTER TABLE Episodes DROP CONSTRAINT upper_summary;

ALTER TABLE Viewers DROP CONSTRAINT pk_viewer_id;
ALTER TABLE Viewers DROP CONSTRAINT upper_v_name;
ALTER TABLE Viewers DROP CONSTRAINT upper_v_surname;
ALTER TABLE Viewers DROP CONSTRAINT check_v_gender;
ALTER TABLE Viewers DROP CONSTRAINT upper_v_email;
ALTER TABLE Viewers DROP CONSTRAINT unique_v_email;
ALTER TABLE Viewers DROP CONSTRAINT upper_v_address;
ALTER TABLE Viewers DROP CONSTRAINT upper_v_city;
ALTER TABLE Viewers DROP CONSTRAINT upper_v_country;
ALTER TABLE Viewers DROP CONSTRAINT unique_v_contact_num;

--Dropping the triggers

DROP TRIGGER check_actor_age_trigger;

DROP TRIGGER check_viewer_age_trigger;

DROP TRIGGER check_first_view_trigger;

drop sequence actor_id_sequence;
drop sequence series_id_sequence;
drop sequence episode_id_sequence;
drop sequence viewer_id_sequence;
drop sequence casting_id_sequence;
drop sequence viewership_id_sequence;
drop sequence series_episode_id_sequence;

drop table actors;
drop table series;
drop table episodes;
drop table viewers;
drop table casting;
drop table viewership;
drop table series_episodes;

commit;
