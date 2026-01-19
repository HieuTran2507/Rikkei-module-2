use session5;

create table ex3_products(
	product_id varchar(5) primary key,
    product_name varchar(10),
    category varchar(10),
    price decimal(10,2)
);

INSERT INTO ex3_products (product_id, product_name, category, price)
VALUES
-- Laptop
('P001', 'Dell XPS',   'Laptop', 25000000),
('P002', 'HP Pro',     'Laptop', 18000000),
('P003', 'Asus Zen',   'Laptop', 15000000),

-- Phone
('P004', 'iPhone',     'Phone',  22000000),
('P005', 'Samsung S',  'Phone',  19000000),
('P006', 'Xiaomi',     'Phone',  9000000),

-- Tablet
('P007', 'iPad Pro',   'Tablet', 21000000),
('P008', 'Galaxy Tab', 'Tablet', 14000000),

-- TV
('P009', 'Sony TV',    'TV',     30000000),
('P010', 'LG TV',      'TV',     18000000);

# Hiển thị các sản phẩm có: giá cao hơn giá trung bình của tất cả sản phẩm
select * from ex3_products 
where price > (
	select avg(price) from ex3_products
);

# Hiển thị sản phẩm có: giá cao nhất trong từng loại sản phẩm
select * from ex3_products p
where price = (
	select max(price)
    from ex3_products
    where category = p.category
);

# Hiển thị các sản phẩm thuộc loại: có ít nhất một sản phẩm giá trên hoặc bằng 25.000.000
select * from ex3_products p
where p.category in (
	select category from ex3_products 
    where price >= 25000000
); 