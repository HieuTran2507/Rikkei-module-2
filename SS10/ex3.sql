use session10;

drop trigger if exists trig_before_insert_product;
delimiter // 
create trigger trig_before_insert_product before insert 
on products for each row
begin 
	if new.quantity < 0 then 
    signal sqlstate '45001' set message_text = "số lượng sản phẩm phải lớn hơn 0";
    end if;
end//
delimiter ;

insert into products (product_name,quantity) values
("product form America", -1);

insert into products (product_name,quantity) values
("product form America", 999);

select * from products;