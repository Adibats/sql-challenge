drop table if exists salaries;
drop table if exists dept_manager;
drop table if exists dept_emp;
drop table if exists employees;
drop table if exists titles;
drop table if exists departments;

create table departments(
dept_no varchar (255) primary key not null,
dept_name varchar(255) not null);

select * from departments;

create table titles(
title_id varchar(255) primary key not null,
title varchar(255) not null);

select * from titles;

create table employees(
emp_no int primary key not null,
emp_title_id varchar(255) not null,
birth_date date not null,
first_name varchar(255) not null,
last_name varchar(255) not null,
sex varchar(1) not null,
hire_date date not null,
foreign key (emp_title_id) references titles(title_id));

select * from employees;

create table dept_emp(
emp_no int not null,
dept_no varchar(255) not null,
foreign key (dept_no) references departments(dept_no),
foreign key (emp_no) references employees(emp_no));

select * from dept_emp;

create table dept_manager(
dept_no varchar(255) not null,
emp_no int primary key not null,
foreign key (dept_no) references departments(dept_no),
foreign key (emp_no) references employees(emp_no));

select * from dept_manager;

create table salaries(
emp_no int not null,
salary int not null,
foreign key (emp_no) references employees(emp_no));

select * from salaries;

select employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
from employees
left join salaries on
employees.emp_no=salaries.emp_no;

select first_name, last_name, hire_date
from employees
where date_part('year', hire_date)=1986;

select dept_manager.emp_no,dept_manager.dept_no, departments.dept_name, employees.first_name, employees.last_name
from dept_manager
left join departments on
dept_manager.dept_no=departments.dept_no
left join employees on
dept_manager.emp_no=employees.emp_no;

select employees.emp_no, employees.last_name,employees.first_name,departments.dept_no,departments.dept_name
from employees
left join dept_emp on
employees.emp_no=dept_emp.emp_no
right join departments on
dept_emp.dept_no=departments.dept_no;

select employees.first_name, employees.last_name, employees.sex
from employees
where first_name = 'Hercules' and starts_with(last_name,'B');

select employees.first_name, employees.last_name, employees.emp_no, departments.dept_name
from employees
left join dept_emp on
employees.emp_no=dept_emp.emp_no
left join departments on
dept_emp.dept_no=departments.dept_no
where dept_name='Sales';

select employees.first_name, employees.last_name, employees.emp_no, departments.dept_name
from employees
left join dept_emp on
employees.emp_no=dept_emp.emp_no
left join departments on
dept_emp.dept_no=departments.dept_no
where dept_name='Sales' or dept_name='Development';

select last_name, count(last_name)
from employees
group by last_name
order by count(last_name) desc;
