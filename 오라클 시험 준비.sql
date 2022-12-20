[오라클 시험 준비]
 1. SQL은 DDL, DML, DCL로 구분할 수 있다. DML에 해당하는 것으로 나열된 것은?
 ㄱ.SELECT  ㄴ.UPDATE    ㄷ.INSERT    ㄹ.GRANT
 
 답 : ㄱ, ㄴ, ㄷ
 
  DML : 데이터 조작어 DDL : 데이터 정의어
-> DML(date manipulation languege) : select, insert, update, delete 
-> DDL(date definition languege) : create, alter, drop, rename, truncate
 
 2. DDL에 해당하는 SQL 명령으로만 짝지어 진 것은?
    1. SELECT, ALTER, UPDATE
    2. INSERT, CREATE, DELETE
    3. DELETE, DROP, ALTER
    4. DROP, ALTER, CREATE
 답 : 4번

[  DML : 데이터 조작어 DDL : 데이터 정의어  ]
-> DML(date manipulation languege) : select, insert, update, delete 
-> DDL(date definition languege) : create, alter, drop, rename, truncate
   
3. 아래와 같은 SQL 문에서 [] 안에 조건문을 넣기 위한 키워드를 작성하시오
SELECT *
FROM employees
where employee_id = 100;

 답 : where 
 
4.다음은 학생이라는 테이블의 컬럼을 나타내고 있다
여기서 "학과"를 기본 키로 사용하기 곤란한 이유로 가장 타당한 것은?
    학생(학과, 성명, 학번, 세부전공, 주소, 우편번호)
    
 답 : 4번. 동일한 학과명을 가진 학생이 두 명 이상 존재할 수 있다

5.다음의 sql문에서 잘못된 부분은 어느 라인인가?      답 : ㄹ
Select employee_id, last_name, department_id       -- ㄱ
from employees                                     -- ㄴ
where department_id = 80                           -- ㄷ
and employee_id between 150 or 160;                -- ㄹ

<문제> 사번이 150번부터 160번 사이 중, 부서 번호가 80인 사원의 사번, 성, 부서번호를 조회하는 쿼리문을 작성하시오
Select employee_id, last_name, department_id      
from employees                                    
where  department_id = 80                     
and employee_id between 150 and 160  ;  

 답 : or가 아니라 and가 들어가야함

6. 함수를 사용한 아래의 sql 문에서 그 결과값이 다른 함수는?
Select trunc(3.46)
from dual;

Select floor(3.46)
from dual;

1. trunc    2.ceil    3.floor   4.round

 답 : 2번.ceil
 1.trunc : 숫자에서 지정된 자릿수까지만 남기고 나머지는 버림
 2.ceil : 숫자에서 무조건 반올림하여 출력
 3.floor : 소숫점을 버리고 정수로 출력
 4.round : 일반적인 반올림 처리 후 출력
 
7. 4개의 테이블로부터 join하여 필요한 컬럼을 조회할 때 몇 개의 join 조건이 필요한가?
 답 : 3개
    여러 테이블로부터 원하는 데이터를 조회하기 위해서는
    전체 테이블 개수에서 최소 N-1개 만큼의 조인 조건이 필요하다.

8. sql에 대한 설명으로 가장 부적절한 것은?
select sum( nvl(salary,0))
from employees e, departments d
where e.department_id = 30;

1.조인 조건이 없어서 결과 건수가 여러 건이 된다
2.조인 조건이 없다고 문법 오류가 발생하지는 않는다
3.조인 조건이 없어서 결과 데이터가 바르지 않다 
4.조인 조건이 없어서 cartesian product가 발생한다

 답 : 2번
 
9.다음 중 self join을 수행해야 할 때는 어떤 경우인가?
1. 두 테이블에 공통 데이터 컬럼이 존재하고 두 테이블에 연관 관계가 있다
2. 두 테이블에 연관된 데이터 컬럼은 없으나 join을 해야한다
3. 한 테이블 내에서 두 데이터 컬럼이 연관 관계가 있다
4. 한 테이블 내에서 연관된 데이터 컬럼은 없으나 join을 해야한다

< self join을 수행해야 할 때 >
--두 테이블에 공통 컬럼이 존재하고 두 테이블에 연관 관계가 있다.
--두 테이블에 연관된 컬럼은 없으나 JOIN을 해야 한다.
--한 테이블 내에서 두 컬럼이 연관 관계가 있다.

 답 : 4번

10.다음 sql 문의 결과로 조회되는 데이터는 무엇인가?
select  last_name||' '||first_name name
from employees
where last_name || first_name like '%z_'

 답 : 사원의 성명이 두 번째 문자가 z인 사원들의 성명
 
 select *
 from employees
 where department_id != null;
 
11.다음의 두 sql은 nvl 함수를 사용한 문장을 case문으로 바꾸어 표현한 것이다
아래 case 문의 [] 안에 들어갈 내용을 작성하시오
select employee_id, last_name,
        nvl(to_char(manager_id),'없음')manager
from employees;

[풀이]
select employee_id, last_name
        case when manager_id IS NULL THEN '없음'
            else to_char(manager_id) end manager
from employees

 답 : manager_id IS NULL
 
12. having 절은 반드시 어떤 구문과 함께 사용되어야 하는가?
 답 : GROUP BY

 [풀이] 
 having 절은 GROUP BY 구문 뒤에 위치함.
 ORDER BY는 SELECT 문의 맨 마지막에 위치
 JOIN - INNER JOIN, CROSS JOIN, OUTER JOIN, SELF JOIN

