create schema session3;
use session3;
create table ex1_classes(
	classID int primary key,
    className varchar(5) not null,
    startYear year,
    endYear year,
    check (endYear >= startYear)
);

create table ex1_students(
	studentID int primary key,
    classID int not null,
    studentName varchar(100) not null,
    birthday date,
    sex binary,
    constraint FK_ex1
		foreign key (classID) 
        references ex1_classes(classID)
);