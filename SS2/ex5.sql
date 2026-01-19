use session2;

create table ex5_classes(
	classID int primary key,
    className varchar(10) not null,
    startYear year not null,
    endYear year not null,
    check (endYear > startYear)
);

create table ex5_students(
	studentID int primary key,
    fullname varchar(100) not null,
    birthday date,
    sex binary,
    classID int,
    constraint FK_student_class
    foreign key (classID) references ex5_classes(classID)
);

