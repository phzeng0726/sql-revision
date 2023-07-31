-- Q7 查詢學過張三老師授課的同學的資訊
-- select student.*, score.c_id
-- from student
-- join score on student.s_id = score.s_id
-- where score.c_id in (
-- 	select c_id -- 取 c_id
-- 	from course
-- 	join teacher on teacher.t_id = course.t_id
-- 	where teacher.t_name = "張三"
-- )
-- ;

-- 優化
select s.* from teacher t
left join course c on t.t_id=c.t_id  -- 教師表和課程表
left join score sc on c.c_id=sc.c_id  -- 課程表和成績表
left join student s on s.s_id=sc.s_id  -- 成績表和學生資訊表
where t.t_name='張三';