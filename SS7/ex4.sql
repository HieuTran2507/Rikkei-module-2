use session7;

create table products(
	id int primary key,
	product_name varchar(255),
    category varchar(255),
    price decimal(19,2)
);

create index idx_category on products(category);

create index idx_price on products(price);