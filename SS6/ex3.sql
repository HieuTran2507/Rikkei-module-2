use session6;

create table ex3_products(
	product_id int primary key,
    product_name varchar(255),
    price decimal (10,2),
    category varchar(255)
);

insert into ex3_products (product_id, product_name, price, category) values
(1, 'Laptop Dell Inspiron',   1200.00, 'Electronics'),
(2, 'Laptop HP Pavilion',    1100.00, 'Electronics'),
(3, 'iPhone 14',              999.99, 'Electronics'),
(4, 'Samsung Galaxy S23',     899.99, 'Electronics'),

(5, 'Bàn làm việc gỗ',         350.00, 'Furniture'),
(6, 'Ghế văn phòng',           180.00, 'Furniture'),
(7, 'Tủ hồ sơ sắt',            220.00, 'Furniture'),

(8, 'Áo thun nam',              25.00, 'Clothing'),
(9, 'Áo sơ mi nữ',              45.00, 'Clothing'),
(10,'Quần jean',                60.00, 'Clothing'),

(11,'Sách lập trình SQL',       30.00, 'Books'),
(12,'Sách học tiếng Nhật',      28.00, 'Books'),
(13,'Sách automation cơ bản',   40.00, 'Books');

# Tìm các sản phẩm có giá nằm trong một khoảng cụ thể
select * from ex3_products where price between 10.00 and 100.00;

# Tìm các sản phẩm có tên chứa một chuỗi ký tự nhất định
select * from ex3_products where product_name like '%lap%' or 
								 product_name like '%áo%';
                                 
# Tính giá trung bình của sản phẩm cho mỗi danh mục
select 
	category,
    avg(price) as 'average price'
from ex3_products
group by category;

# Tìm những sản phẩm có giá cao hơn mức giá trung bình của toàn bộ sản phẩm
select avg(price) from ex3_products;
select * from ex3_products
where price > (
	select avg(price) from ex3_products
);

# Tìm sản phẩm có giá thấp nhất cho từng danh mục
select min(price) from ex3_products group by category;
select * from ex3_products p
where price = (
	select min(price) from ex3_products 
    where category = p.category
);