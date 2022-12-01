-- 6장. 서브쿼리(Sub Query)
-- 서브쿼리란, SQL 문장 안에 있는 또다른 SQL문장을 뜻함
-- 1) 서브쿼리는 괄호로 묶어서 사용
-- 2) 메인쿼리 vs 서브쿼리 : ()로 묶인 부분


-- 6.1 단일 행 서브쿼리 : 서브쿼리 실행 결과가 하나의 결과 행을 반환하는 서브쿼리
-- 6.2 다중 행 서브쿼리 :         "          여러개의 결과 행을      "
-- 6.3 다중 컬럼 서브쿼리 :        "        둘 이상의 컬럼을         "
-- 6.4 상호 연관 서브쿼리 : 메인쿼리의 컬럼이 서브쿼리의 조건으로 사용되는 서브쿼리
-- 6.5 스칼라 서브쿼리 : SELECT 절에 사용되는 서브쿼리 (=컬럼)
-- 6.6 인라인 뷰 서브쿼리 : FROM 절에 사용되는 서브쿼리

-- ※ 서브쿼리는 어디든 올 수 있음, (보통 WHERE 절에 작성)
-- ※ 서브쿼리가 없어도 작업 처리는 가능! 사용이유) 처리속도 빠르고 효율적, 실무에서 서브쿼리를 사용!

[예제6-1] 평균 급여보다 더 적은 급여를 받는 사원의 사번, 이름, 성을 조회하시오

-- 1) 메인쿼리로 작성한다면?
-- 1-1) 평균 급여를 알아보자
SELECT  ROUND(AVG(salary)) avg_sal
FROM    employees; -- 6,462$

-- 1-2) 평균 급여보다 적은 급여를 받는 사원들의 정보를 알아보자
SELECT employee_id, first_name, last_name
FROM    employees
WHERE   salary <= 6462
ORDER BY 1; -- 56 rows

-- 2) 서브쿼리로 작성한다면? [SQL 안에 어느 위치라도 올수 있는 또다른 () 안의 SQL]
SELECT employee_id, first_name, last_name
FROM    employees
WHERE   salary <= ( SELECT  ROUND(AVG(salary))
                    FROM    employees )
ORDER BY 1; -- 56 rows
-- ============================================
-- 일반쿼리로 결과를 구하고 서브쿼리로 수정!!
-- ============================================


-- 6.1 단일 행 서브쿼리 
-- 단일 행 연산자(=, >, >=, <, <=, <>, != ) 와 함께 사용한다.
-- 결과행이 하나이므로 그룹 함수 COUNT(), SUM(), AVG(), MAX(), MIN() 를 사용하는 경우가 많다
[예제6-2] 월 급여가 가장 많은 사원의 사번, 이름, 성 정보를 조회하시오

-- 1) 월급여 최고금액을 구해보기 <---> 월급여 최저금액
SELECT MAX(salary)                 -- MIN(salary)
FROM    employees; -- 24000$

-- 2) 월급여 최대치와 같은 급여를 받는 사원의 정보를 조회
SELECT  employee_id, first_name, last_name, salary
FROM    employees
WHERE   salary = 24000;

-- 서브쿼리로 바꾸어 표현한다면?
SELECT  employee_id, first_name, last_name, salary
FROM    employees
WHERE   salary = ( SELECT MAX(salary)
                   FROM    employees )
ORDER BY 1;                   


-- 월급여가 가장 적은 사원의 사번, 이름, 성 정보를 조회하시오
-- I. 일반쿼리
SELECT  MIN(salary)
FROM    employees; -- 2100$

SELECT employee_id, first_name, last_name
FROM    employees
WHERE   salary = 2100;

-- II. 서브쿼리
SELECT employee_id, first_name, last_name
FROM    employees
WHERE   salary = ( SELECT  MIN(salary)
                   FROM    employees );
                   
[예제6-3] 사번이 108인 사원의 급여보다 더 많은 급여를 받는 사원의 사번, 이름, 급여를 조회하시오
-- 108번 사원의 급여를 조회
SELECT  salary
FROM    employees
WHERE   employee_id = 108; -- 12,008$

-- 급여가 12,008$ 를 초과하는 사원의 정보를 조회
SELECT  employee_id, first_name, TO_CHAR(salary,'$99,999') salary
FROM    employees
WHERE   salary > 12008; -- 6 rows

