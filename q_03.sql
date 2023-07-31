-- Q3 查詢平均成績大於等於60分的同學的學生編號和學生姓名和平均成績

select a.*
from (
	select student.s_id, student.s_name, avg(score.s_score) as avg_score
	from student
	join score on student.s_id = score.s_id
	group by student.s_id
	) as a
where a.avg_score >= 60
;

-- 優化
select student.s_id, student.s_name, avg(score.s_score) as avg_score
from student
join score on student.s_id = score.s_id
group by student.s_id
having avg_score >= 60 -- group by分組後進行篩選的關鍵字
;