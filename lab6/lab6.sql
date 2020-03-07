drop database theatre_db;
CREATE DATABASE theatre_db;
USE theatre_db;
CREATE TABLE auditorium
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(32) NOT NULL,
    seats_number INT NOT NULL
);

CREATE TABLE performance
(
    id              INT AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(32) NOT NULL,
    price           VARCHAR(32) NOT NULL,
    duration        INT NOT NULL ,
    id_auditorium   INT NOT NULL ,
    data_performance TIMESTAMP NOT NULL,
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

INSERT INTO auditorium VALUES
(1,"Big auditorium", 240),
(2,"Small auditorium", 110),
(3,"Middle auditorium", 170);


INSERT INTO actor VALUES
(1,"Ivan","Olexsuk",11),
(2,"Petro","Ivanenko",13),
(3,"Olha","Makohin",6),
(4,"Oksana","Muha",10),
(5,"Oleh","Savka",7);

INSERT INTO genre VALUES
(1, "Drama"),
(2, "Comedy"),
(3, "Tragedy"),
(4, "Tragicomedy"),
(5, "Melodrama");

SET FOREIGN_KEY_CHECKS=0; 
LOAD DATA INFILE 'genre.txt' INTO TABLE performance_genre;

INSERT INTO author VALUES
(1,"Mukola","Kulich",null),
(2,"Ivan","Franko","Dzedzaluk"),
(3,"William", "Shakespeare",null),
(4,"Lesya", "Ukrainka", null);

INSERT INTO performance VALUES
(1, "Muna Mazailo", 200, 2, 1, "2020-03-04 10:10:00"),
(2, "Stolen happiness", 400, 3, 2, "2020-03-03 10:50:00"),
(3, "Coriolanus", 600, 3, 2, "2020-04-03 15:00:00"),
(4, "Fireplace master", 450, 2, 3, "2020-04-04 16:30:00");

INSERT INTO performance_actor VALUES
(1,2,"Muna mazailo"),
(2,5,"Mukola"),
(2,1,"Muhailo Gurman"),
(1,3,"Lina Mazailo"),
(3,2,"Caius Marcius"),
(3,4,"Virgilia"),
(1,1,"Mokiy Mazailo"),
(4,1,"Don Juan"),
(4,4,"Donna Mercedes"),
(4,3,"Anna");

INSERT INTO performance_author VALUES
(1,1),
(2,2),
(3,3),
(4,4);

INSERT INTO performance_genre VALUES
(1,1),
(2,1),
(3,3),
(4,2);

INSERT INTO performance VALUES (5, "Le malade imaginaire", 500, 2, 3, "2020-01-01 16:30:00");

SET SQL_SAFE_UPDATES = 0;
 
DELETE FROM `theatre_db`.`performance` WHERE data_performance<"2020-02-02";

UPDATE performance SET duration = duration + 1;

CREATE VIEW table1 AS SELECT DISTINCT name, price, data_performance FROM performance;

SELECT * FROM table1 WHERE data_performance >= "2020-03-03" AND data_performance < "2020-04-04";

SELECT performance.id, performance.name, performance.price, performance.data_performance,
auditorium.name, auditorium.seats_number
FROM performance, auditorium
WHERE performance.id = auditorium.id;


