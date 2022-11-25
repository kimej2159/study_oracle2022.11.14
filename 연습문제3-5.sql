--[연습문제3-5]
-- 1. 사원의 사번, 이름, 업무(코드), 업무등급을 조회하는 쿼리문을 DECODE함수와 CASE ~ END 표현식으로 작성하시오
-- 1-1.DECODE() 함수 사용
SELECT  employee_id, first_name, job_id,
        DECODE(
                job_id, 'AD_PRES', 'A',
                        'ST_MAN', 'B',
                        'IT_PROG', 'C',
                        'SA_REP', 'D',
                        'ST_CLERK', 'E',
                        'X'
        ) grade
FROM    employees
--WHERE   manager_id IS NOT NULL -- 사장님은 AD_PRES 라는 JOB_ID 소유, 'A'등급
ORDER BY grade ASC;

-- 1-2. CASE ~ END 표현식 사용
SELECT  employee_id, first_name, job_id,
        CASE job_id  WHEN 'AD_PRES' THEN 'A'
                     WHEN 'ST_MAN' THEN 'B'
                     WHEN 'IT_PROG' THEN 'C'
                     WHEN 'SA_REP' THEN 'D'
                     WHEN 'ST_CLERK' THEN 'E'
                     ELSE 'X'                     
        END grade
FROM    employees
--WHERE   manager_id IS NOT NULL -- 사장님은 AD_PRES 라는 JOB_ID 소유, 'A'등급
ORDER BY grade ASC;




-- 2. 사원의 사번, 이름, 입사일, 근무년수, 근속상태를 조회하는 쿼리를 작성하시오
-- 단, 근무년수는 오늘 날짜를 기준으로 정수로 표기한다.
-- 현재 근속상태를 조회(=범위 비교) <---> CASE ~ END 표현식
-- 10 ~ 15 년 : 10년 이상 근속
-- 16 ~ 19년 : 15년 이상 근속
-- 20 ~ : 20년 이상 근속

SELECT  employee_id, first_name, last_name, hire_date,
        ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) "Years Of Service",
        CASE WHEN ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) BETWEEN 10 AND 15 THEN '10년 이상 15년 이하 근속'
             WHEN ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) BETWEEN 16 AND 19 THEN '15년 이상 20년 이하 근속'
             ELSE '20년 이상 근속'            
        END "employment status"
FROM    employees
ORDER BY 5;




