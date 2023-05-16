CREATE TABLE t_deal(
	id INT UNSIGNED AUTO_INCREMENT
	, deal_date DATE NOT NULL 
	, price INT UNSIGNED NOT NULL DEFAULT 0;
	, PRIMARY KEY(id)
);

ALTER TABLE t_deal MODIFY price INT NOT null DEFAULT 0;

DROP TABLE t_deal_sub;

CREATE TABLE t_deal_sub(
	deal_id INT UNSIGNED 
	, seq INT UNSIGNED
	, provider_cd CHAR(1) NOT NULL 
	, parts_id INT UNSIGNED NOT NULL 
	, quantity INT UNSIGNED NOT NULL
	, PRIMARY KEY(deal_id, seq)
	, FOREIGN KEY(provider_cd) REFERENCES t_provider(cd)
	, FOREIGN KEY(parts_id) REFERENCES t_parts(id)
	, FOREIGN KEY(deal_id) REFERENCES t_deal(id)
);

CREATE TABLE t_provider(
	cd CHAR(1) PRIMARY KEY
	, nm VARCHAR(10) NOT NULL
);

CREATE TABLE t_parts(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY
	, nm VARCHAR(10) NOT NULL
	, price INT UNSIGNED NOT NULL
);

-- s. 추가하기
INSERT t_parts
SET id = 1
, nm = '모니터'
, price = 200000;

INSERT t_parts
SET nm = '마우스'
, price = 10000;

INSERT t_parts
SET nm = '키보드'
, price = 30000;

INSERT t_provider
SET cd = 'A'
, nm = '알파';

INSERT t_provider
SET cd = 'B'
, nm = '브라보';

INSERT t_provider
SET cd = 'C'
, nm = '찰리';

INSERT INTO t_deal
(deal_date)
VALUES
('2023-10-20'),
('2023-10-20'),
('2023-10-22');

INSERT INTO t_deal_sub
(deal_id, seq, provider_cd, parts_id, quantity)
VALUES
(1, 1, 'A', 1, 10),
(1, 2, 'B', 2, 10),
(1, 3, 'C', 3, 10),
(2, 1, 'A', 1, 20),
(2, 2, 'B', 2, 10),
(3, 1, 'A', 2, 30),
(3, 2, 'C', 3, 5);

UPDATE t_deal A
INNER JOIN (
	SELECT deal_id, SUM(A.quantity * C.price) total_price 
	FROM t_deal_sub A
	INNER JOIN t_parts C
	ON A.parts_id = C.id
	GROUP BY deal_id
) B
ON A.id = B.deal_id
SET A.price = B.total_price;

-- s. 추가하기
SELECT A.deal_id '전표번호'
		, date_format(deal_date, '%m/%d') '날짜'
		, provider_cd '공급자'
		, C.nm '공급자명'
		, B.nm '부품명'
		, B.price '단가'
		, A.quantity '수량'
		, A.quantity * B.price '금액'
FROM t_deal_sub A
INNER JOIN t_parts B
ON A.parts_id = B.id
INNER JOIN t_provider C
ON A.provider_cd = C.cd
INNER JOIN t_deal D
ON A.deal_id = D.id
ORDER BY A.deal_id;













