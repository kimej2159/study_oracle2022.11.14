--8장. DML
-- 수동을 COMMIT 이나 ROLLBACK;
-- 트랜잭션(Transaction, 거래/ 송금)

-- Data 조작 언어
-- 개발자들이 가장 많이 사용하는 문법 vs 모델러, DBA, 데이터 분석가
-- select, insert, update, delete

--8.1 데이터 삽입
-- insert into 테이블 (컬럼명 1, 컬럼명2,...) : 순서, 컬럼 갯수 중요
-- values (값1, 값2,...)

--insert into 테이블 : 모든 컬럼을 데이터 삽입(생략x)
--1.hr 스키마 ==> EMPLOYEES 테이블 중 일부 컬럼을 가져와서 EMP로 만드는 방법 : CTAS ( 조회된
--CREATE TABLE 테이블명
--SELECT 이하
-- 2.emp 라는 테이블을 직접 정의
DROP TABLE emp;

create table emp AS
SELECT employee_id emp_id, first_name fname, last_name lname,
        hire_date, job_id, salary,
        commission_pct comm_pct, department_id dept_id
from employees

desc emp;
select *
from emp;

select *                       -- 'emp' 테이블에 설정된 제약 조건 
from user_constraints
where table_name = 'EMPLOYEES'
        
INSERT INTO emp(emp_id, fname, lname, dept_id)
values (301, 'Bill', 'Gates', TO_CHAR('2013/05/26', 'YYYY/MM/DD'), 'SA_CLERK');     -- JOB_ID NOT NULL 제약 조건 때문에 데이터 삽입시 오류

-- 2. 'emp' 테이블 정의
CREATE TABLE emp (
    emp_id NUMBER PRIMARY KEY,
    fname VARCHAR2(20),
    lname VARCHAR2(20),
    Hire_date date default sysdate,
    JOB_ID VARCHAR2(20),
    SALARY NUMBER(9,2),
    COMM_PCT NUMBER(3,2),
    DEPT_ID NUMBER(3)
);

[예제 8-1]
INSERT INTO emp (emp_id, fname, lname, hire_date)
VALUES (300, 'Steven', 'Jobs' , sysdate);

commit; -- 소동으로 개발자가 커밋 (메모리 --> 물리적으로 저장)

TRUNCATE TABLE emp;     -- emp 테이블의 모든 데이터를 삭제 / 구조는 남김 ( 자동으로 commit)
ROLLBACK; -- 수동으로 롤백
SELECT * 
FROM EMP;

[예제 8-4]워렌버핏의 정보를 입력, NULL 또는 '' 빈문자열로 표시
INSERT INTO emp (emp_id, fname, lname, hire_date, job_id, salary)
VALUES (302, 'Warren', 'Buffett', sysdate, 'ST_CEO','');

[예제 8-5]
--ITAS : INSERT INTO 테이블 (AS 없음) SELECT 이하
INSERT INTO emp (emp_id, fname, lname, hire_date, job_id, dept_id);
select employee_id, first_name, last_name, hire_date, job_id, salary
from employees
where department_id in (10,20);

--CTAS : create table 테이블 AS SELECT 이하 

commit;

-- 월별 급여 관리 테이블 : month salary
DESC MONTH_salary;

select *
from month_salary;

[예제 8-6]
--
TRUNCATE TABLE month_salary;

select *
from month_salary;

rollback;
--ITAS
INSERT INTO month_salary (magam_date, dept_id)
select sysdate, department_id
from employees
where department_id IS NOT NULL
group by department_id

SELECT * FROM month_salary;
-- 나머지 NULL 채우려면, 다중컬럼 서브쿼리를 사용해서 UPDATE 구문 실행

[예제8-7] emp 테이블에 employees 테이블의 30번 부터 60번 까지의 부서에
        근무하는 사원의 정보를 조회하시오
insert into emp
select employee_id, first_name, last_name, hire_date, job_id,
        salary, commission_pct, department_id
from employees
where department_id between 30 and 60;

select * from EMP;
-------------------------------------------------------------------
-- INSERT INTO 테이블명 (컬럼명1, 컬럼명2,..) VALAUES
-- INSERT INTO 테이블명 VALUES(값1, 값2, ... 컬렴수 만큼)
-- INSERT INTO 테이블명 select 이하~ : ITAS(AS 없음)
-------------------------------------------------------------------
--8.2 데이터 변경 /UPDATE
--INSERT            VS UPDATE
-- 새로운 데이터 삽입   VS 기존 데이터를 변경해서 저장 (=갱신)

--UPDATE 텡블명
--SET 컬럼명 = 값
--WHERE 조건절 : WHERE 조건절 생략시 모든 행이 변경 대상 
-- UPDATE 구문 + 다중 컬럼 서브쿼리 : 테이블의 여러 행의 구문을 한꺼번에 업데이트 할 때 좋음
SELECT *
FROM EMPLOYEES;

UPDATE EMPLOYEES
SET SALARY = (SELECT MIN(salary) from employees);

rollback;

[예제 8-8]사번이 300번 이상인 사원의 부서코드를 20으로 변경한다
select * from emp;

update emp
set dept_id = 20
-- where emp_id>= 300;         -- 조건에 일치하는 행의 컬럼 데이터를 갱신 


[예제8-9]사번이 300번 이상인 사원의 급여, 커미션 백분율 , 업무코드를 변경한다
select * from emp;

update emp
set salary=2000,
    comm_pct=0.1,
    job_id='IT_PROG'
where emp_id=300;

select * from emp;
commit;
[예제 8-10] emp 테이블이 모든 사원들의 salary를 5000, 보너스 백분율을 0.4로 변경하시오
update emp
set salary = 5000,
    comm_pct=0.4;
select * from emp;

[예제5-11] 서브쿼리를 이용해서 emp 테이블 103 사원의 
    급여를 employees 테입ㄹ의 20번 부서의 최대급여로 변경 
-- 1.일반쿼리
select max(salary)
from employees
where department_id = 20;

update emp
set salary = 13000
where emp_id = 103;

INSERT INTO emp
SELECT  employee_id, first_name, last_name, hire_date, job_id, salary, commission_pct, department_id
FROM    employees
WHERE   employee_id = 103;

select * from emp;

--2. 서브쿼리로 데이터를 변경
-- 사용 위치 따라 : select절 (=스칼라) , from절 (= 인라인뷰), where 절 (= 일반적인 조건절)
-- 연관성(join연산) 유무 : 
-- 단일행 

update emp
set salary = (select max(salary)
                from employees
                where department_id = 20)
where emp_id = 103;

select * from emp;

[예제 8-12] emp 테이블의 사번 180번 사원과 같은 해에 입사한 사원들의 급여를
        employees 테이블 50번 부서의 평균 급여로 변결한다.
select *
from emp;

update emp
set = 50번 부서의 평균 급여
where = 180번 사원의 입사 년도

-- 1. 일반쿼리
select round(AVG(salary))
from employees
where department_id = 50;       -- 3476

select TO_CHAR(hire_date, 'yyyy')
from employees
where employee_id = 180

update emp
set salary = 3476
where TO_CHAR(hire_date, 'yyyy') = '2006;



-- 서브쿼리 
update emp
set salary = (select round(AVG(salary))
                from employees
                where department_id = 50)
where TO_CHAR(hire_date) = (select TO_CHAR(hire_date, 'yyyy')
                    from employees
                    where employee_id = 180)


select TO_CHAR(hire_date, 'yyyy')
from employees
where employee_id = 180


/*
TRUNCATE TABLE emp;
INSERT INTO emp;
SELECT employee_id, first_name, last_name, hire_date, salary, commission_pct, department_id
*/

[예제 8-14]다중 컬럼 서브쿼리로 MOMTH_SALARY의 모든 행의 컬럼 데이트를 업데이트 하시오
TRUNCATE TABLE month_salary;

SELECT *
FROM  month_salary;

UPDATE month_salary m
set (emp_cnt, sum_salary, avg_salary) = ( select count(*), sum(e.salary), round(AVG(e.salary))
                                            from employees e
                                            where e.department_id = m.dept_id
                                            group by e.department_id )

commit;
-- 1. maga_date, dept_id를 먼저 insert
-- 2. 다중컬럼 서브쿼리를 이용해서 emp_cntm sum_sal, avg_salary update
-- 단, update는 다중 컬럼 서브쿼리로 작성하시오

insert into month_salary (magam_date, dept_id)
select last_day(sysdate), department_id
from employees
where department_id IS NOT NULL
group by department_id;

--8.3 delete / 데이터 삭제
-- 조건에 명시된 데이터 행 (row)을 삭제하는 명령
-- where 절 생략시 모든 데이터 (=레코드) 삭제
-- rollback 으로 트랜잭션 처리 이전으로 돌아가기!!
/*
    delete from 테이블명
    where 조건절
*/
[예제 8-15] emp 테이블의 60번 부서의사원 정보를 삭제하시오
select *
from emp
where dept_id = 60;

delete from emp
where dept_id = 60;

rollback;

[예제 8-16] emp 테이블에서 모든 데이터를 삭제하시오
delete from emp;        -- 107개 행 이(가) 삭제되었습니다.
truncate table emp;     --  Table EMP이(가) 잘렸습니다.





-- 9장 . DDL
-- SQL : Strustured Query Languege --> 에스큐엘, 시퀄
-- 0) DQL : SELECT 
-- 1) DML : INSERT, UPDATE, DELETE
-- 2) DDL : CREATE, ALTER, DROP
-- 3) DCL : COMMIT, ROLLBACK


