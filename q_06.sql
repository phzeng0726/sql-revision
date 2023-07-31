-- Q6 查詢“李”姓老師的數量

select count(t_name) as lee_count
from teacher
where t_name like "李%" -- 模糊查詢萬用字元
;