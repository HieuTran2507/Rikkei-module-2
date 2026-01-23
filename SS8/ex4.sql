use session8;

create table orders(
	id int primary key,
    total decimal(10,2)
);

insert into orders value
(1, 1000),
(2, 2000),
(3, 5000),
(4, 6000),
(5, 7000);

delimiter //
create procedure sp_check_order_value(in total decimal(10,2))
begin 
	if total > 3000 then 
    select 'đơn hàng giá trị cao' as result;
    else select 'đơn hàng bình thường' as result;
    end if;
end;
// delimiter ;

set @chkvalue = (
	select total from orders where id = 4
);

call sp_check_order_value(@chkvalue);