-- 서브쿼리로 표현하면
SELECT  employee_id, first_name, TO_CHAR(salary,'$99,999') salary
FROM    employees
WHERE   salary > ( SELECT  salary
                   FROM    employees
                   WHERE   employee_id = 108 ); -- 6 rows


[예제 6-4] 월 급여가 가장 많은 사원의 사번, 이름, 성, 업무 제목 정보를 조회하시오

-- 월급여 최고금액
SELECT MAX(salary)
FROM    employees; -- 24,000$

-- 사번~업무제목 정보 : JOIN 연산 + 서브쿼리
-- ※ 업무제목은 JOB_TITLE (JOBS 테이블에 있음)
SELECT  e.employee_id, e.last_name, e.salary, 
        j.job_title
FROM    employees e, jobs j
WHERE   e.job_id = j.job_id -- 조인 조건절
AND     e.salary = ( SELECT MAX(salary)
                     FROM    employees );--일반 조건절

--6.2.1 IN 연산자 
SELECT employee_id, first_name, job_id
from employees
where department_id = 10             -- department_id in(10, 30, 50);
or department_id = 30 
or department_id = 50;


[예제 6-5]근무지(위치코드)가 영국인 부서코드, 위치코드, 부서명 정보를 조회한다
-- 일반 쿼리
select *
from departments;

select *
from country_id = 'UK';

select department_id, location_id, department_name
from departments
where location_id = 'UK';

-- 서브 쿼리
select department_id, location_id, department_name
from departments
where location_id in ( select location_id
                        from locations
                        where country_id ='UK');

-- 6.2.2 ANY 연산자
-- 서브쿼리 결과값 중 어느 하남나 값만 만족하면 되는 행을 반환한다.
[예제 6-6] 70번 부서원의 급여보다 높은 급여를 받는 사원의 사번, 이름, 부서번호, 급여를 급여 순으로 조회한다

select salary               --10000
from employees
where department_id = 80
order by 1;

select employee_id, first_name, department_id, salary
from employees
where salary > 10000                   --15raws
order by 1;

select  employee_id, first_name, department_id, salary
from employees
where salary > ANY ( select salary              -- ANY 가 여러개의 결과행을 비교연산 처리해줌 
                    from employees
                    where department_id = 80)
ORDER BY salary;

--------------------------------------------------
 -- > any는 최소값( min )으로 대체가능
 -- < any는 최대값( max )으로 대체가능
 -------------------------------------------------
[예제 6-8] 10번 부서원의 급여보다 적느 급여를 받는 사원의 사번, 이름, 부서 번호, 급여를 급여 순으로 조회한다
select salary
from employees
where department_id = 10;               -- 4400

-- 서브 쿼리
-- > any : min
-- < any : max
select employee_id, last_name, department_id, salary
from employees
where salary < any (select max (salary)         -- 서브쿼리에서 그룹함수 : 단일행 결과를 반환
                from employees
                where department_id = 80)
order by 4;                             -- 46rows

6.2.3 ALL 연산자 
-- ANY :  하나라도 일치하면
-- ALL : 모두 일치하면 
-- 서브쿼리의 결과 값 모두에 만족하는 결과행을 반환한다.
[예제 6-10] 100부서원 모두의 급여보다 높은 급여를 받는 사원의 사번, 이름, 부서번호, 급여를 급여 오름차순으로 조회한다.
SELECT SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 100;
-- 서브 쿼리 
SELECT EMPLOYEE_ID, LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = 100)
ORDER BY 4;

-- > ALL은 > 최대값(MAX)로 대체 가능하다
--------------------------------------------------------------
[예제 6-12] 30번 부서원 모두의 급여보다 적은 급여를 받는 사원의 사번, 이름, 부서번호, 급여를 급여 순으로 조회한다.
SELECT employee_id, first_name, department_id, salary
from employees
where salary < all (select salary
                    from employees
                    where department_id = 30);              -- 5rows
                                        
-- 비교 연산자로 다중행 결과를 비교하려면 발생하는 오류 :  ANY , ALL 사용해야 함
--> ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.

--------------------------------------------
-- 서브쿼리 연산자     |    대체가능
--------------------------------------------
--   > ANY           |    MIN()
--   < ANY           |    MAX()
--   > ALL           |    MAX()
--   < ALL           |    MIN()
--------------------------------------------


