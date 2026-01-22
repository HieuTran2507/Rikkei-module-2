use session6;

-- Thêm một đơn hàng mới vào bảng orders và chi tiết của đơn hàng đó vào bảng order_details.
insert into orders value
(1006, 5, 20250202);
insert into order_details value
(1006, 104, 2, 1099.00);

-- Tính tổng doanh thu của toàn bộ cửa hàng.
select sum(quantity*price) as `tổng doanh thu` from order_details;

-- Tính doanh thu trung bình của mỗi đơn hàng.
select 
	order_id,
    avg(price*quantity) `doanh thu trung bình`
from order_details
group by order_id;


-- Tìm và hiển thị thông tin của đơn hàng có doanh thu cao nhất.
select 
	order_id `đơn có doanh thu cao nhất`,
    sum(price*quantity) `doanh thu cao nhất`
from order_details
group by order_id
order by `doanh thu cao nhất` desc limit 1;

-- Tìm và hiển thị danh sách 3 sản phẩm bán chạy nhất dựa trên tổng số lượng đã bán.
select 
	p.product_name,
    od.quantity
from products p
inner join order_details od on p.id = od.product_id
order by od.quantity desc limit 3; 


