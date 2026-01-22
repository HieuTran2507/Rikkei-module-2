use session7;

create table employees(
 id int primary key,
 fullname varchar(255),
 department varchar(255),
 salary decimal(10,2)
);

create index idx_department
on employees(department);

explain 
select * from employees where department = 'IT';

drop index idx_department on employees;

explain analyze
select * from employees where department = 'IT';