-- 1. 데이터베이스 객체 > 개발자가 프로젝트에서는 만듦 : 테이블
create table 테이블명 (
-- 컬럼명 데이터 타입 (byte 길이) 제약 조건, 
-- ....ect..
-- );

--2) CTAS : 다른 테이블의 조회된 데이터를 참조해서 (=복사하듯 기존 테이블의 구조와 데이터를 가져와 생성)
-- CREATE TABLE 테이블명 AS
-- FROM 참조 테이블명
-- WHERE 조건절
-- 제약조건중 일부 복사 되었으나 PK,FK, 등은 복사 안되었음

DESC departments;
-- 특정 테이블에 정의된 제약 조건을 조회하는 명령
-- 이름 : 관계,(PK -FK : 식별관계, JOIN 연산)
-- A테이블의 PK를 B테이블에서 FK로 사용하는 관계 : 식별관계(종속적인, 수직, 상하관계)
select *
from user_constraints
where table_name='DEPARTMENTS';

DESC EMPLOYEES;
rollback;

9.1 데이터 타입
1) 문자형 : 고정문자 vs 가변문자
1-1) 고정문자
- CHAR(n) : n 바이트 길이의 고정된 문자데이터 타입
   └ 영문 1자 : 1byte
- CHAR(char n) : n개의 문자로 고정하는 문자데이터 타입   
- NCHAR(n) : National CHAR(n) : 지역별로 다른 n 바이트 길이를 갖는 문자데이터
   └ 한글 1자 :  3~4 byte로 셋팅 [Oracle 판단]

