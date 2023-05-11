-- 05.11
SELECT 1 as num, 'abc' as str
UNION
SELECT 9 as num, 'xyzaa' as str
UNION ALL
SELECT 1 , 1 ;
-- union 하면 따로따로 된 행을 한번에 출력하게 해준다.
-- 하지만 중복제거 기능이 있어서 중복된 것도 다 출력하고싶으면 
-- union all 해주면 된다.
-- 타입별로 자동 형변환 해준다 

-- 고객의 이름, 성/ 배우의 이름, 성 같이 띄워주세요~~ union 이용 


SELECT 'customer' as typ, first_name, last_name
FROM customer 
UNION 
SELECT 'actor', first_name, last_name
FROM actor
ORDER BY first_name;

-- 배우, 고객 둘 다 이니셜이 J , D로 시작하는 사람리스트

SELECT 'customer' as typ, first_name, last_name
FROM customer 
WHERE first_name REGEXP '^J' AND last_name REGEXP '^D'
UNION 
SELECT 'actor', first_name, last_name
FROM actor
WHERE first_name REGEXP '^J' AND last_name REGEXP '^D'
ORDER BY first_name;


SELECT T.*
FROM (
	SELECT 'customer' as typ, first_name, last_name
	FROM customer 
	UNION 
	SELECT 'actor', first_name, last_name
	FROM actor
) T
WHERE T.first_name REGEXP '^J' AND T.last_name REGEXP '^D'; 

-- 중복 이름 추출

SELECT T.first_name, T.last_name
FROM (
	SELECT 'customer' as typ, first_name, last_name
	FROM customer 
	WHERE first_name REGEXP '^J' AND last_name REGEXP '^D'
	UNION 
	SELECT 'actor', first_name, last_name
	FROM actor
	WHERE first_name REGEXP '^J' AND last_name REGEXP '^D'
) T
GROUP BY T.first_name, T.last_name
HAVING COUNT(1) > 1; 

-- 중복되지 않은 이름 추출

SELECT T.first_name, T.last_name
FROM (
	SELECT 'customer' as typ, first_name, last_name
	FROM customer 
	WHERE first_name REGEXP '^J' AND last_name REGEXP '^D'
	UNION 
	SELECT 'actor', first_name, last_name
	FROM actor
	WHERE first_name REGEXP '^J' AND last_name REGEXP '^D'
) T
GROUP BY T.first_name, T.last_name
HAVING COUNT(1) = 1; 

--  

CREATE TABLE except_a(
	id INT UNSIGNED 
);


CREATE TABLE except_b(
	id INT UNSIGNED 
);

INSERT INTO except_a
(id)
VALUES
(10), (11), (12), (10), (10);

INSERT INTO except_b
(id)
VALUES
(10), (10);

-- 10, 11, 12

SELECT id FROM except_a
UNION 
SELECT id FROM except_b;

-- P.163
-- 6-5-2,3
SELECT T.*
FROM (
	SELECT 'customer' as typ, first_name, last_name
	FROM customer
	UNION
	SELECT 'actor' as typ, first_name, last_name
	FROM actor
) T
WHERE last_name REGEXP '^[L]'
ORDER BY last_name;


-- ==================

DROP TABLE string_tbl;

CREATE TABLE string_tbl(
	char_fld CHAR(30)
	, vchar_fld VARCHAR(30)
	, text_fld text
);

INSERT INTO string_tbl
( char_fld, vchar_fld, text_fld)
VALUES
(
	'this is char data'
	, 'this is vchar data'
	, 'this is text data'
);

SELECT *, QUOTE(text_fld) FROM string_tbl;  -- QUOTE excape 문자 다 찍는다~

UPDATE string_tbl
SET vchar_fld = 'This is a piece of extremely long varchar data';

UPDATE string_tbl
SET text_fld = 'This s\'tring didn''t WORK, but it does now';

SELECT @@SESSION.sql_mode;

SET sql_mode = 'strict';

SHOW WARNINGS;


SELECT lname, fname, CONCAT(lname, ' ', fname)
FROM person;

SELECT lname, CHAR_LENGTH(lname)
FROM person; -- 글자 갯수 확인

SELECT lname, POSITION('김' IN lname)
FROM person; -- 컬럼안에 문자 있는지 확인

SELECT * FROM string_tbl;

SELECT text_fld, POSITION('n' IN text_fld), LOCATE('n', text_fld, 12)
FROM string_tbl;

SELECT '안녕' = '안녕'  -- 같으면 1
	, 'abc' = 'ABC'
	, 'abc' = 'cba'
	, STRCMP('abc','ABCC')
	, STRCMP('abc','ab');

SELECT 
	NAME,
	NAME LIKE '%y',
	NAME REGEXP '^[C]'
FROM category;

SELECT first_name | ' ' | last_name
FROM customer;

SELECT first_name, 
REPLACE(first_name, 'BA', 'DA') 
FROM customer;

-- 성에서 PH > TH 로 바꾸고, NI > NA  >> STETHANAE

SELECT first_name, 
REPLACE(REPLACE(first_name, 'PH', 'TH'),'NI','NA')
FROM customer
ORDER BY first_name;

SELECT 'goodbye world', INSERT('goodbye world', 9, 0, 'cruel ');

-- 영화제목 빈간에 NICE 추가해 주세요

SELECT title, INSERT(title, POSITION(' ' IN title),0 ,' NICE')
FROM film;

SELECT email, 
SUBSTRING(email, 3), 
SUBSTRING(email, 3, 6), 
SUBSTR(email, 3, 3)
FROM customer;

-- 사용자 이메일 쪼개서 출력 @ 기준으로


SELECT
SUBSTRING(email, 1, POSITION('@' IN email)-1) AS nm,
SUBSTRING(email, POSITION('@' IN email)+1) AS email
FROM customer;

SELECT (37 * 59) / ( 78 - (8 * 6));

SELECT MOD(9, 2);

SELECT TRUNCATE(1123.3456,2), -ABS(-10), ABS(10);

SELECT NOW(), CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP();

SELECT CAST('2023-05-11 16:46:30' AS DATETIME)
, CONVERT('2023-05-11 16:46:30', DATETIME);

SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY)
, DATE_ADD(NOW(), INTERVAL '03:27:11' HOUR_SECOND);


-- 1953-09-02
SELECT * FROM employees
WHERE emp_no = 10001;

UPDATE employees
SET birth_date = DATE_ADD(birth_date, INTERVAL '2-1' YEAR_MONTH)
WHERE emp_no = 10001;


SELECT 
	CURDATE()
	, SYSDATE()
	, WEEKDAY(NOW())  -- 월(0), 화(1), 수(2), 목(3), 금(4), 토(5), 일(6)
	, LAST_DAY(NOW()) -- 그달의 마지막 일
	, LAST_DAY('2023-06-11')
	, DATE_SUB(NOW(), INTERVAL '2' YEAR)
	, EXTRACT(MONTH FROM NOW())
	, DATEDIFF('2023-09-20','2023-05-11')
	;



