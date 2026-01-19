use session4;

select * from ex1_students where email is null;
select * from ex1_students where email is not null;

select * from ex1_students where full_name like 'Ng%';

select * from ex1_students where gender <> 'male';