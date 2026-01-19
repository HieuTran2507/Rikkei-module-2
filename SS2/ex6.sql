use session2;

create table ex6_orders(
	orderID int primary key not null,
    orderDate date not null,
    orderStatus varchar(5) not null check(orderStatus = 'NEW' OR orderStatus = 'PAID')
);

create table ex6_products(
	productID int primary key not null,
    productName varchar(100) not null,
    price decimal(10,2) not null
);

create table ex6_order_items(
	orderID int not null,
	productID int not null,
    quantity int not null,
    primary key(orderID, productID),
    constraint FK_ex6_01
    foreign key (orderID) references ex6_orders(orderID),
    constraint FK_ex6_02
    foreign key (productID) references ex6_products(productID)
);