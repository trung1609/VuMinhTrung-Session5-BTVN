CREATE TABLE gioi2.customers
(
    customer_id   SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    city          VARCHAR(50)
);

-- Thêm dữ liệu vào customers
INSERT INTO gioi2.customers (customer_name, city)
VALUES ('Nguyễn Văn A', 'Hà Nội'),
       ('Trần Thị B', 'Đà Nẵng'),
       ('Lê Văn C', 'Hồ Chí Minh'),
       ('Phạm Thị D', 'Cần Thơ'),
       ('Vũ Minh E', 'Hải Phòng');


CREATE TABLE gioi2.orders
(
    order_id     SERIAL PRIMARY KEY,
    customer_id  INT REFERENCES gioi2.customers (customer_id),
    order_date   DATE,
    total_amount NUMERIC(10, 2)
);


INSERT INTO gioi2.orders (customer_id, order_date, total_amount)
VALUES (1, '2024-12-20', 30000.00),
       (2, '2025-01-05', 15000.00),
       (1, '2025-02-10', 2500.00),
       (3, '2025-02-15', 4000.00),
       (4, '2025-03-01', 8000.00);


CREATE TABLE gioi2.order_items
(
    item_id      SERIAL PRIMARY KEY,
    order_id     INT REFERENCES gioi2.orders (order_id),
    product_name VARCHAR(100),
    quantity     INT,
    price        NUMERIC(10, 2)
);


INSERT INTO gioi2.order_items (order_id, product_name, quantity, price)
VALUES (1, 'Chuột không dây Logitech', 2, 15000.00),
       (2, 'Bàn phím cơ Keychron', 1, 15000.00),
       (3, 'Tai nghe Sony', 5, 500.00),
       (4, 'Màn hình Samsung', 4, 1000.00),
       (5, 'Ổ cứng SSD 1TB', 1, 8000.00);
--Cau 1
select c.customer_name, o.order_date, o.total_amount
from gioi2.customers c
         join gioi2.orders o on c.customer_id = o.customer_id;

--Cau 2
select sum(o.total_amount) as total_revenue,
       avg(o.total_amount) as average_order,
       max(total_amount)   as max_order,
       min(total_amount)   as min_order,
       count(o.order_id)   as order_count
from gioi2.customers
         join gioi2.orders o on customers.customer_id = o.customer_id;

--Cau 3

select c.city, sum(o.total_amount) as total
from gioi2.customers c
         join gioi2.orders o on c.customer_id = o.customer_id
group by c.city
having sum(o.total_amount) > 10000;

-- Cau 4
select c.customer_name, o.order_date, od.quantity, od.price
from gioi2.customers c
         join gioi2.orders o on c.customer_id = o.customer_id
         join gioi2.order_items od on o.order_id = od.order_id;

--Cau 5
select c.customer_id, c.customer_name as name, sum(o.total_amount) as total_revuene
from gioi2.customers c
         join gioi2.orders o on c.customer_id = o.customer_id
group by c.customer_id
having sum(total_amount) = (select max(total_revuene)
                            from (select c.customer_id, c.customer_name as name, sum(o.total_amount) as total_revuene
                                  from gioi2.customers c
                                           join gioi2.orders o on c.customer_id = o.customer_id
                                  group by c.customer_id));

--Cau 6
select distinct c.city
from gioi2.customers c
where c.city is not null;
union
select distinct c.city
from gioi2.orders o join gioi2.customers c on c.customer_id = o.customer_id
where c.city is not null;

select distinct c.city
from gioi2.customers c
where c.city is not null;
intersect
select distinct c.city
from gioi2.orders o join gioi2.customers c on c.customer_id = o.customer_id
where c.city is not null;
