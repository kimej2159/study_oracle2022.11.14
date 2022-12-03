-- p.9 논리 조건 연산자
-- 1. 현재 NLS 세팅 확인
SELECT *
FROM v$nls_parameters;

-- &&, ||, ! : 프로그래밍 언어마다 조금씩 다름
-- AND, OR를 혼합하여 문장을 작성
[예제 2-16] 30번 부서의 급여가 10000 미만인 사원과 60번 부서의 급여가 5000 이상인 사원 정보를 조회하시오

SELECT  employee_id, last_name, salary, department_id
FROM    employees
WHERE   (department_id = 30 AND  salary < 10000)
OR      (department_id = 60 AND  salary >= 5000); -- 7rows


-- 60번 부서의 정보를 조회
SELECT *
FROM    departments
WHERE   department_id = 60;

-- AND, OR를 혼합하여 문장을 작성할때 가독성을 위해 ()를 붙여 주는것이 좋다.


2.3.5 BETWEEN (범위 조건 연산자)
-- BETWEEN 초기값 AND 마지막값 : 초기값 이상, 마지막값 이하 (=값이 포함됨)
-- WHERE 조건 >= 값 OR 조건 <= 값;

[예제2-18] 사번이 110 부터 120번까지의 사원 정보를 조회하시오
--사번이 110, 111, 112, ... 120에 해당하는 사원들의 정보를 조회한다.
SELECT  employee_id, first_name, department_id, phone_number
FROM    employees
WHERE   employee_id >= 110
AND      employee_id <= 120;  -- 논리 (조건) 연산자 사용

SELECT  employee_id, first_name, department_id, phone_number
FROM    employees
WHERE   employee_id BETWEEN 110 AND 120; -- BETWEEN 범위 조건 연산자 사용

SELECT *
FROM    employees;


[예제 2-19] 사번이 110에서 120인 사원중 급여가 5000 에서 10000 사이의 사원 정보를 조회하시오
SELECT  employee_id, first_name, salary, department_id, job_id
FROM    employees
WHERE   employee_id >= 110 AND employee_id <=120
AND     salary >= 5000  AND salary <= 10000;

[예제2-20]
SELECT  employee_id, first_name, salary, department_id, job_id
FROM    employees
WHERE   employee_id BETWEEN 110 AND 120   -- employee_id >= 110 AND employee_id <=120
AND     salary BETWEEN 5000 AND 10000;    -- salary >= 5000  AND salary <= 10000;

-------------
SELECT *
FROM employees; -- 전체 사원 107명, 사번이 100번 부터 1씩 증가해서 206번까지 존재 / 부서는 10~270번까지 27개 존재
-------------

[예제2-21] 사번이 110번 미만, 120번 초과인 사원들의 정보를 조회하시오
SELECT  employee_id, first_name, salary, department_id, job_id
FROM employees
WHERE   employee_id < 110
OR      employee_id > 120;

-- BETWEEN 초기값 AND 마지막값 : 해당 구간
-- WHERE 조건컬럼 NOT BETWEEN 초기값 AND 마지막값 : 해당 구간이 아닌 구간(1)
-- WHERE NOT 조건컬럼 BETWEEN 초기값 AND 마지막값 : 해당 구간이 아닌 구간(2)
SELECT  employee_id, first_name, salary, department_id, job_id
FROM    employees
--WHERE   employee_id NOT BETWEEN 110 AND 120;
WHERE   NOT employee_id BETWEEN 110 AND 120;

-- ※ BETWEEN 이나 관계 연산자로 비교할 수 있는 값은 1)숫자 데이터, 2)문자데이터, 3)날짜 데이터 이다.
[예제 2-23] 입사일이 2005년 1월 1일 이후부터 2007년 12월 31일 사이에 입사한 사원의 정보를 조회하시오
-- '문자' 또는 '2022-11-18' 사용
SELECT  employee_id, first_name, hire_date, salary, department_id
FROM    employees
--WHERE   hire_date BETWEEN '05-01-01' AND '07-12-31';
--WHERE   hire_date BETWEEN '05/01/01' AND '07/12/31';
WHERE   hire_date BETWEEN '01-JAN-05' AND '31-DEC-07'; -- RR/MM/DD vs YY/MM/DD : 년/월/일 (RR 표기 : 19xx or 20xx)

