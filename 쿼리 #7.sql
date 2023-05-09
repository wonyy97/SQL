-- 등급이 'G'면서 빌릴수 있는 기간이 7일 이상인 레코드 

SELECT title
FROM film
WHERE rating = 'G' AND rental_duration >= 7;

-- select from where group having order-by limit 


-- 등급이 'G'면서 빌릴수 있는 기간이 7일 이상인 레코드 
-- 혹은 등급이 'PG-13' 이면서 빌릴 수 있는 기간이 4미만인 
-- 모든 레코드 


SELECT title , rating, rental_duration
FROM film
WHERE (rating = 'G' AND rental_duration >= 7) 
OR (rating = 'PG-13' AND rental_duration < 4);

-- group by  그룹함수 그룹별로..함수계산...
-- sum, avg, min, max, count

SELECT * FROM customer;


-- count 전체 레코드 수	 

SELECT COUNT(*), SUM(active)
, COUNT(*) - SUM(active) 
, MAX(address_id)
, MIN(address_id)
, CEIL(AVG(address_id))
FROM customer;  

SELECT store_id, COUNT(*)
FROM customer
WHERE active = 1
GROUP BY store_id  -- group by를 주지 않으면 전체가 하나의 그룹이 된다.
HAVING COUNT(*) >= 300 -- where절은 전체에서 having절은 그룹에서 하는것
ORDER BY store_id;

-- 3.8.1

SELECT actor_id, first_name, last_name
FROM actor
ORDER BY last_name, first_name;

-- 3.8.2

SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name IN ('WILLIAMS', 'DAVIS');
-- WHERE last_name = 'WILLIAMS'
-- OR last_name = 'DAVIS';


-- 3.8.3

SELECT distinct customer_id -- , date(rental_date)
FROM rental
WHERE date(rental_date) = '2005-07-05'
ORDER BY customer_id;

-- 3.8.4

SELECT c.email, r.return_date
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
WHERE DATE(r.rental_date) = '2005-06-14'
ORDER BY r.return_date DESC;

SELECT * FROM customer
WHERE first_name = 'STEVEN'
OR create_date > '2006-01-01';

-- 이름은 STEVEN이고, 생성날짜는 2006년 1월 1일 또는 그 이전

SELECT * FROM customer
WHERE first_name = 'STEVEN'
AND create_date <= '2006-01-01';

-- 이름은 STEVEN 이 아니면서, 생성날짜는 2006년 1월 1일 이후 

SELECT * FROM customer
WHERE first_name != 'STEVEN'
AND create_date > '2006-01-01';

-- 이름은 STEVEN 이 아니거나 성이 'YOUNG'인 사람 중에 
-- 생성날짜가 2006년 1월 1일 이후인 사람들 

SELECT * FROM customer
WHERE (first_name != 'STEVEN' 
OR last_name = 'YOUNG')
AND create_date > '2006-01-01';

-- 이름은 STEVEN 이 아니면서  성이 'YOUNG'이 아닌  사람 중에 
-- 생성날짜가 2006년 1월 1일 이후인 사람들 

SELECT * FROM customer
WHERE !(first_name = 'STEVEN' 
AND last_name = 'YOUNG')
AND create_date > '2006-01-01';

-- 제목 SASSY PACKER, film_id = 762, 대여기간보다 짧은 영화만 알고싶다. 
-- 서브쿼리 

SELECT *
FROM film 
WHERE rental_duration < (SELECT rental_duration
								   FROM film
							      WHERE film_id = 762);

SELECT 6;

SELECT rental_duration
FROM film
WHERE film_id = 762;


-- '2005-06-14' 렌탈을 한 사람들의 이메일을 알고싶다.

SELECT distinct c.email, r.rental_date
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
WHERE DATE(rental_date) = '2005-06-14'
ORDER BY c.email;

-- 2004, 2005년을 제외한 렌탈정보를 알고싶다

SELECT *
FROM rental
-- WHERE YEAR(rental_date) != '2004' AND YEAR(rental_date) != '2005';
-- WHERE YEAR(rental_date) NOT BETWEEN '2004' AND '2005';
WHERE YEAR(rental_date) NOT IN (2004, 2005);

-- 2005-06-14 ~ 16 일 사이에 렌탈정보 알고싶다.

SELECT *
FROM rental
-- WHERE
-- YEAR(rental_date) = 2005
-- AND MONTH(rental_date) = 06
-- AND DAYOFMONTH(rental_date) IN (14,15,16);
WHERE DATE(rental_date) BETWEEN '2005-06-14' AND '2005-06-16';

-- 고객 성이 'FA' 와 'FR' 사이에 속하는 사람이 알고싶다.

SELECT *
FROM customer
WHERE last_name BETWEEN 'FA' AND 'FS';
-- WHERE last_name LIKE '%FA%', ;



-- 영화등급이 'G' 혹은 'PG'인 영화 정보 알고싶다.

SELECT *
FROM film
WHERE rating IN ('G','PG');



-- 제목에 PET이 포함된 영화와 같은 등급을 가진 영화가 궁금하다. 
SELECT *
FROM film
WHERE rating IN (SELECT DISTINCT rating
						FROM film
						WHERE title LIKE '%PET%');

/*
SELECT DISTINCT rating
FROM film
WHERE title LIKE '%PET%'
*/

-- 등급이 'PG-13', 'R', 'NC-17'이 아닌 영화정보 알고싶다.

SELECT *
FROM film
WHERE rating NOT IN ('G','PG-13','NC-17');


SELECT LEFT('abcdefg' , 2), RIGHT('abcdefg', 2), MID('abcdefg', 1,3);

-- 문자함수 이용하여 고객성이 'Q'로 시작하는 사람 궁금하다.

SELECT *
FROM customer
-- WHERE last_name LIKE 'Q%';
WHERE LEFT(last_name ,1) = 'Q';

