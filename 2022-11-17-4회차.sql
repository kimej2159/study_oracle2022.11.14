--2장. 데이터 조회 문구

/*
DML : SELECT, INSERT, UPDATE, DELETE
DDL : CREATE, ALTER, DROP
DCL : GRANT, REVOKE, TRUNCATE
*/

SELECT 컬럼1, 컬럼2
FROM    테이블명;

SELECT employee_id, first_name, department_id
FROM employees;

SELECT *
FROM eployees;

--2.2 SLECT 구문 + 조건절(+필터링) : 특정 조건에 맞는 데이터만 조회

SELECT employee_id, first_name, department_id       
FROM employees
WHERE department_id = 100;

--자동서식 적용 : 원하는 쿼리를 블럭 씌운 후 CTRL + F7(=자동 서식 )
--TAB 자주 사용!

--2.3.3 비교 연산자
-- 숫자 비교
-- 문자 비교(p.7)

[예제 2-11] tjddl king인 사원의 정보를 조회하시오
--사원의 정보 : 사번, 이름, 성, 전화번호, 이메일, 매니저, 부서, 보너스...
--      last_name 이 king 인지 비교!! (=같다, 크다, 작다)

SELECT employee_id 사번, last_name 성, department_id 부서
FROM employees
WHERE last_name = 'King'; 
     

-- 문자열 패턴 : 특정 조건의 문자를 찾는 과정
-- ex> 전화번호, 이메일 ==> 010-1234-1234 vs email@naver.com
-- sql은 대, 소문자를 구분하지 않으나, 문자 데이터는 구분함
--          (명령어)               (문자값)

[예제 2-12] 입사일이 2004년 1월 1일 이전인 사원의 정보(=사번, 입사일,이름...)
--2004년 1월 1일 이전, 처음부터 ~ 2003년 12월 31일 까지
SELECT *
FROM employees
WHERE hire_date < '01-JAN-04'; --년/월/일 

--' ' : 작은 따옴표는 1) 문자와 데이터 / 2)시간,날짜 데이터를 표기할 때 사용
--" " : 큰 따옴표는 컬럼의 별칭(=Alisa)을 지정할 때, 공백이 있는 단어 

/* 교제대로 실행했는데, 왜 오류가 나는지?
ORA-01858: 숫자가 있어야 하는 위치에서 숫자가 아닌 문자가 발견되었습니다.
01858. 00000 -  "a non-numeric character was found where a numeric was expected"
*Cause:    The input data to be converted using a date format model was
           incorrect.  The input data did not contain a number where a number was
           required by the format model.
*Action:   Fix the input data or the date format model to make sure the
           elements match in number and type.  Then retry the operation.
*/

--오늘 날짜 출력하기
SELECT SYSDATE
FROM dual;
          
SELECT employee_id 사번, last_name 성, department_id 부서, hire_date 입사일
FROM employees
WHERE hire_date < '04/01/01'; --년/월/일 



--데이터베이스 설정 보기
--NLS : national language support :  나라별/ 언어별 설정 지원
-- 1.현재 NLS 세팅 확인
SELECT *
FROM V$nls_parameters;

-- 2. sqlDeveloper > 도구 > 환경설정 > 데이터베이스 >  NLS를 확인

2.3.4 AND, OR, NOT 논리 조건 연산자
-- 여러개의 조건이 오는 경우 필요한 연산자
-- AND 연산은 조건이 모두 TRUE일 때, 최종 TRUE를 반환 
-- OR 연산은 조건이 하나라도 TRUE일 때, 최종 TRUE를 반환 
-- NOT 연산은 조건이 TRUE면 FALSE를 FALSE면 TRUE를 반환

[예제2-13] 30번 부서 사원중 급여가 10000 이하인 사원의 정보를 조회하시오
(사번, 이름, 급여, 부서코드를 뜻함)
SELECT employee_id, last_name, first_name, Salary, department_id
FROM employees
WHERE department_id=30 
AND Salary <= 10000;

--Q. Den 이라는 사람, 사번이 114 인 사람의 정보를 추가 조회하시오
SELECT employee_id, last_name, first_name, Salary, department_id
FROM employees
WHERE employee_id = 114;

[예제 2-13] 30번 부서 사원중 급여가 10000 이하면서 2005년 이전에 입사한 직원의 정보를 조회하시오
SELECT 'hanul' company, employee_id, last_name, first_name, Salary, department_id
FROM employees
WHERE department_id = 30
and Salary <= 10000
and hire_date <= '04-12-31';


-- OR 연산은 조건이 하나라도 TRUE일 때, 최종 TRUE를 반환 
[예제 2-15] 30번 부서나 60번 부서에 속한 사원의 정보를 조회하시오
--부서 VS 사원의 관계 <---> 오라클 RDBMS(Reational DBMS, 관계형 데이터베이스 시스템) <---> 테이블 ~ 테이블 관계
SELECT 'eunji' company, employee_id, last_name, first_name, Salary, department_id
FROM employees
WHERE department_id = 30
OR department_id = 60;






-- NOT 연산은 조건이 TRUE면 FALSE를 FALSE면 TRUE를 반환
