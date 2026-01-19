use session5;

create table ex2_employees(
	emp_id varchar(5) primary key,
    full_name varchar(100) not null,
    department varchar(20),
    salary int
);

INSERT INTO ex2_employees (emp_id, full_name, department, salary)
VALUES
-- Phòng IT (5 nhân viên, lương TB > 12tr)
('E001', 'Nguyen Van An',   'IT', 15000000),
('E002', 'Tran Thi Binh',   'IT', 14000000),
('E003', 'Le Quoc Hung',    'IT', 13000000),
('E004', 'Pham Minh Duc',   'IT', 16000000),
('E005', 'Hoang Tuan Anh',  'IT', 14500000),

-- Phòng HR (4 nhân viên, lương TB > 12tr)
('E006', 'Do Thi Lan',      'HR', 12000000),
('E007', 'Nguyen Thi Mai',  'HR', 13000000),
('E008', 'Tran Van Long',   'HR', 12500000),
('E009', 'Bui Minh Chau',   'HR', 14000000),

-- Phòng Sales (3 nhân viên, KHÔNG đủ >3)
('E010', 'Le Van Nam',      'Sales', 10000000),
('E011', 'Pham Thu Ha',     'Sales', 11000000),
('E012', 'Ngo Quang Huy',   'Sales', 9000000),

-- Phòng Admin (4 nhân viên, lương TB < 12tr)
('E013', 'Vu Thanh Tung',   'Admin', 8000000),
('E014', 'Pham Thi Hoa',    'Admin', 9000000),
('E015', 'Nguyen Minh Son', 'Admin', 10000000),
('E016', 'Tran Thi Nga',    'Admin', 11000000);

# Thống kê: mỗi phòng ban có bao nhiêu nhân viên
select 
department,
count(*) as 'number of employees'
from ex2_employees
group by department;

# Tính: mức lương trung bình của từng phòng ban
select 
department,
avg(salary) as 'average salary'
from ex2_employees
group by department;

# Chỉ hiển thị: các phòng ban có trên 3 nhân viên
select 
department,
count(*) as 'number of employees'
from ex2_employees
group by department
having count(*) >3;

# Chỉ hiển thị: các phòng ban có lương trung bình lớn hơn 12.000.000
select 
department, 
avg(salary) as 'average salary'
from ex2_employees 
group by department
having avg(salary) > 12000000;
