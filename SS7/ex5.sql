use session7;

alter table employees 
add column cmnd int;

create view v_employee_public as
select id, fullname, department from employees;

