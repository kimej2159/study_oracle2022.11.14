5.6 ANSI JOIN (P.48)

--JOIN 연산 : 테이블과 테이블의 관계를 이용해서 다른 테이블의 데이터를 기존 테이블에 부착해서 조회하는 방법
-- WHY? 데이터의 중복을 막고 (=정규화) 효율적으로 관리하기 위한 RDBMS의 특성
-- IF? 모든 데이터가 하나의 테이블에 존재한다면? JOIN 필요없으나 DBMS 목정상 이렇게 사용하지 않음

5.6.1 (Oracle JOIN) JOIN
--Cartesian Product : 카테시안 곱 ( = join 하는 테이블의 각각 rows 수 만큼 곱한 결과행, 잘못된 ) 
-- EQUI-JOIN VS NON-EQUL-JOIN(거의 사용 안함)
--OUTER JOIN (VS  INNER JOIN - 실제 존재 X, 개념상 )


5.6.2 (모든 DBMS 공통) JOIN - 국제 표준 JOIN 형식
-- INNER JOIN : 오라클의 EQUI-JOIN과 같은 기능을 하는 JOIN 형식
--1) from 절에 inner join을 명시
--2) join 조건은 on 절에 명시

[예제5-12] 사원의 사번, 이름, 부서코드, 부서명 정보를 조회하시오
desc employees;
desc departments;           -- 테이블 확인 

select e.employee_id, e.first_name, e.department_id,
        d.department_name
FROM employees e, departments d
where e.department_id = d.department_id(+)
and    e.manager_id IS NOT NULL
ORDER BY 1;                         -- 기존의 데이터 출력 방법
------------------------------------------------------------------
-- ANSI > INNER JOINI vs OUTER JOIN // ON
select e.employee_id, e.first_name, e.department_id,
        d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
ORDER BY 1;                         -- MYSQL 사용 시 

-- ON 대신 USING 사용, 이땐 공통되는 테이블의 알리야스를 표시하지 않아야 함.
select e.employee_id, e.first_name, department_id,
        d.department_name
FROM employees e INNER JOIN departments d
USING   (department_id)
ORDER BY 1;                         -- MYSQL 사용 시 

-----------------------------------------------------------------
-- JOIN에 사용하는 테이블이 3개 이상일 경우, 첫 번째 JOIN을 추가한다
[문제 5-15] 사원의 사번, 이름, 부서코드, 부서명, 위치코드, 도시 정보를 조회한다

--> 1. 기존의 데이터 조회 방법
SELECT  e.employee_id, e.first_name, e.department_id,
        d.department_name, l.location_id,
        l.city
from    employees e, departments d, locations l
where   e.department_id = d.department_id
and     d.location_id = l.location_id
order by 1;

-->( where과 and에 ) INNER JOINI과 on 사용
SELECT  e.employee_id, e.first_name, e.department_id,
        d.department_name, l.location_id,
        l.city
from    employees e INNER JOIN departments d
on   e.department_id = d.department_id
INNER JOIN locations l
on     d.location_id = l.location_id
order by 1;

-->  on 대신 using 사용할 때 // 알리야스 꼭 빼줘야함!!
SELECT  e.employee_id, e.first_name, department_id,
        d.department_name, location_id,
        l.city
from    employees e INNER JOIN departments d
using (department_id)
INNER JOIN locations l
using     (location_id)
order by 1;


-- OUTER JOIN [LEFT | RIGHT | FULL] : OUTER (데이터 중 NULL이 있는 곳의 반대
-- 오라클 조인 > outer join은 (+)를  사용
--ANSI 조인 > OUTER JOIN은 문자로 [방향] OUTER JOIN 
-- FROM절에 [LEFT | RIGHT | FULL]을 사용하고 JOIN 조건은 ON 절에 명시


[예제 5-16] 사원의 사번, 이름 ,부서코드, 부서명 정보를 조회한다.
-- 1. 기본
SELECT e.employee_id, e.first_name, e.department_id,
        d.department_name
from employees e, departments d
where e.department_id = d.department_id(+)
and e.manager_id IS NOT NULL
ORDER BY 1;

-- 2. ANSI 조인 >  OUTTER JOIN 
SELECT e.employee_id, e.first_name, e.department_id,
        d.department_name
from employees e FULL OUTER JOIN departments d
ON e.department_id = d.department_id
WHERE e.manager_id IS NOT NULL
ORDER BY 1;

-- 3. ON 대신 USING 사용 
SELECT e.employee_id, e.first_name, department_id,
        d.department_name
from employees e FULL OUTER JOIN departments d
USING (department_id)
WHERE e.manager_id IS NOT NULL
ORDER BY 1;


















