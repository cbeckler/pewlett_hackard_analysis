# Employee Databases with PostgreSQL

## Overview of Project

### Purpose

The executive team at tech company Pewlett Hackard were concerned about the number of their employees up for retirement soon, and asked the analyst to use SQL to assess the number of employees retiring by job title to estimate impact to professional sectors, and to identify slightly younger employees who may be eligible to participate in a mentorship program to train new employees to replace them after they retire. It is hoped that this data can help the company prepare to manage the "silver tsunami" as their core workforce ages out of employment age.

### Results

The results of the potential employees retiring by title are below:

![Number of Employees Retiring by Title](https://github.com/cbeckler/pewlett_hackard_analysis/blob/main/Resources/title_count.png)

* Unsurprisingly, senior level positions are taking the biggest hit, with nearly 70% of all retirement eligible employees being either Senior Engineers or Senior Staff.
* The amount of retirement eligible employees was roughly equal between engineering and regular staff, indicating that both classes of employee will need to have significant investment in turnover management.

A table was made to identify employees who may be eligible for the proposed mentorship program. While the retirement eligible employees were born between 1952 and 1955, the employees eligible for the pilot mentorship program were born only in 1965. The code used to create the table may be found [here](https://github.com/cbeckler/pewlett_hackard_analysis/blob/main/Queries/Employee_Database_challenge.sql), and a screenshot of the first few rows of the table are below:

![Mentorship Table](https://github.com/cbeckler/pewlett_hackard_analysis/blob/main/Resources/mentorship_eligibility.png)

* There were 1,549 employees potentially eligible for this program. 
* Both engineering and regular staff employees were present in the sample. For further analysis of this, see the following summary section.

## Summary

The total number of all employees potentially retiring from the title analysis is 72,448, indicating that over 70,000 roles may need to be filled in the near future. As stated above, the total number of employees eligible for the proposed mentorship program is only 1,549. While there is a decent sized pool of employees who may be able to join the program, they are vastly outnumbered by the employees who may be retiring imminently. It is unlikely that there will be enough mentor employees to solve the retirement crisis under current criteria.

The analyst performed two exploratory analyses to investigate further.

First, a comparision of the percent of employees by titles for both groups was performed using the following method:

```
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
```

The results: 

![Title comparision](https://github.com/cbeckler/pewlett_hackard_analysis/blob/main/Resources/title_comparison.png)

For staff, the proportion of employees eligible for the mentorship program by title is rougly equal to the proportions of the pool of potential retirees. However, there is a large difference in proportion in engineering, with 35.8% of the retiring employees being Senior Engineers and only 10.9% of mentorship eligible employees having that title. The difference is reversed at the lower Engineering title, indicating that there will be a critcial need to get Senior Engineers into the mentorship program as the older workforce retires, potentially as Engineers promote to Senior Engineers.

Second, the problem of unequal numbers of retirees versus mentors was explored. The retiree pool was chosen with a four year selection criteria, between 1952 and 1955, while the mentorship program had only one year for eligibility, 1965. To see if the total number of employees eligible for the program would be closer to the number of employees potentially retiring if the selection criteria for the mentorship program covered the same span of time, a count of employees was taken from 1962 to 1965, using the same selection criteria as the previous mentorship table for all other filters and joins: 

```
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
 ```
 The number of potentially eligible employees this returned was **56,859**.
 
 This closes the gap between the number of retiring and mentorship program-eligible employees considerably. While it would likely be good to pilot the mentorship program using only the 1965 selection criteria, if the pilot is successful, the analyst would recommend broadening the birth year criteria for eligibility as a longer-term solution to the retirement crisis.
