use session11;

drop table if exists products;
create table products(
 id int auto_increment primary key,
 product_name varchar(100),
 price decimal(15,2),
 stock int
);

drop table if exists orders;
create table orders(
	id int auto_increment primary key,
    product_id int,
    quantity int,
    total decimal(15,2),
    order_date datetime default now(),
    foreign key (product_id) references products(id)
);

insert into products (product_name,price,stock) value
("laptop gaming", 20000000,10);

drop procedure if exists place_order;
delimiter //
create procedure place_order(
	in p_product_id int,
    in p_quantity int
)
main: begin

	-- khai báo biến sl tồn kho
    declare v_stock int;
    declare v_price decimal(15,2);
    
	-- xử lý lỗi bất ngờ
    declare exit handler for sqlexception
    begin
		rollback;
        select 'lỗi hệ thống. Đặt hàng không thành công' as message;
    end;
    
    select stock into v_stock from products where id = p_product_id;
    select price into v_price from products where id = p_product_id;
    
    start transaction;
    -- xủ lý sản phẩm không tồn tại
    if not exists (select * from products where id = p_product_id) then
		rollback;
        select 'sản phẩm không tồn tại' as message;
        leave main;
	end if;
    
    -- kiểm tra số lượng tồn kho nếu không đủ
    if v_stock < p_quantity then
		rollback;
        select concat('số lượng tồn kho: ' ,v_stock, " . Đặt hàng không thành công") as message;
        leave main;
	end if;
    
	-- trừ tồn kho product
	update products set stock = stock - p_quantity where id = p_product_id;
	-- thêm vào order
	insert into orders (product_id,quantity,total) value
	(p_product_id, p_quantity, v_price*p_quantity);
    
    commit;
    
    select "đặt hàng thành công" as message;
    
end//
delimiter ;

-- lỗi sp ko tồn tại
call place_order(10,1);
-- lỗi tồn kho không đủ
call place_order(1,1000);
-- đặt hàng thành công
call place_order(1,2);

select * from products;

select * from orders;