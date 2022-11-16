/*-----------------------------------   
    조건절을 구서하는 항못들의 분류
    1) 컬럼, 숫자, 문자
    2) 산술연산자: +, -, *, / 비교 연산자 : =, >=, <=, >, <, !=, <>, (문자) 연결 연산자:
    3) AND, OR, NOT : 논리 연산자
    4) LIKE, IN, BETWEEN, EXISTS, NOT
    5) IS NULL, IS NOT NULL
    6) ANY, SOME, ALL
    7)  함수(어떤작업을 수행하는 명령어의 단위)    (VS 프로시저)
    
2.3연산자
2.3.1 산술 연산자 : +, -, *, /
-- SELECT 절, WHERE 조건절
*/
SELECT 2+2, 2-1, 2*3, 4/2
FROM dual; --dual : 가짜 테이블 (+실제 존재하지 않는 가상의 테이블인 dual로 연산 처리)

[예제 2-4] 80번 부서 사원의 한 해 동안 받은 급여(=연봉)을 조회하시오
-- 사원들의 정보는 EPLOYEES 라는 테이블에 저장되어 있음.
-- 사원이 근무하는 부서의 정보는 DEPARTMENTS 라는 테이블에 저장되어 있음.
SELECT employee_id emp_id, last_name, salary *12 "Annual Salary"  -- 별칭(=alias, 별명)
FROM employees
WHERE department_id = 80; --34 rows

SELECT department_id, department_name, manager_id
FROM departments
WHERE department_id = 80; --34 rows

[예제2-5] 전체 사원들 중 한 해 동안 받은 급여가 12000인 사원을 조회하시오
-- 전체사원 조회
-- * : aesterisk, 만능 문자 / 모든 문자열을 대체 (= 모든 컬럼을 뜻함. 사번 ~ 부서 코드까지)
SELECT *
FROM employees
WHERE salary*12 = 120000;  --


2.3.2 연결 연산자 :||
-- 이름과 성을 연결하여 이름/성명 이라는 칼럼으로 조회할 때
SELECT employee_id, first_name || last_name full_name
FROM employees;

[예제 2-6] 사번이 101인 사원일 성명을 조회하시오
-- 여기서 성명은 이름+성명 조합, 흔히 FULLNAME 이라고 함.
SELECT employee_id 사번, first_name || '  ' || last_name 성명, department_id 부서이름
FROM employees
WHERE employee_id = 101;

--별칭(Alias)은 컬럼이 별칭 ==> 생략 가능
    1)공백을 두고 사용한다.
    2)키웨드로는 As 또는 as를 사용한다. 
    3별칭에 공백이 있으면 큰 따옴표로 묶어서 사용한다.
    
[예제 2-8] 사번이 101인 사원이 정보중 사번, 성명, 연봉, 부서를 조회하시오
SELECT 'hanul' company, employee_id, first_name ||' '||last_name, salary * 12 as "Annual Salary", department_id 부서이름
FROM employees
WHERE  employee_id = 101;

[예제 2-9] 급여가 3000 이하인 사원의 정보를 조회한다
SELECT employee_id, first_name ||' '||last_name, department_id, salary
FROM employees
WHERE Salary <= 3000;

--30번 부서, 50번 부서는 어떤 부서인지 부서명, 부서장(manager_id)를 알아보세요!

SELECT *
FROM departments
WHERE department_id = 30; --Purchasing

SELECT *
FROM departments
WHERE department_id = 50;--shipping

SELECT *
FROM departments
WHERE department_id = :num; --바인드 변수 pl/sql 파트에서

[예제2-10]부서코드가 80번을 초과하는 사원이 정보를 조회하시오
SELECT *
FROM employees
WHERE department_id > 80;