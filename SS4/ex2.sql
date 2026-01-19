use session4;

alter table ex1_students modify student_id varchar(10);

insert into ex1_students value 
('SV003', 'Nguyen Van A',   '2002-05-12', 'male',   'an.nguyen@gmail.com'),
('SV005', 'Tran Thi B',   '2003-08-20', 'female', 'binh.tran@gmail.com');
select * from ex1_students;

update ex1_students 
set gender = 'male' 
where student_id = 'SV005';
select * from ex1_students;

delete from ex1_students where student_id = 'SV003';
select * from ex1_students;