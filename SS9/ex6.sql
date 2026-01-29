use session9;

delimiter //
drop procedure if exists add_order;
create procedure add_order(
	in p_customer_id int,
    in p_product_id int,
    in p_quantity int,
    out p_message varchar(100)
)
begin 
	-- lấy tồn kho 
    declare v_stock int;
    declare v_total_amount decimal;
    
    select stock into v_stock from products where id = p_product_id;
    set V_total_amount = p_quantity*(select price from products where id = p_product_id);
    -- kiểm tra tôn tại
    if 
		v_stock is null then set p_message = 'sản phẩm không tồn tại';
	elseif
		v_stock >= p_quantity then
        -- trừ tồn kho 
        update products set stock = stock - p_quantity where id = p_product_id;
        -- tạo đơn
        insert into orders(customer_id, product_id, quantity, total_amount) values
        (p_customer_id, p_product_id, p_quantity, V_total_amount);
        -- message 
        set p_message = 'thêm đơn hàng thành công';
	else -- stock < quantity
		set p_message = concat('còn ', v_stock, ' sản phẩm, không thể tạo đơn');
	end if;
end;
// delimiter ;

call add_order(7,2,1,@result);
select @result;

select * from customers;
select * from orders;