1-2) 가변문자 : 바캐릭터2 vs 바차2
- VARCHAR(n) <---> 오라클에서 사용금지 : 다른 용도로 사용할 계획이라서, 가변문자는 VARCHAR2를 사용할 것!
- VARCHAR2(n) :  n 바이트 길이
- NVARCHAR2(n) :  National VARCHAR2(n)
※ sqlDeveloper > 메뉴 > 도구 > 환경설정 > 데이터베이스 > NLS > 길이 : BYTE 로 되어있음
   
   

2) 숫자형 : 정수 VS 소수
    - NUMBER  : 제한x
    - NUMBER(9,2) :  소수부 2, 정수부 7, 총 9자
3) 날짜형 : DATE
SELECT SYSDATE, SYSTIMESTAMP
FROM dual;

4)LOB, BLOB, LONG, RAW, ... 개발자가 사용하지 않는 타입
-- Double, Float 타입 --> 오라클에서는 number로 처리

--------------------------------------------------
-- 테이블 생성 규칙
--------------------------------------------------
-- 반드시 문자로 시작
-- 숫자도 사용 가능(문자 + 숫자)
-- 최대 30바이트(11g 기준, 21c 제한 없음)
-- 오라클 예약어를 사용할 수 없음
----------------------------------------------------------
-- 시스템이 사용하는 예약어(Keyword)로는 객체를 생성할 수 없다
----------------------------------------------------------
-- system 계정으로 변경해서 실행해 볼것 (권한)
--orcle 버전마다 갯수가 다름 : 21c는 2555개
select *
from V$reserved_words
order by 1;

-- 그럼에도 불구하고 꼭 사용해야하는 예약어는 ""로 묶어서 사용

[예제9-1] TMP 라는 테이블은 3byte 숫자 id 컬럼과 20byte 문자 fname 컬럼으로 이루어진 테이블이다. 이것을
생성하는 SQL을 작성하시오

CREATE TABLE TMP(
    id number(3),
    fname varchar2(20)
);

[예제9-2]-- 홍길동 데이터 삽입
INSERT INTO TMP
VALUES (1, '홍길동');

[예제9-3] 홍길동을 홍명보로 1번 선수를 변경
UPDATE TMP
SET fname='홍명보'
where id =1;

