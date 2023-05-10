-- 05.10 // amount는 판매금액, 직원별 평균 판매금액 알고싶다.

SELECT staff_id, AVG(amount)
FROM payment
GROUP BY staff_id;

-- 

SELECT 
	s.first_name, s.last_name, p.staff_id
	, AVG(p.amount) AS avg_amount
FROM payment p
INNER JOIN staff s
ON s.staff_id = p.staff_id
GROUP BY s.staff_id;



