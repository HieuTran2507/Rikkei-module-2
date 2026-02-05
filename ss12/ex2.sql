use session12;

-- 1) Stored Procedure sp_create_order
drop procedure if exists sp_create_order;
delimiter //
create procedure sp_create_order(
	in p_customer_id int,
    in P_product_id int,
    in P_quantity int,
    in P_price decimal(10,2) 
)
main : begin
	declare v_stock int;
    declare v_order_id int;
    
	-- xử lý lỗi đột ngột
    declare exit handler for sqlexception
    begin
		rollback;
        select 'lỗi hệ thống' as message;
    end;
    
    select stock_quantity into v_stock from inventory where product_id = p_product_id;
    
    start transaction;
    -- kiểm tra sản phẩm không tồn tại
    if v_stock is null then
		rollback;
        select 'sản phẩm không tồn tại' as messaage;
		leave main;
	end if;
    
    -- Kiểm tra số lượng tồn kho. 
    if v_stock < p_quantity then
		rollback;
        select concat('số lượng tồn kho còn ' ,v_stock, '. Đặt hàng không thành công') as message;
        leave main;
	end if;
    
    -- Thêm một đơn hàng mới vào bảng orders.
    insert into orders(customer_id,total_amount) values
    (p_customer_id, p_quantity*p_price);
    
    -- Lấy order_id vừa tạo bằng LAST_INSERT_ID().
    set v_order_id = last_insert_id();
    
    -- Thêm sản phẩm vào bảng order_items.
    insert into order_items(order_id, product_id, quantity, price) values
    (v_order_id, p_product_id, p_quantity, p_price);
    
    -- Cập nhật (giảm) số lượng tồn kho trong bảng inventory.
    update inventory set stock_quantity  = stock_quantity - p_quantity where product_id = p_product_id;
    
    commit;
    
    select 'đặt hàng thành công' as message;
    
end// 
delimiter ;
-- test lỗi sản phẩm không tồn tại
select * from products;
call sp_create_order(1,100,3,123);
-- tsst lỗi tồn kho không đủ
call sp_create_order(1,1,100,123);
-- test tạo đơn thành công
call sp_create_order(1,1,3,123);

-- 2) Stored Procedure sp_pay_order
drop procedure if exists sp_pay_order;
delimiter //
create procedure sp_pay_order(
	in p_order_id int,
    in p_payment_method varchar(50)
)
main : begin 
	declare v_status varchar(50);
    declare v_amount decimal(10,2);
    
	-- xử lý lỗi đột ngột 
    declare exit handler for sqlexception
    begin 
		rollback;
        select 'lỗi hệ thống, thanh toán không thành công' as message;
    end;
    
    select status,  total_amount
    into v_status, v_amount  
    from orders where order_id = p_order_id;
    
    start transaction;
    -- Kiểm tra trạng thái đơn hàng. Nếu không phải 'Pending', ROLLBACK và thông báo lỗi
    if v_status <> 'Pending' then 
		rollback;
        select 'không phải trạng thái Pending' as message;
        leave main;
	end if;
    
    if V_status = 'Pending' then 
		-- Thêm bản ghi thanh toán vào bảng payments.
		insert into payments (order_id,amount,payment_method,status) values
        (p_order_id, v_amount, p_payment_method, 'Completed');
        -- Cập nhật trạng thái đơn hàng trong bảng orders thành 'Completed'.
        update orders set status = 'Completed' where order_id = p_order_id;
        
        commit;
        
        select 'thanh toán thành công' as message;
        
	end if;

end //
delimiter ;
-- test lỗi trạng thái khác Pending
call sp_pay_order(1,'Bank Transfer');
-- test thanh toán thành công
call sp_pay_order(2,'Bank Transfer');

-- 3) Stored Procedure sp_cancel_order
drop procedure if exists sp_cancel_order;
delimiter //
create procedure sp_cancel_order(in p_order_id int)
main : begin
	declare v_status varchar(50);
    declare v_quantity int;
    declare v_product_id int;
    
	-- xử lý lỗi bất ngờ
    declare exit handler for sqlexception 
    begin 
		rollback;
        select 'lỗi hệ thống, hủy đơn hàng không thành công' as message;
    end;
    
    select status into v_status from orders where order_id = p_order_id;
    select quantity, product_id into v_quantity, v_product_id from order_items where order_id = p_order_id;
    
    start transaction;
    -- Kiểm tra trạng thái đơn hàng. Nếu không phải 'Pending', ROLLBACK và thông báo lỗi.
    if v_status <> 'Pending' then
		rollback;
        select 'không thể hủy đơn hàng' as message;
        leave main;
	end if;
    
    -- Hoàn trả số lượng hàng vào kho bằng cách cập nhật bảng inventory.
    update inventory set stock_quantity = stock_quantity +  v_quantity where product_id = v_product_id;
    
    -- Xóa các sản phẩm liên quan khỏi bảng order_items.
    delete from order_items where order_id = p_order_id;
    
    -- Cập nhật trạng thái đơn hàng trong bảng orders thành 'Cancelled'.
    update orders set status = 'Cancelled' where order_id = p_order_id;
    
    commit;
    
    select 'hủy đơn hàng thành công' as message;
    
end //
delimiter ;
-- test status <> pending
call sp_cancel_order(1);
-- test hủy thành công
call sp_cancel_order(5);
select * from orders;

  delete from order_items where product_id = 5;
  
  -- Sử dụng lệnh DROP PROCEDURE để xóa tất cả các Stored Procedure đã tạo.
drop procedure if exists sp_cancel_order;
drop procedure if exists sp_pay_order;
drop procedure if exists sp_create_order;
