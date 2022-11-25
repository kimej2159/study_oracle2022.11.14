 -- 4장. 그룹함수
-- 집계함수 : SUM, MIN,..
-- 그룹함수 : Group by

-- 4.1 DISTINCT
-- 함수는 함수명() 형태   vs   SYSDATE
-- hr 스키마 : 여러 테이블중 Employees 테이블의 정보중 employee_id가 주 식별자(Primary Key = Not NULL + Unique)
DESC employees;

-- 테이블의 제약조건 : 식별자 등...
select constraint_name, constraint_type
from user_constraints
where table_name = 'EMPLOYEES';

-- PK (=Primary Key) : 주 식별자, 주키
-- FK (=Foreign Key, 다른 테이블에서의 PK가 참조하는 테이블의 FK 관계) : 외래 키
-- NN (=Not Null) : 널을 허용하지 않음
-- UK (=Unique Key) : 중복을 허용하지 않지만 Null 허용
-- ※ PK = UK + NN (PK는 중복과 NULL을 허용하지 않음)


[예제4-1] 사원들이 소속된 부서를 조회하는 쿼리를 작성
SELECT DISTINCT department_id -- 부서코드를 중복되지 않게 (=중복된 부서코드는 제거하고, 나머지를 조회)
FROM    employees;

[예제4-1] 사원들이 소속된 부서를 사번과 함게 조회
SELECT DISTINCT department_id, employee_id
FROM    employees;

-- DISTINCT는 SELECT 목록의 모든 컬럼에 적용된다.
-- DISTINCT로 department_id, employee_id를 조회하면 department_id와 employee_id를 조합한 결과가
-- 중복되지 않는 데이터들을 조회해준다.

--[연습문제4-1]
--1. 사원테이블에서 이 회사의 매니저들을 조회하는 쿼리문을 작성하시오
SELECT DISTINCT manager_id "매니저의 번호(=사번)"
FROM    employees
ORDER BY manager_id;

-- 매니저 정보
SELECT employee_id, first_name, last_name, department_id, job_id, hire_date
FROM    employees
WHERE   employee_id IN (100,101,102,103,108,114);


-- 4.2 집계함수
-- 함수의 형태 : 하나의 결과행을 반환(COUNT,MAX,MIN,SUM,AVG)  vs 여러개의 결과행을 반환(DISTINCT)

-- 4.2.1 COUNT()
-- 데이터의 행이 몇 건이 존재하는지 갯수를 반환하는 함수
-- 데이터 값이 NULL인 행은 제외된다.
[예제4-3]
SELECT  COUNT(*) cnt1, COUNT(employee_id) cnt2, COUNT(department_id) cnt3, 
        COUNT(DISTINCT department_id) cnt3
FROM    employees;

-- 4.2.2 SUM()
-- 숫자 데이터 컬럼의 전체 합계를 계산한 결과를 반환하는 함수
-- 오라클 숫자 데이터 타입 : NUMBER
-- ※ 오라클에서 INT나, DOUBLE, LONG, FLOAT, TINYINT,.. 다른 프로그래밍 언어의 숫자 데이터 타입을 사용하면?
-- 내부적으로 다~ NUMBER 취급

CREATE TABLE tax (
    id INT PRIMARY KEY,
    title CHAR(10),
    source VARCHAR(10)    
);
/*
Table TAX이(가) 생성되었습니다.

이름     널?       유형           
------ -------- ------------ 
ID     NOT NULL NUMBER(38)   <--- INT로 설계했지만, 내부적으로는 NUMBER로 결정!!
TITLE           CHAR(10)     
SOURCE          VARCHAR2(10)
*/
DESC tax;

[예제4-4] 사원들의 급여 통계를 조회하시오
SELECT COUNT(*) "총 사원수", TO_CHAR(SUM(salary), '9,999,999') "급여 총계",
        TO_CHAR(ROUND(SUM(salary) / 107), '9,999,999') "1인당 급여 평균"
FROM    employees;

-- 4.2.3 MAX() 와 MIN()
-- 데이터 컬럼에서 가장 큰 값을 반환하는 함수 : MAX()
--                "  작은       "        : MIN()
SELECT employee_id, last_name, MAX(salary), MIN(salary)
FROM    employees;
/* 원인 : 집계함수와 함께 사용한 일반 컬럼은 group by 절에 명시해야 함
ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
00937. 00000 -  "not a single-group group function"
*/


SELECT MAX(salary), MIN(salary)
FROM    employees;

-- 4.2.4 AVG()
-- 컬럼의 평균값을 계산하는 함수
-- 성적 평균 = 총계 /  과목 수

SELECT ROUND(AVG(salary)) 평균, SUM(salary) 합계, COUNT(employee_id) "총 사원수"
FROM    employees;



-- 4.3 GROUP BY 절
-- GROUP BY 절에 특정 조건을 사용해서 데이터 행을 하나의 그룹으로 나눌 수 있다 (DISTINCT)
-- GROUP BY 절에는 그룹 짓는 기준의 컬럼을 지정한다.
-- 그룹함수(COUNT, SUM, AVG, MAX, MIN) 사용시 일반 컬럼을 GROUP BY 절에 지정해야 함
-- ※ 그렇지 않으면 오류 발생 : ORA

