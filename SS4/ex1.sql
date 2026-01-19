create schema session4;

use session4;

create table ex1_students(
	student_id int primary key,
    full_name varchar(100) not null,
    birth_date date not null,
    gender varchar(6) not null,
    email varchar(100),
    check(gender = 'male' or gender = 'female')
);

INSERT INTO ex1_students (student_id, full_name, birth_date, gender, email) VALUES
(1, 'Nguyen Van An',   '2002-05-12', 'male',   'an.nguyen@gmail.com'),
(2, 'Tran Thi Binh',   '2003-08-20', 'female', 'binh.tran@gmail.com'),
(3, 'Le Hoang Cuong',  '2001-11-03', 'male',   'cuong.le@gmail.com'),
(4, 'Pham Thi Dao',    '2002-02-15', 'female', 'dao.pham@gmail.com'),
(5, 'Vo Minh Duc',     '2003-09-30', 'male',   NULL);

select * from ex1_students;