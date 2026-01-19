create schema session6;
use session6;

create table ex1_categories(
	category_id int primary key,
    category_name varchar(255)
);

create table ex1_products(
	product_id int primary key,
    product_name varchar(255),
    price double,
    category_id int,
    constraint fk_ex1_1
    foreign key (category_id) references ex1_categories(category_id)
);

insert into ex1_categories (category_id, category_name) values
(1, 'Electronics'),
(2, 'Furniture'),
(3, 'Office Supplies'),
(4, 'Home Appliances'),
(5, 'Accessories');

insert into ex1_products (product_id, product_name, price, category_id) values
(101, 'Laptop Dell',        15000000, 1),
(102, 'Smartphone Samsung', 12000000, 1),
(103, 'Monitor LG 27"',      4500000, 1),

(201, 'Office Desk',        3500000, 2),
(202, 'Office Chair',       2800000, 2),

(301, 'Printer Canon',      6000000, 3),
(302, 'A4 Paper (500)',      120000, 3),

(401, 'Air Conditioner',   18000000, 4),
(402, 'Washing Machine',   14000000, 4),

(501, 'Wireless Mouse',      450000, 5),
(502, 'Keyboard Mechanical',1200000, 5);

# Cập nhật giá của một sản phẩm đã có
update ex1_products set price = 4800000 where product_id = 103;
select * from ex1_products;

# Xóa một sản phẩm
delete from ex1_products where product_id = 502;
select * from ex1_products;

# Hiển thị tất cả sản phẩm, sắp xếp theo giá
select * from ex1_products
order by price ASC;

# Thống kê số lượng sản phẩm cho từng danh mục
select 
	c.category_id,
    c.category_name,
    count(p.category_id) as 'number of items'
from ex1_categories c
inner join ex1_products p
on c.category_id = p.category_id
group by category_id;