--P.56
--ANY  : IN 연산자와 동일한 기능을 한다.
SELECT EMPLOYEE_ID, LSAT_NAME, DEPARTMENT_ID
FROM employees
where department_id = any (10, 30, 50); -- 10번 이나 20번 이나 30번 부서에 해당하는 사원
-- where department_id = all (10, 30, 50); 10,20,30 부서 모두에 해당하는 사원 : 있을 수 없음
-- where department_id > any (10, 30, 50); 는 가능

[예제 6-14] 20번 부서원의 급여와 같은 급여를 받는 사원의 사번, 이름, 부서번호, 급여를 부서코드 순, 급여 순으로 조회한다
select employee_id, first_name, department_id, salary
from employees
where salary = any (select salary
                    from employees
                    where department_id = 20)
order by 3;


-- not in <> any ! = any로 대체 불가능

-- not in 연산자는  <>  all 대체 가능

--not in 연산자를 <> any 로 변경하면 모든 부서를 조회한 결과와 같은 결과가 추출

6.3 다중 컬럼 서브 쿼리
-- 서브 쿼릐의 실행 결과가 여러개의 컬럼을 반환하는 것 
[예제 6-18]매니저가 없는 사원이 매니저로 있는 부서코드, 부서명을 조회합니다 
-- 1. 일반 쿼리 
SELECT employee_id
from employees
where manager_id IS NULL;

SELECT department_id
from employees
where manager_id = 100;            -- 14rows : 사장이 직접 관리하는 사원 수

select manager_id 
from employees;

select department_id, department_name
from departments
where manager_id = 100;      -- 90, executive

-- 2. 서브 쿼리 
select department_id, department_name
from departments
where (department_id, manager_id ) IN ( select department_id, employee_id
                                        from employees
                                        where manager_id IS NULL);

-- 다중컬럼 서브쿼리 예제 : 좀 더 이해하기 위한
-- eployees 테이블: 사원 정보, 급여정보, 부서, ...

-- 매달 말 부서별로 / 사원별로 지급되는 급여에 대한 집계를 하고자 할 때 -->테이블 생성 집계해서 추가/ 업데이트

-- 부서별로 월별 지급된 급여 합계, 급여 평균, 급여 최고, 급여 최소,,,
-- 마감 : magam ==> 월별 집계/ 통계
-- 날짜 정보 
--사원 수 정보
-- 급여 합게 정보
-- 급여 평균 정보
--...etc...

-- 1. 월별 업무 마감시 사원들의 통계 정보를 집계해서 저장할 때 저장할 테이블을 설계
CREATE TABLE month_salary (
    magam_date DATE NOT NULL,
    dept_id NUMBER,
    emp_cnt NUMBER,
    sum_salary NUMBER,     
    avg_salary NUMBER(9,2) -- 총 9자 인데 소수점 2자 까지
);

DESC MONTH_SALARY;



-- 2. 부서별 집계
-- 사원의 수
SELECT department_id, ROUND( AVG(SALARY))
FROM employees
group by department_id
order by 1;

--(매) 달의 마지막 날짜
select LAST_DAY(TO_DATE('22/10/01')) LAST_DATE
FROM dual;

--3. 실제 데이터를 삽입하자
-- ITAS : INSERT INTO 테이블 AS SELECT ~ 이하 [한번에 조회된 결과를 다른 테이블에 삽입하는 구문]
-- CTAS : CREATE TABLE 테이블 AS SELECT ~ 이하 [한번에 조회된 결과를 다른 테이블을 생성하여 삽입]
INSERT INTO month_salary (magam_date, dept_id)
SELECT LAST_DAY(SYSDATE), department_id
FROM employees
GROUP BY department_id
ORDER BY 2;

-- 4. 데이터 확인
SELECT *
FROM month_salary;

ROLLBACK;
COMMIT;

--5. 다중컬럼 서브 쿼리로 EMP_CNT(사원수), SUM_SALARY(급여합), AVG_SALARY(급여 평균)을 NULL 인 값들을 갱신
UPDATE month_salary m
SET EMP_CNT=(   SELECT COUNT(*)
                FROM employees e
                WHERE e.department_id = m.dept_id
                GROUP BY e.department_id ),
    SUM_SALARY=(    SELECT SUM(salary)
                    FROM employees e
                    WHERE e.department_id = m.dept_id
                    GROUP BY e.department_id ),  
    AVG_SALARY=(   SELECT ROUND(AVG(salary))
                    FROM employees e
                    WHERE e.department_id = m.dept_id
                    GROUP BY e.department_id );          
  ------------- -------------- ------------ ----------------- ---- 선생님꺼
  UPDATE month_salary m
