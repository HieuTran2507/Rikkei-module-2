use session11;

-- 1) Cập nhật cấu trúc bảng orders
-- Hãy thêm cột status (VARCHAR/ENUM) với giá trị mặc định là 'Completed' (hoặc 'Pending').
alter table orders add column order_status varchar(15) default 'Pending';
-- Cập nhật các đơn hàng cũ thành trạng thái 'Completed'.
update orders set order_status = 'Completed' where id is not null;

-- 2) Viết Stored Procedure cancel_order
drop procedure if exists cancel_order;
delimiter //
create procedure cancel_order(in p_order_id int)
main: begin
    declare v_product_id int;
    declare v_quantity int;
    
	-- xử lý lỗi đột ngột
	declare exit handler for sqlexception 
	begin
		rollback;
		select 'Lỗi hệ thống. Hủy đơn hàng không thành công.' as message;
	end;
    
    start transaction;
    -- kiểm tra đơn hàng có tồn tại không
    if not exists(select id from orders where id = p_order_id) then
		rollback;
        select 'Đơn hàng không tồn tại. Hủy đơn hàng không thành công' as message;
        leave main;
	end if;
    
    -- kiểm tra trạng thái đã hủy
    if (select order_status from orders where id = p_order_id) = 'Cancelled' then
		rollback;
        select 'Đơn hàng đã hủy trước đó' as message;
        leave main;
	end if;
    
    -- lấy thông tin product_id và quantity
    select product_id, quantity 
    into v_product_id, v_quantity
    from orders where id = p_order_id;
    
    -- cập nhật trạng thái đơn hàng thành Cancelled
	update orders set order_status = 'Cancelled' where id = p_order_id;
    
    -- cộng lại số lượng vào kho
    update products set stock = stock + v_quantity where id = v_product_id;
    
    commit;
    select 'Đã hủy đơn hàng thành công' as message;
end// 
delimiter ;

call cancel_order(1);

select * from orders;
select * from products;
