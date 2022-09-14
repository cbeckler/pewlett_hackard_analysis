-- retiring employees pcts
SELECT 
	r.count, 
	ROUND(r.count/(SELECT SUM(r.count) FROM retiring_tables r)*100, 1) AS pct, 
	title 
FROM 
	retiring_tables r
ORDER BY 
	title DESC;	

-- mentorship employees pcts
WITH x AS
(SELECT
	COUNT(*) AS m_count, 
	title 
FROM 
	mentorship_eligibility
GROUP BY 
	title)
SELECT
	m_count,
	ROUND(m_count/(SELECT SUM(m_count) FROM x)*100, 1) AS pct,
	title 
FROM 
	x
ORDER BY 
	title DESC;
	
SELECT 
	COUNT(DISTINCT e.emp_no)
FROM 
	employees e
INNER JOIN 
	dept_emp d 
ON 
	e.emp_no = d.emp_no
INNER JOIN 
	titles tt 
ON 
	e.emp_no = tt.emp_no
WHERE 
	(d.to_date = '9999-01-01') 
AND 
	(e.birth_date BETWEEN '1962-01-01' AND '1965-12-31');