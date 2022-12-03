--[연습문제5-2]
--
--1. 사번이 110, 130, 150에 해당하는 사원의 사번, 이름, 부서명을 조회하시오
--     [일반조건]                               [조인]

-- 1-1. 오라클 조인
SELECT  e.employee_id, e.first_name, 
        d.department_name
FROM    employees e, departments d        
WHERE   e.department_id = d.department_id
AND     e.employee_id IN (110, 130, 150)
ORDER BY 1; -- 3 rows

-- 1-2. ANSI 조인
SELECT  e.employee_id, e.first_name, 
        d.department_name
--FROM    employees e JOIN departments d        
FROM    employees e INNER JOIN departments d        
ON      e.department_id = d.department_id
AND     e.employee_id IN (110, 130, 150)
ORDER BY 1; -- 3 rows

2. 모든 사원의 사번, 이름, 부서명, 업무코드, 업무제목을 조회하시오
-- 2-1. 오라클 조인
SELECT  e.employee_id, e.first_name, 
        d.department_name,
        j.job_id, j.job_title
FROM    employees e, departments d, jobs j
WHERE   e.department_id = d.department_id(+)
AND     e.job_id = j.job_id(+)
AND     e.manager_id IS NOT NULL
ORDER BY 1; -- 106 rows

-- 2-2. ANSI 조인 
SELECT  e.employee_id, e.first_name, 
        d.department_name,
        j.job_id, j.job_title
FROM    employees e LEFT OUTER JOIN departments d
ON      e.department_id = d.department_id
LEFT OUTER JOIN jobs j
ON      e.job_id = j.job_id
WHERE   e.manager_id IS NOT NULL
ORDER BY 1; -- 106 rows


-- ON 을 USING으로 변경
SELECT  e.employee_id, e.first_name, 
        d.department_name,
        job_id, j.job_title
FROM    employees e LEFT OUTER JOIN departments d
USING      (department_id)
LEFT OUTER JOIN jobs j
USING      (job_id)
WHERE   e.manager_id IS NOT NULL
ORDER BY 1; -- 106 rows
        
        
SELECT SYSDATE, SYSTIMESTAMP,
FROM    dual;
