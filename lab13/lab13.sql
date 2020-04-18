drop database theatr_db;
CREATE DATABASE theatr_db;
USE theatr_db;
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

INSERT INTO auditorium VALUES
(1,"Big auditorium", 240),
(2,"Small auditorium", 110),
(3,"Middle auditorium", 170);

INSERT INTO performance VALUES
(1, "Muna Mazailo", 200, 2, 1, "2020-03-04 10:10:00"),
(2, "Stolen happiness", 400, 3, 2, "2020-03-03 10:50:00"),
(3, "Coriolanus", 600, 3, 2, "2020-04-03 15:00:00"),
(4, "Fireplace master", 450, 2, 3, "2020-04-04 16:30:00");

SHOW INDEX FROM performance;
SHOW INDEX FROM auditorium;

CREATE INDEX performance_name ON performance(name);

CREATE INDEX seats_number ON auditorium(seats_number); 



EXPLAIN SELECT * FROM auditorium INNER JOIN performance
WHERE performance.name="Stolen happiness";

EXPLAIN SELECT straight_join performance.name as performance_name
FROM performance INNER JOIN auditorium
WHERE auditorium.name="Big auditorium";

























