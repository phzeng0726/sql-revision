-- Q4 查詢平均成績小於60分的同學的學生編號和學生姓名和平均成績（包括有成績的和無成績的）
select student.s_id, student.s_name, avg(score.s_score) as avg_score
from student
join score on student.s_id = score.s_id
group by student.s_id
having avg_score < 60
union -- 兩個查詢結果合併
select student.s_id, student.s_name, score.s_score
from student
left join score on student.s_id = score.s_id
where s_score is null
;

-- 優化
-- 如果為null的時候給預設值
select student.s_id, student.s_name, avg(ifnull(score.s_score, 0)) as avg_score
from student
left join score on student.s_id = score.s_id
group by student.s_id
having avg_score < 60
;

-- having or
select student.s_id, student.s_name, avg(score.s_score) as avg_score
from student
left join score on student.s_id = score.s_id
group by student.s_id
having avg_score < 60 or avg_score is null
;