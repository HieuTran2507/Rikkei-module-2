use session9;

create table orders(
	order_id int primary key auto_increment,
    customer_id int,
    product_id int,
    quantity int not null check(quantity > 0),
    total_amount decimal not null check(total_amount > 0),
    order_status enum("Pending","Success","Cancel") default "Pending",
    constraint fk01 foreign key (customer_id) references customers(id),
    constraint fk02 foreign key (product_id) references products(id)
);

INSERT INTO orders (customer_id, product_id, quantity, total_amount, order_status) VALUES
(1, 1, 1, 15000000, 'Success'),
(2, 2, 2, 24000000, 'Success'),
(3, 5, 3, 10500000, 'Pending'),
(4, 7, 5, 6000000,  'Success'),
(5, 9, 2, 900000,   'Cancel'),

(6, 4, 1, 25000000, 'Success'),
(7, 6, 2, 11000000, 'Pending'),
(8, 10, 1, 950000,  'Success'),
(9, 13, 10, 2500000, 'Success'),
(10, 14, 5, 2250000, 'Pending'),

(1, 15, 1, 2200000, 'Success'),
(2, 16, 1, 3800000, 'Pending'),
(3, 17, 2, 3200000, 'Success'),
(4, 18, 1, 4800000, 'Cancel'),
(5, 19, 3, 3900000, 'Success'),

(6, 20, 1, 4200000, 'Pending'),
(7, 8, 4, 1400000,  'Success'),
(8, 11, 2, 3600000, 'Success'),
(9, 12, 1, 2500000, 'Pending'),
(10, 3, 1, 18000000, 'Success');

create view view_customer_spending as
select 
	c.id, 
    c.customer_name,
    count(o.order_id) as total_orders,
    sum(o.total_amount) as total_spent
from orders o
inner join customers c on o.customer_id = c.id
group by c.id, c.customer_name;

select * from view_customer_spending;






