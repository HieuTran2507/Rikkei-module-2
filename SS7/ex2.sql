use session7;

create table customers(
	id int primary key,
    customer_name varchar(255)
);

create table orders(
	id int primary key,
	order_date date,
    customer_id int,
    constraint fk01 foreign key (customer_id) references customers(id)
);

insert into customers value
(1,'Nguyen Van An'),
(2,'Tran Thi Binh'),
(3,'Le Minh Duc'),
(4,'Pham Thu Ha'),
(5,'Vo Quoc Huy');

insert into orders value 
(101,'2024-01-05',1),
(102,'2024-01-10',2),
(103,'2024-01-12',1),
(104,'2024-01-15',3),
(105,'2024-01-18',4),
(106,'2024-01-20',2),
(107,'2024-01-25',5);

create view v_order_info as
select o.id,
	o.order_date,
    c.customer_name
from customers c inner join orders o
on c.id = o.customer_id;



