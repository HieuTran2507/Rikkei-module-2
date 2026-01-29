use session10;

drop table if exists orders;
create table orders(
	id int auto_increment primary key,
    customer_name varchar(100),
    total_amount decimal(10,2),
    order_date datetime default now(),
    order_status enum('pending', 'shipping', 'completed', 'cancelled') default 'pending'
);

drop table if exists order_logs;
create table order_logs(
	log_id int auto_increment primary key,
    order_id int,
    old_status varchar(50),
    new_status varchar(50),
    log_date timestamp,
    foreign key (order_id) references orders(id)
);

insert into orders(customer_name,total_amount,order_date,order_status) values
('Nguyen Van An', 150.50, '2025-01-10 09:15:00', 'pending'),
('Tran Thi Binh', 320.00, '2025-01-11 10:30:00', 'shipping'),
('Le Minh Chi', 89.99, '2025-01-12 14:20:00', 'completed'),
('Pham Quang Dung', 450.75, '2025-01-13 16:45:00', 'cancelled'),
('Hoang Thu Hanh', 210.00, '2025-01-14 08:10:00', 'pending'),
('Vo Duc Khanh', 999.99, '2025-01-15 11:00:00', 'shipping'),
('Bui Ngoc Linh', 120.00, '2025-01-16 13:55:00', 'completed'),
('Dang Thanh Minh', 560.40, '2025-01-17 17:30:00', 'pending'),
('Huynh Tuan Nam', 75.25, '2025-01-18 09:40:00', 'completed'),
('Do Thi Phuong', 305.00, '2025-01-19 15:10:00', 'cancelled');

drop trigger if exists trig_status_update;
delimiter // 
create trigger trig_status_update after update 
on orders for each row
begin
	if 
		old.order_status <> new.order_status then
        insert into order_logs(order_id,old_status,new_status,log_date) value
        (old.id, old.order_status, new.order_status, now());
	end if;
end // 
delimiter ;

update orders set order_status = 'shipping' where id = 1;
update orders set customer_name = 'tran tuan hieu' where id = 2;

select * from order_logs;

