use session8;

delimiter //
create procedure sp_check_employee_income(in employees_name varchar(255), in salary decimal(10,2))
begin
	if salary > 300 then
    select employees_name, salary, 'Thu nhập cao' as result;
    elseif salary > 200 and salary <350 then
    select employees_name, salary, 'thu nhập trung bình' as result ;
    else select employees_name, salary, 'thu nhập thấp' as result;
    end if ;
end;
// delimiter ;

call sp_check_employee_income('Nguyễn Văn A',500);

