--[연습문제3-3]
-- 1. 사원 테이블에서 30번 부서원의 사번, 성명, 급여, 근무 개월수를 조회하는 쿼리문을 작성하시오
-- 단, 근무 개월수를 오늘 날짜를 기준으로 날짜 함수를 사용하여 계산하시오

-- MONTHS_BETWEEN(date1, date2) : date1 에서 date2를 뺀 개월수를 반환하는 함수
-- 사원들의 근무 관련 데이터 : 입사일(hire_date)
SELECT  employee_id emp_id, first_name||' '||last_name name, 
        TO_CHAR(salary, '$9,999,999') salary,
        ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) "근속 개월수",
        ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)/12) "근속 년수"
FROM    employees
WHERE   department_id = 30 -- purchasing : 구매부서
ORDER BY 1; -- 6rows


-- 2. 급여가 12000 달러 이상인 사원의 사번, 성명, 급여를 조회하여 급여 순으로 결과를 정렬하시오
-- 단, 급여는 천단위 구분기호를 사용하여 표시

SELECT  employee_id emp_id, first_name||' '||last_name name, 
        TO_CHAR(salary, '$9,999,999') salary,
        department_id, job_id
FROM    employees
WHERE   salary >= 12000 -- Alias 사용금지
ORDER BY 3; -- Alias 사용가능, 9rows



-- 3. 2005년 이전에 입사한 사원들의 사번, 성명, 입사일, 업무 시작 요일을 조회하시오
-- 단, 업무 시작 요일이란 입사일에 해당하는 요일을 지칭한다.
SELECT  employee_id 사번, first_name||' '||last_name 성명, hire_date 입사일,
        INITCAP(LOWER(TO_CHAR(hire_date, 'DAY'))) 업무시작요일1, -- Tuesday
        INITCAP(LOWER(TO_CHAR(hire_date, 'DY'))) 업무시작요일2   -- Tue
FROM    employees
--WHERE   TO_CHAR(hire_date, 'YYYY') < '2005'; --24 rows
--WHERE   hire_date <= TO_DATE('04/12/31'); --24 rows
WHERE   hire_date <= '04/12/31'; --24 rows
-- 2004/12/31까지 포함해서 비교도 가능

-- 기본설정이 KOREAN이면, 수요일 or 수 라고 나옴.
-- 현재 로그인한 HR 스키마에서만 변경, 다른 스키마로 접속 하거나 재접속하면 원래의 설정으로 돌아감.
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH'; 






