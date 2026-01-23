use session8;

delimiter //
create procedure sp_classify_student(
	in p_score decimal(3,1),
	out p_rank varchar(10)
)
begin
	declare t_score decimal(3,1);
    set t_score = p_score;
    set p_rank = case 
		when t_score >= 8 then 'giỏi'
        when t_score >= 6.5 and t_score < 8 then 'khá'
        when t_score >= 5 and t_score < 6.5 then 'trung bình'
        when t_score < 5 then 'yếu'
	end;
end;
// delimiter ;

call sp_classify_student(4, @result);
select @result as `xếp loại`;





