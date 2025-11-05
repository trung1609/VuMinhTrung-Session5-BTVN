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

select p.category ,sum(o.total_price) as total_sales, sum(o.quantity) as total_quantity
from kha1.orders o join kha1.products p on o.product_id = p.product_id
group by p.category;

select p.category, sum(o.total_price) as total_price
from kha1.orders o join kha1.products p on p.product_id = o.product_id
group by p.category
having sum(o.total_price) > 2000;

select o.product_id,p.product_name, sum(o.total_price) as total_price
from kha1.orders o join kha1.products p on o.product_id = p.product_id
group by o.product_id, p.product_name
order by sum(total_price) desc ;


