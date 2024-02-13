USE practice_sql;

# 서브쿼리: 쿼리 내부에 위치하는 또 다른 쿼리,
	  --  쿼리 결과를 조건이나 테이블로 사용할 수 있도록 함

# WHERE 절에서 서브쿼리: 쿼리 결과를 조건으로 사용하여, 조건을 동적으로 지정 
# WHERE 절에서 비교 연산으로 사용될 때 조회하는 컬럼의 개수 및 레코드 개수 주의
SELECT * FROM employee 
WHERE department_code = (
		SELECT code FROM department WHERE name = '인사부'
);

# FROM 절에서 서브쿼리: 쿼리 결과 테이블을 다시 FROM절에 사용하여 복합적인 테이블 조회    //사용방법만 보기
SELECT * FROM (
	SELECT name AS employee_name, department_code
    FROM employee
    WHERE department_code IS  null
) AS SQ									# 별칭 지정을 꼭 해줘야함 이름이라고 지정할 것이 없기때문에 
WHERE employee_name = '홍길동';           # 별칭을 지정하게되면 항상 일관성을 확인해야함

SELECT * FROM (
	SELECT name AS employee_name, department_code
    FROM employee
    WHERE department_code IS  null
) AS SQ									 
WHERE employee_name = '홍길동';          

# ex) 부서 이름이 '개발부'인 사원이름, 부서코드, 부서명을 조회	 (조인 : 무조건 2개 이상의 테이블) (서브쿼리 불가)
# ex) 부서 이름이 '개발부'인 사원이름, 부서코드 조회			 (조인가능) (서브쿼리 가능)    

# 코드 작성 순서 (접근방법) (1)  부서이름이 개발부인 데이터
SELECT * FROM department
WHERE department = '개발부';

# (2) 그안에 코드
SELECT code
FROM department
WHERE department = '개발부';

# (3) 사원이름과 부서코드에 있는 것을 조회 (최종)
SELECT name, department_code
FROM employee
WHERE department_code =(
	SELECT code
    FROM department
    WHERE name = '개발부'
);