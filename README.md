# Analysis Report Prepared for Pewlett Hackard
It has come to the attention of Pewlett Hackard executives that many baby boomers are retiring at a rapid rate. Bobby has been tasked to find out who many employees will be eligible for retirement in the next few years and which employees will be eligible to act as mentors to help prepare younger employees in their respective deparment for career advancement. 

## Overview
This analysis has 2 main objectives:

1) How many employees will be ready to retire in the next 3 years?
2) Which employees are eligible to be part of the mentorship to prepare them as the next generation to take on these senior roles?

Pewlett Hackard (PH) is a huge company with a very large employee database.  Before we go over the results, please refer the the following ERD where we can see all of the currently existing tables and their relationships to one another.

<img src="./analysis/EmployeeDB.png" alt="ER Diagram" height="600" width="500"/>

In the ERD, we can easily see that the employees are the main table used to track every employee that is or has worked at PH. Each employee has 1 or more titles and 1 or more salaries over the years.  Titles and Salaries are kept in separate tables referencing the employees and dates that each employee had that Title and/or Salary.

As an employees of the company, the Managers table connects each manager with its respective employee record in a one-to-one relationship.  Similarly, each manager is connected to its respective department record which is also a one-to-one relationship for a specific date range. In other words, a manager can only be associated with one department at any given point in time.  There could be cases where a manager has worked for more than one department over the course of their career but they will only be associated with one of the them depending depending on the date being used to query for the manager's department info.

Finally, the Dept-Emp table is a cross reference table between Employees and Departments.  Since there is a many-to-many relationship between Employees and Departments, this cross reference table creates a one-to-many relationship from Dept-Emp to Employees via the emp_no and dept_no such that one employee will have several records in the Dept-Emp table... (TODO: See questions in slack to confirm these relationships.) 

## Results
TODO: Provide a bulleted list with four major points from the two analysis deliverables. Use images as support where needed.



## Summary
TODO: Provide high-level responses to the following questions, then provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami."

### How many roles will need to be filled as the "silver tsunami" begins to make an impact?
TODO: answer q

### Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
TODO: answer q

