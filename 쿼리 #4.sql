SELECT 
	NAME AS nm
	, 'common1' AS language_usage
	, floor(language_id * 3.1415927)  AS lang_pi_value
	, UPPER(NAME) AS language_name
	, NAME + 'man'
	, CONCAT(NAME, 'man', 'yep') AS another_name
FROM language;


SELECT distinct actor_id
FROM film_actor 
ORDER BY actor_id DESC;

SELECT 
	CONCAT (cust.first_name, ' ', cust.last_name) AS full_name
FROM (
	SELECT first_name, last_name, email
	FROM customer
	WHERE first_name = 'JESSIE'
) AS cust;