--삭제하세요
delete from TMP;        --rollback 가능 commit 수동
TRUNCATE TABLE TMP      -- rollback 불가능 commit 자동


[예제9-4] 부서테이블의 데이트를 복사하여 dept1 테이블을 생성하시오
-- CTAS : create table 테이블명 as select 이하~      / 테이블 생성
-- ITAS : INSERT INTO 테이블명 SELECT 이하 ~       / 데이터 입력

rollback;

CREATE TABLE dept1 AS
SELECT *
FROM departments;

desc dept1;

select *
from dept1;

[예제 9-5] 사원테이블의 사번, 이름, 입사일 컬럼의 데이터를 복사해서 emp20으로 생성
DROP TABLE EMP20;
create table EMP20 as
select employee_id, first_name, hire_date
from employees

desc emp20;

select *
from employees;

[예제 9-6] 부서테이블을 데이터 없이 복사하여(=구조만 복사) dept2테이블을 생성
-- where 조건절을 거짓 조건을 만들어, 복사되는 데이터가 없도록 테이블을 생성하는 방법

create table dept2 as
select *
from departments
where 1 = 2;

desc dept2;

select *
from dept2;

9.3 ALTER TABLE / 테이블의 구조 변경 명령
--데이터가 없다면? 테이블을 잘못 생성했을 때, 삭제하고 다시 생성
-- 데이터가 있을경우? 테이블의 구조, 제약조건, BYTE 등을 변경
--                새로운 컬럼 추가시, 당연히 데이터는 NULL 세팅

--# 테이블의 구조를 변경하는 명령(컬럼추가, 컬럼 삭제, 컬럼 변경-이름, 크기)

--9.3.1 컬럼 추가
-- 테이블의 컬럼을 추가하는 형식
-- ALTER TABLE 테이블명
-- ADD (컬럼명1 데이터타입1, 컬럼명2 데이터 타입2,...)


DESC emp20;
desc dept2;


[예제9-7]EMP20 테이블에 숫자타입 급여 컬럼, 문자타입 업무코드 컬럼을 추가하시오
DESC EMP20;
/*
이름          널?       유형           
----------- -------- ------------ 
EMPLOYEE_ID          NUMBER(6)    
FIRST_NAME           VARCHAR2(20) 
HIRE_DATE   NOT NULL DATE
--------- 추가할 칼럼 --------------
SALARY               NUMBER(9,2)
JOB_ID               CHAR(6)
*/

SELECT *
FROM jobs;


ALTER TABLE emp20
ADD (salary NUMBER(20,2), job_id VARCHAR2(10));

update emp20
set salary=24000,
    job_id='AD_PRES'

--number :  숫자형 VS NUMBER(전체자릿수, 소수자릿수) : 실수형[정수부 : 전체 - 소수부 자릿수]

DESC emp20;

alter table emp20
add (gender CHAR(1) NOT NULL);      -- NOT NULL 제약조건
--오류 보고 -
--ORA-01758: 테이블은 필수 열을 추가하기 위해 (NOT NULL) 비어 있어야 합니다.
--01758. 00000 -  "table must be empty to add mandatory (NOT NULL) column"

--해결 > 기존 테이블의 데이터를 비우고, alter table
TRUNCATE TABLE emp20;



-- 9.3.2 컬럼의 변경
-- ALTER TABLE 테이블명
-- MODIFY (컬럼명1 데이터타입1, 컬럼명2 데이터타입1,....)

-- 테이블의 행이 없거나 컬럼이 NULL 값만 포함하고 있어야 데이터 타입을 변경할 수 있다 
-- 컬럼에 저장되어 있는 데이터의 크기 이상까지 데이터의 크기를 줄일 수 있다

[예제9-8] EMP20 테이블의 급여 컬럼과 업무코드 컬럼의 데이터 사이즈를 변경한다


--9.3.3 컬럼으 ㅣ삭제
-- 테이블의 컬럼을 삭제하는 형식
-- alter tabel 테이블명
--drop column 컬럼명;

[예제 9-9] emp20 테이블 업무코드 컬럼을 삭제하시오

desc emp 20;
alter table emp20
drop colum salary;
select * from emp20;

alter table emp20
add (salary number(8,20), job_id VARCHAR2(7));

------------------------------------------
-- DML : COMMIT, ROLLBACK [개발자가]
-- DDL : AUTO COMMIT[자동커밋] / CREATE, ALTER, DEOP, TRANCATE















