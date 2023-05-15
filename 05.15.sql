-- 5.15

-- 가장 나중에 가입한 고객의 PK, 이름, 성 출력하시오

SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id = (
	SELECT max(customer_id)
	FROM customer
);

-- 도시id, 도시명> India(인도)나라가 아닌 나라들의 도시id,도시명

SELECT city_id, city
FROM city
WHERE country_id <> (
		SELECT country_id FROM country
		WHERE country = 'India');


SELECT city_id, city
FROM city
WHERE country_id != (
	SELECT country_id
	FROM country
	WHERE country = 'India'
);

SELECT A.city_id, A.city
FROM city A
INNER JOIN (
	SELECT country_id
	FROM country
	WHERE country = 'India'
) B
ON A.country_id != B.country_id;

-- Canada, Mexico 도시id, 도시명 출력

SELECT A.city_id, A.city
FROM city A
INNER JOIN (
	SELECT country_id
	FROM country
	WHERE country IN ('Canada', 'Mexico')
) B
ON A.country_id = B.country_id;

-- s.추가하기

-- all 연산자
SELECT *
FROM customer
WHERE customer_id != ALL(  -- = not in
	SELECT customer_id
	FROM payment
	WHERE amount = 0
);

-- United States, Maxico, Canada에 거주하는
-- 소비자의 렌탈횟수보다 많이 렌탈한 사람들의
-- 렌탈한 사람들의 고객id, 횟수

SELECT customer_id, COUNT(customer_id)
FROM rental
GROUP BY customer_id
HAVING COUNT(customer_id) > ALL(
	SELECT COUNT(customer_id)
	FROM rental
	WHERE customer_id IN (
		SELECT customer_id
		FROM customer
		WHERE address_id IN(
			SELECT address_id
			FROM address
			WHERE city_id IN (
				SELECT city_id
				FROM city
				WHERE country_id IN (
					SELECT country_id
					FROM country
					WHERE country IN ('United States', 'Mexico', 'Canada')
				)
			)
		)
	)
	GROUP BY customer_id
);


-- 배우 성이 'MONROE'인 사람이 PG영화등급에 출연했다.
-- 배우id와 영화id가 궁금하다

SELECT *
FROM actor A
INNER JOIN film_actor B
ON A.actor_id = B.actor_id
INNER JOIN film C
ON B.film_id = C.film_id
WHERE A.last_name = 'MONROE'
AND C.rating = 'PG';

SELECT *
FROM actor
WHERE (first_name, last_name) IN
		(	
			SELECT first_name, last_name
			FROM actor
			WHERE last_name = 'MONROE'
			
		);


-- case문
SELECT 
	customer_id
	, active
	,case
		when active = 1
		then '활성화' 
		ELSE '비활성화'
	END active_str
	, if(active = 1, '활성화', '비활성화')active_str2
FROM customer;


-- PG, G 전체이용, NC-17 17세 이상, PG-13은 13세 이상, R은 청소년관람불가

SELECT
	*,
	case when rating IN ('PG','G') then '전체이용'
		  when rating = 'NC-17' then '17세 이상' 	
		  when rating = 'PG-13' then '13세 이상'
		  ELSE '청소년관람불가'
	END rating_str
FROM film;

-- first_name / last_name / num_rentals (active = 0 >0)
-- s.추가하기
SELECT distinct A.first_name, A.last_name, A.active,
	case when A.active = 0	then '0'
	ELSE COUNT(*)
	END num_rentals 
FROM customer A
INNER JOIN rental B
ON A.customer_id = B.customer_id
GROUP BY A.first_name, A.last_name
;

-- rental테이블에서 2005-05~ 08월 각 달의 렌탈 수 출력

SELECT DATE_FORMAT(rental_date, '%Y-%m') mon, COUNT(rental_date) total
FROM rental
WHERE year(rental_date) = 2005
AND MONTH(rental_date) IN (05, 06, 07)
GROUP BY MONTH(rental_date)
;

-- 가로로 나오게 하기
SELECT
	SUM(
	case DATE_FORMAT(rental_date, '%Y-%m') when '2005-05' then 1 ELSE 0 end
	) may_rentals

	,SUM(
	case DATE_FORMAT(rental_date, '%Y-%m') when '2005-06' then 1 ELSE 0 end
	) june_rentals

	,SUM(
	case DATE_FORMAT(rental_date, '%Y-%m') when '2005-07' then 1 ELSE 0 end
	) july_rentals

FROM rental
WHERE DATE_FORMAT(rental_date, '%Y-%m') BETWEEN '2005-05' AND '2005-07';


-- 트랜디션 여러가지 업무를 하나로 본다. 
-- 문제가 없었다. 작업처리
-- 하나라도 에러가 생겼다. 롤백처리 (야 했던거 다시 빠꾸 해~)




















