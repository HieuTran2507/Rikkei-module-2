use session5;

create table ex6_customers(
	customer_id varchar(5) primary key,
    customer_name varchar(20) not null
);

create table ex6_order_items(
	order_id varchar(5) primary key,
    product_name varchar(20) not null,
    quantity int,
    price decimal(10,2)
);

create table ex6_orders(
	order_id varchar(5) not null,
    order_date date,
    customer_id varchar(5) not null, 
    primary key (order_id, customer_id),
    constraint fk_ex6_1
		foreign key (customer_id) references ex6_customers(customer_id),
	constraint fk_ex6_2
		foreign key (order_id) references ex6_order_items(order_id)
);	

insert into ex6_customers (customer_id, customer_name) values
('C001', 'Nguyen Van A'),
('C002', 'Tran Thi B'),
('C003', 'Le Van C'),
('C004', 'Pham Thi D'),
('C005', 'Hoang Van E');

insert into ex6_order_items (order_id, product_name, quantity, price) values
('O001', 'Laptop Dell', 1, 15000000),
('O002', 'Chuột Logitech', 2, 500000),
('O003', 'Màn hình LG', 1, 4000000),
('O004', 'Laptop HP', 1, 17000000),
('O005', 'Tai nghe Sony', 2, 3000000),
('O006', 'Laptop Lenovo', 1, 21000000),
('O007', 'Máy in Canon', 1, 6000000),
('O008', 'SSD 1TB', 2, 3500000),
('O009', 'Màn hình Samsung', 2, 4500000);

insert into ex6_orders (order_id, order_date, customer_id) values
-- C001
('O001', '2025-01-05', 'C001'),
('O002', '2025-01-06', 'C001'),

-- C002
('O003', '2025-01-07', 'C002'),
('O004', '2025-01-08', 'C002'),

-- C003
('O005', '2025-01-10', 'C003'),

-- C004
('O006', '2025-01-12', 'C004'),

-- C005 (doanh thu cao nhất)
('O007', '2025-01-15', 'C005'),
('O008', '2025-01-16', 'C005'),
('O009', '2025-01-17', 'C005');

# Hiển thị: mã đơn hàng - tên khách hàng - tổng tiền của đơn hàng
select 
	o.order_id,
    c.customer_name,
    sum(ot.quantity*ot.price)  as total
from ex6_customers c
inner join ex6_orders o 
on c.customer_id = o.customer_id
inner join ex6_order_items ot
on o.order_id = ot.order_id
group by o.order_id, c.customer_name;

# Tính: tổng doanh thu của mỗi khách hàng
select 
	c.customer_id,
    c.customer_name,
    sum(ot.quantity*ot.price) as total
from ex6_customers c
inner join ex6_orders o 
on c.customer_id = o.customer_id
inner join ex6_order_items ot
on o.order_id = ot.order_id
group by c.customer_id;

# Chỉ hiển thị: các khách hàng có tổng doanh thu lớn hơn 20.000.000
select 
	c.customer_id,
    c.customer_name,
    sum(ot.quantity*ot.price) as total
from ex6_customers c
inner join ex6_orders o 
on c.customer_id = o.customer_id
inner join ex6_order_items ot
on o.order_id = ot.order_id
group by customer_id
having sum(ot.quantity*ot.price) > 20000000;

# Hiển thị: khách hàng có doanh thu cao nhất
select 
	c.customer_id,
    c.customer_name,
    sum(ot.quantity*ot.price) as total
from ex6_customers c
inner join ex6_orders o 
on c.customer_id = o.customer_id
inner join ex6_order_items ot
on o.order_id = ot.order_id
group by customer_id
having total = (
	select max(sub_total)
    from (
		select sum(ot1.quantity*ot1.price) as sub_total
        from ex6_customers c1
		inner join ex6_orders o1
		on c1.customer_id = o1.customer_id
		inner join ex6_order_items ot1
		on o1.order_id = ot1.order_id
		group by c1.customer_id
    ) as temp
);
