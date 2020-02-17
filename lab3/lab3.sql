CREATE DATABASE theatre_db;
USE theater_db;
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
    data_performance TIMESTAMP(6) NOT NULL,
    CONSTRAINT fk_performance_auditorium
        FOREIGN KEY (id_auditorium)
            REFERENCES auditorium (id)
				ON DELETE CASCADE
);


CREATE TABLE actor
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(64) NOT NULL,
    surname     VARCHAR(64) NOT NULL,
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
