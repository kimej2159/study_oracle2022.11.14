-- 테이블 구조 조회
DESC 테이블명

-- 테이블 데이터 조회
SELECT 컬럼1, 컬럼2 
FROM 테이블

-- 테이블 데이터 조회 + 조건(=필터링)
SELECT 컬럼1, 컬럼2 
FROM 테이블
WHERE 조건들 나열...

-- SQL 조건절에 department_id [부서코드] 라는 컬럼, 비교연산자 (=), 상수값 80 으로 구성되어서 
-- 연산을 수행


/* ============================================
    조건절을 구성하는 항목의 분류 (p.5)
============================================ */

1) 컬럼, 숫자, 문자
2) 산술연산자(+, -, *, /), 비교 연산자(=, >=, <=, <, >, !=, <>), (문자)연결 연산자(||)
3) AND, OR, NOT : 논리 연산자
4) LIKE, IN, BETWEEN, EXISTS, NOT
5) IS NULL, IS NOT NULL
6) ANY, SOME, ALL
7) 함수(어떤 작업을 수행하는 명령어의 단위)  (vs 프로시저)


2.3 연산자
2.3.1 산술연산자 : +, -, *, /
-- SELECT 절, WHERE 절에 사용함.
SELECT 2 + 2, 2 - 1, 2 * 3, 4 / 2
FROM dual; -- dual : 가짜 테이블 (=실제 존재하지 않는 가상의 테이블인 dual로 연산 처리)

[예제2-4] 80번 부서 사원의 한 해 동안 받은 급여(=연봉)을 조회하시오
-- 사원들의 정보는 EMPLOYEES 라는 테이블에 저장되어 있음.
-- 사원이 근무하는 부서의 정보는 DEPARTMENTS 라는 테이블에 저장되어 있음.
SELECT  employee_id emp_id, last_name, salary * 12 "Annual Salary" -- 별칭(=Alias, 별명)
FROM    employees
WHERE   department_id = 80; -- 34 rows, 34명이나 근무하는 80번 부서는 무슨일을 하는 곳일까? SALE(=판매부서)

--SELECT department_id, department_name, manager_id
--FROM departments
--WHERE department_id = 80;

[예제2-5] (전체 사원들 중) 한 해 동안 받은 급여가 120000인 사원을 조회하시오
-- 전체 사원을 조회
-- * : aesterisk, 만능문자 / 모든 문자열을 대체 (= 모든 컬럼을 뜻함. 사번~ 부서코드까지)
SELECT *
FROM    employees
WHERE   salary*12 = 120000; -- salary는 월급여 <---> 12000은 연봉(=한 해동안 받은 급여)








