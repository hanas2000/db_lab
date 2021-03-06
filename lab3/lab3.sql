Drop database theatre_db;
CREATE DATABASE theatre_db;
use theatre_db;
CREATE TABLE auditorium
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(32) NOT NULL,
    seatsNumber INT NOT NULL
);

CREATE TABLE performance
(
    id              INT AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(32) NOT NULL,
    price           VARCHAR(32) NOT NULL,
    duration        INT NOT NULL ,
    id_auditorium   INT NOT NULL ,
    CONSTRAINT fk_performance_auditorium
        FOREIGN KEY (id_auditorium)
            REFERENCES auditorium (id)
				ON DELETE CASCADE ON UPDATE NO ACTION
);


CREATE TABLE actor
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(32) NOT NULL,
    surname     VARCHAR(32) NOT NULL,
    experience  INT NOT NULL
);


CREATE TABLE performance_actor
(
    id_performance  INT NOT NULL,
    id_actor        INT NOT NULL,
    role            VARCHAR(32) NOT NULL,
    PRIMARY KEY (id_performance, id_actor),
    CONSTRAINT fk_performnce_actor_performance
        FOREIGN KEY (id_performance)
            REFERENCES performance (id),
    CONSTRAINT fk_performnce_actor_actor
        FOREIGN KEY (id_actor)
            REFERENCES actor (id)
);

CREATE TABLE author
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(32) NOT NULL,
    surname     VARCHAR(32) NOT NULL,
    nick        VARCHAR(32)
);


CREATE TABLE performance_author
(
    id_performance  INT NOT NULL,
    id_author        INT NOT NULL,
    PRIMARY KEY (id_performance, id_author),
    CONSTRAINT fk_performnce_author_performance
        FOREIGN KEY (id_performance)
            REFERENCES performance (id),
    CONSTRAINT fk_performnce_author_author
        FOREIGN KEY (id_author)
            REFERENCES author (id)
);

CREATE TABLE genre
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    genre       VARCHAR(32) NOT NULL
);


CREATE TABLE performance_genre
(
    id_performance  INT NOT NULL,
    id_genre        INT NOT NULL,
    PRIMARY KEY (id_performance, id_genre),
    CONSTRAINT fk_performnce_genre_performance
        FOREIGN KEY (id_performance)
            REFERENCES performance (id),
    CONSTRAINT fk_performnce_genre_genre
        FOREIGN KEY (id_genre)
            REFERENCES genre (id)
);

SHOW TABLES; 
DESCRIBE performance;

ALTER TABLE theatre_db.performance
	ADD COLUMN data_performance TIMESTAMP(6) NOT NULL;
    
ALTER TABLE performance ADD UNIQUE INDEX(id_auditorium, data_performance);
DESCRIBE performance;

ALTER TABLE theatre_db.actor
    MODIFY name VARCHAR(64) NOT NULL,
    MODIFY surname VARCHAR(64) NOT NULL;
DESCRIBE actor;

ALTER TABLE theatre_db.performance
DROP FOREIGN KEY fk_performance_auditorium;

ALTER TABLE theatre_db.performance
ADD CONSTRAINT fk_performance_auditorium FOREIGN KEY (id_auditorium)
REFERENCES theatre_db.auditorium (id) ON DELETE CASCADE;

DESCRIBE performance;

ALTER TABLE theatre_db.actor 
DROP COLUMN experience;
DESCRIBE actor;

ALTER TABLE theatre_db.actor 
ADD COLUMN experience INT NOT NULL;
DESCRIBE actor;

