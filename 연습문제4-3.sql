--[연습문제4-3]
--
--1. 사원테이블에서 똑같은 이름(=first_name)이 둘 이상 있는 이름과 그 이름이 모두 몇 명인지 조회하는 쿼리를 작성하시오
SELECT  first_name, COUNT(first_name) cnt
FROM    employees
--WHERE   manager_id IS NOT NULL
GROUP BY    first_name
HAVING  COUNT(first_name) >= 2; -- 13 rows
-- David, John, Peter가 중복된 이름중 3건이나 있음 (=그만큼 흔하다)
--
--
--
--2. 부서번호, 각 부서별 급여총액과 평균 급여를 조회하는 쿼리문을 작성하시오
--(단, 부서 평균 급여가 8000 이상인 부서만 조회되도록 하시오)
SELECT  department_id dept_id, TO_CHAR(SUM(salary),'9,999,999') sum_sal, 
        TO_CHAR(ROUND(AVG(salary)),'9,999,999') avg_sal
FROM    employees
--WHERE
GROUP BY department_id
HAVING  ROUND(AVG(salary)) >= 8000
ORDER BY    1; -- 6rows
--
--
--3. 년도, 년도별로 입사한 사원수를 조회하는 쿼리문을 작성하시오
--(단, 년도는 2014의 형태로 표기되도록 하시오)
SELECT  TO_CHAR(hire_date, 'YYYY') year, -- CHAR
        COUNT(hire_date) cnt
FROM    employees
--GROUP BY hire_date -- 98 rows
GROUP BY TO_CHAR(hire_date, 'YYYY') -- 8rows
ORDER BY 1;

/* 
YEAR   CNT
-----------
2001	1
2002	1
2002	1
2002	4
2002	1
....
2003	1
2004	1
2004	1
2004	1
2004	1
2004	1
*/
-- ====================================================
-- group by 절에 그룹의 기준되는 컬럼 그리고 그 타입도 유의
-- ====================================================
/*
YEAR   CNT
------------
2001	1
2002	7
2003	6
2004	10
2005	29
2006	24
2007	19
2008	11
*/
