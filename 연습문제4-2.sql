--[연습문제4-2]
--
--1. 사원 테이블에서 커미션을 받는 사원이 모두 몇 명인지 그 수를 조회하시오
-- COUNT() : 컬럼의 데이터가 있는 갯수, NULL 제외
SELECT COUNT(commission_pct) cnt
FROM    employees; -- 35(명)
--
--
--2. 가장 최근에 뽑은 직원을 입사시키 날짜가 언제인지 최근 입사일자를 조회하시오
-- MAX(hire_date) : 가장 최근 입사자의 입사일 (=나중)
-- MIN(hire_date) : 가장 마지막 입사자의 입사일 (=먼저)
-- ※MAX(), MIN() : 모든 데이터 유형에 사용가능한 그룹함수
SELECT MAX(hire_date)
FROM    employees
WHERE   manager_id IS NOT NULL; -- 08/04/21

--
--3. 90번 부서의 평균 급여액을 조회하시오 (단, 평균급여액은 소수 둘째자리까지 표시하시오)
SELECT  ROUND(AVG(salary), 2) avg_sal1,
        ROUND(SUM(salary) / COUNT(employee_id), 2) avg_sal2
FROM    employees
WHERE   department_id = 90; -- 19333.33
