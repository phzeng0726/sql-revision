-- Q8 找出沒有學過張三老師課程的學生
select * 
from student
where student.s_id not in (
	select s.s_id -- 修過張三課程的學生
	from teacher as t
	left join course as c on t.t_id = c.t_id
	left join score as sc on sc.c_id = c.c_id
	left join student as s on s.s_id = sc.s_id
	where t_name = '張三'
);

