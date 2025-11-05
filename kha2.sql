create table kha1.products(
                              product_id serial primary key ,
                              product_name varchar(50),
                              category varchar(50)
);

create table kha1.orders(
                            order_id serial primary key ,
                            product_id int references kha1.products(product_id),
                            quantity int,
                            total_price numeric(10,2)
);

insert into kha1.products(product_name, category) VALUES
                                                      ('Laptop Dell','Electronics'),
                                                      ('Iphone 15','Electronics'),
                                                      ('Bàn học gỗ', 'Furniture'),
                                                      ('Ghế xoay','Furniture');
insert into kha1.orders(product_id, quantity, total_price) VALUES
                                                               (1,2,2200),
                                                               (2,3,3300),
                                                               (3,5,2500),
                                                               (4,4,1600),
                                                               (1,1,1100);


--Viết truy vấn con (Subquery) để tìm sản phẩm có doanh thu cao nhất trong bảng orders
--1.Lấy tổng doanh thu các sản phẩm
--2.Lấy doanh thu lớn nhất >= doanh thu của các sản phẩm
select p1.product_id
from kha1.products p1 join kha1.orders o1 on p1.product_id = o1.product_id
group by p1.product_id
having sum(o1.total_price) >= All (
select sum(total_price) as total_price
from kha1.products p join kha1.orders o on p.product_id = o.product_id
group by p.product_id);
intersect
select p1.product_id, sum(total_price)
from kha1.products p1 join kha1.orders o1 on p1.product_id = o1.product_id
group by p1.product_id
having sum(total_price) >= ALL (
select sum(o.total_price)
from kha1.products p join kha1.orders o on p.product_id = o.product_id
group by p.product_id
having sum(o.total_price) >3000);


select p.category, sum(o.total_price) as total
from kha1.products p join kha1.orders o on p.product_id = o.product_id
group by p.category;

