--5) a)     

SELECT * FROM Actors;

--5) b)     

SELECT a_name as ACTORS_NAME, a_surname as ACTORS_SURNAME, a_gender as ACTORS_GENDER 
FROM Actors ORDER BY a_surname DESC;

--5) c) 1)  

SELECT a_name as ACTORS_NAME, a_surname as ACTORS_SURNAME, a_country as COUNTRY_OF_RESIDENCE 
FROM Actors 
WHERE a_country = 'USA';

--5) c) 2)  

SELECT a_name as ACTORS_NAME, a_surname as ACTORS_SURNAME 
FROM Actors 
WHERE a_surname LIKE 'C%STON'; --an actor surname that starts with C and ends with STON

SELECT a_name as ACTORS_NAME, a_surname as ACTORS_SURNAME 
FROM Actors 
WHERE a_surname LIKE '%KU'; --an actor surname that contains the letters K,U in it

SELECT a_name as ACTORS_NAME, a_surname as ACTORS_SURNAME 
FROM Actors 
WHERE a_surname LIKE '____ EN'; --an actor surname that starts with 4 characters and then has the letters EN

--5) c) 3)  

SELECT a_name as ACTORS_NAME, a_surname as ACTORS_SURNAME, a_city as CITY_OF_RESIDENCE 
FROM Actors 
WHERE a_city != 'LONDON';

--5) c) 4)  

SELECT title, production_year 
FROM Series 
WHERE production_year BETWEEN '1-JAN-2000' AND '31-DEC-2010';

--5) d) 1)  

SELECT a_name as ACTORS_NAME, a_surname as ACTORS_SURNAME, c_role as ROLE
FROM Actors a 
JOIN Casting c ON a.actor_id = c.casting_id;

--5) d) 2)  

SELECT a_name as ACTORS_NAME, a_surname as ACTORS_SURNAME, title 
FROM Actors a 
JOIN Casting c ON a.actor_id = c.actor_id 
JOIN Series s ON s.series_id = c.series_id;

--5) e) 2)

SELECT COUNT(*) as VIEWER_COUNT, v_country AS VIEWER_COUNTRY 
FROM Viewers 
GROUP BY v_country;

--5) e) 3) 

SELECT e.title AS episode_title, COUNT(*) AS view_count
FROM Viewership v
JOIN Episodes e ON v.episode_id = e.episode_id
GROUP BY e.title
ORDER BY view_count DESC
FETCH FIRST 1 ROW ONLY;

--5) e) 4) 

SELECT s.title AS series_title, COUNT(*) AS view_count
FROM Viewership v
JOIN Series_Episodes se ON v.episode_id = se.episode_id
JOIN Series s ON se.series_id = s.series_id
GROUP BY s.title
ORDER BY view_count DESC
FETCH FIRST 1 ROW ONLY;

-- 5) e) 5)

SELECT a_name as ACTORS_NAME, a_surname as ACTORS_SURNAME, title AS series_title
FROM Actors a
JOIN Series s ON a.actor_id = s.series_id
ORDER BY actor_id ASC;

-- 5) e) 6)

WITH ActorSeriesCounts AS (
    SELECT a.actor_id, a.a_name, a.a_surname, COUNT(DISTINCT c.series_id) AS series_count
    FROM Casting c
    JOIN Actors a ON c.actor_id = a.actor_id
    GROUP BY a.actor_id, a.a_name, a.a_surname
)
SELECT actor_id, a_name, a_surname, series_count
FROM ActorSeriesCounts
WHERE series_count = (SELECT MAX(series_count) FROM ActorSeriesCounts);

--5) e) 7)

WITH ActorEpisodeCounts AS (
    SELECT a.actor_id, a.a_name, a.a_surname, COUNT(DISTINCT e.episode_id) AS episode_count
    FROM Casting c
    JOIN Series_Episodes se ON c.series_id = se.series_id
    JOIN Episodes e ON se.episode_id = e.episode_id
    JOIN Actors a ON c.actor_id = a.actor_id
    GROUP BY a.actor_id, a.a_name, a.a_surname
)
SELECT actor_id, a_name, a_surname, episode_count
FROM ActorEpisodeCounts
WHERE episode_count = (SELECT MAX(episode_count) FROM ActorEpisodeCounts);

/* SELECT a.actor_id, a.a_name, a.a_surname, COUNT(*) AS episode_count
FROM Casting c
JOIN Series_Episodes se ON c.series_id = se.series_id
JOIN Episodes e ON se.episode_id = e.episode_id
JOIN Actors a ON c.actor_id = a.actor_id
GROUP BY a.actor_id, a.a_name, a.a_surname
ORDER BY episode_count DESC
FETCH FIRST 1 ROW ONLY; */

--5) e) 8)

SELECT title, num_of_seasons
FROM Series
ORDER BY num_of_seasons DESC
FETCH FIRST ROW ONLY;

--5) e) 9)