SET EMP_CNT=( SELECT    COUNT(*)
              FROM      employees e
              WHERE     e.department_id = m.dept_id
              GROUP BY  e.department_id ),              
    SUM_SALARY=( SELECT    SUM(salary)
                 FROM      employees e
                 WHERE     e.department_id = m.dept_id
                 GROUP BY  e.department_id ),
    AVG_SALARY=( SELECT    ROUND(AVG(salary))
                 FROM      employees e
                 WHERE     e.department_id = m.dept_id
                 GROUP BY  e.department_id );
---------------- -------------- ------------- ------------- -----------    
WHERE 조건절;      -- 조건절 생략하면 모든 레코드가 업데이트 되므로 주의!! 

--magam_date, dept_id에 입력한 데이터를 실제 저장 공간에 저장 : 현재는 메모리에서 기억하고 있지만
--COMMIT;

--update 구문 연습
UPDATE employees
set salary = 2009;

SELECT *
FROM EMPLOYEES;

 ROLLBACK;

6. 최종적으로 업데이트된 부서별 사원수, 부서별 급여합계,부서별 급여 평균 조회
SELECT *
FROM month_salary;

7. 12번 행의 null 값을 업데이트 하려면?
UPDATE month_salary
set EMP_CNT = ( SELECT COUNT(*)
                FROM employees
                where department_id IS NULL),
    SUM_SALARY = ( SELECT sum(salary)
                FROM employees
                where department_id IS NULL),
    AVG_SALARY = ( SELECT ROUND(AVG(salary))
                FROM employees
                where department_id IS NULL)
WHERE   dept_id IS NULL;
--Kimberey의 정보를 조회
select salary
from employees
where department_id IS NULL;

--8. 최종 커밋
-- 메모리에 있는 데이터를 DBMS가 관리하는 저장 공간에 파일로 저장

COMMIT;

SELECT *
FROM MONTH_SALARY
WHERE TO_CHAR(MAGAM_DATE, 'MONTH') = '11월';     -- 언어가 한글이라서 11이 아닌 11월로 조회 vs NOVEMBER

select TO_CHAR(magam_date, 'MM')
from month_salary;


-- DBA가 설계한 테이블에, 매달 말 자동으로 (스케쥴) 데이터를 집계하고 삽입과 업데이트를 실시해서 저장해 두면,
-- 개발자는 사용자 또는 관리자가 사용할 수 있는 화면과 버튼을 만들어서,
-- 데이터를 조회하고, 그래프나 차트로 변환한 화면을 [출력]하거나 [전송]하는 버튼을 눌러 원하는 기능을 수행하는
-- 프로그램을 제작할 수 있다.

        
-- 6.4 상호 연고나 서브 쿼리 
-- 대게는 JOIN연산의 형식
-- 메인 쿼리의 컬럼이 서브 쿼리의 조건절에 사용되는 서브쿼리로, 메인 쿼리에 독립적이지 않은 형식이다

[예제 6-19] 매니저가 있는 부서코드에 소속된 사원들의 수를 조회한다.
--<서브쿼리 사용 위치에 따른 구분 > 
-- 1. WHERE 절에 서브 쿼리 : (일반적인) 서브쿼리
-- 2. SELECT 절에 서브 쿼리 : 스칼라 서브쿼리
--3. FROM 절에 서브쿼리 : 인라인 뷰 서브쿼리

select count(*) cnt
from employees e
where department_id IN ( SELECT department_id
                            from employees d
                            where manager_id IS NOT NULL
                            AND e.department_id = d.department_id);
    
--SELECT department_id
--FROM   employees
--WHERE   manager_id IS NOT NULL;

---------------------------------------------------------
--IN 연산자를 EXISTS 연산자로 대체 가능 
----------------------------------------------------------
select count(*) cnt
from employees e
where EXISTS ( SELECT department_id
                            from employees d
                            where manager_id IS NOT NULL
                            AND e.department_id = d.department_id);                            

--FROM      테이블1, 테이블2, ,,,         : 인라인 뷰 서브쿼리 위치
--WHERE 조건들                           : 일반적인 서브쿼리 위치

