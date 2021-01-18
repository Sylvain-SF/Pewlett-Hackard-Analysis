-- Retrive desired columns from Employees and Titles tables:
SELECT
	e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ;

SELECT * FROM retirement_titles
LIMIT 10 ;

-- Use Dictinct with Orderby to remove duplicate rows:
SELECT DISTINCT ON (emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO unique_titles
FROM retirement_titles AS rt
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles
LIMIT 10 ;

-- Employees count by most recent job title who are about to retire:
SELECT COUNT(ut.emp_no), ut.title 
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY title
ORDER BY count DESC;

SELECT * FROM retiring_titles ;

-- Employees who are eligible to participate in a mentorship program:
DROP TABLE mentorship_eligibilty ;
SELECT DISTINCT ON (emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31' AND de.to_date = '9999-01-01')
ORDER BY emp_no ;

SELECT COUNT(emp_no),title
FROM mentorship_eligibilty
GROUP BY title
ORDER BY count ;

SELECT * FROM mentorship_eligibilty ;

--SELECT * FROM mentorship_eligibilty ;
--SELECT COUNT(emp_no), title 
--FROM mentorship_eligibilty
--GROUP BY title
--ORDER BY count DESC;
