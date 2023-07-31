-- https://tw511.com/a/01/41709.html
-- 1、查詢課程編號為「01」的課程比「02」的課程成績高的所有學生的學號（難）
select s.s_id
from student s
join score sc1 on s.s_id = sc1.s_id
join score sc2 on s.s_id = sc2.s_id
where sc1.c_id = 01 and sc2.c_id = 02 and sc1.s_score > sc2.s_score;

-- 2、查詢平均成績大於60分的學生的學號和平均成績
select s.s_id, avg(sc.s_score) as avg_score
from student s
join score sc on s.s_id = sc.s_id
group by s.s_id
having avg_score > 60;

-- 3、查詢"所有"學生的學號、姓名、選課數、總成績
select s.s_id, s.s_name, count(s.s_id) as course_count, sum(sc.s_score) as total_score
from student s
left join score sc on s.s_id = sc.s_id
group by s.s_id;

-- 4、查詢姓「猴」的老師的個數
select count(t_id) as ho_count
from teacher
where t_name like '猴%';

-- 5、查詢沒學過「張三」老師課的學生的學號、姓名
select *
from student s1
where s1.s_id not in (
	select s2.s_id
	from student s2
	join score sc on s2.s_id = sc.s_id
	join (select c.c_id from teacher t join course c on t.t_id = c.t_id where t.t_name="張三") tc on sc.c_id = tc.c_id
);
-- TODO 所教的所有課? 還是只要有上過一堂就好?
-- 6、查詢學過「張三」老師所教的所有課的同學的學號、姓名
select s.s_id, s.s_name
from student s
join score sc on s.s_id = sc.s_id
where sc.c_id in (
	select c.c_id from teacher t join course c on t.t_id = c.t_id where t.t_name="張三"
);
-- 7、查詢學過編號為「01」的課程並且也學過編號為「02」的課程的學生的學號、姓名
select s.s_id, s.s_name
from student s 
join score sc on s.s_id = sc.s_id
left join score sc2 on s.s_id = sc2.s_id 
where sc.c_id = 01
and sc2.c_id = 02;

-- 8、查詢課程編號為「02」的總成績
select sum(sc.s_score) as total_score_02
from score sc
where sc.c_id = 02
group by c_id;

-- 9、查詢所有，課程成績小於60分的學生的學號、姓名
select s.s_id, s.s_name
from student s
left join score sc on s.s_id = sc.s_id
where sc.s_score < 60
or sc.s_score is null
;
-- 10、查詢沒有學全所有課的學生的學號、姓名
select s.s_id, s.s_name, count(s.s_id) as c_count
from student s
left join score sc on s.s_id = sc.s_id
group by s.s_id
having c_count != (select count(*) from course c)
;

-- 11、查詢至少有一門課與學號為「01」的學生所學課程相同的學生的學號和姓名 （難）
select distinct s2.s_id, s2.s_name
from student s2
join score sc2 on s2.s_id = sc2.s_id
where s2.s_id != 01
and sc2.c_id in (select sc.c_id
	from student s
	join score sc on s.s_id = sc.s_id
	where s.s_id = 01
);
-- 12、查詢和「01」號同學所學課程完全相同的其他同學的學號（難）
with sub as (
    select sc.c_id
    from student s
    join score sc on s.s_id = sc.s_id
    where s.s_id = '01'
)

select s.s_id, s.s_name
from student s
join score sc on s.s_id = sc.s_id
where sc.c_id in (select c_id from sub) and s.s_id != '01'
group by s.s_id, s.s_name
having count(distinct sc.c_id) = (select count(*) from sub);

-- 13、查詢沒學過"張三"老師講授的任一門課程的學生姓名
with sub as (
	select c.c_id
	from teacher t
	join course c on t.t_id = c.t_id
	where t.t_name = "張三"
)

-- select s2.s_name 
-- from student s2 
-- where s2.s_id not in (
-- 	select s.s_id
-- 	from student s
-- 	join score sc on s.s_id = sc.s_id
-- 	where sc.c_id in (select c_id from sub)
-- );

-- 優化版
select s.s_name
from student s
left join score sc on s.s_id = sc.s_id 
and sc.c_id in (select c_id from sub)
where sc.s_id is null;

-- 15、查詢兩門及其以上不及格課程的同學的學號，姓名及其平均成績
select s.s_id, s.s_name, avg(sc.s_score) as avg_score
from student s
join score sc on s.s_id = sc.s_id
where s_score < 60
group by s.s_id
having count(s.s_id) >= 2;
 
-- 16、檢索"01"課程分數小於60，按分數降序排列的學生資訊
-- 17、按平均成績從高到低顯示所有學生的所有課程的成績以及平均成績(難)
-- 18、查詢各科成績最高分、最低分和平均分：以如下形式顯示：課程ID，課程name，最高分，最低分，平均分，及格率，中等率，優良率，優秀率
-- 19、查詢學生的總成績並進行排名
-- 20、查詢不同老師所教不同課程平均分,從高到低顯示
-- 21、查詢學生平均成績及其名次
-- 22、按各科成績進行排序，並顯示排名(難)
-- 23、查詢每門功課成績最好的前兩名學生姓名
-- 24、查詢所有課程的成績第2名到第3名的學生資訊及該課程成績
-- 25、查詢各科成績前三名的記錄（不考慮成績並列情況）
-- 26、使用分段[100-85],[85-70],[70-60],[<60]來統計各科成績，分別統計各分數段人數：課程ID和課程名稱
-- 27、查詢每門課程被選修的學生數
-- 28、查詢出只有兩門課程的全部學生的學號和姓名
-- 29、查詢男生、女生人數
-- 30、查詢名字中含有"風"字的學生資訊
-- 31、查詢1990年出生的學生名單
32、查詢平均成績大於等於85的所有學生的學號、姓名和平均成績
-- 33、查詢每門課程的平均成績，結果按平均成績升序排序，平均成績相同時，按課程號降序排列
-- 34、查詢課程名稱為"數學"，且分數低於60的學生姓名和分數
-- 35、查詢所有學生的課程及分數情況
-- 36、查詢任何一門課程成績在70分以上的姓名、課程名稱和分數
-- 37、查詢不及格的課程並按課程號從大到小排列
-- 38、查詢課程編號為03且課程成績在80分以上的學生的學號和姓名
-- 39、求每門課程的學生人數
-- 40、查詢選修「張三」老師所授課程的學生中成績最高的學生姓名及其成績
-- 41、查詢不同課程成績相同的學生的學生編號、課程編號、學生成績 （難）
-- 42、統計每門課程的學生選修人數（超過5人的課程才統計）。要求輸出課程號和選修人數，查詢結果按人數降序排列，若人數相同，按課程號升序排列
-- 43、檢索至少選修兩門課程的學生學號
-- 44、查詢選修了全部課程的學生資訊
-- 45、查詢各學生的年齡
-- 48、查詢兩門以上不及格課程的同學的學號及其平均成績
-- 49、查詢本月過生日的學生
-- 50、查詢下一個月過生日的學生