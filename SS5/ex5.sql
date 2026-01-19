use session5;

create table ex5_students(
	student_id varchar(5) primary key,
    student_name varchar(50) not null
);

create table ex5_scores(
	student_id varchar(5),
    subject_name varchar(50),
    score decimal(3,2) not null,
    constraint fk_ex5_1
		foreign key (student_id) references ex5_students(student_id)
);

INSERT INTO ex5_students (student_id, student_name) VALUES
('S001', 'Nguyen An'),
('S002', 'Tran Binh'),
('S003', 'Le Anh'),
('S004', 'Pham Hoa'),
('S005', 'Vo Minh');

INSERT INTO ex5_scores (student_id, subject_name, score) VALUES
-- S001 (TB ≈ 8.0)
('S001', 'Math',     8.5),
('S001', 'Physics',  7.5),
('S001', 'English',  8.0),

-- S002 (TB ≈ 6.5)
('S002', 'Math',     6.0),
('S002', 'Physics',  6.5),
('S002', 'English',  7.0),

-- S003 (TB ≈ 9.0) → cao nhất
('S003', 'Math',     9.5),
('S003', 'Physics',  8.5),
('S003', 'English',  9.0),

-- S004 (TB ≈ 7.0)
('S004', 'Math',     7.0),
('S004', 'Physics',  7.0),
('S004', 'English',  7.0),

-- S005 (TB ≈ 5.5)
('S005', 'Math',     5.0),
('S005', 'Physics',  5.5),
('S005', 'English',  6.0);

# Tính điểm trung bình của mỗi sinh viên
select 
	st.student_id,
    st.student_name,
	avg(s.score) as 'average score'
from ex5_students st 
inner join ex5_scores s 
on st.student_id = s.student_id
group by student_id;

# Chỉ hiển thị các sinh viên có: điểm trung bình ≥ 7.0
select 
	st.student_id,
    st.student_name,
	avg(s.score) as 'average score'
from ex5_students st 
inner join ex5_scores s 
on st.student_id = s.student_id
group by student_id
having avg(s.score) >= 7;

# Hiển thị sinh viên có: điểm trung bình cao nhất trong toàn bộ danh sách
select 
	st.student_id,
    st.student_name,
	avg(s.score) as 'average score'
from ex5_students st 
inner join ex5_scores s 
on st.student_id = s.student_id
group by student_id
order by avg(s.score) DESC
limit 1;

# Hiển thị các sinh viên có: điểm trung bình cao hơn điểm trung bình chung của tất cả sinh viên
select avg(score) from ex5_scores; # điểm trung bình tất cả = 7.2
select 
	st.student_id,
    st.student_name,
	avg(s.score) as 'average score'
from ex5_students st 
inner join ex5_scores s 
on st.student_id = s.student_id
group by student_id
having avg(s.score) > (
	select avg(score) from ex5_scores
);


	
	