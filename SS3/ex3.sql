use session3;

create table ex3_products(
	productID int primary key,
    productName varchar(50) not null,
    price decimal(10,2) not null,
    stockQuantity int
);

create table ex3_orders(
	orderID int primary key,
    orderDate date not null,
    orderStatus varchar(6) not null,
    check(orderStatus = 'PAID' or orderStatus = 'UNPAID')
);

create table ex3_oder_product(
	productID int not null,
    orderID int not null,
    quantity int not null,
    totalAmount decimal(10,2),
    primary key (productID,orderID),
    constraint FK_ex3_1
		foreign key (productID) references ex3_products(productID),
	constraint FK_ex3_2
		foreign key (orderID) references ex3_orders(orderID)
);