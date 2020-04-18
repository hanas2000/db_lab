DROP DATABASE theatre;
CREATE DATABASE theatre;
USE theatre;
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

START TRANSACTION;
INSERT INTO auditorium VALUES
(1,"Big auditorium", 240);
INSERT INTO auditorium VALUES
(2,"Small auditorium", 110);
INSERT INTO auditorium VALUES
(3,"Middle auditorium", 170);
COMMIT;

START TRANSACTION;
INSERT INTO performance VALUES
(null, "Muna Mazailo", 200, 2, 4);
INSERT INTO performance VALUES
(null, "Stolen happiness", 400, 3, 2);
INSERT INTO performance VALUES
(null, "Coriolanus", 600, 3, 2);
INSERT INTO performance VALUES
(null, "Fireplace master", 450, 2, 3);
COMMIT;

START TRANSACTION;
INSERT INTO performance VALUES
(null, "Muna Mazailo", 200, 2, 1);
INSERT INTO performance VALUES
(null, "Stolen happiness", 400, 3, 2);
INSERT INTO performance VALUES
(null, "Coriolanus", 600, 3, 2);
INSERT INTO performance VALUES
(null, "Fireplace master", 450, 2, 3);
COMMIT;

select * from performance;
