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

--======================================================
--i가 음수인 경우 정수부 i번째 자리에서 반올림 한다.
--======================================================


[예제 3-4]
SELECT ROUND(123.456789, 2) R1,     -- 소수부 2번째 자리에서 만올림
       ROUND(123456.789, -2) R2     --정수부 2번째 자리에서 반올림
FROM dual;

--TRUNC(n [,i]) : round 함수와 같은 방식이지만, 
--ROUND(반올림) VS TRUNC(버림)
--TRUNCATE TABLE 테이블명 : 테이블의 데이터를 모두 버림(=삭제) 단, 구조/컬럼은 남김

[예제 3-5]
SELECT TRUNC(123.456789) T1,
        TRUNC(123.456789, 2) T2,
        TRUNC(123.456789, -2) T3,
        TRUNC(123456.789, -2) T4
FROM dual;

--CEILL(n) : n과 같거나 큰, 가장 작은 정수 반환하는 함수
-- 무조건 올림된 결과를 반환한느 함수
[예제3-6]
select CEIL(0.12345) C1,
        CEIL(123.25) C2
FROM    dual;

--FLOOR(n) : n 과 같거나 작은 가장 큰 정수를 반환하는 함수
-- 무조건 내림된 결과를 반환하는 함수

select FLOOR(0.12345) C1,
        FLOOR(123.25) C2
FROM    dual;

--MOD(m, n ) : m을 n으로나눈 나머지 값을 반환하는 함수
--n에 0이 오면, m의 값을 그대로 반환한다.
--프로그래밍 언너 : 0으로 나누면 ==> zero divide Error 발생

select MOD(2,0) M1,
        MOD(4,2) M2
FROM dual;

[예제 3-4]
select MOD(17,4) M1, -- 17 = 4*4+1
        MOD(17,-4) M2, -- 17 = -4*-4+1
        MOD(-17,-4) M2, -- -17 = -4*4-1
        MOD(17,0) M2 --17 = 0* + 17
FROM dual;        

[연습문제 3-1]
1. 사원테이블에서 100번 부서와 110번 사원에 대해 사번, 이름, 급여와 15% 인상된 급여를 조회하는 쿼리문을 작성한다
select employee_id, first_name, salary,
        round(salary + salary*0.15) " increase salary1",
        round(salary + salary *0.15, 0) " increase salary2",
        trunc(salary + salary *0.15, 1) " increase salary3",
        trunc(salary + salary *0.15, 2) " increase salary4",
        ceil(salary + salary *0.15, 0) "ceils5",
        floor(salary + salary * 0.15) "floor6"
from employees
where department_id in(100, 110)
order by 1;



--3.2 문자함수(p.22)
--CONCAT(CHAR1, CHAR2) :  파라미터로 받은 두 문자열을 연결하여 결과를 반환하는 함수
-- || : 문자열 연결 연산자
[예제 3-9]
SELECT CONCAT('hello', 'oracle') CONTROL,       --문자열 연결 함수를 씀
'HELLO'||'ORCLE' CONCAT2                        --문자열 연결 연산자를 씀
FROM DUAL;

--INITCAP(CHAR) :  파라미터로 받은 알파벳 단어의 첫글자를 대문자로 하여 반환하는 함수
--UPPER(CHAR) : 파라미터로 받은 알파벳 모두를 대문자로 하여 반환하는 함수
--LOWER(CHAR) : 파라미터로 받은 알파벳 모두를 소문자로 하여 반환하는 함수

[예제3-10]
SELECT INITCAP('I am a boy') init1,
upper('I am a boy') upper2,
LOWER('I am a boy') lower3
from dual;

--LPAD, RPAD 
--LEFT RIGHT
--PAD

select LPAD('page 1' , 15,'*.') "LPAD example",
LENGTH(LPAD('page 1' , 15,'*.')) " LPAD  example lengTh",
Lengthb(lpad('page 1' , 15,'*.')) " LPAD example bytes1",
Lengthb(lpad('페이지 1' , 15,'*.')) " LPAD example bytes2"
from dual;


--제거하고자 하는 문자[,CHAR2] 생략시 기본값으로 공백문자 한 개가 사용된다.
--LTRIM(char1, [char2]) : 왼쪽에서 ~char1에서 char2로 지정한 문자를 제거한 결과를 반환
[예제3-12]
select '[' || LTRIM('   ABCDEFG     ') || ']' RLTRM1,
        '[' || LTRIM('   ABCDEFG     ',' ') || ']' RLTRM2,
        LTRIM('ABCDEFG','AB') LTRIM3,
     LTRIM('ABCDEFG','BA') LTRIM4,
     LTRIM('ABCDEFG','BC') LTRIM5
FROM dual;

