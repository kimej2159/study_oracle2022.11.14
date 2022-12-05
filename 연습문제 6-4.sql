[연습문제 6-4]

1. 급여가 적은 상위 5명사원의 순위, 사번 이름, 급여를 조회하는 쿼리문을 인라인 뷰 서브쿼리를 사용하여 작성한다.
select e.*
from  (
            select RANK() OVER (ORDER BY SALARY) "rank",
                    DENSE_RANK() OVER (ORDER BY SALARY) "DANSE_RANK",
                    employee_id,
                    last_name,
                    salary
            from employees                
        ) e
where ROWNUM <= 5;

2. 부서별로 가장 급여를 많이 받는 사원의 사번, 이름, 부서번호, 급여,
    업무코드를 조회하는 쿼리문을 인라인뷰 서브쿼리를 사용하여 작성한다
--NULL 처리 함수
--NVL(expr1, expr2) : expr1이 NULL이면 expr2를 반환 아니면 expr1를 반환
--NVL2(expr1, expr2, expr3) : expr1이 NULL이면 expr3을 반환 아니면 expr2를 반환

select e.employee_id, e.last_name, e.department_id,
        e.salary, e.job_id
from employees e, (        select department_id, max(salary) max_sal
                            from employees
                            GROUP BY department_id ) k
WHERE NVL(e.department_id, 0) = NVL(k.department_id, 0)
AND     e.salary = k.max_sal
order by 1;                                              -- 12 rows

-- 부서별 최고 급여, 사원수 조회하고 ROLLUP 함수로 총계
select employee_id, max(salary), department_id
from employees
group by department_id, employee_id;








