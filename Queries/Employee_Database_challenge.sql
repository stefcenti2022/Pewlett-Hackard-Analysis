
-- *** Code for Deliverable 1

-- *** STEPS 1-7

-- Retrieve the emp_no, first_name, and last_name columns 
-- from the Employees table.
SELECT 
	e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM titles AS t
JOIN employees AS e
ON (t.emp_no = e.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles LIMIT 20;

-- *** STEPS 8 - 15
-- Create a Table of Unique Titles

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no ASC, rt.to_date DESC;

SELECT * FROM unique_titles;

-- *** STEPS 16 - 22 to complete Deliverable 1
-- Retrieve the number of employees who are about to retire
-- by their most recent job title.

SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY count DESC;

SELECT * FROM retiring_titles;

-- *** Code for Deliverable 2

-- *** STEPS 1 - 9

-- Retrieve the emp_no, first_name, last_name, and 
-- birth_date columns from the Employees table.
-- Retrieve the from_date and to_date columns 
-- from the Department Employee table.
-- Retrieve the title column from the Titles table.

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name, 
	e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (t.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibility;


