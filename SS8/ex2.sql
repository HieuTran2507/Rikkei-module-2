use session8;

create table products(
	id int primary key,
	product_name varchar(255),
    price decimal(19,2),
    category varchar(255)
);

insert into products value
(1, 'san pham 1', 123, 'loai 1'),
(2, 'san pham 2', 124, 'loai 2'),
(3, 'san pham 3', 125, 'loai 3');

delimiter $$
create procedure sp_get_products_by_category(p_category varchar(255))
begin
	select * from products where category = p_category;
end;
$$ delimiter ;

call sp_get_products_by_category('loai 1');