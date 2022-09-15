# Analysis Report Prepared for Pewlett Hackard
It has come to the attention of Pewlett Hackard executives that many baby boomers are retiring at a rapid rate. Bobby has been tasked to find out who many employees will be eligible for retirement in the next few years and which employees will be eligible to act as mentors to help prepare younger employees in their respective deparment for career advancement. 

## Overview
This analysis has 2 main objectives:

1) How many employees will be ready to retire in the next 3 years?
2) Which employees are eligible to be part of the mentorship program to prepare them as the next generation to take on these senior roles?

Pewlett Hackard (PH) is a huge company with a very large employee database.  Before we go over the results, please refer the the following ERD where we can see all of the currently existing tables and their relationships to one another.

<img src="./Resources/ERD.png" alt="ER Diagram" height="600" width="500"/>

In the ERD, the all tables are connected to the employees table either directly or indirectly.  This is the main table of the employee database and contains all the identifying information of an employee with keys to access any additional information where the employee will have 1 or more records.  This table is used to track every employee that works at PH. 

Going counter clockwise starting from the employees table we can see that each employee has 1 or more titles and 1 or more salaries over the years.  Titles and Salaries are kept in separate tables referencing the employees and dates that each employee had a specific Title and/or Salary.

Next, the departments table contains all the dpartments of the complany by number and name. This table is connected to the 2 cross reference tables, dept_emp and dept_manager.

The dept_emp table is a cross reference table between Employees and Departments.  Since there is a many-to-many relationship between Employees and Departments, this cross reference table creates a one-to-one relationship between Departments and Employees via the emp_no and dept_no such that one employee will have one department based on the values in to_date and from_date fields that the employee worked in the specific department.

The dept_manager table is also a cross reference table between Employees and Departments. Similar to the the dept_emp table, this one also creates a one to one relationship between Employees and Departments, however, this one is for employees that are managers of the department vs. employees that are workers in the department.

## Results
Major takeaways from this analysis include the following:

- The first run through the data created a table of all the employees born between 1952 and 1955 for every role they held during their employment.  This list of employees turned out to have over 267.5K records as shown here:

<img src="./Resources/retirement_titles.png" alt="Titles by Employee" width="500"/>

- Since this list included every title for each employee, the search was narrowed down to only include employees and their current role. Even so, the potential number of roles that need to be filled over the next few years is quite staggaring. The following image shows each role and how many potential openings there are if everyone born between 1952 and 1955 were to retire:

<img src="./Resources/potential_retirees.png" alt="Potential Retirees" width="500"/>

- The number of roles to be filled by title are shown in the table below.

<img src="./Resources/retiring_titles.png" alt="Retiring Titles" width="500"/>

- The table of employees that are eligible for mentorship using the original birthdate of 1965 is shown below:

<img src="./Resources/mentorship_eligibility.png" alt="Mentorship Eligibility" width="500"/>

## Summary
TODO: Provide high-level responses to the following questions, then provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami."

### How many roles will need to be filled as the "silver tsunami" begins to make an impact?
TODO: answer q

### Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

The number of potential retirees compared to the number of employees that were born in 1965 is too great to expect the retiring roles of over 72.5K employees to be filled by just 1.5K employees.  In order to get a reasonable number of employees to fill these roles we needed to expand our search to include birthdates starting in 1961 through 1965. This new search gave us a total of a little over 75K employees that would be eligible for mentorship into the roles that will be opening up over the next few years.

<img src="./Resources/expanded_eligibility.png" alt="Expanded Eligibility" width="500"/>

