-- 05.10 //

SELECT last_name, first_name
FROM customer
WHERE last_name LIKE '_A_T%S';  -- _는 뭐가와도 상관없다. %는 길이 문자 상관없는데 마지막은S여야 한다

-- 고객 중에 이메일값이 네번째에 .이 있고 아이디값이 13번째가 @인 사람
SELECT email
FROM customer
WHERE email LIKE '____._______@%';

-- 성이 Q,Y로 시작하는 사람 
SELECT *
FROM customer
WHERE last_name LIKE 'Q%' OR last_name LIKE 'Y%';

-- 정규식 으로 전환 
SELECT *
FROM customer
WHERE last_name REGEXP '^[QY]';

-- 성이 L,Y로 끝나는 사람 
SELECT *
FROM customer
WHERE last_name REGEXP '[YL]$';

SELECT *
FROM customer
WHERE last_name REGEXP 'COB+';


SELECT rental_id, customer_id
FROM rental
WHERE return_date IS NULL;


-- 반납일이 '2005-05-01' ~ '2005-09-01'이 아닌 렌탈 정보 알고싶다.
SELECT *
FROM rental
WHERE return_date NOT BETWEEN '2005-05-01' AND '2005-08-31'
OR return_date IS NULL;

-- P.126
-- 4-5-2
SELECT payment_id, customer_id, amount, DATE(payment_date)
FROM payment
WHERE payment_id BETWEEN 101 AND 120
AND customer_id = 5 AND not(amount > 6 OR DATE(payment_date) = '2005-06-19');

-- 4-5-3

SELECT *
FROM payment
WHERE amount IN(1.98, 7.98, 9.98);

-- 4-5-4
SELECT *
FROM customer 
WHERE last_name LIKE '_A%W%';


-- exam

SELECT * FROM person;


SELECT A.food, A.person_id, B.person_id, B.fname, B.lname
FROM favorite_food A
INNER JOIN person B
ON A.person_id = B.person_id; -- 둘 다 가진거 나온다


SELECT * 
FROM person A
LEFT JOIN favorite_food B  -- 나오는거 보장하지만 연결시킬게 없으면 null
ON A.person_id = B.person_id;

-- 고객id, 이름 , 성, address, district 나오는 쿼리문 완성

SELECT A.customer_id, A.first_name, A.last_name, B.address, B.district
FROM customer A
INNER JOIN address B
ON A.address_id = B.address_id;
-- USING(address_id);


-- 고객id, 이름 , 성, 도시명 나오는 쿼리문 완성 
SELECT A.customer_id, A.first_name, A.last_name, C.city
FROM customer A
INNER JOIN address B
ON A.address_id = B.address_id
INNER JOIN city C
ON B.city_id = C.city_id;


-- 'California' 값만 알고 있다. 미국 주중에 Cailfornia에 사는 소비자 정보가 궁금하다.

SELECT * 
FROM customer A
INNER JOIN address B
ON A.address_id = B.address_id
WHERE B.district = 'California';
 
SELECT * FROM customer
WHERE address_id IN (
		SELECT address_id FROM address 
		WHERE district = 'California');


SELECT * FROM customer A
inner JOIN (
		SELECT address_id FROM address 
		WHERE district = 'California'
) B
ON A.address_id = B.address_id;

-- 배우이름 CATE MCQUEEN, CUBA BIRCH 나온 영화

SELECT DISTINCT C.* FROM actor A
INNER JOIN film_actor B
ON A.actor_id = B.actor_id
INNER JOIN film C
ON B.film_id = C.film_id
WHERE (A.first_name, A.last_name) 
IN (('CATE','MCQUEEN'),('CUBA','BIRCH'))
ORDER BY film_id;
-- WHERE (C.first_name ='CATE' AND C.last_name = 'MCQUEEN') OR
-- (C.first_name ='CUBA' AND C.last_name = 'BIRCH');



-- 두명 다 출연하는 영화 찾기

SELECT * FROM
film F
INNER JOIN 
(
SELECT B.film_id FROM actor A
INNER JOIN film_actor B
ON A.actor_id = B.actor_id
INNER JOIN film C
ON B.film_id = C.film_id
WHERE (A.first_name, A.last_name) IN (('CATE','MCQUEEN'),('CUBA','BIRCH'))
GROUP BY B.film_id
HAVING COUNT(*) = 2
) S
ON S.film_id = F.film_id;



-- P.144
-- 5-4-1

SELECT c.first_name, c.last_name, a.address, ct.city
FROM customer c
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city ct
ON a.city_id = ct.city_id
WHERE a.district = 'California';

-- 5-4-2
SELECT C.*
FROM actor A
INNER JOIN film_actor B
ON A.actor_id = B.actor_id
INNER JOIN film C
ON B.film_id = C.film_id
WHERE A.first_name = 'JOHN';


-- 5-4-3
SELECT a1.address addr1, a2.address addr2, a1.city_id, a2.city_id
FROM address a1
INNER JOIN address a2
ON a1.city_id = a2.city_id
WHERE a1.address_id <> a2.address_id;




