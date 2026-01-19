create schema session2;

use session2;

create table ex1_student(
	MSSV int primary key,
    fullname varchar(100),
    birthday date,
    sex binary
);