-- Liệt kê sản phẩm cùng với tên danh mục tương ứng.
select 
	c.category_name,
    p.product_name
from categories c 
inner join products p 
on c.id = p.category_id;

-- Đếm số đơn hàng của từng khách hàng.
select 
	c.id,
    c.customer_name,
    ifnull(count(od.quantity),0) ` số đơn hàng`
from customers c 
left join orders o on c.id = o.customer_id
left join order_details od on o.id = od.order_id
group by c.id, c.customer_name;

-- Xác định 3 khách hàng có tổng doanh thu chi tiêu cao nhất.
select 
	c.customer_name,
    sum(od.quantity * od.price) `tổng doanh thu`
from customers c 
inner join orders o on c.id = o.customer_id
inner join order_details od on o.id = od.order_id
group by c.customer_name
order by `tổng doanh thu` desc limit 3;

-- Tìm các sản phẩm chưa từng xuất hiện trong bất kỳ đơn hàng nào.
select * from products;
insert into products value
(105,'Asus ROG',3569.78, 2),
(106, 'Sony Experia', 999.99, 1);

select p.* from products p 
left join order_details od
on p.id = od.product_id
where od.product_id is null;

-- Tìm những khách hàng đã mua sản phẩm thuộc danh mục có số lượng sản phẩm lớn nhất.
select 
	c.id,
    c.customer_name,
    p.product_name
from customers c 
inner join orders o on c.id = o.customer_id
inner join order_details od on o.id = od.order_id
inner join products p on od.product_id = p.id
where p.category_id = (
	select category_id 
	from products
	group by category_id
	having count(*) = (
		select max(cnt) from (
			select count(*) as cnt from products
			group by category_id
		) temp
	)
);