--6.5 스칼라 서브쿼리
-- select 절에 사용하는 서브쿼리 형태
-- 코드성 테이블에서 코드명을 조회하거나, 그룹 함수의 결과 값을 조회할 때 사용한다.
-- ST_CLERK                     ,AVG(salary)

[예제 6-22] 사원의 이름, 급여, 부서, 부서명 정보를 조회한다
-- 서브쿼리로 조회
select e.first_name, e.salary, e.department_id,
        (select department_name
         from departments d
         where d.department_id = e.department_id)
from employees e
order by e.department_id;

select first_name, salary, department_id,
        (select round(avg(salary))
        from employees) avg_sal
from employees
order by department_id;             // 서브 쿼리는 where 절에 쓰는게 일반적인데
                                    // 여기서는 select 절에서 사용 됨
desc employees;


-- 일반 쿼리
SELECT e.first_name, e.salary, 
        d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

select *
from month_salary;              //이상함

select dept_id sum_salary, avg_salary
from month_salary;

[연습문제6-3] 각 부서에 대해 부서코드, 부서명, 
            부서가 위치한 도시이름을 조회하는 쿼리문 스칼라 수브쿼리를 사용하여 작성한다.

select d.department_id, d.department_name
from departments d
order by 1;

-- 일반 쿼리
select d.department_id, d.department_name,
        l.city
from departments d INNER JOIN locations l
using (location_id)
order by 1;

--6.6 인라인 뷰(객체) <------------> 서브쿼리의 (작성 위치에 따른) 구분

--뷰(view)                   vs    테이블(table)
--임시성 테이블                       영구적인 테이블
--쿼리실행 생성~종료하면 사라짐          계속 살아있음
--메모리                             저장 장치(물리적)

-- ex) 오르클 설치시 미리 만들어준 emp_details_view를 조회 (= a.k.a 테이블)
-- 모든 테이블의 데이터를 개발자에게 주지 않기 위한것
desc emp_details_view;
select * from emp_details_view; 

----------------------------------------------------------------------
-- 인라인 뷰 서브쿼리는 서브쿼리다! (뷰라는 객체로 구분하기 보다는, 서브 쿼리로 구분)
-----------------------------------------------------------------------

[예제 6-24] 급여가 회사 평균 급여 이상이고, 최대급여 이하인 사원의 사번, 이름, 급여, 회사평균 급여 , 회사최대급여를 조회한다.
-- 일반 쿼리
1. 평균 급여
select round(avg(salary))
from employees;                 -- 6462

2.최대
select max(salary) max_sal
from employees;                 -- 24000
       
-- 1,2번 합쳐서       
select  employee_id, first_name, salary   -- 급여 최대 최소 조회 불가능, 테이블이 없으니까
from employees
where salary >= 6462
and   salary <= 24000;

--회사 평균 급여, 회사최대 급여 컬럼이 존재하지 않음 (employees 와 그어떤 테이블도)
-- 인라인 뷰 서브쿼리로, 마치 그러한 테이블이 존재하듯이 (집계성 테이블, month_salary처럼) 데이터 조회
 

-- 인라인 뷰 서브쿼리로 해결해 보자    
select e.employee_id, e.last_name, e.salary,
        k.avg_sal, k.max_sal
from employees e,
    (select round(avg(salary)) avg_sal, max(salary) max_sal
    from employees) k
where salary >=6462
and salary <= 24000;
        
select e.employee_id, e.last_name, e.salary,
        k.avg_sal, k.max_sal
from employees e,
    (select round(avg(salary)) avg_sal, max(salary) max_sal
    from employees) k
where salary between k.avg_sal AND k.max_sal;   

[예제 6-25] 사원 테이블의 데이터를 기준으로 월별 입사 현황을 조회해 테이블을 출력
-- 실제로는 테이블이 없음, 임의로 테이블을 만들어야함

-- 결과행은 하나 
-- 컬럼 수는 12 개
-- 데이터의 사원수는 월별 입사자의 합계

-- 오라클 설정 확인
select *
from v$nls_parameters;      --RR/MM/DD, KOREAN  --> 11(mm, MM) vs 11월 (MON, MONTH)

SELECT TO_CHAR(hire_date, 'MONTH') month
from employees;

