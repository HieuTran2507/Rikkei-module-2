use session4;

INSERT INTO ex1_students (student_id, full_name, birth_date, gender, email)
VALUES
('SV001',  'Do Thanh Long',    '2003-01-08', 'male',   'long.do@gmail.com'),
('SV002',  'Hoang Mai Anh',    '2004-03-19', 'female', 'anh.hoang@gmail.com'),
('SV004',  'Bui Tien Dat',     '2005-11-27', 'male',   'dat.bui@gmail.com'),
('SV006',  'Ngo Phuong Thao',  '2003-07-02', 'female', 'thao.ngo@gmail.com'),
('SV007', 'Dang Quoc Bao',    '2004-12-14', 'male',   'bao.dang@gmail.com');
select * from ex1_students;

select * from ex1_students where (year(birth_date) between 2003 and 2005);

select * from ex1_students where (gender = 'male');
select * from ex1_students where (gender = 'female');

select 
	student_id, 
    full_name,
    birth_date
from ex1_students;
