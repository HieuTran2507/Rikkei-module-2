use session6;

create table ex2_customers(
	customer_id int primary key,
    customer_name varchar(255),
    email varchar(255)
);

create table ex2_orders(
	order_id int primary key,
    customer_id int,
    order_date date, 
    constraint fk_ex2_1
    foreign key (customer_id) references ex2_customers(customer_id)
);

create table ex2_categories(
	category_id int primary key,
    category_name varchar(255)
);

create table ex2_products(
	product_id int primary key,
    product_name varchar(255),
    price double,
    category_id int,
    constraint fk_ex2_2
    foreign key (category_id) references ex2_categories(category_id)
);

create table ex2_order_details(
	order_id int,
    product_id int,
	quantity int,
    price double,
    primary key (order_id, product_id),
    constraint fk_ex2_3
    foreign key (order_id) references ex2_orders(order_id),
    constraint fk_ex2_4
    foreign key (product_id) references ex2_products(product_id)
);

insert into ex2_customers (customer_id, customer_name, email) values
(1, 'Nguyen Van A', 'a@gmail.com'),
(2, 'Tran Thi B', 'b@gmail.com'),
(3, 'Le Van C', 'c@gmail.com'),
(4, 'Pham Thi D', 'd@gmail.com'),
(5, 'Hoang Van E', 'e@gmail.com');

insert into ex2_orders (order_id, customer_id, order_date) values
(101, 1, '2025-01-05'),
(102, 1, '2025-01-10'),
(103, 2, '2025-01-12'),
(104, 3, '2025-01-15');

insert into ex2_categories (category_id, category_name) values
(1, 'Electronics'),
(2, 'Office'),
(3, 'Accessories');

insert into ex2_products (product_id, product_name, price, category_id) values
(201, 'Laptop Dell', 20000000, 1),   -- giá cao nhất
(202, 'Monitor LG',  5000000,  1),
(203, 'Office Chair',3000000,  2),
(204, 'Mouse Logitech',500000, 3);

insert into ex2_order_details (order_id, product_id, quantity, price) values
-- Order 101 (KH 1)
(101, 201, 1, 20000000),
(101, 204, 2, 500000),

-- Order 102 (KH 1)
(102, 202, 1, 5000000),

-- Order 103 (KH 2)
(103, 203, 2, 3000000),

-- Order 104 (KH 3)
(104, 204, 3, 500000);

# Liệt kê những khách hàng đã có ít nhất một đơn hàng
select 
	customer_id,
    customer_name
from ex2_customers
where customer_id in (
	select customer_id from ex2_orders
);

# Tìm những khách hàng chưa từng đặt đơn hàng nào
select 
	customer_id,
    customer_name
from ex2_customers
where customer_id not in(
	select customer_id from ex2_orders
);

# Tính toán tổng doanh thu mà mỗi khách hàng đã mang lại
select 
	c.customer_id,
    c.customer_name,
    sum(od.price*od.quantity) as total
from ex2_customers c
inner join ex2_orders o
on c.customer_id = o.customer_id
inner join ex2_order_details od
on o.order_id = od.order_id
group by c.customer_id;

# Xác định khách hàng đã mua sản phẩm có giá cao nhất
select 
	c.customer_id,
    c.customer_name,
    sum(od.price*od.quantity) as total
from ex2_customers c
inner join ex2_orders o
on c.customer_id = o.customer_id
inner join ex2_order_details od
on o.order_id = od.order_id
group by c.customer_id
having total = (
	select max(sub_total)
    from(
		select sum(od1.price*od1.quantity) as sub_total
        from ex2_customers c1
		inner join ex2_orders o1
		on c1.customer_id = o1.customer_id
		inner join ex2_order_details od1
		on o1.order_id = od1.order_id
		group by c1.customer_id
    ) as temp 
);