-- 기본 NLS 파라미터 설정
SELECT *
FROM    v$nls_parameters;       -- database 설정값 조회(뷰==임시테이블

SELECT *
FROM    nls_database_parameters; -- database 설정값 조회(테이블)

-- hr 스키마에 작성되어 있는 사원 상세정보 view를 조회
SELECT *
FROM emp_details_view;

--======================= 형변환(Casting) 함수 ===================
-- 1.TO_DATE() : 어떤(=문자) 데이터를 날짜 포맷으로 변환하는 함수
-- JAN : January , 1월을 나타내는 문자 --> 01 (월)로 바꾸는 함수 (11g 기준, 21c는 오류)
-- 2.TO_CHAR() : 어떤 숫자를 문자 포맷으로 변환하는 함수
-- 3.TO_NUMBER() : 어떤 문자를 숫자로 변환하는 함수
-- 그밖의 내장 함수들이 많이 있지만, 변환하는 함수중 자주 쓰이는 것 3가지!!
-- ==============================================================


2.3.5 IN 연산자
-- 여러개의 값 중 일치하는 값이 존재하는지를 비교하는 연산자
[예제2-25] 30번 부서원, 60번 부서원, 90번 부서원의 사원 정보를 조회하시오
SELECT  employee_id emp_id, first_name fname, salary, commission_pct comm, department_id dept_id
FROM    employees
WHERE   department_id = 30
OR      department_id = 60
OR      department_id = 90;


SELECT  employee_id emp_id, last_name lname, salary, commission_pct comm, department_id dept_id
FROM    employees
WHERE   department_id IN (30, 60, 90);

SELECT  employee_id emp_id, last_name lname, salary, commission_pct comm, department_id dept_id
FROM    employees
WHERE   last_name IN ('King', 'Grant');

select *
from employees;

-- IN + NOT ==> WHERE 조건 NOT IN (값1,값2,..)   또는 WHERE NOT 조건 IN (값1, 값2, ..)
[예제2-27] 30번, 60번, 90번 이외의 부서에 소속된 사원들의 정보를 조회
SELECT  employee_id 사번, first_name ||' '||last_name 성명, department_id 부서코드
FROM    employees
--WHERE   department_id IN (30, 60, 90); 
--WHERE   NOT department_id IN (30, 60, 90); 
WHERE   department_id NOT IN (30, 60, 90); 

2.3.6 LIKE 조건 연산자 (=문자열의 패턴을 찾는 연산자)
-- Regular Expression : REGEXP (정규식, 정규표현식)
-- 컬럼값들중 특정 문자열 패턴에 속하는 값을 찾는 연산자,
-- % : 여러 개의 문자열을 나타낸다.
-- _ : 하나의 문자를 나타낸다.

[예제2-28] 이름(=first_name vs 성=last_name)이 K(=문자는 대,소문자를 가림 vs SQL 대,소문자를 가리지 않음)로
시작하는 사원의 정보를 조회 하시오

SELECT  employee_id, first_name, last_name, department_id, job_id
FROM    employees
WHERE   first_name LIKE 'K%';

[예제2-28] 성이 s로 끝나는 사원의 정보를 조회하시오
SELECT  employee_id, first_name, last_name, department_id, job_id
FROM    employees
WHERE   last_name LIKE '%s'; -- 18rows

[예제2-30] 이름에 b가 들어가 있는 사원의 정보를 조회하시오
SELECT  employee_id, first_name, last_name, department_id, job_id
FROM    employees
WHERE   first_name LIKE '%b%';

[예제2-31] 이메일의 세번째 문자가 B인 사원의 정보를 조회하시오
SELECT  employee_id, first_name, last_name, email, department_id
FROM    employees
WHERE   email LIKE '__B%'; -- 1rows

[예제2-31] 이메일의 뒤에서 세번째 문자가 B인 사원의 정보를 조회하시오
SELECT  employee_id, first_name, last_name, email, department_id
FROM    employees
WHERE   email LIKE '%B__'; -- 2rows

[예제2-33] 전화번호가 6으로 시작하지 않는 사원의 정보를 조회하시오
-- NOT + BETWEEN, NOT + IN, NOT + LIKE?
SELECT  employee_id, first_name, last_name, email, department_id, phone_number
FROM    employees
--WHERE   phone_number NOT LIKE '6%'; -- 6으로 시작하는 사원 : 46 rows, 6으로 시작하지 않는 사원 : 50 rows
WHERE   NOT phone_number LIKE '6%'; -- 6으로 시작하는 사원 : 46 rows, 6으로 시작하지 않는 사원 : 50 rows

-- xxx.xxx.xxxx : 6xx, 5xx, 0xx..

SELECT  employee_id, first_name, last_name, email, department_id, phone_number, job_id
FROM    employees;

-- ======================================================
-- %나 _ 자체를 문자열로 조회하고자 할때는?
-- ======================================================

[예제2-34] EMPLOYEES 테이블에서 JOB_ID 컬럼에 _A가 포함된 사원의 정보를 조회하시오
SELECT  employee_id, first_name, last_name, email, job_id, department_id
FROM    employees
WHERE   job_id LIKE '%_A%';

-- java : System.outprint("안녕, 나는 \"길동\"이야");

-- ESCAPE 처리 : 특정 문자열로 인식시킬수가 있음.
-- 오라클에서는 ESCAPE 식별자를 사용해서 %나 _를 하나의 문자 자체로 검색할 수 있다.
[예제2-35] JOB_ID에서 _A가 들어간 사원의 정보를 조회
SELECT  employee_id, first_name, last_name, email, job_id, department_id
FROM    employees
WHERE   job_id LIKE '%\_A%' ESCAPE '\';







