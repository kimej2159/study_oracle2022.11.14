--[예제 2-16] 30번 부서의 급여가 10000미만인 사원과 60번 부서의 급여가 5000이상인 사원의 정보를 조회한다.
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE (department_id = 30 AND Salary < 10000)
OR (department_id = 60 AND Salary >= 5000);

--60번 부서의 정보를 조회
SELECT *
FROM departments
WHERE  department_id = 60

2.3.5  BETWEEN (범위 조건 연산자)
-- BETWEEN 초기갑 and 마지막값 : 초기값 이상, 마지막값 이하(포함)
--WHERE 조건 >= 값 OR 조건 <= 값;

[예제2-18] 사번이 110번 부터 120번까지의 사원 정보를 조회한다. --BETWEEN 사용
SELECT *
FROM employees
-- WHERE employee_id >= 110 and employee_id <=120;  
WHERE employee_id between 110 AND 120;

[예제2-19] 사번이 110번 부터 120번까지의 사원 중 급여가 5000에서 10000사이의 사원의 정보를 조회한다. --BETWEEN 사용
SELECT *
FROM employees
WHERE employee_id between 110 AND 120
and Salary between 5000 AND 10000;

[예제2-21]사번이 110번 미만 120번 초과의 사원 정보를 조회한다. -- OR 사용
SELECT *
FROM employees 
WHERE employee_id < 110 OR employee_id > 120;

 --BETWEEN 초기값 AND 마지막값 : 해당 구간
 --NOT BETWEEN 초기값 AND 마지막값 : 해당 구간 
 -- WHERE NOT 조건컬럼  BETWEEN 초기값 AND 마지막값 : 해당 구간
 
SELECT *
FROM employees 
WHERE NOT employee_id between 110 AND 120;


 
[예제 2-23] 2005년 1월 1일 이후붙너 2007 년 12월 31일 사이에 입사한 사원의 정보를 조회하시오
SELECT employee_id, first_name, last_name,hire_date, salary, department_id
FROM employees
WHERE Hire_date between '05.01.01' and '07.12.31';

--기본 NLS 파라미터 설명
SELECT *
FROM V$nls_parameters;  --database 설정값 조회(뷰)

SELECT *
FROM nls_database_parameters; --database 설정값 조회(테이블)

SElECT *
FROM emp_details_view;

--------------------------------------형변환(casting) 함수
-- 1. TO_DATE() : 어떤 데이터를 날짜 포맷으로 변환하는 함수
-- JAN : january , 1월을 나타내는 문자 --> 01(월) 로 바꾸는 함수
-- 2. TO_CHAR() : 어떤 숫자를 문자로 포맷 변환하는 함수
-- 3. 그 밖의 내장 함수들이 많이 있지만, 변환하는 함수중 자주 쓰이는 것 3가지!
---------------------------------------------------------------------

SELECT TO_DATE('05-JAN-01', 'RR-MM-DD')
FROM dual;


2.3.5 IN 연산자
-- 여러개의 값 중 일치하는 값이 존재하는 지를 비교하는 연산자
[예제2-25] 30번 부서원, 60번 부서원, 90번 부서원의 사원 정보를 조회하시오.
SELECT employee_id, first_name, last_name,hire_date, salary, department_id
FROM employees
WHERE department_id = 30
OR department_id = 60
OR department_id = 90;

SELECT employee_id, first_name, last_name,hire_date, salary, department_id
FROM employees
WHERE department_id IN (30, 60, 90);

SELECT employee_id, first_name,commission_pct comm, last_name,hire_date, salary, department_id
FROM employees
WHERE last_name IN ('King', 'Grant');

--IN + NOT ==> WHERE 조건 NOT IN(값1, 값2 ,,,)
--30번, 60번, 90번 이외의 부서에 소속된 사원의 정보를 조회한다
SELECT employee_id, first_name ||' '|| last_name, commission_pct comm,hire_date, salary, department_id
FROM employees
WHERE NOT employee_id in (30, 60, 90);

2.3.6 LIKE 조건 연산자 (=문자열의 패턴을 찾는 연산자)
-- Regular Expression : REGEXP (정규식, 정규표현)
-- 컬럼값들중 특정 문자열 패턴에 속하는 값을 찾는 연산자
-- % : 여러 개의 문자열을 나타낸다.
-- _ : 하나의 문자를 나타낸다.


[예제2-28] 이름(=first_name vs 성= last_name)이 K로 시작하는 사원의 정보를 조회하시오
SELECT *
FROM employees
WHERE first_name Like 'K%'
OR first_name Like 'P%';

[예제2-29]성이 s로 끝나는 사원의 정보를 조회하시오.
SELECT employee_id, last_name, commission_pct comm,hire_date, salary, department_id
FROM employees
WHERE last_name Like 'S%';  --18rows

[예제2-30] 이름에 b가 들어가 있는 사원의 정보를 조회하시오
SELECT employee_id, last_name, commission_pct comm,hire_date, salary, department_id
FROM employees
WHERE first_name Like '%b%'

[예제2-30]email의 세번째 문자가 B인 사원의 정보를 조회하시오.
SELECT email, employee_id, last_name, commission_pct comm, hire_date, salary, department_id
FROM employees
WHERE email Like '__B%'; --3번째이니까 __ 필수, 뒷자리는 상관 없으니 %표시

[예제2-30] 전화번호가 6으로 시작하지 않는
-- NOT + BETWEEN, NOT + IN, NOT + LIKE ?
SELECT email, employee_id, last_name, commission_pct comm, hire_date, salary, department_id
FROM employees
WHERE phone_number LIKE '6_3%';
--WHERE NOT phone_number LIKE '6_3%';
--WHERE phone_number LIKE '6_3%';

SELECT email, employee_id, last_name, commission_pct comm, hire_date, salary, department_id
FROM employees;

-----------------------------------------
-- %나 _자체를 문자열로 조회하고자 할때

[예제2-34] 테이블에서 JOB_ID 컬럼에 _A가 들어간 사원의 정보를 조회하시오.
SELECT email, employee_id, last_name, JOB_ID, hire_date, salary, department_id
FROM employees
WHERE JOB_ID LIKE '%_A%';

--ESCAPE 처리 : 특정 문자열로 인식시킬수가 있음.
--오라클에서는 ESCAPE 식별자를 사용해서 %나 _를 하나의 문자 자체로 검색할 수 있다.

[예제2-35] JOB_ID에서 _A가 들어간 사원의 정보를 조회하시오.
SELECT employee_id, last_name, JOB_ID, hire_date, salary, department_id
FROM employees
WHERE JOB_ID LIKE '%\_A%' ESCAPE '\';





