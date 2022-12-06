-- 7장 . SET 연산자 (P.63)
-- hr, co 스키마 활용
-- 교사용 PC/Study_oracle/Extras에 있는 HWP, PDF 참조하여 개별 설치

--join subquery : 종속적인 관계에서 테이블의 데이터를 조회  -->서브쿼리에는 메인쿼리가 최종 조회하는 데이터를 결정
-- SET 연산 : 수평관게


-- SQL에서도 수학에서 사용하는 집합의 개념처럼 (VS 조인 ,서브쿼리는 종속적인 관계)
-- 서로다른 결과의 쿼리 실행 결과를 합칠 수 있다.
-- 1) UNION : 합집합
-- 2) UNION ALL : 
-- 3) INTERSECT : 교집합
-- 4) MINUS : 차집합
/*
[1, 2, 3] ∪ [4, 5] <---> [1, 2, 3, 4, 5]
[1, 2, 3] ∪ [3, 4, 5] <---> [1, 2, 3, 4, 5]
*/

[예제7-1] UNION -- 테이블을 합치며 중복을 제거
--중복을 제거한 행의 결과를 반환
-- 열의 개수가 맞지 않으면 오류 발생 : ORA-01789
-- 
--NULL 허용 
SELECT 1, 3, 4, 5, 7, 8, 'A' first
from dual
UNION 
select 1, 4, 5, 6, 8,  null, 'B' second
from dual
UNION
SELECT 1, 3, 4, 5, 7, 8, 'A' first
from dual;

[에제 7-2]관리되고 있는 부서, 관리되고있는 도시 정보를 조회하시오
DESC departments;
DESC employees;

select *
from departments;

select department_id code, department_name name
from hr.departments
union    
select location_id, city
from hr.locations
union   
select customer_id, full_name
from co.customers
UNION
SELECT ROWNUM id, job_id
from hr.jobs;

--SYSTEM 계정등에서 권한을 부여
--GRNAT 권한1, 권한2,  권한 TO 계정명;
-- EX) HR 계정을 SYSTEM에서 생성하고 권한을 부여하는 경우 
--GRANT create table, connect, resources, DBA to HR;
--! DBA가 관리자 권한 !


[예제 7-3] 관리되고 있는 도시와 국가 정보를 조회하시오
desc locations;
desc countries;

select TO_CHAR(location_id) code, city name
from locations
union
select NULL, country_name           --CHAR, VARCHAR2
from countries;
-- 7.2 UNION ALL
-- UNION VS UNJOIN :중복을 제거 VS 중복을 포함

-- 7.3 INTERSECT
-- 교집합
-- [ 1, 2, 3, 4] ∩ [2,4,6] = [2]

[예제 7-7] 80번 부서와 50번 부서에 공통으로 있는 사원의 이름을 조회하시오
SELECT first_name
from employees
where department_id = 80       -- 34
INTERSECT
SELECT first_name
from employees
where department_id = 50       -- 45

-- PETER, JOHN

--7.4 MINUS 차집합
-- 집합에서 차집합에 해다앟는 연산
-- [1,2,3,4] - [2, 4, 6] = [1, 3, 5]
SELECT first_name
from employees
where department_id = 80       -- 34
MINUS
SELECT first_name
from employees
where department_id = 50       -- 45    // 30

--8장 DML
--DATA Manipulation lang : 데이터 조작어/명령어
--1) SELECT : 조회
--2) INSERT : 새로운 데이터 삽입
--3) UPDATE : 기존의 데이터를 갱ㅅ니
--4) DELETE :  기존의 데이터를 삭제 
-- DML은 TCL(=Transaction Control Language)과 함께
--Rollback : 이전에 수행한 명령을 취소한느 트랜잭션 제어 명령어

-- 8.1 INSERT
-- 1. 컬럼을 명시하는 경우 : 갯수만큼 값을 삽입, 순서에 따라 데이터의 종류
-- INSERT INTO 테이블명 (컬럼명1, 컬럼명2, ...)
-- VALUES (값1, 값2,,,)

--2. 컬럼을 생략하는 경우 : 테이블의 모든 컬럼에 대응하는 값을 입력
-- INSERT INTO 테이블명
--VALUES (값1, 값2,,..)

-- 저장하지 않는 컬럼값은 자동으로 NULL이 저장된다.
SAVEPOINT SP1;   --SP1 이라는 세이브포인트 이름 / 어느만큼 작업이 진행 되었는지 간략히 표시
COMMIT;

[예제8-1] 사번, 이름, 성, 입사일을 300, 'Steven', 'Jobs', sysdate 행을 삽입하라
-- emp 생성

CREATE TABLE emp (
    emp_id NUMBER PRIMARY KEY,
    fname VARCHAR2(20),
    lname VARCHAR2(20),
    Hire_date date default sysdate
    
);

drop table emp;
--1. 테ㅣ블의 구조만 복사해서 생성하는 방법
create table emp AS
select employee_id emp_id, first_name fname, last_name lname,
        hire_date, job_id, salary, commission_pct comm_pct, 
        department_id dept_id
from employees;                     -- 완전 복사
where 1=2;      -- 거짓조건으로 조회한 결과를 토대로 emp를 생성/ 테이블만 생성
                -- 제약조건도 복사됨
select *
from emp;
    
--rollback;

--2. 데이터 행 삽입
INSERT INTO emp (emp_id, fname, lname, hire_date, job_id)
VALUES (300, 'Steven', 'Jobs', to_date('2022/12/02'), ('RR/MM/DD'));


desc emp;

INSERT INTO emp (emp_id, fname, lname, hire_date, job_id)
VALUES (301,'Bill', 'Gates', sysdate, 'ST_MAN');

INSERT INTO 
select employee_id emp_id , first_name fname, last_name lname, hire_date, job_id
         salary, NVL(commission_pct, 0), department_id dept_id
from employees
where department_id = 30;

select *
from emp;



