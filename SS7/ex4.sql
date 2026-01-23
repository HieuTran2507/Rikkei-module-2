use session7;

create table products(
	id int primary key,
	product_name varchar(255),
    category varchar(255),
    price decimal(19,2)
);

create index idx_category_price on products(category, price);