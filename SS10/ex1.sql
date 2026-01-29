create database session10;

use session10;

drop table if exists products;
create table products(
	product_id int auto_increment primary key,
    product_name varchar(100),
    quantity int
);

drop table if exists inventory_change;
create table inventory_change(
	change_id int auto_increment primary key,
    product_id int not null,
    old_quantity int,
    new_quantity int,
    change_date datetime,
    foreign key (product_id) references products(product_id)
)auto_increment = 101;

insert into products (product_name,quantity) values
("product 1", 241),
("product 2", 143),
("product 3", 545),
("product 4", 111),
("product 5", 235),
("product 6", 3454),
("product 7", 123);

drop trigger if exists trig_after_product_update;
delimiter //
create trigger trig_after_product_update after update
on products for each row
begin
	insert into inventory_change(product_id,old_quantity,new_quantity,change_date) value
    (old.product_id, old.quantity, new.quantity, now());
end//
delimiter ;

update products set quantity = 100 where product_id in (1,3,5,7);

select * from inventory_change;