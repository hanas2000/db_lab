Drop database tickets_shop;
CREATE DATABASE tickets_shop;
USE tickets_shop;
CREATE TABLE user
(
	id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(32) NOT NULL,
    email		VARCHAR(32) NOT NULL,
    password    VARCHAR(32) NOT NULL
);

CREATE TABLE ticket
(
	id		INT AUTO_INCREMENT PRIMARY KEY,
    name 		VARCHAR(32) NOT NULL,
    price 		INT NOT NULL
);

CREATE TABLE purchase
(
	id    		INT AUTO_INCREMENT PRIMARY KEY,
    user_id  	INT NOT NULL,
    ticket_id   INT NOT NULL,
    purchase_date DATE NOT NULL,
    
    CONSTRAINT fk_purchse_user
        FOREIGN KEY (user_id)
            REFERENCES user (id),
	CONSTRAINT fk_purchse_ticket
        FOREIGN KEY (ticket_id)
            REFERENCES ticket (id)
);

INSERT INTO user VALUES
(1, "Petro", "ghjfhgjfd@gmail.com", "dfdjfj2432"),
(2, "Ivan", "fdjfd@gmail.com", "Dzedzaluk"),
(3, "William", "dfjhdjh@gmail.com", "william123"),
(4, "Lesya", "Ukrainka@gmail.com", "le145sya");
 
INSERT INTO ticket VALUES
(1, "ticket1", 200),
(2, "ticket2", 100),
(3, "ticket3", 500),
(4, "ticket4", 300);
 
INSERT INTO purchase VALUES
(1, 1, 1, "2019-12-12"),
(2, 3, 2, "2019-11-15"),
(3, 2, 3, "2019-11-15"),
(4, 2, 4, "2019-03-20"),
(5, 1, 1, "2019-02-14"),
(6, 4, 2, "2019-01-11"),
(7, 3, 3, "2019-07-25"),
(8, 2, 2, "2018-06-20"),
(9, 2, 1, "2019-12-30"),
(10, 4, 3, "2019-12-12");

DELIMITER //
CREATE FUNCTION get_earning_by_da(needed_date DATE)
RETURNS int
DETERMINISTIC
BEGIN
	DECLARE earning INT DEFAULT 0;
    SELECT sum(price) INTO earning
    FROM ticket
    INNER JOIN purchase p ON p.ticket_id = ticket.id
    WHERE p.purchase_date = needed_date;
RETURN earning;
END //

DELIMITER //
CREATE PROCEDURE st (IN id INT, IN date DATE)
BEGIN
	DECLARE error VARCHAR(32);
	SET error =  'incorrect date';
	IF (date < CURDATE()) THEN
	BEGIN 
		CREATE TABLE IF NOT EXISTS tickets_shop.statistic (total_price INT UNSIGNED);
		TRUNCATE tickets_shop.statistic;
		INSERT INTO tickets_shop.statistic SELECT 
        SUM(tickets_shop.ticket.price) as total_price
		FROM ticket
        INNER JOIN purchase p ON p.ticket_id = ticket.id
		WHERE p.user_id = id  
		AND p.purchase_date BETWEEN date AND curdate();
	END;
		ELSE SELECT error;
	END IF;
END//
DELIMITER ;

SELECT get_earning_by_da("2019-11-15");

CALL st(1, '2010-05-05');
SELECT * FROM tickets_shop.statistic;
CALL st(2, '2010-05-05');
SELECT * FROM tickets_shop.statistic;
CALL st(3, '2010-05-05');
SELECT * FROM tickets_shop.statistic;
CALL st(11, '2020-05-05');


