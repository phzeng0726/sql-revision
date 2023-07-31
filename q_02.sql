-- Q2 查詢”01"課程比”02"課程成績低的學生的資訊及課程分數（題目1是成績高）

select student.*, s1.s_score as 01_score, s2.s_score as 02_score
from student, score as s1, score as s2
where student.s_id = s1.s_id
and student.s_id = s2.s_id
and s1.c_id = 01
and s2.c_id = 02
and s1.s_score<s2.s_score
;