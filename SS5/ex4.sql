use session5;

create table ex4_customers(
	customer_id varchar(5) primary key,
    customer_name varchar(20) not null
);

create table ex4_order_items(
	order_id varchar(5) primary key,
    product_name varchar(20) not null,
    quantity int,
    price decimal(10,2)
);

create table ex4_orders(
	order_id varchar(5) not null,
    order_date date,
    customer_id varchar(5) not null, 
    primary key (order_id, customer_id),
    constraint fk_ex4_1
		foreign key (customer_id) references ex4_customers(customer_id),
	constraint fk_ex4_2
		foreign key (order_id) references ex4_order_items(order_id)
);	

insert into ex4_customers (customer_id, customer_name) values
('C001', 'Nguyen Van A'),
('C002', 'Tran Thi B'),
('C003', 'Le Van C'),
('C004', 'Pham Thi D'),
('C005', 'Hoang Van E'),
('C006', 'Do Thi F');

insert into ex4_order_items (order_id, product_name, quantity, price) values
('O001', 'Laptop Dell', 1, 15000000),
('O002', 'Chuột Logitech', 2, 500000),
('O003', 'Màn hình LG', 1, 4000000),
('O004', 'Bàn phím cơ', 1, 2000000),
('O005', 'Laptop HP', 1, 18000000),
('O006', 'Tai nghe Sony', 2, 3000000),
('O007', 'Máy in Canon', 1, 6000000),
('O008', 'Ổ cứng SSD 1TB', 1, 3500000),
('O009', 'Laptop Lenovo', 1, 22000000),
('O010', 'Router Wifi', 1, 2500000),
('O011', 'Camera an ninh', 2, 2000000),
('O012', 'Màn hình Samsung', 2, 4500000);

insert into ex4_orders (order_id, order_date, customer_id) values
('O001', '2025-01-05', 'C001'),
('O002', '2025-01-05', 'C001'),

('O003', '2025-01-07', 'C002'),
('O004', '2025-01-07', 'C002'),

('O005', '2025-01-10', 'C003'),

('O006', '2025-01-12', 'C004'),
('O007', '2025-01-12', 'C004'),

('O008', '2025-01-15', 'C005'),
('O009', '2025-01-15', 'C005'),

('O010', '2025-01-18', 'C006'),
('O011', '2025-01-18', 'C006'),
('O012', '2025-01-18', 'C006');

# Hiển thị: mã đơn hàng - ngày đặt hàng - tên khách hàng
select 
	o.order_id, 
    o.order_date, 
    c.customer_name
from ex4_customers c 
inner join ex4_orders o
on c.customer_id = o.customer_id; 

# Hiển thị: danh sách sản phẩm trong mỗi đơn hàng
select 
	o.order_id,
	ot.product_name
from ex4_order_items ot 
inner join ex4_orders o
on ot.order_id = o.order_id;

# Tính: tổng tiền của mỗi đơn hàng
select
	order_id,
    sum(quantity*price) as total
from ex4_order_items
group by order_id;

# Hiển thị: các đơn hàng có tổng tiền lớn hơn 10.000.000
select
	order_id,
    sum(quantity*price) as total
from ex4_order_items
group by order_id
having sum(quantity*price) > 10000000;