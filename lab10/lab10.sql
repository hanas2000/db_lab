CREATE DATABASE tickets_shop;
USE tickets_shop;
CREATE TABLE user
(
	id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(32) NOT NULL,
    email		VARCHAR(32) NOT NULL,
    password    VARCHAR(32) NOT NULL
);

CREATE TABLE purchase
(
	id    		INT AUTO_INCREMENT PRIMARY KEY,
    user_id  	INT NOT NULL,
    purchase_date DATE NOT NULL,
    name 		VARCHAR(32) NOT NULL,
    price 		INT NOT NULL,
    
    CONSTRAINT fk_purchse_user
        FOREIGN KEY (user_id)
            REFERENCES user (id)
);

INSERT INTO user VALUES
(1, "Petro", "ghjfhgjfd@gmail.com", "dfdjfj2432"),
(2, "Ivan", "fdjfd@gmail.com", "Dzedzaluk"),
(3, "William", "dfjhdjh@gmail.com", "william123"),
(4, "Lesya", "Ukrainka@gmail.com", "le145sya");
 
INSERT INTO purchase VALUES
(1, 1, "2019-12-12", "ticket1", 200),
(2, 3, "2019-11-15", "ticket2", 100),
(3, 2, "2019-04-18", "ticket3", 500),
(4, 2, "2019-03-20", "ticket4", 300),
(5, 1, "2019-02-14", "ticket1", 200),
(6, 4, "2019-01-11", "ticket2", 100),
(7, 3, "2019-07-25", "ticket3", 500),
(8, 2, "2018-06-20", "ticket2", 100),
(9, 2, "2019-12-30", "ticket1", 200),
(10, 4, "2019-12-12", "ticket3", 500);

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
        SUM(tickets_shop.purchase.price) as total_price
		FROM purchase, user
		WHERE purchase.user_id = id  
		AND purchase_date BETWEEN date AND curdate();
	END;
		ELSE SELECT error;
	END IF;
END//
DELIMITER ;

CALL st(1, '2010-05-05');
SELECT * FROM tickets_shop.statistic;
CALL st(2, '2010-05-05');
SELECT * FROM tickets_shop.statistic;
CALL st(3, '2010-05-05');
SELECT * FROM tickets_shop.statistic;
CALL st(11, '2020-05-05');
