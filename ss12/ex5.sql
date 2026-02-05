use session12;

-- 1) Viết Stored Procedure IncreaseSalary 
drop procedure if exists increase_salary;
delimiter //
create procedure increase_salary(
	in p_emp_id int, 
    in p_new_salary decimal(10,2), 
    in p_reason text
)
main : begin
	declare v_old_salary decimal(10,2);
    
	-- xử lý lỗi bất ngờ 
    declare exit handler for sqlexception
    begin 
		rollback;
        select 'lỗi hệ thống' as message;
    end;
    
    start transaction;
    -- Kiểm tra sự tồn tại của nhân viên.
    if (select employee_id from employees where employee_id = p_emp_id) is null then 
		rollback;
        select 'nhân viên không tồn tại' as message;
        leave main;
	end if;
    
    -- Nếu nhân viên tồn tại,
    -- lấy lương cũ của nhân viên
    select base_salary into v_old_salary from salaries where employee_id = p_emp_id;
    -- cập nhật lương mới và 
    update salaries set base_salary = p_new_salary where employee_id = p_emp_id;
    -- lưu lại lịch sử lương. 
    insert into salary_history(employee_id,old_salary,new_salary,reason) value
    (p_emp_id, v_old_salary, p_new_salary, p_reason);
    
    commit;
    
    select 'update lương thành công' as message;
end //
delimiter ;
-- test nhân viên không tồn tại
call increase_salary(100, 54321, 'tang luong dinh ky');
-- test tăng lương thành công
call increase_salary(1, 54321, 'tang luong dinh ky');
select * from salary_history;

-- 2) Viết Stored Procedure DeleteEmployee
drop procedure if exists delete_employee;
delimiter //
create procedure delete_employee(in p_emp_id int)
main : begin
	-- xử lsy lỗi bất ngờ
    declare exit handler for sqlexception
    begin 
		rollback;
        select 'lỗi hệ thống' as message;
    end;
    
    start transaction;
    -- Kiểm tra sự tồn tại của nhân viên.
    if (select employee_id from employees where employee_id = p_emp_id) is null then
		rollback;
        select 'nhân viên không tồn tại' as message;
        leave main;
	end if;
    
    -- Nếu nhân viên tồn tại, thực hiện các câu lệnh DELETE để xóa nhân viên và lương của họ.
    delete from salaries where employee_id = p_emp_id;
    delete from attendance where employee_id = p_emp_id;
    delete from salary_history where employee_id = p_emp_id;
    delete from employees where employee_id = p_emp_id;
    
    commit;
    
    select 'xóa nhân viên thành công' as message;
end //
delimiter ;
-- test nhân viên không tồn tại
call delete_employee(100);
-- test xóa nhân viên thành công
call delete_employee(1);
select * from employees;
