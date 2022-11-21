--NULL 처리(P. 15)
--값이 없는 상태, 미지의 값(=수학적 표현)
-- 그렇다고 0이라는 뜻은 아님

--각 부서의 위치 정보를 가진 Locations 테이블을 사용하여 다음과 같이 정보를 조회해 보자
DESC locations;
/*
이름          널?          유형
------------ ----------- -------------
LOCATION_ID  NOT NULL     

--2. locations 데이터 조회
select *
from locations; -- postal_code, state_province에 null 존재

-- 3. employees 데이터 조회
select *
from employees;-- commission_pct, manager_id, department_id 에 null 존재

[예제 2-37]locations 테이블에서 윙치코드, 도로주소, 주를 조회하시오.
select location_id, street_address, city, state_province
from locations;

--is null : 컬럼이 null인 조건
--is not null : 컬럼의 데이터가 null 아닐때 조건

select location_id, street_address, city, state_province
from locations
where state_province IS NULL; -- where state_province = NULL;로 하면 안됨

select location_id, street_address, city, state_province
from locations
where state_province IS NOT NULL;

--사원 테이블 EMPLOYEES 조회
-- 총 사원수 : 
select *
from employees
where commiSSion_pct IS NULL; -- 50rows

select *
from employees
where MANAGER_ID IS NULL; --BOSS

select *
from jobs;
-- 부서 없이도 일하는 사람? 부서가 적거나 , 회사에 필수적이지 않지만 꼭 필요한 사람
select *
from employees
where commiSSion_pct IS NULL;


--2.4 데이터 정렬
-- ORDER BI 컬럼 [ASC | DESC] : 특정 컬럼을 오름차순(Ascending) 또는 내림차순(Desending)으로 정렬
select *
from employees
ORDER BY employee_id asc; -- 사원 코드를 ASC으로 정렬 시킴

select *
from employees
where department_id IS NOT NULL
ORDER BY employee_id DEsc; -- 사원 코드를 DESC으로 정렬 시킴

[예제 2-40] 80번 부서의 사원정보중 이름을 기준으로 오름차순 정렬하시오
SELECT employee_id, first_name, department_id
FROM employees
where department_id = 80 
ORDER BY first_name asc;

[예제2-41] 80번 부서의 사원정보에 대해 이름을 내림차순으로 정렬한다.
select employee_id, salary, email
from employees
where department_id = 80
order by first_name desc;

[예제 2-42] 60번 부서의 사원 정보에 대해 년 급여(=연봉)를 오름차순으로 정렬하시오
select employee_id, salary*12 annual_salary, email, job_id, hire_date
from employees
where department_id = 60
order by annual_salary asc;

[예제 2-43] 사원 테이블에서 부서는 오름차순, 월 급여는 내림차순으로 정렬하여 사원 정보를 조회한다.
select  employee_id,last_name, salary mon_salary, email, job_id, department_id
from employees
--order by department_id  asc, salary desc ;
--order by dept_id ASC, mom_desc;
order by 4 asc, 3 desc;

--F10 : 여러 테이블을 이용해 JOIN 연살할 때 시간소요, 복잡도 등을 오리클엔진이 어떻게 처리하는지 들여다 보는 단축키




--3장. 기본함수
-- 오라클이 제공하는 함수 VS 사용자가 작성하는 함수 : PL, SQL에서 function(=펑션, 기능)
-- 함수 : 어떠한 명령 처리 코드가 포함된 객체 VS  변수 메모리에 데이터를 저장하기 위한 어떤 공간
-- 메소드 : 객체에 정의된 함수 (= 재 사용을 위한)
--syso + [control + space] : 자동완성 --> system 객체에 있는 outprintln()
-- 단일 행 vs 다중 행 함수 
-- 함수에 사용하는 파라미터와 반환되는 값의 유형에 따라 함수를 구분한다.
-- dual : 가짜ㅏ 테이블 , dummy 테이블로 표현식의 결과값을 알아보고자 할 때 유용하다.


--3.1 숫자함수
ABS(n) : 함수 내부에 전달하는 값n은 파리미터라고 읽습니다. Absolute 절대값 표현결과
[예제 3-1]
select ABS(32) ABS1,
        abs(-32) abs2
from dual;

--sign(n) : 함수 내부에 전달하는 n이 양수인지, 음수인지 여부를 판단하고 그 결과를 반환하는 함수
select sign(1), sign(-1),sign(0)
from dual;

-- 개발자 과정엣 ㅓ한번쯤은 사용할만한 함수만 다룸.
--cos(n) : 각도에 대한  cos 값 계산 결과를 반환
--tan(n) : 각도에 다핸 tan 값 계산 결과를 반환
-- 수학관련 함수등이 더 많이 있음.

--ROUND(n [,i]) -- n은 필수, i는 옵션 // n을 소수점 i번째 자리로 반올림 한 수
--i는 표현할 소수점 아래 자릿수
--i를 생략하면 i값을 0으로 인식하여, 반올림한다. 즉 ROUND(N,0)은 ROUND(N)과 반환값이 같다
[예제 3-3] 
SELECT ROUND(123.45678) R1,
       ROUND(123.45678, 2) R2,
       ROUND(123.45678, 0) R3
FROM dual;

[예제 3-4]
select 







--3.2 문자함수
--3.3 날짜함수
--3.4 변환함수
--3.5 null 관련 함수
--3.6 descode와 case





