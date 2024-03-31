-- 1.Создайте функцию, которая принимает кол-во сек и далее переводит их в кол-во дней, часов, минут, секунд.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

DROP FUNCTION IF EXISTS convert_seconds;

DELIMITER //

CREATE FUNCTION convert_seconds(seconds_number BIGINT)
RETURNS TEXT READS SQL DATA
BEGIN
	DECLARE days INT;
    DECLARE hours INT;
    DECLARE mins INT;
    DECLARE secs INT;
    SET days = FLOOR(seconds_number / 86400);
    SET hours = FLOOR((seconds_number % 86400) / 3600);
    SET mins = FLOOR((seconds_number % 3600) / 60);
    SET secs = seconds_number % 60;
RETURN CONCAT(days, ' days ', hours, ' hours ', mins, ' minutes ', secs, ' seconds');
END//

DELIMITER ;

SELECT convert_seconds(123456);

-- 2.Cоздайте процедуру, которая выведет только числа, делящиеся на 15 или 33 в промежутке от 1 до 1000.
-- Пример: 15,30,33,45...

DROP PROCEDURE IF EXISTS show_divisibles;
DELIMITER //

CREATE PROCEDURE show_divisibles(start_range BIGINT, end_range BIGINT, divider1 BIGINT, divider2 BIGINT)
BEGIN
	DECLARE i INT DEFAULT start_range;
	DROP TABLE IF EXISTS numbers;
	CREATE TABLE numbers (num INT); 
    WHILE i <= end_range DO
		IF i % divider1 = 0 OR i % divider2 = 0 THEN
        INSERT INTO numbers(num) VALUES (i);
        END IF;
	SET i = i + 1;
	END WHILE;
    SELECT num FROM numbers;
END//

DELIMITER ;