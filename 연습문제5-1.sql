--[연습문제5-1]

--1. 이름에 소문자 v가 포함된 모든 사원의 사번, 이름, 부서명을 조회하는 쿼리를 작성하시오
--                                   [employees] [departments]
-- 대,소문자 구분 : 'v'  vs 'VS'는 다름.
-- EQUI-JOIN : 동등 연산자를 이용한 오라클 조인(=내부 조인)

SELECT  e.employee_id, e.first_name, 
        d.department_name
FROM    employees e, departments d        
WHERE   e.department_id = d.department_id(+)-- 조인 조건절 / Kimberely
AND     e.first_name LIKE '%v%' -- 일반 조건절
ORDER BY 1; -- 8 rows


--2. 커미션을 받는 사원의 사번, 이름, 급여, 커미션 금액, 부서명을 조회하는 쿼리를 작성하시오
--단, 커미션 금액은 월급여에 대한 커미션 금액을 나타낸다 ==> salary * commission_pct == commission
SELECT  e.employee_id emp_id, e.first_name, TO_CHAR(e.salary, '$9,999,999') salary, TO_CHAR(e.salary * e.commission_pct, '$9,999,999') bonus,
        d.department_name dept_name
FROM    employees e, departments d
WHERE   e.department_id = d.department_id(+)
AND     commission_pct IS NOT NULL
ORDER BY 1; --35 rows


-- 3. 각 부서의 부서코드, 부서명, 위치코드, 도시명, 국가코드, 국가명을 조회하시오
SELECT  d.department_id, d.department_name, 
        l.location_id, l.city, 
        c.country_id, c.country_name
FROM    departments d, locations l, countries c
WHERE   d.location_id = l.location_id
AND     l.country_id = c.country_id
ORDER BY    1; -- 27 rows

-- 4. 사원의 사번, 이름, 업무코드, 매니저의 사번, 매니저의 이름, 매니저의 업무코드를 조회하여  사원의 사번 순서로
-- 정렬하시오
SELECT  e.employee_id, e.first_name, e.job_id,
        m.employee_id manager_id, m.first_name manager_name, m.job_id manager_job_id
FROM    employees e, employees m
WHERE   e.manager_id = m.employee_id
AND     e.manager_id IS NOT NULL -- 사장인 100번 King 은 제외
ORDER BY 1; --106 rows


-- 5. 모든 사원의 사번, 이름, 부서명, 도시, 주소 정보를 조회하여 사번 순으로 정렬하시오
SELECT  e.employee_id, e.first_name, 
        d.department_name,
        l.city, l.street_address
FROM    employees e, departments d, locations l
WHERE   e.department_id = d.department_id(+)
AND     d.location_id = l.location_id(+)
AND     e.manager_id IS NOT NULL
ORDER BY 1; -- 106 rows








