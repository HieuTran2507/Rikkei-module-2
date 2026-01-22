use session6;

create table customers(
id int primary key,
customer_name varchar(255),
email varchar(255)
);

create table orders(
id int primary key,
customer_id int not null,
order_date date,
constraint fk02 foreign key (customer_id) references customers(id) 
);

create table order_details(
order_id int,
product_id int,
quantity int,
price double(10,2),
primary key(order_id, product_id),
constraint fk03 foreign key (order_id) references orders(id),
constraint fk04 foreign key (product_id) references products(id)
);

insert into customers value
(1, 'Nguyen Van A', 'a@gmail.com'),
(2, 'Tran Thi B', 'b@gmail.com'),
(3, 'Le Van C', 'c@gmail.com'),
(4, 'Pham Thi D', 'd@gmail.com'),
(5, 'Hoang Van E', 'e@gmail.com');

insert into orders value
(1001, 1, 20250110),
(1002, 1, 20250115),
(1003, 2, 20250118),
(1004, 3, 20250120),
(1005, 5, 20250122);

insert into order_details value
(1001, 101, 1, 999.00),
(1001, 103, 1, 1299.00),
(1002, 102, 2, 899.00),
(1003, 103, 1, 1299.00),
(1004, 104, 1, 1099.00),
(1004, 103, 2, 1299.00),
(1005, 101, 1, 799.00);

-- Thêm 2 khách hàng mới vào bảng customers
insert into customers value
(6, 'Ding Van F', 'f@gmail.com'),
(7, 'Mac Thi G', 'g@gmail.com');

-- Liệt kê những khách hàng đã có ít nhất một đơn hàng
select c.id, c.customer_name 
from customers c
inner join orders o 
on c.id = o.customer_id
group by c.id, c.customer_name;

-- Tìm những khách hàng chưa từng đặt đơn hàng nào
select c.id, c.customer_name
from customers c
left join orders o
on c.id = o.customer_id
where o.customer_id is null;

-- Tính toán tổng doanh thu mà mỗi khách hàng đã mang lại
select 
 c.id, 
 c.customer_name,
 ifnull(sum(od.quantity*od.price),0) as 'tong doanh thu'
from customers c 
left join orders o on c.id = o.customer_id
left join order_details od on o.id = od.order_id
group by c.id, c.customer_name;

-- Xác định khách hàng đã mua sản phẩm có giá cao nhất
select 
	c.id,
    c.customer_name,
    p.product_name as `sản phẩm giá cao nhất`
from customers c 
inner join orders o on c.id = o.customer_id
inner join order_details od on o.id = od.order_id
inner join products p on od.product_id = p.id
where p.price = (
	select price from products order by price desc limit 1
);


