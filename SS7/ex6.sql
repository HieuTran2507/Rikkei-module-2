use session7;

alter table orders
	add column order_status binary,
    add column total decimal(10,2);
    
create index idx_status_date on orders(order_date, order_status);