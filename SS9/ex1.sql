create database session9;

use session9;

create table customers (
	id int primary key,
    customer_name varchar(50) not null,
    email varchar(100) not null,
    phone varchar(10) not null,
    address varchar(255) not null
);

INSERT INTO customers (id, customer_name, email, phone, address) VALUES
(1, 'Nguyen Van An',   'an.nguyen@gmail.com',   '0912345678', 'Ho Chi Minh City'),
(2, 'Tran Thi Binh',   'binh.tran@gmail.com',   '0987654321', 'Ha Noi'),
(3, 'Le Van Cuong',    'cuong.le@gmail.com',    '0901122334', 'Da Nang'),
(4, 'Pham Thi Dung',   'dung.pham@gmail.com',   '0933445566', 'Can Tho'),
(5, 'Hoang Minh Duc',  'duc.hoang@gmail.com',   '0977889900', 'Binh Duong'),
(6, 'Vo Thi Hanh',     'hanh.vo@gmail.com',     '0966554433', 'Dong Nai'),
(7, 'Dang Quoc Huy',   'huy.dang@gmail.com',    '0944221100', 'Hai Phong'),
(8, 'Bui Ngoc Lan',    'lan.bui@gmail.com',     '0922334455', 'Vung Tau');


create unique index idx_email on customers(email);
create index idx_phone on customers(phone);

explain
select * from customers where email = 'dung.pham@gmail.com';
