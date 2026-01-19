use session4;

create table ex5_employees(
	emp_id varchar(5) primary key,
    full_name varchar(100) not null,
    birth_year year,
    department varchar(100),
    salary decimal(8,0),
    phone varchar(10)
);

INSERT INTO ex5_employees (emp_id, full_name, birth_year, department, salary, phone)
VALUES
('E001', 'Nguyen Van Anh', 1998, 'IT', 15000000, '0901234567'),
('E002', 'Tran Thi Mai',   1995, 'HR', 12000000, NULL),
('E003', 'Le Quoc Hung',   1997, 'IT', 22000000, '0912345678'),
('E004', 'Pham Minh Anh',  2000, 'Sales',  9000000, NULL),
('E005', 'Do Thanh Nam',   1999, 'HR', 18000000, '0923456789'),
('E006', 'Bui Van Long',   2001, 'IT',  4500000, '0934567890'),
('E007', 'Hoang Anh Tuan', 1996, 'Marketing', 8000000, NULL);

# Hiển thị danh sách nhân viên có mức lương từ 10.000.000 đến 20.000.000
select * from ex5_employees where salary between 10000000 and 20000000;

# Hiển thị nhân viên thuộc phòng ban IT hoặc HR
select * from ex5_employees where department = 'IT' or department = 'HR';

# Hiển thị nhân viên có họ tên chứa chữ “Anh”
select * from ex5_employees where full_name like '%Anh%'; 

# Hiển thị nhân viên chưa có số điện thoại
select * from ex5_employees where phone is null;

# Cập nhật lương tăng thêm 10% cho nhân viên phòng IT
select * from ex5_employees where department = 'IT';
update ex5_employees
set salary = salary*1.1
where department = 'IT'; 
select * from ex5_employees where department = 'IT';

# Cập nhật số điện thoại cho nhân viên chưa có số điện thoại
update ex5_employees
set phone = '0123456789'
where phone is null;
select * from ex5_employees;

# Xóa nhân viên có mức lương thấp hơn 5.000.000
delete from ex5_employees where salary <5000000;
select * from ex5_employees;


