use session9;

create table products(
	id int primary key,
    product_name varchar(50) not null,
    price double not null check (price > 0),
    stock double not null check (stock > 0)
);

INSERT INTO products (id, product_name, price, stock) VALUES
(1,  'Laptop Dell Inspiron',     15000000, 10),
(2,  'Laptop HP Pavilion',       12000000, 8),
(3,  'Laptop Lenovo ThinkPad',   18000000, 6),
(4,  'PC Gaming',                25000000, 4),
(5,  'Monitor 24 inch',           3500000, 15),
(6,  'Monitor 27 inch',           5500000, 10),
(7,  'Keyboard Mechanical',        1200000, 50),
(8,  'Keyboard Office',             350000, 60),
(9,  'Wireless Mouse',              450000, 80),
(10, 'Gaming Mouse',                950000, 40),
(11, 'Headphone Bluetooth',       1800000, 30),
(12, 'Gaming Headset',            2500000, 25),
(13, 'USB Flash Drive 64GB',        250000, 200),
(14, 'USB Flash Drive 128GB',       450000, 150),
(15, 'External HDD 1TB',          2200000, 20),
(16, 'External SSD 1TB',          3800000, 12),
(17, 'Webcam Full HD',            1600000, 35),
(18, 'Printer Laser',             4800000, 7),
(19, 'Router WiFi',               1300000, 18),
(20, 'UPS 1000VA',                4200000, 9);

delimiter //
create procedure get_high_value_products()
begin 
	select * from products where price >1000000;
end;
// delimiter ;

call get_high_value_products();