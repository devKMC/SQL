USE practice_sql;	


ALTER TABLE jeju ADD above_avg_spd BOOLEAN; # 평균
ALTER TABLE jeju ADD above_avg_dir BOOLEAN; # 방향
ALTER TABLE jeju ADD null_column1 DOUBLE; 
ALTER TABLE jeju ADD null_column2 DOUBLE;

UPDATE jeju					#업데이트 테이블명
SET above_avg_spd = true
WHERE speed_80m > 5.5; 

UPDATE jeju
SET above_avg_spd = false
WHERE speed_80m <= 5.5; 

UPDATE jeju					 
SET above_avg_dir = true
WHERE direction_50m > 160; 

UPDATE jeju
SET above_avg_dir = false
WHERE direction_50m <= 160; 

UPDATE jeju					 
SET null_column1 = speed_80m
WHERE speed_80m > 5.5; 

UPDATE jeju					 
SET null_column2 = direction_50m
WHERE direction_50m > 160; 



# 연산자 
# 산술연산자 : +, -, *, /, %
SELECT speed_80m + speed_76m + speed_70m + speed_35m AS total_speed
FROM jeju; 

SELECT (speed_80m + speed_76m + speed_70m + speed_35m)/4 AS avg_speed
FROM jeju;

# 비교연산자 (WHERE절에서 자주 사용)
-- SELECT employee_name, salary
-- FROM employees
-- WHERE salary >= 5000;
# true false 라는게 참 거짓 값이 나온다. (true false 글씨로 나오는게 아님)


# =: 좌항이 우항과 같으면 true
SELECT * FROM jeju WHERE observe_date = '2023-07-05';

# <>,!= : 좌항이 우항과 다르면 true 
SELECT * FROM jeju WHERE observe_date != '2023-07-05';
SELECT * FROM jeju WHERE observe_date <> '2023-07-05';

#<,<= : 좌항이 우항보다 작거나 같으면 true
SELECT * FROM jeju WHERE speed_80m < 3.5;
SELECT * FROM jeju WHERE speed_80m <= 3.5;

# >,>= : 좌항이 우항보다 크거나 같으면 true
SELECT * FROM jeju WHERE speed_80m > 3.5;
SELECT * FROM jeju WHERE speed_80m >= 3.5;

# <=> : 좌항과 우항이 모두 null이면 true
SELECT * FROM jeju WHERE null_column1 <=> null_column2;

# IS : 좌항과 우항이 같으면 true (키워드)
# IS NOT : 좌항이 우항과 다르면 true (키워드)

SELECT * FROM jeju WHERE above_avg_spd is TRUE;
SELECT * FROM jeju WHERE above_avg_dir is NOT FALSE;

# IS NULL : 좌항이 NULL이면 TRUE 
# IS NOT NULL : 좌항이 NULL이 아니면 true

SELECT * FROM jeju WHERE null_column1 IS NULL;
SELECT * FROM jeju WHERE null_column1 IS NOT NULL;

# BETWEEN min AND max : 좌항이 min보다 크거나 같으면서 max보다 작거나 같으면 true
# NOT BETWEEN min AND max : 좌항이 min보다 작거나 max보다 크면 true

SELECT * FROM jeju WHERE direction_50m BETWEEN 270 AND 360; #북서풍
SELECT * FROM jeju WHERE direction_50m NOT BETWEEN 270 AND 360; #북서풍

# IN() : 주어진 값중에 하나라도 일치하는 값이 존재하면 true
# NOT IN() : 주어진 값들이 모두 일치하지 않으면 true

SELECT * FROM jeju WHERE observe_date IN 
('2023-07-01', '2023-08-01', '2023-09-01', '2023-10-01', '2023-11-01', '2023-12-01');

SELECT * FROM jeju WHERE observe_date NOT IN 
('2023-07-01', '2023-08-01', '2023-09-01', '2023-10-01', '2023-11-01', '2023-12-01');

# 논리연산자
# AND (&&) : 좌항과 우항이 모두 true이면 true

SELECT * FROM jeju WHERE speed_80m > 4 AND direction_50m < 180;

# OR (||) : 좌항과 우항이 하나라도 true이면 true

SELECT * FROM jeju WHERE speed_80m > 4 OR direction_50m < 180;

# XOR : 좌항과 우항이 다르면 TRUE  (OR - AND) 

SELECT * FROM jeju WHERE speed_80m > 4 XOR direction_50m < 180;

# LIKE 연산자 : 문자열을 비교할 때 패턴을 기준으로 비교 
# % : 임의의 개수 ( 0 ~ 무한대)의 문자 :
# _ : 임의의 한 개 문자

# 문자열을 가져오는 것	
SELECT * FROM jeju WHERE observe_date LIKE '20%';			#시작하는 값
SELECT * FROM jeju WHERE observe_date LIKE '%08';			#끝나는 값
SELECT * FROM jeju WHERE observe_date LIKE '%08%';			#시작과 끝 상관없이 값을 가지고 있는 값
SELECT * FROM jeju WHERE observe_date LIKE '20_';			#20? 20으로 시작하고 3개의 값     
SELECT * FROM jeju WHERE observe_date LIKE '2023-__-08';	#2023-??-08 값   

# 정렬
# ORDER BY : 쿼리 결과를 기준으로 정렬
# ASC : 오름 차순 정렬
# DESC : 내림 차순 정렬 
# ORDER BY column1 [ASC|DESC], column2 [ASC|DESC], ...; ex) 컬럼 1 정렬후 중복값 안에서 다시 컬럼 2 정렬을 함

SELECT * FROM jeju ORDER BY speed_80m ASC;
SELECT * FROM jeju ORDER BY speed_80m DESC;
SELECT * FROM jeju ORDER BY observe_date DESC;

# 중복 제거
# DISTINCT: SELECT 결과 테이블에서 컬럼의 조합의 중복을 제거하여 출력
SELECT DISTINCT above_avg_spd FROM jeju; 					#이 컬럼에는 0, 1밖에 없음
SELECT DISTINCT above_avg_spd, above_avg_dir FROM jeju; 	
SELECT DISTINCT * FROM jeju; 	

