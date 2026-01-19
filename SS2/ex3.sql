use session2;

create table ex3_students_constraint(
	MSSv int primary key,
    fullname varchar(100) not null,
    email varchar(150) unique,
    age int check(age >=18)
);