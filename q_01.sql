use demo; 
-- Q1 查詢”01"課程比”02"課程成績高的學生的資訊及課程分數
-- 優化前 --  
select a.s_id, a.s_name, a.s_birth, a.s_sex, c_01_s_score, c_02_s_score
from (select student.s_id, student.s_name, student.s_birth, student.s_sex, score.s_score as c_01_s_score
	from student 
	join score on student.s_id = score.s_id
	where score.c_id = 01) as a
join (select student.s_id, score.s_score as c_02_s_score
	from student 
	join score on student.s_id = score.s_id
	where score.c_id = 02) as b
on a.s_id = b.s_id
where c_01_s_score> c_02_s_score;


-- 方法1
select 
	a.*
	,b.s_score as 1_score  
	,c.s_score as 2_score
from student a
join score b on a.s_id = b.s_id  and b.c_id = '01'   -- 方法1兩個表透過學號連線，指定01
left join score c on a.s_id = c.s_id and c.c_id='02' or c.c_id is NULL -- 指定02，或者c中的c_id直接不存在
-- 為NULL的條件可以不存在，因為左連線中會直接排除c表中不存在的資料，包含NULL
where b.s_score > c.s_score;   -- 判斷條件

-- 方法2：直接使用where語句
select 
	a.*
	,b.s_score as 1_score
	,c.s_score as 2_score
from student a, score b, score c
where a.s_id=b.s_id   -- 列出全部的條件
and a.s_id=c.s_id
and b.c_id='01'
and c.c_id='02'
and b.s_score > c.s_score;   -- 前者成績高