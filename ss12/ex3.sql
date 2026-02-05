use session12;

CREATE TABLE order_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    old_status ENUM('Pending', 'Completed', 'Cancelled'),
    new_status ENUM('Pending', 'Completed', 'Cancelled'),
    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

-- 1) Tạo bảng và Trigger BEFORE INSERT:
drop trigger if exists before_insert_check_payment;
delimiter //
create trigger before_insert_check_payment before insert 
on payments for each row
begin
	declare v_total_amount decimal(10,2);
    declare v_status varchar(50);
    select total_amount, status into v_total_amount, v_status from orders where order_id = new.order_id;
    
    if new.amount <> v_total_amount then 
		signal sqlstate '45000' set message_text = 'số tiền thanh toán không khớp';
	end if;
end //
delimiter ;
-- test insert payments, amount không đủ
insert into payments (order_id, amount, payment_method) values 
(4,1,'PayPal');
-- test insert payments, amount khớp
insert into payments (order_id, amount, payment_method) values 
(4,10500000.00,'PayPal');

-- 2) Tạo Trigger AFTER UPDATE:
drop trigger if exists after_update_order_status;
delimiter //
create trigger after_update_order_status after update
on orders for each row
begin
	if new.status <> old.status then 
		insert into order_logs(order_id, old_status, new_status) values
        (new.order_id, old.status, new.status);
	end if;
end //
delimiter ;
-- test update status orders
update orders set status = 'Completed' where order_id = 1;
select * from order_logs;

-- 3) Viết Stored Procedure:
drop procedure if exists sp_update_order_status_with_payment;
delimiter //
create procedure sp_update_order_status_with_payment(
	in p_order_id int,
    in p_new_status varchar(50),
    in p_payment_amount decimal(10,2),
    in p_payment_method varchar(50) 
)
main : begin
	declare v_status varchar(50);
    
	-- xử lý lỗi bất ngờ
    declare exit handler for sqlexception
    begin
		rollback;
        select 'lỗi hệ thống !' as message;
    end;
    
    select status into v_status from orders where order_id = p_order_id;
    
    start transaction;
    -- Kiểm tra trạng thái đơn hàng. Nếu trạng thái đã giống với new_status, ROLLBACK và thông báo lỗi.
    if v_status = p_new_status then
		rollback;
        select 'trạng thái trùng. Cập nhật không thành công' as message;
        leave main;
	end if;
    
    -- Nếu new_status là 'Completed', thực hiện: Thêm bản ghi thanh toán vào bảng payments
    if p_new_status = 'Completed' then
		insert into payments (order_id, amount, payment_method, status) values 
        (p_order_id, p_payment_amount,p_payment_method,p_new_status);
	end if;
    
    -- Cập nhật trạng thái đơn hàng trong bảng orders
    update orders set status = p_new_status where order_id = p_order_id;
    
    commit;
    
    select 'update thành công' as message;
    
end // 
delimiter ;
-- test amount không khớp
call sp_update_order_status_with_payment(1, 'Pending', 123456789,'Credit Card');
-- test trường hợp status trùng
call sp_update_order_status_with_payment(2, 'Pending', 28000000.00,'Bank Transfer');
-- test cập nhật thành công
call sp_update_order_status_with_payment(2, 'Completed', 28000000.00,'Bank Transfer');