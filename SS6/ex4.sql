use session6;

create table ex4_orders(
	orderID int primary key,
    customerID int,
    orderDate date
);

create table ex4_order_details(
	orderID int,
    productID int,
    quantity int,
    price decimal(10,2),
    constraint FK_ex4_1
		foreign key (orderID)
        references ex4_orders(orderID)
);

insert into ex4_orders (orderID, customerID, orderDate) values
(1, 101, '2025-01-01'),
(2, 102, '2025-01-02'),
(3, 103, '2025-01-03'),
(4, 104, '2025-01-04');

insert into ex4_order_details (orderID, productID, quantity, price) values
-- Order 1
(1, 1, 2, 1200.00),   -- Laptop
(1, 2, 1,  999.99),   -- Phone

-- Order 2
(2, 1, 1, 1200.00),
(2, 3, 3,   60.00),   -- Clothing

-- Order 3
(3, 2, 2,  999.99),
(3, 3, 5,   60.00),

-- Order 4
(4, 1, 3, 1200.00),
(4, 2, 1,  999.99),
(4, 3, 2,   60.00);


