5.6 ANSI JOIN (p.48)
-- ANSI : 국가표준 협회는 미국에서 제품, 서비스, 과정, 시스템, 인력관리 분야에서 표준을 개발하는 것을 감독하는 비영리 민간 기구
-- JOIN 연산 : 테이블과 테이블의 관계를 이용해서 다른 테이블의 데이터를 기존 테이블에 부착해서 조회하는 방법
-- WHY? 데이터의 중복을 막고(=정규화) 효율적으로 관리하기 위한 RDBMS의 특성
-- IF? 모든 데이터가 하나의 테이블에 존재한다면? JOIN 필요없으나~ DBMS 목적상 이렇게 사용하지 않음.

5.6.1 (Oracle JOIN) JOIN
-- Cartesian Product : 카테시안 곱(=JOIN하는 테이블의 각각 rows 수 만큼  곱한 결과행 , 잘못된)
-- EQUI-JOIN  vs  NON-EQUI JOIN (거의 사용 안함)
-- OUTER JOIN  (vs INNER JOIN-실제 존재x 개념상)
5.6.2 (모든 DBMS공통) JOIN - 국제 표준 JOIN 형식
※ ORACLE로 배웠으나 회사에 갔더니 mariaDB 라고 하면 새롭게 mariaDB를 배워야 할까? 대부분 비슷하지만, 각 DBMS 저마다의
문법적 특성도 있고..JOIN은 표준조인
-- INNER JOIN : 오라클의 EQUI-JOIN과 같은 기능을 하는 JOIN 형식 
-- 1) FROM 절에 INNER JOIN을 명시
-- 2) JOIN 조건은 ON 절에 명시

-- 오라클 조인
[예제5-12] 사원의 사번, 이름, 부서코드, 부서명 정보를 조회하시오
SELECT  e.employee_id, e.first_name, e.department_id,
        d.department_name
FROM    employees e, departments d     
WHERE   e.department_id = d.department_id(+) -- OUTER
AND     e.manager_id IS NOT NULL
ORDER BY 1;

-- ANSI > INNER JOIN  vs  OUTER JOIN
-- ==================================================
-- WHERE 절에 일반 조건은 ON, USING절 다음에 표시한다
-- JOIN 조건에 사용하는 컬럼명이 같은 경우 ON 대신 USING을 사용한다.
-- USING을 사용하면 식별자(=Alias)를 사용할 수 없다.
-- ==================================================

SELECT  e.employee_id, e.first_name, department_id,  -- USING(1)
        d.department_name
FROM    employees e INNER JOIN departments d     
--ON      e.department_id = d.department_id
USING   (department_id)                              -- USING(2)
WHERE   e.manager_id IS NOT NULL
ORDER BY 1;


-- ========================================================================================
-- JOIN에 사용하는 테이블이 3개 이상일 경우, 첫번째 JOIN 결과에 두번째 JOIN을 추가하는 형태
-- ========================================================================================
[문제 5-15] (모든)사원의 사번, 이름, 부서코드, 부서명, 위치코드, 도시의 이름을 조회하시오
-- employees
-- departments
-- locations

SELECT  e.employee_id, e.first_name, e.department_id,
        d.department_name, l.location_id,
        l.city
FROM    employees e INNER JOIN departments d
ON   e.department_id = d.department_id
INNER JOIN locations l
ON     d.location_id = l.location_id
ORDER BY 1;

-- ON을 USING 으로
SELECT  e.employee_id, e.first_name, department_id,
        d.department_name, location_id,
        l.city
FROM    employees e INNER JOIN departments d
USING   (department_id)
INNER JOIN locations l
USING    (location_id)
ORDER BY 1;





-- OUTER JOIN [LEFT | RIGHT | FULL★] : OUTER (데이터중 NULL 이 있는곳의 반대)
-- 오라클 조인 > OUTER JOIN은 (+)를 사용
-- ANSI 조인 > OUTER JOIN은 문자로 [방향] OUTER JOIN
-- FROM 절에 [LEFT|RIGHT|FULL]을 사용하고, JOIN 조건은 ON절에 명시

[예제5-16] 사원의 사번, 이름, 부서코드, 부서명 정보를 조회한다.
-- 오라클 조인 > OUTER JOIN
SELECT  e.employee_id, e.first_name, e.department_id,
        d.department_name
FROM    employees e, departments d
WHERE   e.department_id = d.department_id(+)
AND     e.manager_id IS NOT NULL
ORDER BY 1;

-- ANSI 조인 > OUTER JOIN
SELECT  e.employee_id, e.first_name, department_id,
        d.department_name
--FROM    employees e LEFT OUTER JOIN departments d
--FROM    departments d RIGHT OUTER JOIN employees e
FROM    employees e FULL OUTER JOIN departments d   -- 업무상 가장 안전하게 누락된 데이터 없이 조회
--ON      e.department_id = d.department_id
USING   (department_id)
WHERE   e.manager_id IS NOT NULL
ORDER BY 1;



















