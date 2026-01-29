use session9;

alter table customers 
modify id int auto_increment;

delimiter //
create procedure insert_customer(
	in customer_name varchar(50),
    in email varchar(100),
    in phone varchar(10),
    in address varchar(255)
)
begin 
	insert into customers (customer_name, email, phone, address)
    value (customer_name, email, phone, address);
    select 'thêm khách hàng thành công' as message;
end;
// delimiter ;

call insert_customer('Bùi Văn An', 'An@gmail.com', '0003339991', 'toyama');

select * from customers;
