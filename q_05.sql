-- Q5 查詢所有同學的學生編號、學生姓名、選課總數、所有課程的總成績

select student.*, count(score.c_id) as couse_count, sum(score.s_score) as total_score
from student
left join score on student.s_id = score.s_id
group by student.s_id
;
