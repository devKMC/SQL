USE practice_sql;

CREATE TABLE jeju2 
AS
SELECT * FROM jeju;

UPDATE jeju2 SET observe_date = '7월 상반기'
WHERE observe_date BETWEEN '2023-07-01' AND '2023-07-15';
UPDATE jeju2 SET observe_date = '7월 하반기'
WHERE observe_date BETWEEN '2023-07-16' AND '2023-07-31';
UPDATE jeju2 SET observe_date = '8월 상반기'
WHERE observe_date BETWEEN '2023-08-01' AND '2023-08-15';
UPDATE jeju2 SET observe_date = '8월 하반기'
WHERE observe_date BETWEEN '2023-08-16' AND '2023-08-31';
UPDATE jeju2 SET observe_date = '9월 상반기'
WHERE observe_date BETWEEN '2023-09-01' AND '2023-09-15';
UPDATE jeju2 SET observe_date = '9월 하반기'
WHERE observe_date BETWEEN '2023-09-16' AND '2023-09-31';

SELECT * FROM jeju2;

# 그룹화(GROUP BY): 레코드를 하나 이상의 컬럼으로 그룹하여 결과를 도출하고자 할때 사용
# 일반적으로 집계함수와 함께 사용됨 
SELECT observe_date FROM jeju2 GROUP BY observe_date;
SELECT observe_date,speed_80m FROM jeju2 GROUP BY observe_date;
SELECT observe_date,speed_80m FROM jeju2 GROUP BY observe_date,speed_80m;
SELECT observe_date, AVG(speed_80m) FROM jeju2 GROUP BY  observe_date;
  
#  필터링(HAVING): 그룹화된 결과에 필터링을 적용하는 명령어
-- 주의! WHERE 절과 사용방법이 같지만 WHERE 절은 SELECT
-- 이전에 실행되고 HAVING절은 SELECT 이후에 실행됨  

# jeju2라는 곳에는 avg가 없고 이 안에서 만든것 결과를 필터링함 (WHERE랑 좀 다름)
SELECT observe_date, AVG(speed_80m) AS avg 
FROM jeju2 
GROUP BY observe_date
having avg> 5.5;

# 실행되지 않음
SELECT observe_date, AVG(speed_80m) AS avg 
FROM jeju2 
GROUP BY observe_date
having speed_80m > 5.5;
  
# WHERE를 사용하여 실행가능 (WHERE의 경우 순서를 잘 확인해야함)
SELECT observe_date, AVG(speed_80m) AS avg 
FROM jeju2 
WHERE speed_80m > 5.5
GROUP BY observe_date;







