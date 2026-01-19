create schema session5;

use session5;

create table ex1_students(
	student_id varchar(5) primary key,
    full_name varchar(100) not null,
    birth_year year,
    gender varchar(6),
    score decimal (3,2),
    check (gender = 'male' or gender = 'female')
);

INSERT INTO ex1_students (student_id, full_name, birth_year, gender, score)
VALUES
('S001', 'Nguyen van anh', 2003, 'male',   7.31),
('S002', 'Tran thi mai',   2004, 'female', 8.92),
('S003', 'Le quoc hung',   2002, 'male',   6.55),
('S004', 'Pham thu ha',    2005, 'female', 9.17),
('S005', 'Hoang minh duc', 2003, 'male',   5.15),
('S006', 'Do thi lan',     2004, 'female', 8.08);

# Hiển thị: mã sinh viên - họ tên (viết hoa toàn bộ)
select student_id, ucase(full_name) from ex1_students;

# Hiển thị: họ tên - số tuổi của sinh viên (dựa vào năm hiện tại)
select 
ucase(full_name),
year(curdate()) - birth_year as age
from ex1_students;

# Hiển thị: điểm trung bình được làm tròn 1 chữ số thập phân
select 
ucase(full_name),
round(score,1)
from ex1_students;

#Hiển thị: tổng số sinh viên - điểm cao nhất - điểm thấp nhất
select 
count(student_id) as 'number of students',
max(score) as 'highest score',
min(score) as 'lowest score'
from ex1_students;

