DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

CREATE TABLE employees (
  emp_no integer NOT NULL,
  birth_date date NOT NULL,
  first_name varchar(50) not null,
  last_name varchar(50) not null,
  gender varchar(50) not null,
  hire_date date not null
);

CREATE TABLE departments (
  dept_no varchar(50) NOT NULL,
  dept_name varchar(50) NOT NULL
);

CREATE TABLE dept_emp (
  emp_no integer NOT NULL,
  dept_no varchar(50) not null,
  from_date date not null,
  to_date date NOT NULL
);

CREATE TABLE dept_manager (
  dept_no varchar(50) not null,
  emp_no integer NOT NULL,
  from_date date not null,
  to_date date NOT NULL
);

CREATE TABLE salaries (
  emp_no integer NOT NULL,
  salary integer NOT NULL,
  from_date date NOT NULL,
  to_date date NOT NULL
);

CREATE TABLE titles (
  emp_no integer NOT NULL,
  title varchar(50) NOT NULL,
  from_date date NOT NULL,
  to_date date NOT NULL
);

select * from employees;
select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from salaries;
select * from titles;

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
select employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
from employees
inner join salaries on employees.emp_no = salaries.emp_no;
-- 2. List employees who were hired in 1986.
select employees.emp_no, employees.first_name, employees.last_name,
extract (year from hire_date) as year
from employees
where hire_date > '12/31/1985' and hire_date < '01/01/1987';
-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
select dm.dept_no, dm.emp_no, dm.from_date, dm.to_date, e.first_name, e.last_name,
    d.dept_name
from dept_manager as dm
join employees as e on dm.emp_no = e.emp_no
join departments as d on d.dept_no = dm.dept_no;
-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
join dept_emp as de on e.emp_no = de.emp_no
join departments as d on d.dept_no = de.dept_no;
-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
select employees.first_name, employees.last_name
from employees
where first_name = 'Hercules' and last_name like 'B%';
-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
join dept_emp as de on e.emp_no = de.emp_no
join departments as d on d.dept_no = de.dept_no
where d.dept_name = 'Sales';
-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
join dept_emp as de on e.emp_no = de.emp_no
join departments as d on d.dept_no = de.dept_no
where d.dept_name = 'Sales' or d.dept_name = 'Development';
-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name, count(last_name) as count_name
from employees
group by last_name
order by count_name desc;
