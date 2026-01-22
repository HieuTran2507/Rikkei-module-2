use session6;

-- Tìm các sản phẩm có giá nằm trong một khoảng cụ thể
select * from products where price between 1000 and 2000;

-- Tìm các sản phẩm có tên chứa một chuỗi ký tự nhất định
select * from products where product_name like '%o%';

-- Tính giá trung bình của sản phẩm cho mỗi danh mục
select 
	c.id `id danh mục`,
    c.category_name `tên danh mục`,
    avg(p.price) `giá trung bình`
from categories c 
inner join products p on c.id = p.category_id
group by c.id, c.category_name;

-- Tìm những sản phẩm có giá cao hơn mức giá trung bình của toàn bộ sản phẩm
select * from products p 
where p.price >= (
	select avg(price) from products
);

-- Tìm sản phẩm có giá thấp nhất cho từng danh mục
select 
	p.category_id,
    c.category_name,
    p.product_name, 
    p.price
from products p 
inner join (
	select 
		p1.category_id,
		min(p1.price) as `min price`
	from products p1
	group by p1.category_id 
) as pp
on p.category_id = pp.category_id 
and p.price = pp.`min price`
inner join categories c on pp.category_id = c.id;



