-----------------------------------------------------------
-- *** Code for Deliverable 1
-----------------------------------------------------------

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

-----------------------------------------------------------
-- *** Code for Deliverable 2
-----------------------------------------------------------

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

-----------------------------------------------------------
-- *** Code for Deliverable 3
-----------------------------------------------------------

--*********************************************
-- Queries for images shown in Results Section
--*

-- 1st img with duplicate employees
select * from retirement_titles;

-- 2nd img w/o duplicate employees
select * from unique_titles;

-- 3rd img shows the number of roles opening up
select * from retiring_titles;

-- 4th img shows small pool of mentees
select * from mentorship_eligibility;

--*********************************************
-- Queries for images shown in Summary Section
--*

-- 1st img shows number of roles opening up
select * from retiring_titles;

-- 2nd img shows larger pool of mentees
-- Expand the mentorship eligibility requirements to retrieve
-- enough employees to fill the roles of potential retirees.

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name, 
	e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	de.dept_no,
	t.title
INTO expanded_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (t.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1961-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

select * from expanded_eligibility;


-- Before performing the final query for display, the
-- following code was used to create 2 additional tables to
-- hold employee info for employees with senior titles in one
-- one table and employee info with junior titles in the other. 

----------------------------------------------------------------------
-- We want to find a list of employees that are near retirement that
-- currently have a "Senior" title. These employees will be the first
-- ones to be contacted to enter the mentorship program as Mentors.
--
-- Note the following:
--
-- mr = Mentor
--
-- unique_titles contains a unique list of employees along with
-- their current title who are about to retire.
--
-- retiring_sr_mentors will be asked to join the first wave of mentors.
----------------------------------------------------------------------
SELECT de.dept_no,
	e.birth_date,
	mr.title,
	e.emp_no,
	e.first_name,
	e.last_name
INTO retiring_sr_mentors
FROM unique_titles AS mr,
	employees AS e,
	dept_emp AS de
WHERE mr.title IN ('Senior Engineer', 'Senior Staff', 'Manager', 'Technique Leader')
AND mr.emp_no = e.emp_no
AND de.emp_no = e.emp_no
AND de.to_date = '9999-01-01'
ORDER BY de.dept_no, e.birth_date, mr.title;

SELECT * from retiring_sr_mentors;

----------------------------------------------------------------------
-- Next we want to find a list of employees that are near retirement that
-- currently have a "Junior" title. These employees will be the first
-- ones to be contacted to enter the mentorship program as Mentees.
--
-- This is for employees that may be eligible for retirement but are
-- willing and able to take on a more senior role before doing so.
--
-- Note the following:
--
-- me = Mentee
--
-- unique_titles contains a unique list of employees along with
-- their current title who are about to retire.
--
-- retiring_jr_mentees will be asked to join the first wave of mentees.
----------------------------------------------------------------------
SELECT de.dept_no,
	e.birth_date,
	me.title,
	e.emp_no,
	e.first_name,
	e.last_name
INTO retiring_jr_mentees
FROM unique_titles AS me,
	employees AS e,
	dept_emp AS de
WHERE me.title IN ('Engineer', 'Assistant Engineer', 'Staff')
AND me.emp_no = e.emp_no
AND de.emp_no = e.emp_no
AND de.to_date = '9999-01-01'
ORDER BY de.dept_no, e.birth_date, me.title;

SELECT * from retiring_jr_mentees;

-- 3rd img shows junior level titles about to retire

-------------------------------------------------------------------------
-- Find all employees with junior roles that are eligible for retirement.
--
-- These employees may be interested in becoming a mentee vs mentor
-- in the mentorship program if they are not ready to retire and are
-- able and willing to advance.
--
-- In order to show a more varied sampling, we selected a small set of
-- random birthdates.
-------------------------------------------------------------------------
SELECT * 
FROM retiring_jr_mentees 
WHERE birth_date IN ('1952-01-05', '1953-02-05', '1954-03-05', '1955-04-05');


----------------------------------------------------------------------
-- The following queries will attempt to show how HR can match a group
-- employees with a role of 'Senior Engineer' with a group of employees
-- that are in the pool of eligible mentees created and and stored 
-- previously in the expanded_eligibilty table.
----------------------------------------------------------------------

-- 4th img shows possible mentors with a title of 'Senior Engineer'

----------------------------------------------------------------------
-- First, we will find the mentors that will be eligible first based
-- on birthdate. These mentors will come from the retiring_sr_mentors 
-- table and we will narrow our selection to only choose those with a 
-- title of 'Senior Engineer' in department and a birthdate between 
-- '1952-01-01' and'1952-02-02'.
----------------------------------------------------------------------
SELECT *
FROM retiring_sr_mentors
WHERE title = 'Senior Engineer'
AND (birth_date BETWEEN '1952-01-01' AND '1952-02-02')
ORDER BY dept_no, birth_date, emp_no;

-- 5th img shows possible mentees with a title of simply 'Engineer'

----------------------------------------------------------------------
-- Next, we will search the expanded_eligibilty table to find mentees 
-- to match with the Senior Engineers found above.
--
-- In this query, we will limit the pool to a similar size as the pool
-- for Senior Engineers. Here, we are only choosing employees born 
-- between '1961-01-01' and '1961-01-04'.
----------------------------------------------------------------------
SELECT dept_no,
	birth_date,
	title,
	emp_no,
	first_name,
	last_name
FROM expanded_eligibility
WHERE title = 'Engineer'
AND (birth_date BETWEEN '1961-01-01' AND '1961-01-04')
ORDER BY dept_no, birth_date;
