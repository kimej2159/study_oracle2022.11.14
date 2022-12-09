--11장. 뷰와 시퀀스 (p.93)
--데이터 베이스 여러가지 객체 중 하나 (테이블, 뷰 , 시퀀스, 시노님, 인덱스 ...)
--데이터 베이스 객체 조회 쿼리
select *
from user_objects;

-- 11.1 뷰
-- 데이터가 존재하지 않는 가상 테이블로 보안과 사용자 편의를 위해 사용/생성한다
-- 보안 : 모든 데이터 중 일부 데이터만 보여주기 위한 목적
-- 사용자 편의 : 개발자가 많들 서비스, 앱, 시스템을 실제로 사용하는 and-user 측면
-- ※ 사용자 스키마에 해당 권한 (CREATE VIEW, CREATE TABLE, CREATE...)이 있어야 가능

-- [예제 11-1]
--CREATE OR REPLACE VIEW 뷰명 AS 
--SELECT 이하

-- V : view
-- emp80 : employees (80번)
-- 뷰 생성 권한만 없음
CREATE OR replace view v_emp80 AS
select employee_id emp_id, first_name fname, email, hire_date
from hr.employees
where department_id = 80;

select *
from  v_emp80

-- GRANT : 권한을 주는 명령어 
-- REVOKE : 줬던 권한을 뺏는 명령어
-- GRANT 권한1,...TO 대상계정;

--테이블 생성 권한, 테이블 조회 권한은 있음 : HANUL
--hr 계정으로 실습하거나 hanul 계정에 create view 라는 권한을 부여 (SYSTEM)
CREATE OR replace view v_emp80 AS
select employee_id emp_id, first_name fname, email, hire_date
from hr.employees
where department_id = 80;
with read only; -- 뷰의 수정을 금지
--WITH CHECK; -- 뷰의 컬럼값을 변경하는것을 금지(옵션)

DROP TABLE emp80;

======================================
-- 테이블과 뷰는 거의 같다 (데이터 조회)
-- 뷰는 데이터를 입력, 수정, 삭제가 (불)가능(READ ONLY)

--뷰 조회
SELECT *
FROM    v_emp80; -- 테이블 처럼

-- 뷰 데이터 입력
INSERT INTO v_emp80 (emp_id, first_name, last_name, email, hire_date)
VALUES (400,'Yeonghun', 'Seon', 'Seonyeonghun', SYSDATE);

--뷰 데이터 변경

-- 뷰 데이터 삭제

------------------------------------------------------------
-- 뷰가 아닌 뷰가 참조하는 실제 테이블에 데이터가 변경하는 시도가 됩니다
-------------------------------------------------------------
-- 뷰 삭제 = 테이블 삭제

-- 뷰 삭제 : 테이블 삭제와 같음
DROP VIEW v_emp80;


--11.2 시퀀스 



