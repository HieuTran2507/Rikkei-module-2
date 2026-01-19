use session2;

create table ex2_products(
	productID int primary key,
    productName varchar(50),
    price decimal(10,2),
    stockQuantity int 
);