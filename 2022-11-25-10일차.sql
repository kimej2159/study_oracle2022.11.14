-- 5장. JOIN (연산)
-- 여러 테이블을 연결하여 데이터를 조회하는 방법을 JOIN
-- I. 오라클 조인(<--> OLD JOIN)

-- 5.1 Cartesian Product (카테시안 프로덕트)
-- [JOIN 조건을 작성하지 않았을때] 잘못된 결과가 발생하는 것을

SELECT  employee_id, first_name, last_name, salary, department_id
FROM    employees; -- 107 rows

SELECT  *
FROM    departments; -- 27 rows

SELECT 107 * 27
FROM    dual; -- 2889 = 107 x 27 rows

-- 사원들의 정보 + 부서이름 함께 조회
--    (주)         (부)
--  테이블 간의 공통된 컬럼

SELECT  employee_id, last_name, 
        department_name
FROM    employees, departments -- 테이블 2개 이상을 사용해서 데이터를 조회할때, JOIN
WHERE   employees.department_id = departments.department_id;

-- JOIN 연산이 끝나면, 여러테이블을 연결해서 어떤 데이터를 조회할수 있는지 미리 만들어진 뷰를 확인해봅시다.
SELECT *
FROM    emp_details_view;


-- 테이블 ALIAS를 사용하여, 쿼리문을 단순화시켜 가독성을 높인다.
SELECT  e.employee_id, e.last_name, 
        d.department_name
FROM    employees e, departments d -- 테이블 2개 이상을 사용해서 데이터를 조회할때, JOIN
WHERE   e.department_id = d.department_id;



5.2 EQUI-JOIN  (  vs   NON-EQUI JOIN)
-- 동등 연산자를 사용하는 JOIN 형식 <--> 동등 JOIN
-- JOIN 조건은 같은 값을 가진 컬럼에 대한  테이블명.컬럼명 = 테이블명.컬럼명  형식을 사용한다.
-- 내부조인   vs   외부조인

[예제5.3] employees, departments 테이블을 이용하여 사번, 이름, 부서코드, 부서명을 조회하시오
SELECT  e.employee_id, e.first_name, 
        d.department_name,
        j.job_title
FROM    employees e, departments d, jobs j
WHERE   e.department_id = d.department_id
AND     e.job_id = j.job_id
ORDER BY 1;

-- =====================================================
--  JOIN 하는 대상 테이블이 추가되면, JOIN 조건을 추가한다.
--  ex> JOIN 하는 테이블이 2개 ==> JOIN 조건은 1개
--                "      3개 ==> JOIN 조건은 2개
-- =====================================================

[예제5-6] 사번이 101번인 사원의 사번, 이름, 급여와 부서명, 업무제목을 조회하시오
-- employees, departments : department_id
-- employees, jobs : job_id
SELECT  e.employee_id, e.first_name, e.salary, 
        d.department_name, 
        j.job_title
FROM    employees e, departments d, jobs j
WHERE   e.department_id = d.department_id -- 조인 조건1
AND     e.job_id = j.job_id -- 조인 조건2
AND     employee_id = 101; -- 일반 조건

-- 나눠져 있는 데이터를 마치 원래 하나로 합쳐진 데이터 처럼 조회하는 것

ex> 사번이 101번인 사원의 사번, 이름, 급여와 부서명, 업무제목, 부서가 위치한 도시명을 조회하시오
-- employees, departments, jobs + locations 테이블의 city_name 컬럼을 추가해서 조회
DESC locations;
/*
이름             널?       유형           
-------------- -------- ------------ 
LOCATION_ID    NOT NULL NUMBER(4)    : 위치 코드
STREET_ADDRESS          VARCHAR2(40) : 도로주소
POSTAL_CODE             VARCHAR2(12) : 우편번호
CITY           NOT NULL VARCHAR2(30) : 도시(=부서가 위치하고 있는 도시의 이름)
STATE_PROVINCE          VARCHAR2(25) : 주(ex.남구/서구/북구..)
COUNTRY_ID              CHAR(2)      : 나라/국가 코드
*/


SELECT  e.employee_id, e.first_name, e.salary, 
        d.department_name, 
        j.job_title,
        l.city
FROM    employees e, departments d, jobs j, locations l
WHERE   e.department_id = d.department_id -- 조인 조건1
AND     e.job_id = j.job_id -- 조인 조건2
AND     d.location_id = l.location_id -- 조인 조건3
--AND     employee_id = 101; -- 일반 조건



