--데이터 조회(p.4)
--SQL은 대, 소문자를 구분하지 않음 vs Java는 대, 소문자 엄격히 구분함!
--테이블의 구조를 살펴보는 명령 :desc, describe


desc countries;
describe countries; -- 테이블의 각 컬럼
DESC countries;


SELECT * FROM countries;

SELECT *       -- select 절(=clause)
FROM countries;  -- from 절

SELECT country_id, country_name,region_id
FROM countries;

[예제 2-1] employees 테이블의 구조를 조회하시오
DESC empoloyees;

[예제 2-2] employees 테이블의 데이터를 모두 조회하시오 VS 사번, 이름 성 월급여
SELECT *
FROM employees;

SELECT employee_id, first_name, last_name, salary
FROM employees;







2.2 조건절
전체 데이터에서 특정 행 데이터를 제한하여 조회하기 위해서 조건절을 사용합니다.
/*
SELECT 컬럼1, 컬럼2,...          (3)원하는 컬럼만 조회
FROM 테이블 이름                 (1) 실행
WHERE 조건을 나열;               (2) 실행( = 필터링 조회)
*/
[예제2-3] 80번 부서원의 사원 정보를 조회하시오
--Space Bar를 눌러 명령과 컬럼, 조건들을 각각 구분하여 수동으로 적용
SELECT *
FROM employees
WHERE department_id = 80; --같다 연산자 : = (eaual)

-- 키보드의 Tab 키를 눌러 일정한 간격을 유지하면서 포맷형식을 수동으로 적용
SELECT  *
FROM    employees
WHERE   department_id = 80;

-- 블럭 씌우고 CTRL+F7 : 자동으로 SQL 포맷 형식을 적용
SELECT
FROM
WHERE

--전체 부서의 개수?
DESC departments;

SELECT  *
FROM departments;  --27 rows
