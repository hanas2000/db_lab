DROP DATABASE theatr;
CREATE DATABASE theatr;
USE theatr;
CREATE TABLE auditorium
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(32) NOT NULL,
    seats_number INT NOT NULL,
    count_use    INT NOT NULL
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
(1,"Big auditorium", 240,1),
(2,"Small auditorium", 110,2),
(3,"Middle auditorium", 170,1);

INSERT INTO performance VALUES
(1, "Muna Mazailo", 200, 2, 1, "2020-03-04 10:10:00"),
(2, "Stolen happiness", 400, 3, 2, "2020-03-03 10:50:00"),
(3, "Coriolanus", 600, 3, 2, "2020-04-03 15:00:00"),
(4, "Fireplace master", 450, 2, 3, "2020-04-04 16:30:00");

CREATE
TRIGGER auditorium_delete BEFORE DELETE
ON theatr.auditorium FOR EACH ROW
DELETE FROM performance WHERE id_auditorium=OLD.id;

SELECT * FROM auditorium;

SELECT * FROM performance;

DELETE FROM auditorium WHERE auditorium.id = 1;

SELECT * FROM auditorium;

SELECT * FROM performance;


CREATE TRIGGER price_level AFTER
INSERT ON theatr.performance FOR EACH ROW
UPDATE theatr.auditorium SET count_use = (SELECT count_use FROM auditorium WHERE id = new.id_auditorium)+1
WHERE auditorium.id = new.id_auditorium;

INSERT INTO performance VALUES
(5, "Muna Mazailo", 2222, 2, 2, "2020-03-04 10:10:00");

SELECT * FROM auditorium;
