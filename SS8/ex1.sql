create database session8;

use session8;

create table students(
	mssv int primary key,
    fullname varchar(255),
    class varchar(255),
    score decimal(3,1)
);

DELIMITER $$
CREATE PROCEDURE sp_get_all_students()
BEGIN
    SELECT * FROM student;
END ;
$$ DELIMITER ;

Call sp_get_all_students();