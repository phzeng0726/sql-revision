-- Q10 查詢學過01課程，但是沒有學過02課程的學生資訊
-- 01 集合 - 02 集合
SELECT s.*
FROM student s
JOIN score sc1 ON s.s_id = sc1.s_id AND sc1.c_id = '01'
LEFT JOIN score sc2 ON s.s_id = sc2.s_id AND sc2.c_id = '02'
WHERE sc2.s_id IS NULL;