[예제4-8] 부서별 급여 총액, 부서별 사원의 수, 부서별 평균 급여를 조회하는 쿼리를 작성하시오
-- 부서코드가 없는 사원 : 1명
-- 총 사원수(사원+사장님) : 107명
SELECT  department_id, SUM(salary) total_sal, COUNT(department_id) cnt, ROUND(AVG(salary)) avg_sal
FROM    employees  -- 691416,	106,	6462
GROUP BY department_id;
/* 그룹함수와 일반컬럼을 함께 SELECT절에 사용할 경우, GROUP BY 절에 일반 컬럼을 지정해야 함.
ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
00937. 00000 -  "not a single-group group function"
*/

[예제4-9] 부서별, 업무별 급여총액, 평균급여를 조회하는 쿼리를 작성하시오
SELECT  department_id, job_id, SUM(salary), AVG(salary)
FROM    employees
GROUP BY department_id, job_id;

-- =========================================================================
-- SELECT 목록에 사용된 그룹함수 이외의 컬럼은 반드시 GROUP BY 절에 명시해야 한다.
-- 그러나, GROUP BY 절에 명시된 컬럼은 SELECT 절에 사용되지 않아도 된다.
-- =========================================================================

SELECT  SUM(salary), AVG(salary)
FROM    employees
GROUP BY department_id, job_id;

/* SQL 전체 작성 순서
SELECT
FROM
WHERE   -- 일반 조건절
GROUP BY
HAVING  -- 일반 조건절, 그룹함수 조건절
ORDER BY -- 항상 마지막!!
*/

[예제4-10] 80번 부서의 급여 총액과 평균급여를 조회하는 쿼리를 작성하시오
SELECT  department_id, SUM(salary) sum_salary, ROUND(AVG(salary)) avg_salary
FROM    employees
WHERE   department_id = 80
GROUP BY department_id; 


-- 4.4 HAVING 절
-- HAVING 절을 사용하여 그룹을 제한한다.
-- WHERE 절에는 조건을 HAVING 절에도 사용할 수 있지만,
-- 그룹함수가 포함된 조건은 HAVING 절에서만 사용한다.

[예제4-11] 80번 부서의 평균급여를 조회하시오
SELECT ROUND(AVG(salary)) avg_sal -- 전체 사원의
FROM    employees
WHERE   department_id = 80; -- 80번부서의 평균 8,956$ vs 전체사원평균 6,461$

-- 80번 부서에 소속된 사원의 수 : 34명
SELECT count(*)
FROM    employees
WHERE   department_id = 80;

[예제4-12] 부서에 소속된 사원의 수가 5명 이하인 부서와 그 수를 조회하시오
-- COUNT(*) vs COUNT(employee_id) : 내부 연산속도는 * 빠름
SELECT  department_id, COUNT(*)
FROM    employees
--WHERE  COUNT(*) <= 5  -- (x)
GROUP BY department_id
HAVING  COUNT(*) <= 5   -- (o)
ORDER BY 1;
/* 원인 : WHERE 절에 그룹함수 조건을 명시해서 발생 --> HAVING 절에 그룹함수 조건을 명시
ORA-00934: 그룹 함수는 허가되지 않습니다
00934. 00000 -  "group function is not allowed here"
*/

-- 일반 조건을 HAVING 절에 사용하는것 : 가능~
SELECT  department_id, count(employee_id) emp_count
FROM    employees
GROUP BY department_id
HAVING  department_id = 80; -- WHERE 절을 대신한 HAVING 절



-- 4.5 ROLLUP과 CUBE
-- GROUP BY 절에 사용하는 함수로 마치 엑셀의 피벗 테이블 기능처럼, 소계나 합계를 계산해서 반환하는 함수
-- 분석용 함수로 구분가능


-- 4.5.1 ROLLUP : GROUP BY 구문에 의한 단계별 소계, 총계
[예제4-13] 부서별 사원의 수와 급여합계, 총계를 조회하는 쿼리를 작성하시오
SELECT department_id 부서코드, COUNT(*) 사원수, SUM(salary) 합계
FROM    employees
WHERE   manager_id IS NOT NULL
GROUP BY CUBE(department_id)
ORDER BY 1;


-- 4.5.2 CUBE : GROUP BY 구문에 의한 모든 경우의 조합에 대한 소계, 총계를 구할 수 있다.

-- 데이터 분석가를 위한 함수(, 개발자도 사용할 수 있지만..) : ROLLUP, CUBE

[예제4-15] 부서 내 업무별 사원의 수, 급여합계, 부서별 소계, 업무별 소계, 총계를 조회하는 쿼리를 작성하시오
SELECT job_id
FROM    employees;

SELECT department_id, job_id, COUNT(*), SUM(salary)
FROM    employees
WHERE   manager_id IS NOT NULL
--GROUP BY ROLLUP(department_id, job_id)
GROUP BY CUBE(department_id, job_id)
ORDER BY 1;