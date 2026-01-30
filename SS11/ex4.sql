use session11;

drop procedure if exists transfer_money;
delimiter //
create procedure transfer_money(
	in p_sender_id int,
    in p_reciever_id int,
    in p_amount decimal(15,2)
)
main: begin 
	-- biến lưu số tiền người gửi và người nhận
    declare v_balance_sender decimal(15,2);
    declare v_balance_reciever decimal(15,2);
    
	-- xử lý lỗi, rollback khi gặp lỗi bất ngờ
    declare exit handler for sqlexception
    begin
		rollback;
        select 'đã xảy ra lỗi hệ thống ! giao dịch không thành công' as message;
    end;
    
    start transaction;
		-- kiểm tra tài khoản không tồn tại
		if not exists(select * from accounts where id = p_sender_id) then
			rollback;
            select 'tài khoản người gửi không tồn tại, giao dịch không thành công' as message;
            leave main;
		end if;
        
        if not exists(select * from accounts where id = p_reciever_id) then
			rollback;
            select 'tài khoản người nhận không tồn tại, giao dịch không thành công' as message;
            leave main;
		end if;
        
		-- kiểm tra trùng người gửi và người nhận
        if p_sender_id = p_reciever_id then 
			rollback;
            select 'tài khoản gửi và tài khoản nhận trùng, giao dịch không thành công' as message;
            leave main;
		end if;
        
        -- kiểm tra ng gửi có đủ tiền không
        select balance into v_balance_sender from accounts where id = p_sender_id;
        if v_balance_sender < p_amount then
			rollback;
			select concat('tài khoản người gửi còn ', v_balance_sender, ' . Giao dịch không thành công.') as message;
            leave main;
        end if;
        
        -- trừ tiền người gửi
        update accounts set balance = balance - p_amount where id = p_sender_id;
        
        -- cộng tiền người nhận
        update accounts set balance = balance + p_amount where id = p_reciever_id;
        
        commit; 
        
        select 'giao dịch thành công' as message;
    
end//
delimiter ;

-- ngừi gửi và nhận trùng nhau
call transfer_money(1,1,10);
-- tài khoản không đủ tiền
call transfer_money(1,2,10000000);
-- tài khoản không tồn tại
call transfer_money(2,100,10);
-- giao dịch thành công
call transfer_money(2,1,10);

select * from accounts;