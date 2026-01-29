use session10;

drop table if exists employees;
create table employees(
	id int auto_increment primary key,
    first_name varchar(50),
    last_name varchar(50),
    salary decimal(10,2),
    email varchar(100) unique, 
    phone_number varchar(15)
);

drop table if exists salary_log;
create table salary_log(
	log_id int auto_increment primary key,
    employee_id int,
	old_salary decimal(10,2),
    new_salary decimal(10,2),
    change_date datetime default current_timestamp,
    foreign key (employee_id) references employees(id)
);

insert into employees(first_name,last_name,salary,email,phone_number) values
('An', 'Nguyen', 1200.00, 'an.nguyen@company.com', '0901000001'),
('Binh', 'Tran', 1500.50, 'binh.tran@company.com', '0901000002'),
('Chi', 'Le', 1800.00, 'chi.le@company.com', '0901000003'),
('Dung', 'Pham', 2000.75, 'dung.pham@company.com', '0901000004'),
('Hanh', 'Vo', 950.00, 'hanh.vo@company.com', '0901000005'),
('Khanh', 'Do', 2200.00, 'khanh.do@company.com', '0901000006'),
('Linh', 'Hoang', 1700.25, 'linh.hoang@company.com', '0901000007'),
('Minh', 'Bui', 2500.00, 'minh.bui@company.com', '0901000008'),
('Nam', 'Dang', 1300.00, 'nam.dang@company.com', '0901000009'),
('Phuong', 'Huynh', 1600.00, 'phuong.huynh@company.com', '0901000010');

drop trigger if exists trg_after_update_salary;
delimiter //
create trigger trg_after_update_salary after update
on employees for each row
begin 
	insert into salary_log(employee_id,old_salary,new_salary,change_date) values
    (old.id, old.salary, new.salary, now());
end//
delimiter ;

update employees set salary = 123456 where id in (1,2,3,4,5,6);

select * from salary_log;

select * from employees;