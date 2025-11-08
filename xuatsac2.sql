create table xuatsac2.departments
(
    dept_id   serial primary key,
    dept_name varchar(100)
);

create table xuatsac2.employees
(
    emp_id    serial primary key,
    emp_name  varchar(100),
    dept_id   int references xuatsac2.departments (dept_id),
    salary    numeric(10, 2),
    hire_date date
);

create table xuatsac2.projects
(
    project_id   serial primary key,
    project_name varchar(100),
    dept_in      int references xuatsac2.departments (dept_id)
);

insert into xuatsac2.departments (dept_name)
values ('HR'),
       ('IT'),
       ('Finance'),
       ('Marketing'),
       ('Sales'),
       ('Operations'),
       ('R&D'),
       ('Customer Service'),
       ('Legal'),
       ('Administration');

insert into xuatsac2.employees (emp_name, dept_id, salary, hire_date)
values ('Alice', 1, 60000, '2020-01-15'),
       ('Bob', 2, 75000, '2019-03-22'),
       ('Charlie', 3, 80000, '2018-07-30'),
       ('David', 4, 55000, '2021-11-05'),
       ('Eve', 4, 72000, '2017-09-12'),
       ('Frank', 6, 68000, '2020-06-18'),
       ('Grace', 7, 90000, '2016-02-25'),
       ('Heidi', 8, 62000, '2019-12-10'),
       ('Ivan', 9, 77000, '2018-04-14'),
       ('Judy', 10, 59000, '2021-08-03');

insert into xuatsac2.projects (project_name, dept_in)
values ('Project Alpha', 2),
       ('Project Beta', 3),
       ('Project Gamma', 4),
       ('Project Delta', 5),
       ('Project Epsilon', 6),
       ('Project Zeta', 7),
       ('Project Eta', 8),
       ('Project Theta', 9),
       ('Project Iota', 10),
       ('Project Kappa', 5);

-- Cau 1
select e.emp_name, d.dept_name, e.salary
from xuatsac2.employees e
         join xuatsac2.departments d on e.dept_id = d.dept_id;

-- Cau 2
select sum(e.salary)   as total_salary,
       avg(e.salary)   as average_salary,
       max(e.salary)   as highest_salary,
       min(e.salary)   as lowest_salary,
       count(e.emp_id) as employee_number
from xuatsac2.employees e;

-- Cau 3
select d.dept_id, d.dept_name, avg(e.salary) as average_salary
from xuatsac2.employees e
         join xuatsac2.departments d on e.dept_id = d.dept_id
group by d.dept_id
having avg(e.salary) > 70000;

-- Cau 4
select p.project_name, d.dept_name, e.emp_name
from xuatsac2.employees e
         join xuatsac2.departments d on e.dept_id = d.dept_id
         join xuatsac2.projects p on p.dept_in = d.dept_id;

-- Cau 5
select e.emp_name, d.dept_name, e.salary
from xuatsac2.employees e
         join xuatsac2.departments d on e.dept_id = d.dept_id
where e.salary = (select max(salary_emp)
                  from (select e.salary as salary_emp
                        from xuatsac2.employees e
                                 join xuatsac2.departments d on e.dept_id = d.dept_id));

-- Cau 6
select d.dept_id
from xuatsac2.employees e
         join xuatsac2.departments d on e.dept_id = d.dept_id
union
select d.dept_id
from xuatsac2.departments d
         join xuatsac2.projects p on dept_id = dept_in;

select d.dept_id
from xuatsac2.employees e
         join xuatsac2.departments d on e.dept_id = d.dept_id
intersect
select d.dept_id
from xuatsac2.departments d
         join xuatsac2.projects p on dept_id = dept_in;