13. 아래와 같은 dept 테이블을 생성하는 명령문을 작성하시오


14. EMP 테이블에서 2001년도에 입사한 사원들의 이름, 급여, 부서번호, 입사일자를 조회하여
최근 입사한 순으로 정렬하시오
SELECT FIRST_NAME, SALARY, department_id, hire_date
from employees
where hire_date = '2001'

15.emp 테이블에서 부서번호가 10, 20인 부서에 속한 사원의 사원번호, 이름, 부서번호, 급여를 조회하는데 
다음의 결과가 나오게 부서번호 순으로 부서에서 높은 급여 순으로 조회하시오

SELECT department_id, employee_id, first_name,  salary
from employees
where department_id = 10 or department_id = 20
order by department_id asc, salary desc;

-- [ 데이터 정렬 ]
-- ORDER BY 컬럼 [ASC | DESC] : 특정 컬럼을 오름차순(=Ascending) 또는 내림차순(=Descending)으로 정렬
-- 기본값은 ASC(작은수 --> 큰수 방향, 생략가능)


16. emp, dept 테이블을 사용하여 모든 사원의 이름, 급여, 부서명을 조회하시오
select e.first_name, e.salary, d.department_name
from employees e, departments d
WHERE   e.department_id = d.department_id;


17.emp 테이블에서 부서별로 부서번호, 부서 평균 급여를 죄회하시오
(단, 평균 급여는 소수 둘째자리까지 조회하시오)
select department_id, round(AVG(salary),2)
from employees
group by department_id;



18.다음의 정보를 갖는 사원을 emp 테이블에 저장하시오 
EMPNO 201701 / NAME Bill / JOB Clerk / HIREDATE 2017-10-02 / SALARY 1000 / DEPTNO 20

CREATE TABLE emp (
    EMPNO NUMBER(10),
    NAME VARCHAR2(20) NOT NULL, -- 컬럼레벨
    JOB VARCHAR2(20),
    Hire_date VARCHAR2(20),
    SALARY NUMBER(10),
    DEPTNO NUMBER(10),    
    CONSTRAINT emp_EMPNO_pk PRIMARY KEY (EMPNO) -- 테이블 레벨
);


TRUNCATE TABLE emp;


19. EMP 테이블에서 사원이 하는 업무가 CLERK인 사원들의 급여를 1400으로 변경하시오
-- 서브쿼리 
update emp
SET salary = 1400
where JOB = 'Clerk';

20. EMP 테이블에서 가장 많은 급여를 받는 사원의 정보를 삭제하시오
delete from emp
where salary = (select max(salary) from emp);

<15번>
CREATE TABLE DEPT (
    DEPTNO number(10),
    DNAME varchar(20),
    CITY varchar(20),
    constraint DEPT_DEPTNO_pk primary key(DEPTNO)
    );
insert into DEPT
values(10, 'Accounting', 'New York');
insert into DEPT
values(20, 'Research', 'Dallas');
insert into DEPT
values(30, 'Sales', 'Chicago');

select *
from DEPT;

INSERT INTO emp
values(201701, 'Bill', 'Clerk', '2017-10-02' , 1000, 20);

drop table DEPT;



create table EMP (
    EMPNO number(10) NOT NULL,
    NAME varchar(20),
    JOB varchar(20),
    HIREDATE VARCHAR2(20),
    SALARY NUMBER(10),
    DEPTNO NUMBER(10),    
    CONSTRAINT EMP_EMPNO_pk PRIMARY KEY (EMPNO) 
);

select *
from EMP

drop table EMP;

INSERT INTO EMP
values(200103, 'Jones', 'Manager', '2001-04-02', 2975, 20);
INSERT INTO EMP
values(200104, 'Blake', 'Manager', '2001-05-01' , 2850, 30);
INSERT INTO EMP
values(200105, 'Clark', 'Manager', '2001-06-09', 2450, 10);
INSERT INTO EMP
values(200106, 'King', 'President', '2001-11-17', 5000, 10);
INSERT INTO EMP
values(200201, 'Miller', 'Cleck', '2002-01-23', 1300, 10);
INSERT INTO EMP
values(200202,'Allen', 'Salesman', '2002-02-20', 1600, 30);
INSERT INTO EMP
values(200203, 'Ford', 'Analyst', '2002-12-03', 3000, 20);
INSERT INTO EMP
values(200701, 'Adams', 'Clerk', '2007-02-23', 1100, 20);
INSERT INTO EMP
values(200702, 'Ward', 'Salesman', '2007-05-22', 1250, 30);
INSERT INTO EMP
values(200703,'James', 'Clerk', '2007-12-03', 950, 30);


<16번>
select *
from EMP
where name = 'Allen';

<17번>
select name, salary, job
from EMP
where salary >= 2000;

<18번>
select count(EMPNO), round(AVG(SALARY),2)
from EMP;

<19번>
select name, salary, deptno, hiredate
from EMP
where hiredate like '2001%'
ORDER BY hiredate desc;

<20번>
select e.name, e.salary, d.dname
from EMP e, DEPT d
WHERE   e.deptno = d.deptno;

<21번>
insert into EMP
values(201701,'Bill', 'Clerk', '2017-10-02', 1000, 20);

select *
from EMP;

<22번>
update EMP
SET salary = 1400
where JOB = 'Manager';

delete from EMP
where salary = (select min(salary) from emp);


