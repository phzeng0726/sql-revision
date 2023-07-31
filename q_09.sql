-- Q9 查詢學過編號為01，並且學過編號為02課程的學生資訊

-- 雖然答案對但有點危險
-- select s.*
-- from student as s
-- join score as sc on s.s_id = sc.s_id
-- where sc.c_id = 01 or sc.c_id = 02 -- 修01或02課程
-- group by s.s_id 
-- having count(s.s_id) = 2 -- 數量為2 
-- ;

select s.*
from student s, score sc1, score sc2
where s.s_id = sc1.s_id
and s.s_id = sc2.s_id
and sc1.c_id = 01
and sc2.c_id = 02
;
