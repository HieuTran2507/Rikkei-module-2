create database session12;

use session12;

-- 1. Bảng customers (Khách hàng)
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO customers (customer_id, name, email, phone, address) VALUES
(1, 'Nguyen Van A', 'vana@gmail.com', '0901234567', 'TP.HCM'),
(2, 'Tran Thi B', 'thib@yahoo.com', '0912345678', 'Da Nang'),
(3, 'Le Van C', 'vanc@outlook.com', '0988888888', 'Ha Noi'),
(4, 'Hoang Minh Tu', 'tu.hoang@gmail.com', '0945123456', 'Can Tho'),
(5, 'Pham Thanh Thao', 'thao.pham@gmail.com', '0932111222', 'Hai Phong');

-- 2. Bảng orders (Đơn hàng)
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) DEFAULT 0,
    status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);
INSERT INTO orders (order_id, customer_id, total_amount, status) VALUES
(1, 1, 30500000.00, 'Completed'), -- (iPhone + AirPods)
(2, 2, 28000000.00, 'Pending'),   -- (MacBook)
(3, 4, 40500000.00, 'Completed'), -- (iPad + Keyboard)
(4, 5, 10500000.00, 'Cancelled');  -- (Apple Watch)

-- 3. Bảng products (Sản phẩm)
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO products (product_id, name, price, description) VALUES
(1, 'iPhone 15 Pro', 25000000.00, 'Apple smartphone'),
(2, 'MacBook Air M2', 28000000.00, 'Apple Laptop'),
(3, 'AirPods Pro 2', 5500000.00, 'Wireless Earbuds'),
(4, 'iPad Pro M4', 32000000.00, 'OLED Display'),
(5, 'Magic Keyboard', 8500000.00, 'Accessories'),
(6, 'Apple Watch S9', 10500000.00, 'Smartwatch');

-- 4. Bảng order_items (Chi tiết đơn hàng)
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
-- Đơn 1: iPhone (1) + AirPods (3)
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 25000000.00),
(1, 3, 1, 5500000.00);
-- Đơn 2: MacBook (2)
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(2, 2, 1, 28000000.00);
-- Đơn 3: iPad (4) + Keyboard (5)
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(3, 4, 1, 32000000.00),
(3, 5, 1, 8500000.00);
-- Đơn 4: Watch (6)
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(4, 6, 1, 10500000.00);

-- 5. Bảng inventory (Kho hàng)
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);
INSERT INTO inventory (product_id, stock_quantity) VALUES
(1, 50), (2, 30), (3, 100), (4, 20), (5, 15), (6, 40);

-- 6. Bảng payments (Thanh toán)
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Credit Card', 'PayPal', 'Bank Transfer', 'Cash') NOT NULL,
    status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);
INSERT INTO payments (order_id, amount, payment_method, status) VALUES
(1, 30500000.00, 'Credit Card', 'Completed'),
(2, 28000000.00, 'Bank Transfer', 'Pending'),
(3, 40500000.00, 'PayPal', 'Completed');

SELECT 
    o.order_id, 
    c.name AS customer_name, 
    p.name AS product_name, 
    oi.quantity,
    oi.price,
    o.status AS order_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;



-- 1) Tạo Trigger kiểm tra số lượng tồn kho trước khi thêm sản phẩm vào order_items. Nếu không đủ, báo lỗi SQLSTATE '45000'.
drop trigger if exists trig_insert_order_items;
delimiter //
create trigger trig_insert_order_items before insert
on order_items for each row
begin
	declare v_stock int;
    select stock_quantity into v_stock from inventory i where i.product_id = new.product_id;
	if v_stock < new.quantity then
		signal sqlstate '45000' set message_text = 'số lượng tồn kho không đủ';
	end if;
end //
delimiter ;
-- test trường hợp không đủ tồn kho
insert into order_items (order_id,product_id,quantity,price) values
(2,6,100000,1234567);
-- test trường hợp đủ tồn kho 
insert into order_items (order_id,product_id,quantity,price) values
(2,6,2,1234567);
select * from order_items;