WITH SeriesEpisodesCount AS (
    SELECT s.title, COUNT(e.episode_id) as number_of_episodes
    FROM Series s
    JOIN Series_Episodes se ON s.series_id = se.series_id
    JOIN Episodes e ON se.episode_id = e.episode_id
    GROUP BY s.title
)
SELECT sec.title, sec.number_of_episodes
FROM SeriesEpisodesCount sec
WHERE sec.number_of_episodes = (SELECT MAX(number_of_episodes) FROM SeriesEpisodesCount);

--5) e) 10)

SELECT title, production_year 
FROM Series 
WHERE TO_CHAR(production_year, 'YYYY')
BETWEEN '2000' AND '2009';

--5) e) 11)

SELECT a_name as ACTORS_NAME, a_surname as ACTORS_SURNAME, a_birthdate as ACTORS_BIRTHDATE
FROM Actors 
WHERE TO_CHAR(a_birthdate, 'MON') = 'JUL';

--5) e) 12)

SELECT a_name as ACTORS_NAME, a_surname as ACTORS_SURNAME, c_role as ROLE
FROM Actors a JOIN Casting c ON a.actor_id = c.actor_id
WHERE c.series_id IS NULL or c_role IS NULL;

--5) e) 13)

SELECT v_name as VIEWER_NAME, v_surname as VIEWER_SURNAME, v_birthdate as VIEWER_BIRTHDATE, v_gender as VIEWER_GENDER
FROM Viewers
WHERE v_gender = 'F'
ORDER BY v_birthdate
FETCH FIRST ROW ONLY;

--5) e) 14)

SELECT v_name as VIEWER_NAME, v_surname as VIEWER_SURNAME, v_address as VIEWER_ADDRESS
FROM Viewers
WHERE v_address LIKE '%ODOS%';

--5) e) 15)

SELECT s.title, AVG(e.duration) as AVERAGE_EPISODE_LENGTH
FROM Series s
JOIN Series_Episodes se ON s.series_id = se.series_id
JOIN Episodes e ON se.episode_id = e.episode_id
GROUP BY s.title;

--5) e) 16)

WITH ViewerEpisodeCounts AS (
    SELECT vi.viewer_id, COUNT(vi.episode_id) AS episode_count
    FROM Viewership vi
    GROUP BY vi.viewer_id
)
SELECT ve.viewer_id, v.v_name, v.v_surname, ve.episode_count
FROM ViewerEpisodeCounts ve
JOIN Viewers v ON ve.viewer_id = v.viewer_id
WHERE ve.episode_count = (SELECT MAX(episode_count) FROM ViewerEpisodeCounts)
ORDER BY ve.viewer_id;

--5) e) 17)

WITH ViewerEpisodeCounts AS (
    SELECT vi.viewer_id, COUNT(vi.episode_id) AS episode_count
    FROM Viewership vi
    JOIN Viewers v ON vi.viewer_id = v.viewer_id
    WHERE v.v_city = 'THESSALONIKI'
    GROUP BY vi.viewer_id
)
SELECT ve.viewer_id, v.v_name, v.v_surname, ve.episode_count
FROM ViewerEpisodeCounts ve
JOIN Viewers v ON ve.viewer_id = v.viewer_id
WHERE ve.episode_count = (SELECT MAX(episode_count) FROM ViewerEpisodeCounts);

--5) e) 18)

WITH GenderSeriesViewerCounts AS (
    SELECT
        v.v_gender as viewer_gender,
        se.series_id,
        s.title AS series_title,
        COUNT(vi.viewer_id) AS viewer_count
    FROM
        Viewership vi
    JOIN Viewers v ON vi.viewer_id = v.viewer_id
    JOIN Series_Episodes se ON vi.episode_id = se.episode_id
    JOIN Series s ON se.series_id = s.series_id
    GROUP BY v.v_gender, se.series_id, s.title
)
SELECT
    gsvc.viewer_gender,
    gsvc.series_id,
    gsvc.series_title,
    gsvc.viewer_count
FROM
    GenderSeriesViewerCounts gsvc
WHERE
    gsvc.viewer_count = (
        SELECT MAX(viewer_count)
        FROM GenderSeriesViewerCounts
        WHERE viewer_gender = gsvc.viewer_gender
    );


--5) e) 19)

SELECT
    viewer_id,
    v_name AS first_name,
    v_surname AS last_name,
    CONCAT(SUBSTR(v_name, 1, 4), SUBSTR(v_surname, 1, 4)) AS username
FROM
    Viewers;

--5) e) 20)

SELECT
    s.title,
    TO_CHAR(s.production_year, 'YYYY') AS production_year,
    SUM(e.duration) AS total_series_length
FROM
    Series s
JOIN
    Series_Episodes se ON s.series_id = se.series_id
JOIN
    Episodes e ON se.episode_id = e.episode_id
GROUP BY
    TO_CHAR(s.production_year, 'YYYY'), s.title
ORDER BY
    TO_CHAR(s.production_year, 'YYYY');
