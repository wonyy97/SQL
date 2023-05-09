
-- Data Definition Language
CREATE TABLE t_test(
	  id BIGINT UNSIGNED AUTO_INCREMENT
	, nm VARCHAR(100) NOT NULL
	, jumin CHAR(9) NOT NULL
	, age INT NOT NULL
	, addr VARCHAR(200)
	, created_at DATETIME DEFAULT NOW()
	, PRIMARY KEY(id)
);
DROP TABLE t_test;

-- Data Manipulation Language
-- CRUD

INSERT INTO t_test
( nm, jumin, age, addr )
values
('김윤은', '051126370', 19, '대구시');

INSERT t_test
SET nm = '강감찬'
, jumin = '971211212'
, age = 21
, addr = '경북 경산시';


-- Read (Select문)

SELECT * FROM t_test;

SELECT nm, jumin FROM t_test;

SELECT nm, jumin AS '주민번호' FROM t_test;

SELECT *
FROM t_test
WHERE nm = '김원희';

SELECT * FROM t_test
WHERE nm = '김원희'
AND age > 27;

SELECT * FROM t_test
WHERE age = 27 OR age = 19;

SELECT * FROM t_test
WHERE age IN (19, 27);

SELECT * FROM t_test
WHERE age >= 25 AND age <= 30;

SELECT * FROM t_test
WHERE age BETWEEN 27 and 30;

SELECT * FROM t_test
WHERE nm LIKE '%김%';

-- U Update문

UPDATE t_test
SET nm = '유관순'
WHERE id = 1;

UPDATE t_test
SET age = 22
, addr = '부산시'
WHERE id = 2;

-- Delete

DELETE FROM t_test
WHERE id = 2;






