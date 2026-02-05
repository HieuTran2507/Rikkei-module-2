use session12;

-- 1. Bảng departments (Phòng ban)
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(255) NOT NULL
);

-- 2. Bảng employees (Nhân viên)
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    hire_date DATE NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE CASCADE
);

-- 3. Bảng attendance (Chấm công)
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    check_in_time DATETIME NOT NULL,
    check_out_time DATETIME,
    total_hours DECIMAL(5,2),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

-- 4. Bảng salaries (Bảng lương)
CREATE TABLE salaries (
    employee_id INT PRIMARY KEY,
    base_salary DECIMAL(10,2) NOT NULL,
    bonus DECIMAL(10,2) DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

-- 5. Bảng salary_history (Lịch sử lương)
CREATE TABLE salary_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reason TEXT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

INSERT INTO departments (department_name) VALUES 
('Phòng Hành chính Nhân sự'),
('Phòng Kỹ thuật'),
('Phòng Kinh doanh'),
('Phòng Marketing'),
('Phòng Kế toán');

INSERT INTO employees (name, email, phone, hire_date, department_id) VALUES 
('Nguyễn Văn A', 'nguyenvana@company.com', '0901234567', '2023-01-15', 1),
('Trần Thị B', 'tranthib@company.com', '0912345678', '2023-03-10', 2),
('Lê Văn C', 'levanc@company.com', '0923456789', '2023-06-20', 2),
('Phạm Thị D', 'phamthid@company.com', '0934567890', '2024-01-05', 3),
('Hoàng Văn E', 'hoangvane@company.com', '0945678901', '2024-02-15', 4);

INSERT INTO attendance (employee_id, check_in_time, check_out_time, total_hours) VALUES 
(1, '2024-02-01 08:00:00', '2024-02-01 17:00:00', 8.5),
(2, '2024-02-01 08:15:00', '2024-02-01 17:30:00', 8.25),
(3, '2024-02-01 07:55:00', '2024-02-01 17:05:00', 8.6),
(4, '2024-02-01 08:30:00', '2024-02-01 18:00:00', 8.5),
(5, '2024-02-01 08:00:00', '2024-02-01 17:00:00', 8.0);

INSERT INTO salaries (employee_id, base_salary, bonus) VALUES 
(1, 15000000.00, 1000000.00),
(2, 20000000.00, 2500000.00),
(3, 18000000.00, 1500000.00),
(4, 12000000.00, 5000000.00),
(5, 14000000.00, 2000000.00);

INSERT INTO salary_history (employee_id, old_salary, new_salary, reason) VALUES 
(1, 13000000.00, 15000000.00, 'Tăng lương định kỳ sau 1 năm'),
(2, 18000000.00, 20000000.00, 'Thăng tiến lên vị trí Team Lead'),
(3, 17000000.00, 18000000.00, 'Điều chỉnh lương theo thị trường');

-- 1) Tạo Trigger kiểm tra địa chỉ email của nhân viên mới. 
-- Nếu email không có đuôi @company.com, Trigger sẽ tự động thêm đuôi này vào.
drop trigger if exists trig_check_mail;
delimiter //
create trigger trig_check_mail before insert 
on employees for each row 
begin 
	if new.email not like '%@company.com' then 
		set new.email = concat(substring_index(new.email,'@',1), '@company.com');
	end if;
end //
delimiter ;
-- test email không có @company.com
INSERT INTO employees (name, email, phone, hire_date, department_id) VALUES 
('tran tuan hieu', 'tth@gmail.com', '0901234567', '2023-01-15', 1);
select * from employees;

-- 2) Tạo Trigger tự động tạo bản ghi lương cơ bản trong bảng salaries sau khi một nhân viên mới được thêm vào. 
-- Mức lương mặc định là 10,000.00 và không có thưởng.
drop trigger if exists trig_base_salary;
delimiter //
create trigger trig_base_salary after insert 
on employees for each row
begin 
	insert into salaries(employee_id,base_salary) value
    (new.employee_id, 10000000);
end //
delimiter ;
-- test thêm nhân viên mới và xem bảng lương
INSERT INTO employees (name, email, phone, hire_date, department_id) VALUES 
('tran van hun', 'tranvanhung@gmail.com', '0901234567', '2023-01-15', 1);
select * from employees;
select * from salaries;

-- 3) Tạo Trigger tự động tính toán tổng số giờ làm (total_hours) 
-- dựa trên thời gian check-in và check-out khi cột check_out_time được cập nhật.
drop trigger if exists trig_total_hours;
delimiter //
create trigger trig_total_hours before update 
on attendance for each row
begin 
	if not old.check_out_time <=> new.check_out_time and new.check_out_time > old.check_in_time then
		set new.total_hours = timestampdiff(minute, old.check_in_time, new.check_out_time)/60;
	end if;
end // 
delimiter ;
-- test update giờ check out, kiểm tra total hour có thay đổi không
update attendance set check_out_time = '2024-02-01 16:00:00' where employee_id = 1;
select * from attendance;

