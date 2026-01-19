use session4;

create table ex6_products(
	product_id varchar(5) primary key,
    product_name varchar(20) not null,
    category varchar(20),
    price decimal(10),
    quantity int
);

INSERT INTO ex6_products (product_id, product_name, category, price, quantity)
VALUES
('P001', 'Samsung Laptop A',   'Laptop', 12000000, 10),
('P002', 'Dell Laptop B',      'Laptop', 18000000, 5),
('P003', 'Samsung Phone S',    'Phone',   9000000, 0),
('P004', 'iPad Tablet X',      'Tablet', 14000000, 7),
('P005', 'Samsung TV Q',       'TV',     20000000, 3),
('P006', 'Samsung Laptop Pro', 'Laptop', 15000000, 0),
('P007', 'Asus Laptop Zen',    'Laptop', 11000000, 8),
('P008', 'Samsung Tablet S',   'Tablet', 13000000, 4),
('P009', 'iPhone 13',          'Phone',  16000000, 6),
('P010', 'Samsung Phone A',    'Phone',   7000000, 9),
('P011', 'Xiaomi Phone X',     'Phone',   5000000, 2),
('P012', 'LG Monitor 27',      'Monitor', 6000000, 0);

# Hiển thị sản phẩm có giá từ 5.000.000 đến 15.000.000
select * from ex6_products where price between 5000000 and 15000000;

# Hiển thị sản phẩm thuộc loại Laptop hoặc Tablet
select * from ex6_products where category = 'Laptop' or category = 'Tablet';

# Hiển thị sản phẩm có tên bắt đầu bằng “Sam”
select * from ex6_products where product_name like 'Sam%';

# Hiển thị sản phẩm không thuộc loại Phone
select * from ex6_products where category <> 'phone';

# Giảm giá 5% cho các sản phẩm thuộc loại Laptop
select * from ex6_products where category = 'laptop';
update ex6_products
set price = price*0.95
where category = 'laptop';
select * from ex6_products where category = 'laptop';

# Xóa các sản phẩm có số lượng tồn kho bằng 0
delete from ex6_products where quantity = 0;
select * from ex6_products;