select DECODE(TO_CHAR(hire_date, 'mm'), '01', count(*), 0) "1월",
         DECODE(TO_CHAR(hire_date, 'mm'), '02', count(*), 0) "2월",
         DECODE(TO_CHAR(hire_date, 'mm'), '03', count(*), 0) "3월",
         DECODE(TO_CHAR(hire_date, 'mm'), '04', count(*), 0) "4월",
         DECODE(TO_CHAR(hire_date, 'mm'), '05', count(*), 0) "5월",
         DECODE(TO_CHAR(hire_date, 'mm'), '06', count(*), 0) "6월",
         DECODE(TO_CHAR(hire_date, 'mm'), '07', count(*), 0) "7월",
         DECODE(TO_CHAR(hire_date, 'mm'), '08', count(*), 0) "8월",
         DECODE(TO_CHAR(hire_date, 'mm'), '09', count(*), 0) "9월",
         DECODE(TO_CHAR(hire_date, 'mm'), '10', count(*), 0) "10월",
         DECODE(TO_CHAR(hire_date, 'mm'), '11', count(*), 0) "11월",
         DECODE(TO_CHAR(hire_date, 'mm'), '12', count(*), 0) "12월"
from employees
group by TO_CHAR(hire_date, 'mm')
ORDER BY TO_CHAR(hire_date,'mm');

[예제 6-26]
select sum(m1) "1월",sum(m2) "2월",sum(m3) "3월",sum(m4) "4월",sum(m5) "5월", sum(m6) "6월", 
        sum(m7) "7월",sum(m8) "8월",sum(m9) "9월",sum(m10) "10월",sum(m11) "11월", sum(m12) "12월"
     
from (
        select DECODE(TO_CHAR(hire_date, 'mm'), '01', count(*),0) m1,
                 DECODE(TO_CHAR(hire_date, 'mm'), '02', count(*),0) m2,
                 DECODE(TO_CHAR(hire_date, 'mm'), '03', count(*),0) m3,
                 DECODE(TO_CHAR(hire_date, 'mm'), '04', count(*),0) m4,
                 DECODE(TO_CHAR(hire_date, 'mm'), '05', count(*),0) m5,
                 DECODE(TO_CHAR(hire_date, 'mm'), '06', count(*),0) m6,
                 DECODE(TO_CHAR(hire_date, 'mm'), '07', count(*),0) m7,
                 DECODE(TO_CHAR(hire_date, 'mm'), '08', count(*),0) m8,
                 DECODE(TO_CHAR(hire_date, 'mm'), '09', count(*),0) m9,
                 DECODE(TO_CHAR(hire_date, 'mm'), '10', count(*),0) m10,
                 DECODE(TO_CHAR(hire_date, 'mm'), '11', count(*),0) m11,
                 DECODE(TO_CHAR(hire_date, 'mm'), '12', count(*),0) m12
        from employees
        group by TO_CHAR(hire_date, 'mm')
        );

-------------------------------------------------
--ROWNUM은 서브쿼리가 아닌 분석 함수의 종류

--ROWNUM vs ROW NUMBER()
--의사컬럼 VS 의사컬럼 함수
--표현식에 따른 
--키보드  F1 눌러서 도움말에서 검색해 보세요


[예제6-27]사번, 이름을 10건 조회한다
select rownum num, employee_id,first_name
from employees
where rownum < 11
order by 2;

--순위(ranking)를 나타내는 함수
-- RANK()       VS DENSE_RANK()
-- ex) 급여 순위 1~10등 까지 


select employee_id,first_name,
        RANK() OVER (ORDER BY salary DESC) sal_rank1,
        DENSE_RANK() OVER (ORDER BY salary DESC) sal_rank2,
        ROW_NUMBER() OVER (ORDER BY salary DESC) sal_num1
from employees;        

select employee_id,first_name,
        RANK() OVER (ORDER BY salary DESC) sal_rank1,
        DENSE_RANK() OVER (ORDER BY salary DESC) sal_rank2,
  --      AVERAGE_RANK() OVER (ORDER BY salary DESC) avg_rank3,
        ROW_NUMBER() OVER (ORDER BY salary DESC) sal_num1
from employees;     

select employee_id,first_name,
     AVERAGE_RANK() OVER (ORDER BY salary DESC) avg_rank3
from employees;                         -- 안돼!

[예제6-28]분석함수를 사용해서 급여가 높은 상위 10명 사원의 사번, 이름, 급여를 조회
select employee_id, last_name, salary,
       DENSE_RANK() OVER (ORDER BY salary DESC) sal_rank
from employees
where ROWNUM <= 10;

-----------------------------------
-- AVERAGE_RANK() 는 미확인







                            