select '[' || RTRIM('   ABCDEFG     ') || ']' RLTRM1,
        '[' || RTRIM('   ABCDEFG     ',' ') || ']' RLTRM2,
        RTRIM('ABCDEFG','FG') RLTRM3,
     RTRIM('ABCDEFG','FE') RLTRM4,
     RTRIM('ABCDEFG','GA') RLTRM5
FROM dual;

--TRIM() : 방향을 좌, 우, 양쪽에서 ~char1에서  char2로 지정한 문자를 제거한 결과를 반환
[예제 3-14]
select '[' || trim('   ABCDEFG   ') || ']' T1,양쪽에서 
    trim(Leading 'A' FROM 'ABCDEFG') T2, --왼쪽에서 오른쪽으로
    trim(Trailing 'G' FROM 'ABCDEFG') T3, -- 오른쪽에서 왼쪽으로
    trim(both 'A' FROM 'ABCDEFG') T4,--BOTH 명시
    trim('A' FROM 'ABCDEFG') T5  -- 생략시 default
from dual;

--SUBSUR() : 문자열의 일부를 분리해서 반환한다.(추출한다)
--char 문자열의 position으로 지정된 위치로부터 length개의 문자를 떼어내어 그 결과를 반환한다.
--length 생략시 : position부터 문자열의 끝까지 반환
--position 값을 0으로 명시할 경우, 디폴트로 1이 적용되어 length만큼 문자열을 반환한다

[예제3-15]
select substr('you are not alone',9, 3) STR1,
substr('you are not alone',5 ) STR2,
substr('you are not alone',0, 5) STR3,
substr('you are not alone',1, 5) STR4
from dual;


select 'kimej2159@naver.com' EMAIL,
substr('kimej2159@naver.com', 0, 9) EMAIL_ID,
substr('kimej2159@naver.com', 11, 9) EMAIL_domain
from dual;

-------------------------------------------------------------
-- position의 값을 음수로 작성하면, 그 위치가 오른쪽에서 시작된다. 

select substr('you are not alone',-9, 3) STR1,
substr('you are not alone',-5 ) STR2,
substr('you are not alone',0, 5) STR3,
substr('you are not alone',-1, 5) STR4
from dual;

--REPLACE(char, search_string [,replace_string])
--문자열 중 일부를 다른 문자를 변경하여, 그 결과를 반환한다.
--css(cross site script) 해킹 공격 --> 검색하는 서비스, 여러 사용자의 입력을 받는 서비스를 제공할 때
--사용할 수도 있고, 문자열 일부를 다른 문자로 치환할 수 있음

[예제3-17]
select replace('You are not alone', 'You', 'We') rep1,
replace('You are not alone', ' not') rep2,
replace('You are not alone', ' not', null) rep3
from dual;

--TRANSLATE(char, from_string, to_string)
--char 문자열에서 해당 문자를 찾아 1:1로 변환한 결과를 반환한다.

[예제3-18]
select translate('u! You are not alone', 'You', 'We') Trans1
from dual;

--Quiz. '너는 나를 모르는데 나는 너를 알겠느냐' 을 replace와 TRANSLATE로 변환하여 다음과 같이 변경해 봐라
select replace(char, search_string [,to_string)]
from dual;

select replace('나는 너를 모르는데 너는 나를 알겠느냐', '나', '너') rep1
from dual;

--2.TRANSLATE 함수를 사용 --> 나는 너를 모르는데 너는 나를 알겠느냐

select TRANSLATE ('나는 너를 모르는데 너는 나를 알겠느냐', '나너', '너나') trans1
from dual;


--instr(char, search_string [,position] [,_th])
--문자열에서 특정 문자열의 시작 위치를 반환하는 함수
--char는 대상 문자열, search_string은 찾는 문자열 
--position은 문자열의 찾는 시작위치, _th는 몇번째 인지 명시(단 defualt 값은 1)

[예제3-19]
select Instr('Every Sha-la-la-la', 'la') instr1,
    Instr('Every Sha-la-la-la', 'la', 7) instr2,
     Instr('Every Sha-la-la-la', 'la',1, 2) instr3,
      Instr('Every Sha-la-la-la', 'la',12, 2) instr4,
      Instr('Every Sha-la-la-la', 'la',15, 2) instr5   
From dual;

select 'kimej2159@naver.com' email_addr,
        SUBSTR('kimej2159@naver.com', INSTR('kimej2159@naver.com','@') -1) email_id,
         '@' DIVIDER,
        SUBSTR('kimej2159@naver.com', INSTR('kimej2159@naver.com','@') +1) email_domain
from dual;

SELECT employee_id, first_name, LOWER(TRANSLATE(email, 'akn', '*!')) || '@oracle.com' email
from employees;

-- LENGTH(char) vs lengthb(char)
-- 문자열의 길이를 반환합니다. vs 문자열의 byte 값을 반환합니다.
-- 영문 1자는 1byte, 동아시아(한, 중, 일) 지역의 1글자는 3~4byte로 설정되므로 실제 DB 설계시 저장 공간, 컬럼의 정의시
--데이터에 따른 길이등 


