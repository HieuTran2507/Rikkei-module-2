use session8;

create table employees(
	id int primary key,
    fullname varchar(255),
    salary decimal(10,2)
);

insert into employees value 
(1, 'tên nhân viên 1', 111),
(2, 'tên nhân viên 2', 222),
(3, 'tên nhân viên 3', 333),
(4, 'tên nhân viên 4', 444);

delimiter $$
create procedure sp_get_avg_salary()
begin
	declare avg_salary decimal(19,2) default 0;
	select avg(salary) into avg_salary from employees;
    select avg_salary;
end;
$$ delimiter ;
call sp_get_avg_salary();

