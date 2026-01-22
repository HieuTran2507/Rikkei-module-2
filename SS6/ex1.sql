create database session6;

use session6;

create table categories(
id int primary key,
category_name varchar(255)
);

create table products(
 id int primary key,
 product_name varchar(255),
 price double(10,2),
 category_id int not null,
 constraint fk01 foreign key (category_id) references categories(id)
);

-- Thêm 3 sản phẩm mới vào bảng products
insert into categories values
(1, 'smartphone'),
(2, 'Laptop'),
(3, 'Tablet'),
(4, 'Headphone'),
(5, 'Smartwatch');

insert into products value
(101, 'iphone 15', 999.00, 1),
(102, 'Samsung Galaxy S24', 899.00, 1),
(103, 'MacBook Air M2', 1299.00, 2),
(104, 'iPad Pro', 1099.00, 3),
(105, 'Sony WH-1000XM5', 399.00, 4);

-- Cập nhật giá của một sản phẩm đã có
update products set price = 321.55 where id = 105;

-- Xóa một sản phẩm
delete from products where id = 105;

-- Hiển thị tất cả sản phẩm, sắp xếp theo giá
select * from products order by price asc;

-- Thống kê số lượng sản phẩm cho từng danh mục
select 
	c.id as category_id,
    c.category_name, 
    ifnull((p.category_id),0) as `number of products`
from products p 
right join categories c
on p.category_id = c.id
group by c.id, c.category_name;

