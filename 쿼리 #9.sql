-- 05.10 //
-- 직원 남녀 숫자 알고싶음.

SELECT gender, COUNT(gender) AS count_gender
FROM employees
GROUP BY gender;

-- 사번, 이름, 성 알고싶다. 

SELECT B.emp_no, B.first_name, B.last_name
		, C.dept_no, C.dept_name
FROM dept_emp A
INNER JOIN employees B
ON A.emp_no = B.emp_no
INNER JOIN departments C
ON A.dept_no = C.dept_no
WHERE A.to_date = '9999-01-01'
;


















