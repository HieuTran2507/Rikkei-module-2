create database session7;

use session7;

create table students(
	id int primary key,
    fullname varchar(255),
    birthYear year,
    class varchar(255),
    address varchar(255)
);

insert into students values
(1,'Nguyen Van An',2001,'CNTT1','Ho Chi Minh'),
(2,'Tran Thi Binh',2000,'CNTT1','Ha Noi'),
(3,'Le Minh Duc',2002,'CNTT2','Da Nang'),
(4,'Pham Thu Ha',2001,'CNTT2','Can Tho'),
(5,'Vo Quoc Huy',1999,'CNTT3','Binh Duong'),
(6,'Nguyen Thi Lan',2002,'CNTT3','Dong Nai'),
(7,'Tran Van Long',2000,'CNTT1','Ho Chi Minh'),
(8,'Le Thi Mai',2001,'CNTT2','Hai Phong');

create view v_student_basic as
select id, fullname, birthYear
from students;

select * from v_student_basic;
