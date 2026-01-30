use session11; 

drop table if exists transactions;
create table transactions(
	transaction_id int auto_increment primary key,
    acc_id int,
    amount decimal(15,2),
    log_message varchar(100),
    transaction_date datetime default now(),
    foreign key (acc_id) references accounts(id)
);

drop procedure if exists deposit_with_logging;
delimiter //
create procedure deposit_with_logging(
	in p_acc_id int,
    in p_amount decimal(15,2)
)
begin
	-- khai báo biến xử lý lỗi
    declare exit handler for sqlexception
    begin
		rollback;
        select 'đã xảy ra lỗi hệ thống ! vui lòng thử lại sau' as message;
    end;
    
	start transaction;
		-- cộng tiền
		update accounts set balance = balance + p_amount where id = p_acc_id;
        -- ghi log
		insert into transactions(acc_id,amount,log_message) values
		(p_acc_id, p_amount, 'nạp tiền thành công');
    commit;
    select 'nạp tiền thành công' as message;
end //
delimiter ;

select * from accounts;
select * from transactions;
-- trường hợp nạp tiền thành công
call deposit_with_logging(1,100);

-- trường hợp nạp tiền không thành công
call deposit_with_logging(100,100);