create database session11;

use session11;

drop table if exists accounts;
create table accounts(
	id int auto_increment primary key,
    user_name varchar(100),
    balance decimal(15,2)
);

insert into accounts(user_name, balance) values
('Nguyen Van An', 1000.00),
('Tran Thi Binh', 2500.50),
('Le Hoang Cuong', 500.00),
('Pham Minh Duc', 3200.75),
('Vo Thanh Em', 150.00),
('Do Thi Hoa', 8000.00),
('Bui Quang Huy', 420.25),
('Dang Phuong Linh', 12000.00),
('Hoang Gia Minh', 60.00),
('Phan Thanh Nam', 980.90);

select * from accounts where id = 1;

start transaction;
update accounts set balance = balance + 100 where id = 1;
commit;

select * from accounts where id = 1;