-- 2) Tạo Trigger cập nhật total_amount trong bảng orders sau khi thêm một sản phẩm mới vào order_items.
drop trigger if exists trig_update_total_amount;
delimiter //
create trigger trig_update_total_amount after insert 
on order_items for each row
begin
	update orders set total_amount = total_amount + new.price where order_id = new.order_id;
end //
delimiter ;
-- test total amount trong bảng orders có tăng lên không
select * from orders; 
insert into order_items (order_id,product_id,quantity,price) values
(2,6,2,1234567);
select * from orders;

-- 3) Tạo Trigger kiểm tra số lượng tồn kho trước khi cập nhật số lượng sản phẩm trong order_items. 
-- Nếu không đủ, báo lỗi SQLSTATE '45000'.
drop trigger if exists trig_check_stock;
delimiter //
create trigger trig_check_stock before update 
on order_items for each row
begin
	declare v_stock int;
    select stock_quantity into v_stock from inventory where product_id = new.product_id;
    if v_stock < new.quantity then 
		signal sqlstate '45000' set message_text = 'số lượng tồn kho không đủ';
	end if;
end //
delimiter ;
-- test trường hợp tồn kho không đủ
update order_items set quantity = 1000000000 where order_item_id = 1;
-- test trường hợp tồn kho đủ
select * from order_items;
update order_items set quantity = 2 where order_item_id = 1;
select * from order_items;

-- 4) Tạo Trigger cập nhật lại total_amount trong bảng orders 
-- khi số lượng hoặc giá của một sản phẩm trong order_items thay đổi.
drop trigger if exists trig_change_price_quantity;
delimiter //
create trigger trig_change_price_quantity after update
on order_items for each row
begin
	update orders set total_amount = total_amount - old.price * old.quantity + new.price * new.quantity 
    where order_id = new.order_id;
end // 
delimiter ;
-- test update total amount 
select * from orders;
update order_items set quantity = 2, price = 1111 where order_item_id = 1;
select * from orders;

-- 5) Tạo Trigger ngăn chặn việc xóa một đơn hàng có trạng thái Completed trong bảng orders. 
-- Nếu cố gắng xóa, báo lỗi SQLSTATE '45000'.
drop trigger if exists trig_prevent_delete_complete;
delimiter //
create trigger trig_prevent_delete_complete before delete 
on orders for each row
begin
    if old.status = 'Completed' then 
		signal sqlstate '45000' set message_text = 'trạng thái đã hoàn thành, không thể xóa được';
	end if;
end//
delimiter ;
-- test xóa orders trạng thái completed
select * from orders;
delete from orders where order_id = 1;
-- test xóa order trạng thái khác completed
delete from orders where order_id = 2;
select * from orders;

-- 6) Tạo Trigger hoàn trả số lượng sản phẩm vào kho (inventory) 
-- sau khi một sản phẩm trong order_items bị xóa
drop trigger if exists trig_return_product;
delimiter //
create trigger trig_return_product after delete 
on order_items for each row
begin
	update inventory set stock_quantity = stock_quantity + old.quantity
    where product_id = old.product_id;
end //
delimiter ;
-- test xóa order items, stock quantity tăng lên
select * from order_items;
select * from inventory;
delete from order_items where order_item_id = 6;
select * from inventory;

-- 7) Sử dụng lệnh DROP TRIGGER để xóa tất cả các Trigger đã tạo.
DROP TRIGGER IF EXISTS trig_insert_order_items;
DROP TRIGGER IF EXISTS trig_update_total_amount;
DROP TRIGGER IF EXISTS trig_check_stock;
DROP TRIGGER IF EXISTS trig_change_price_quantity;
DROP TRIGGER IF EXISTS trig_return_product;
DROP TRIGGER IF EXISTS trig_prevent_delete_complete;
