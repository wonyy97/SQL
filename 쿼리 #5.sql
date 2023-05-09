SELECT 
	A.rental_id, A.rental_date
	, ifnull(A.return_date,'반납안했음') AS return_date
	, B.first_name, B.last_name 
FROM rental A
INNER JOIN customer B
ON A.customer_id = B.customer_id
WHERE return_date IS NULL
ORDER BY rental_id DESC;

SELECT B.customer_id, B.first_name, B.last_name
FROM customer B;