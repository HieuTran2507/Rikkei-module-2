use session11;

drop procedure if exists withdraw_money;
delimiter //
create procedure withdraw_money(
	in p_acc_id int,
    in P_amount decimal(15,2)
)
begin
	declare v_balance decimal(15,2);
    
	start transaction;
    update accounts set balance = balance - p_amount where id = p_acc_id;
    
    select balance into v_balance from accounts where id = p_acc_id;
    
    if v_balance >= 0 then 
		commit;
        select 'chuyển tiền thành công' as message;
    else 
		rollback;
        select 'số dư không đủ, chuyển tiền không thành công' as message;
    end if;
end// 
delimiter ;
select * from accounts;

-- chuyển tiền thất bại
call withdraw_money(1,1000000000000);
select * from accounts where id = 1;
-- chuyển tiền thành công 
call withdraw_money(1,10);
select * from accounts where id = 1;