--3.3 날짜함수
--날자와 시간을 연산의 대상으로 하는 함수

select SYSDATE   --오늘 날짜
FROM  dual;

-- 날짜의 형태를 확인하는 명령
select *
from v$nls_parameters;

--RR//MM/DD HH:MT:SS로 바꾸어야 시간 정보가 보임 vs  Y/MM/DD 
ALTER SESSION SET nls_date_format = 'RR/MM/DD HH:MT:SS';

-- 매번 시간/날짜 정보를 출력하기 위해 설정을 바꾸는 것보다는
-- 시간/ 날짜 함수 또는 변환함수를 사용하는 것이 좋다


--ADD_MONTHS(date,n)
-- 특정 날짜에 지정ㅇ한 개월의 수를 더해서 그 결과를 날짜로 반환하는 함수
-- ADD : 추가,  MONTH : 월/개월

SELECT ADD_MONTHS(SYSDATE, 1) MONTH1,
        ADD_MONTHS(SYSDATE, 2) MONTH2,
        ADD_MONTHS(SYSDATE, -3) MONTH3
FROM dual;

--MOMTHS_BETWEEN(date1, date2)
-- 두 날짜 사이의 개월 수 (=차이)를 반환하는 함수
-- date1 - date2 (이후 날짜 - 이전 날짜)

[예제3-22]
select TRUNC(MONTHS_BETWEEN(SYSDATE, '2013-03-20')) || '개월' PASSED,
        TRUNC(MONTHS_BETWEEN('2013-08-28', SYSDATE ))|| '개월' REMAINED
FROM dual;


--Last_Day(date)
--data에 해당하는 마지막 날짜를 반환한다.
-- ex> 날짜가 3월에 해당하면 31을 반환하고 4월이면 30일을 반환한다

SELECT LAST_DAY(SYSDATE) LAST1,
        LAST_DAY('2013-02-01') LAST2
FROM dual;

--NEXT_DAY(date, char)
--date 이후의 날짜에서 char로 명시된 첫번째 일자를 반환
-- char에 요일에 해당하는 문자 SUNDAY, MONDAY,...
-- 또는 요일에 해당하는 숫자 1:일요일, 2:월요일,..7:토요일 
--V$nls_parameter 설정에서 NLS_LANGUEGE, NLS_TERRIORY 설정

SELECT *
FROM V$nls_parameters;

[예제3-24]
select NEXT_DAY(SYSDATE, '월요일') next1,
NEXT_DAY(SYSDATE, '금요일') next2,
NEXT_DAY(SYSDATE, '일') next3,
NEXT_DAY(SYSDATE, 4 ) next4
FROM dual;


--숫자함수, 날짜함수
-- ROUND(N [,i]) : -i 면 정수부 i는 소수부에서 반올림 <숫자함수>
-- ROUND(date, fmt) : 반올림 된 날짜를 fmt에 맞게 그 결과를 반환 <날짜함수>

[예제3-25]
--변환함수

-- JAVA 형변환(CASTING) 함수처럼 사용, ORACLE에서는 한번에 숫자 -->날짜로 변환 불가, 단계적으로 변환은 가능


select round(to_date('2013-06-30'), 'YYYY') R1,
        round(to_date('2013-07-01'), 'YYYY') R2,
        round(to_date('2013-12-15'), 'MONTH') R3,
        round(to_date('2013-12-16'), 'MM') R4,
        round(to_date('2013-05-27 11:59:59', 'YYYY-MM-DD HH24:MI:SS'), 'DD' ) R5,
        round(to_date('2013-05-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'DD' ) R6,
        round(to_date('2013-05-29'), 'DAY') R7,
        round(to_date('2013-05-30'), 'DAY') R8
          
from dual;


--언어를 영문으로 (임시) 변경
alter session set 
SELECT *
FROM employees
where department_id =  :no;


--3.4 변환함수
-- TO_DATE() : 문자를 날짜로
-- TO_CHAR() :  숫자를 문자로
-- TO_NUMBER() : 문자를 숫자로

/*
              숫자 ----------> 문자 -------> 날짜
TO_NUMBER() <--->       TO_CHAR() <---->     TO_DATE()
              숫자 <---------- 문자 <------- 날짜

*/


--3.4.1 TO_CHAR(date/n [,fmt]) : 숫자/날짜를 문자로 변환하는 함수
select TO_CHAR (sysdate,'YYYY-MM-DD HH24:MI:SS') char1,
        TO_CHAR (sysdate,'YYYY') char2,
        TO_CHAR (sysdate,'YYYY/MM/DD') char3
from dual; --시간 정보 출력x

select TO_CHAR(TO_CHAR ('0630'),'RR/DD/YY') char4
from dual;


--3.5 null 관련 함수

--3.6 descode와 case





