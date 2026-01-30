use session10;

drop table if exists cart_items;
create table cart_items(
	id int primary key auto_increment, 
    product_id int,
    quantity int,
    foreign key (product_id) references products(product_id)
);

drop trigger if exists trig_before_add_cart;
delimiter //
create trigger trig_before_add_cart before insert 
on 	cart_items for each row
begin
	declare stock int;
    declare err varchar(50);
    select quantity into stock from products where product_id = new.product_id;
    set err = concat('số lượng tồn kho còn ', stock);
	if new.quantity > stock then
		signal sqlstate '45000' set message_text = err;
	else 
		update products set quantity = quantity - new.quantity where product_id = new.product_id;
	end if;
end//
delimiter ;

-- trường hợp số lượng thêm vào giỏ hàng < số lượng tồn kho
insert into cart_items(product_id,quantity) values
(1, 100);

-- trường hợp số lượng thêm vào giỏ hàng > số lượng tồn kho
insert into cart_items(product_id,quantity) values
(2, 1000);

select * from products;