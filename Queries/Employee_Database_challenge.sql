SELECT
	e.emp_no,
	e.first_name,
	e.last_name,
	tt.title,
	tt.from_date,
	tt.to_date
INTO
	retirement_titles
FROM 
	employees e
INNER JOIN
	titles tt
ON	
	e.emp_no = tt.emp_no
WHERE 
	e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY 
	e.emp_no;
	
SELECT * FROM retirement_titles LIMIT 10;	

-- Use Dictinct with Orderby to remove duplicate rows
SELECT 
	DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO 
	unique_titles
FROM 
	retirement_titles
WHERE 
	to_date = '9999-01-01'
ORDER BY 
	emp_no, 
	to_date DESC;
	
SELECT * FROM unique_titles LIMIT 10;

SELECT 
	COUNT(*),
	title
INTO 
	retiring_tables
FROM
	unique_titles 
GROUP BY 
	title
ORDER BY 
	COUNT(*) DESC;
	
SELECT * FROM retiring_tables;
