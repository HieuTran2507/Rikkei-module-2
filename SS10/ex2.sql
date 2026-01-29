use session10;

drop trigger if exists trig_before_product_delete;
delimiter // 
create trigger trig_before_product_delete before delete
on products for each row
begin
	if old.quantity > 10 then
		signal sqlstate '45000' set message_text = 'không thể xóa sản phẩm có số lượng lớn hơn 10';
	else delete from inventory_change where product_id = old.product_id;
    end if;
end//
delimiter ;

update products set quantity = 5 where product_id in (2,4);

delete from products where product_id in (2,4);

delete from products where product_id in (1,3,5);

select * from products;
