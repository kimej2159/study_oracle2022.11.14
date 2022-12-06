[연습문제 5-2]
1.사번이 110, 130,150번에 해당하는 사원의 사번,
    이름, 부서명을 조회하는 쿼리문을 ANSI 조인으로 작성한다.
--1-오라클 조인
SELECT e.employee_id, e.first_name,
        d.department_id
from employees e, departments d
where e.department_id = d.department_id
and     e.employee_id in (110, 130, 150)
order by 1;

--2-ansi 조인
SELECT e.employee_id, e.first_name,
        d.department_id
from employees e join departments d
on e.department_id = d.department_id
and     e.employee_id in (110, 130, 150)
order by 1;

--2. 모든 사원의 사번, 이름, 부서명, 업무코드, 업무제목을 조회하여 사번순으로 정렬하시오
--2.1-오라클 조인
select e.employee_id, e.first_name,
        d.department_name,
        j.job_id, j.job_title
from employees e, departments d, jobs j
where    d.department_id = e.department_id(+)
and      e.job_id = j.job_id(+)
and     e.manager_id IS NOT NULL
ORDER by 1;

--2.2 ANSI 조인
--(LEFT OUTER JOIN)
select e.employee_id, e.first_name,
        d.department_name,
        j.job_id, j.job_title
from employees e LEFT OUTER JOIN departments d
ON    d.department_id = e.department_id
LEFT OUTER JOIN jobs j
ON     e.job_id = j.job_id
WHERE     e.manager_id IS NOT NULL
ORDER by 1;

--(FULL OUTER JOIN)
select e.employee_id, e.first_name,
        d.department_name,
        j.job_id, j.job_title
from employees e FULL OUTER JOIN departments d
ON    d.department_id = e.department_id
FULL OUTER JOIN jobs j
ON     e.job_id = j.job_id
WHERE     e.manager_id IS NOT NULL
ORDER by 1;

