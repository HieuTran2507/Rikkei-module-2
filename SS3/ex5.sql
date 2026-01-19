use session3;

create table ex5_teachers(
	teacherID int primary key,
    teacherName varchar(100) not null,
    teacherEmail varchar(100) unique
);

create table ex5_students(
	studentID int primary key,
    studentName varchar(100) not null,
    studentEmail varchar(100) unique
);

create table ex5_courses(
	courseID int primary key,
    teacherID int not null,
    courseName varchar(50) not null,
    courseDescription varchar(200),
    courseFee decimal(10,2),
    constraint FK_ex5_1
		foreign key (teacherID) references ex5_teachers(teacherID)
);

create table ex5_enrollments(
	studentID int not null,
    courseID int not null,
    enrollmentDate date,
    enrollmentStatus varchar(6) default 'UNPAID',
    check (enrollmentStatus = 'PAID' or enrollmentStatus = 'UNPAID'),
    primary key (studentID,courseID),
    constraint FK_ex5_2
		foreign key (studentID) references ex5_students(studentID),
	constraint FK_ex5_3
		foreign key (courseID) references ex5_courses(courseID)
);

alter table ex5_courses 
modify courseFee decimal(10,2) check(courseFee>0);

drop table ex5_enrollments;

