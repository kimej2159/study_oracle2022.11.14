[연습문제6-2]

1.부서위치코드가 1700에 해당하는 모든 사원의사번, 이름, 부서코드, 
    업무코드를 조회하는 쿼리문을 다중 행 서브 쿼리를 사용하여 작성한다.
-- 시애틀에 근무하는 사원의 정보
SELECT department_id, department_name
FROM    departments
WHERE   location_id = 1700;

SELECT  city
FROM    locations
WHERE   location_id = 1700; -- Seattle


SELECT employee_id, first_name, department_id, job_id
FROM   employees
WHERE  department_id IN ( SELECT department_id
                          FROM  departments
                          WHERE location_id = 1700 )
ORDER BY 1;      -- 18 rows



2.부서별로 가장 급여를 많이 받는 사원의 사번, 이름, 부서번호,
        급여, 업무코드를 조회하는 쿼리문을 다중 컬럼 서브쿼리를 사용하여 작성한다
-- Kimberely는 부서는 배정되어 있지 않는 사원.
SELECT employee_id, first_name, department_id, salary, job_id
FROM   employees
WHERE   (department_id, salary) IN ( SELECT department_id, MAX(salary)
                                     FROM    employees
                                     GROUP BY department_id ); -- 11 rows
        
SELECT department_id, MAX(salary)
from employees
where department_id IS NOT NULL
GROUP BY department_id;
        





    
    
        
        
        
        