-- 5.3 NON-EQUI JOIN   vs  EQUI-JOIN
-- NON-EQUI JOIN: 비교연산자, 범위연산자, IN 연산자등을 사용하는 JOIN를 뜻함
-- EQUI-JOIN : 동등 연산자(=)

DESC jobs;

[예제5-7] 사원의 급여가 업무테이블의 급여(업무) 상하한 범위 내에 있는 10번 부서원의 사번, 이름, 급여, 업무제목을 조회하는 쿼리를
작성하시오
SELECT  e.employee_id, e.first_name, e.salary,
        j.job_title
FROM    employees e, jobs j
--WHERE   테이블명(또는 ALIAS명).컬럼명 = 테이블명(또는 ALIAS명).컬럼명 -- EQUI-JOIN
WHERE   e.salary BETWEEN j.min_salary AND j.max_salary
AND     e.department_id = 10;

-- 부서별 사원 수 : 그룹함수, GROUP BY
SELECT department_id, COUNT(*) cnt
FROM    employees
GROUP BY department_id
ORDER BY 1;

-- ====================================================================
-- JOIN 하는 컬럼이 일치하지 않게 사용하는 JOIN 조건으로, 거의 사용하지 않는다.
-- ====================================================================

-- JOIN : EQUI JOIN            vs  NON-EQUI JOIN (=거의 사용x)
--        INNER JOIN(=내부조인) vs  OUTER JOIN(=외부조인) ★
--        컬럼의 데이터가 NULL일때 레코드 수가 달라짐!! ==> 누락된 데이터까지 포함시키는 경우~
-- ex> 관리자가 회원을 관리하는 기능(=회원관리 메뉴 :  지금 가입한 회원정보 + 탈퇴한 회원)

-- 5.4 OUTER JOIN
-- EQUI-JOIN은 테이블간 공통 컬럼을 기준으로 데이터를 조회하는데,
-- OUTER JOIN은 만족되는 값이 없는 경우(=NULL 값) 결과까지 반환한다.
-- ex> 사원테이블,부서테이블을 사용해서 사원의 정보에 부서이름을 출력할때.
-- EQUI-JOIN을 사용할때 : 106
-- ★ 만족되는 값이 없는 (=NULL) 테이블 컬럼에 (+) 기호를 표시한다. 
-- 기준테이블의 반대쪽에 (+)기호를 표시한다.
SELECT  e.employee_id, e.first_name, e.department_id, -- 사원의 정보
        d.department_name,
        j.job_title
FROM    employees e, departments d, jobs j, locations, cotur
WHERE   e.department_id = d.department_id(+)
AND     e.job_id = j.job_id(+)

ORDER BY 1; -- 106명에 대한 데이터가 조회됨

SELECT *
FROM    employees
WHERE   department_id IS NULL; -- 누락된 데이터 1명 : Kimberely
      
SELECT COUNT(*) 사원수
FROM    employees; -- 총 107명

        
-- OUTER JOIN을 사용할때 : 107

[예제5-7] 모든 사원의 사번, 이름, 급여, 부서코드, 부서명, 위치코드, 도시정보를 조회하시오
-- 총 사원수 : 107명
SELECT  e.employee_id, e.first_name, e.salary, 
        d.department_name, 
        j.job_title,
        l.city
FROM    employees e, departments d, jobs j, locations l
WHERE   e.department_id = d.department_id(+) -- 조인 조건1
AND     e.job_id = j.job_id(+) -- 조인 조건2
AND     d.location_id = l.location_id(+) -- 조인 조건3


-- 내부조인, OUTER-JOIN, 카테시안 프로덕트... : 식별관계

-- 5.5 SELF JOIN : 자기참조 관계
DESC employees;

-- ====================================================
-- 매니저도 '사원'이다. 매니저 정보는 사원 테이블에 있다.
-- ===================================================
-- ERP : 전사적 자원 관리 시스템 (인사, 물류, ...)
-- id : identify (식별하는) 
[예제5-10] 모든 사원의 사번, 사원의 이름, 매니저의 사번, 매니저의 이름을 조회하시오
--        e.employee_id, e.first_name, m.employee_id manager_id, m.first_name manger_name
SELECT  e.employee_id, e.first_name,
        m.employee_id manager_id, m.first_name manager_name
FROM    employees e, employees m
WHERE   e.manager_id = m.employee_id
AND     e.manager_id IS NOT NULL
ORDER BY    1;



SELECT employee_id, first_name, salary, manager_id
FROM    employees;






