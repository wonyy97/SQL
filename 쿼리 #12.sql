-- 05.12

-- P.202
-- 7-5-1
SELECT MID('Please find the substring in this string', 17 ,25);

-- 7-5-2

SELECT ABS(-25.76823), SIGN(-25.76823), TRUNCATE(-25.76823, 2), ROUND(-25.76823, 2);

-- 7-5-3
SELECT EXTRACT(MONTH FROM NOW());
-- SELECT MONTH(NOW());

SELECT customer_id, COUNT(1)
FROM rental
GROUP BY customer_id
ORDER BY count(1) DESC;


-- limit (1) limit(1, 1)

SELECT * FROM rental
ORDER BY rental_id DESC
LIMIT 2, 3;

-- join 이용하여 사용자 이름 찍어주세요.
SELECT c.customer_id,c.first_name, c.last_name, COUNT(1) cnt
FROM rental r
INNER JOIN customer c
ON r.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY count(1) DESC
LIMIT 1;

-- 가장 적게 빌린 사람의 PK, 이름, 빌린 수

SELECT c.customer_id,c.first_name, c.last_name, COUNT(1) cnt
FROM rental r
INNER JOIN customer c
ON r.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY count(1)
LIMIT 1;


SELECT customer_id, COUNT(1)
FROM rental
GROUP BY customer_id
ORDER BY 2 DESC;

-- 렌탈횟수가 40회 이상인 사람들 pk,이름, 성, 렌탈수

SELECT c.customer_id,c.first_name, c.last_name, COUNT(1) cnt
FROM rental r
INNER JOIN customer c
ON r.customer_id = c.customer_id
GROUP BY c.customer_id
HAVING cnt >= 40
ORDER BY cnt
;

-- max, min, avg, count, sum 

SELECT customer_id
, MAX(amount), MIN(amount) 
, AVG(amount), SUM(amount) / COUNT(amount)
FROM payment
GROUP BY customer_id;


SELECT COUNT(customer_id)
, COUNT(DISTINCT customer_id) 
FROM payment;


SELECT COUNT(1)
FROM customer;

 --               컬럼에 null값이 있으면 카운트를 안올리고 싶다. 할 때 쓴다.
SELECT COUNT(*), COUNT(return_date), COUNT(1)
FROM rental
WHERE return_date IS NULL;


SELECT MAX(DATEDIFF(return_date, rental_date))
FROM rental
;

-- 제일 늦게 반납한 사람 정보

SELECT c.*, MAX(DATEDIFF(return_date, rental_date)) mx
FROM rental r
INNER JOIN customer c
ON r.customer_id = c.customer_id
GROUP BY c.customer_id
HAVING mx >= 10
;


-- 배우의 등급별 출연횟수

SELECT A.actor_id, B.rating, COUNT(1) cnt
FROM film_actor A
INNER JOIN film B
ON A.film_id = B.film_id
GROUP BY A.actor_id, B.rating
ORDER BY cnt desc
;

-- 배우의 카테고리별 출연횟수
SELECT D.actor_id, B.category_id, COUNT(1) cnt
FROM category A
INNER JOIN film_category B
ON A.category_id = B.category_id
INNER JOIN film_actor C
ON B.film_id = C.film_id
INNER JOIN actor D
ON C.actor_id = D.actor_id
GROUP BY D.actor_id, B.category_id
ORDER BY cnt ;

-- 연도별 렌탈 횟수 궁금쓰...

SELECT CONCAT(YEAR(rental_date), '년') year, COUNT(1) cnt
FROM rental
GROUP BY YEAR(rental_date);

-- 롤업생성

SELECT fa.actor_id, f.rating, COUNT(1) cnt
FROM film_actor fa
INNER JOIN film f
ON fa.film_id = f.film_id
GROUP BY fa.actor_id, f.rating WITH ROLLUP
;

-- 배우의 등급별(G, PG) 출연 횟수가 궁금함 
-- 출연횟수가 9 초과인 actor_id 궁금쓰

SELECT A.actor_id, B.rating, COUNT(1) cnt
FROM film_actor A
INNER JOIN film B
ON A.film_id = B.film_id
WHERE B.rating IN ('G', 'PG')
GROUP BY A.actor_id, B.rating
HAVING cnt > 9
;

-- P.221
-- 8-5-1

SELECT COUNT(1) FROM payment;

-- 8-5-2

SELECT customer_id, SUM(amount), COUNT(1) 
FROM payment
GROUP BY customer_id;

-- 8-5-3

SELECT customer_id, SUM(amount), COUNT(1) cnt
FROM payment
GROUP BY customer_id
HAVING cnt >= 40
ORDER BY cnt;





