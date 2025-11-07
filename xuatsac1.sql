CREATE TABLE xuatsac1.students
(
    student_id SERIAL PRIMARY KEY,
    full_name  VARCHAR(100),
    major      VARCHAR(50)
);

CREATE TABLE xuatsac1.courses
(
    course_id   SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    credit      INT
);

CREATE TABLE xuatsac1.enrollments
(
    student_id INT REFERENCES xuatsac1.students (student_id),
    course_id  INT REFERENCES xuatsac1.courses (course_id),
    score      NUMERIC(5, 2)
);

INSERT INTO xuatsac1.students (full_name, major)
VALUES ('Nguyen Van A', 'Computer Science'),
       ('Tran Thi B', 'Information Technology'),
       ('Le Van C', 'Data Science'),
       ('Pham Thi D', 'Software Engineering'),
       ('Hoang Van E', 'Cyber Security'),
       ('Do Thi F', 'Artificial Intelligence'),
       ('Vu Van G', 'Computer Engineering');

INSERT INTO xuatsac1.courses (course_name, credit)
VALUES ('Database Systems', 3),
       ('Operating Systems', 4),
       ('Computer Networks', 3),
       ('Machine Learning', 4),
       ('Web Development', 3),
       ('Data Structures', 3),
       ('Cyber Security', 4);

INSERT INTO xuatsac1.enrollments (student_id, course_id, score)
VALUES (1, 1, 85.5),
       (1, 2, 78.0),
       (2, 3, 88.0),
       (3, 4, 92.5),
       (4, 1, 80.0),
       (5, 5, 75.0),
       (6, 6, 90.0),
       (7, 7, 83.0);

--Cau 1
select s.full_name as "Tên sinh viên", c.course_name as "Tên môn học", e.score as "Điểm"
from xuatsac1.students s
         join xuatsac1.enrollments e on s.student_id = e.student_id
         join xuatsac1.courses c on c.course_id = e.course_id;

--Cau 2
select s.student_id,
       avg(e.score) as "Điểm trung bình",
       max(e.score) as "Điểm cao nhất",
       min(e.score) as "Điểm thấp nhất"
from xuatsac1.students s
         join xuatsac1.enrollments e on s.student_id = e.student_id
group by s.student_id;

--Cau 3
select s.major, avg(e.score) as "Điểm trung bình"
from xuatsac1.students s
         join xuatsac1.enrollments e on s.student_id = e.student_id
group by s.major
having avg(e.score) > 7.50;

--Cau 4
select s.student_id as id, s.full_name as name, c.course_name as course, c.credit as credit, e.score as score
from xuatsac1.students s
         join xuatsac1.enrollments e on s.student_id = e.student_id
         join xuatsac1.courses c on c.course_id = e.course_id;

--Cau 5

/*
    1.Lấy điểm của sinh viên toàn trường
    1.Lấy điểm trung bình sinh vien toàn trường
    2. Lấy điểm trung bình của sinh viên cao hơn điểm trung bình toàn trường
*/
select s.student_id, s.full_name, avg(e.score) as "Điểm trung bình"
from xuatsac1.students s
         join xuatsac1.enrollments e on s.student_id = e.student_id
group by s.student_id
having avg(e.score) > (select avg(score) as "Điểm trung bình"
                       from (select e.score as score
                             from xuatsac1.students s
                                      join xuatsac1.enrollments e on s.student_id = e.student_id
                             group by s.student_id, e.score));

--Cau 6
select s.student_id, s.full_name, e.score as score
from xuatsac1.students s
         join xuatsac1.enrollments e on s.student_id = e.student_id
where e.score >= 9
union
select s.student_id, s.full_name, e.score as score
from xuatsac1.students s
         join xuatsac1.enrollments e on s.student_id = e.student_id
         join xuatsac1.courses c on c.course_id = e.course_id
where c.course_id is not null;

select s.student_id, s.full_name, e.score as score
from xuatsac1.students s
         join xuatsac1.enrollments e on s.student_id = e.student_id
where e.score >= 9
intersect
select s.student_id, s.full_name, e.score as score
from xuatsac1.students s
         join xuatsac1.enrollments e on s.student_id = e.student_id
         join xuatsac1.courses c on c.course_id = e.course_id
where c.course_id is not null;