CREATE TABLE gioi1.customers
(
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city          VARCHAR(50)
);

INSERT INTO gioi1.customers (customer_id, customer_name, city)
VALUES (1, 'Nguyễn Văn A', 'Hà Nội'),
       (2, 'Trần Thị B', 'Đà Nẵng'),
       (3, 'Lê Văn C', 'Hồ Chí Minh'),
       (4, 'Phạm Thị D', 'Hà Nội');



CREATE TABLE gioi1.orders
(
    order_id    INT PRIMARY KEY,
    customer_id INT,
    order_date  DATE,
    total_price INT,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

INSERT INTO gioi1.orders (order_id, customer_id, order_date, total_price)
VALUES (101, 1, '2024-12-20', 3000),
       (102, 2, '2025-01-05', 1500),
       (103, 1, '2025-02-10', 2500),
       (104, 3, '2025-02-15', 4000),
       (105, 4, '2025-03-01', 800);



CREATE TABLE gioi1.order_items
(
    item_id    INT PRIMARY KEY,
    order_id   INT,
    product_id INT,
    quantity   INT,
    price      INT,
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

INSERT INTO gioi1.order_items (item_id, order_id, product_id, quantity, price)
VALUES (1, 101, 1, 2, 1500),
       (2, 102, 2, 1, 1500),
       (3, 103, 3, 5, 500),
       (4, 104, 2, 4, 1000);
-- Cau 1
select c.customer_id, sum(o.total_price) as total_revenue, count(o.order_id) as order_count
from gioi1.customers c
         join gioi1.orders o on c.customer_id = o.customer_id
group by c.customer_id
having sum(o.total_price) > 2000;

-- Cau 2
--1.Doanh thu cua tung khach hang
--2.Trung binh doanh thu cua cac khach hang
select c.customer_id, sum(o.total_price) as total_revenue
from gioi1.customers c
         join gioi1.orders o on c.customer_id = o.customer_id
group by c.customer_id
having sum(total_price) > (select avg(total_revenue)
                           from (select c.customer_id, sum(o.total_price) as total_revenue
                                 from gioi1.customers c
                                          join gioi1.orders o on c.customer_id = o.customer_id
                                 group by c.customer_id));

--Cau 3
/*
1.Lay doanh thu cua cac thanh pho
2.Lay doanh thu cua thanh pho lon hon hoac bang tat ca doanh thu thanh pho
*/
select c1.city, sum(o1.total_price)
from gioi1.customers c1
         join gioi1.orders o1 on c1.customer_id = o1.customer_id
group by c1.city
having sum(o1.total_price) >= All (select sum(o.total_price) as total_revenue
                                   from gioi1.customers c
                                            join gioi1.orders o on c.customer_id = o.customer_id
                                   group by c.city);

-- Cau 4
select c.customer_id,c.city ,sum(oi.quantity) as quantity, sum(o.total_price) as total_price
from gioi1.customers c
         join gioi1.orders o on c.customer_id = o.customer_id
         join gioi1.order_items oi on o.order_id = oi.order_id
group by c.customer_id, c.city;


