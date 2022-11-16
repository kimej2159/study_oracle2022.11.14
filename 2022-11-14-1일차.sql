-- 1~10장. SQL : Structured Query Language (구조화된 질의어) 연습
-- 부록> PL/SQL : 오라클에서 제공하는 절차적인 질의어(Procedural language extension to SQL)
/*
 1. 공통사항
 한줄주석 vs 여러줄 주석 
 명령의 끝에는 세미콜론(;)
 (일반적으로) 대,소문자를 구분하지 않는다.

 2.SQL 종류 : 역할에 따라서 아래와 같이 구분
 (2-0. DQL : SELECT)
 2-1. DML : SELECT, INSERT, UPDATE, DELETE [데이터를 조회, 저장, 삭제하는 명령어]
 ------------------------------ 개발자가 사용하는 명령 ---------------------------
 2-2. DDL : CREATE, ALTER, DROP [데이터베이스 객체를 생성, 삭제, 변경하는 명령어]
 2-3. DCL : GRANT, REVOKE [권한을 주거나 뺏는 명령어]
------------------------------ DBA가 사용하는 명령 --------------------------- 
*/

-- 회원 정보를 저장하는 테이블을 만들기
-- 아이디 : 인조 키 (데이터를 유일하게 식별하는 임의로 만든 키)
-- 이름 : 동명이인이 있다면? 다른 아이디로 구분
-- 나이
-- 전화번호
-- 주소
-- 이메일
-- 가입일
-- 1. 테이블 객체 생성 : DDL(Database Definition Language, 데이터베이스 정의언어)
CREATE TABLE userTBL (
    id NUMBER, -- 회원 아이디 : 1,2,3,...
    name VARCHAR2(20),
    age NUMBER,
    phone CHAR(13),
    addr VARCHAR2(50),
    email VARCHAR2(30),
    reg_date DATE
);

CREATE TABLE itemTBL (
    id NUMBER(4), -- 상품 아이디 : 0001, 0002,..
    buyer NUMBER, -- 구매자 아이디 : 1-홍길동, 2-김길동,...
    title VARCHAR2(100), -- 상품명 : 100바이트
    qty NUMBER, -- 상품 갯수
    price VARCHAR2(50), -- 상품 가격
    sell_date DATE-- 판매일
);

-- NUMBER : 숫자 타입/소숫점
-- CHAR : 고정 문자 (ex.주민번호)
-- VARCHAR2 : 가변 문자 vs VARCHAR : 오라클에서 다시 어떤 목적으로 재사용하기위해 가급적 사용하지 않도록!!
-- NCHAR, NVARCHAR : National (다국어, 영어가 아닌 한국어/일본어/중국어/아랍어,..각 나라별 언어 설정)
-- DATE : (시간)날짜   vs  TIMEZONE, TIMESTAMP : 밀리세컨드까지 저장 (ex.출입기록)
------------------------------------------------------------------------------------
-- LOB(Large Object), CLOB, BLOB : 이미지, 영상등의 용량이 큰 바이너리 파일들을 관리하는 타입
-- BFILE : 테라바이트 까지..

-- ※ DBA, Modeler가 주로 결정하고 진행 , Developer는 그렇게 만들어진 데이터베이스에 데이터입출력,조작을 담당

-- 2. 테이블에 데이터 삽입 : DML (Database Manipulation Language, 데이터베이스 조작언어)
-- 2.1 새로운 데이터를 삽입/저장 : INSERT
-- 2.2 기존데이터를 변경해서 저장 : UPDATE

INSERT INTO userTBL (id, name, age, phone, addr, email, reg_date)
VALUES (1, '홍길동', 20, '010-1234-5678', 'gwangju, seo-gu', 'hong2@naver.com', SYSDATE);
-- 샘플 데이터 입력은 쉬는시간 갖고!! 회원, 상품 테이블 데이터를 입력하세요!!
INSERT INTO userTBL (id, name, age, phone, addr, email, reg_date)
VALUES (2, '최길동', 55, '010-1234-5671', 'gwangju, seo-gu', 'hong@naver.com', SYSDATE);
INSERT INTO userTBL (id, name, age, phone, addr, email, reg_date)
VALUES (3, '김길동', 42, '010-1234-5672', 'gwangju, nam-gu', 'hong3@naver.com', SYSDATE);
INSERT INTO userTBL (id, name, age, phone, addr, email, reg_date)
VALUES (4, '박길동', 23, '010-1234-5673', 'gwangju, buk-gu', 'hong4@naver.com', SYSDATE);
INSERT INTO userTBL (id, name, age, phone, addr, email, reg_date)
VALUES (5, '이길동', 25, '010-1234-5674', 'gwangju, gwansan-gu', 'hong5@naver.com', SYSDATE);
INSERT INTO userTBL (id, name, age, phone, addr, email, reg_date)
VALUES (6, '차길동', 30, '010-1234-5678', 'gwangju, seo-gu', 'hong6@naver.com', SYSDATE);
INSERT INTO userTBL (id, name, age, phone, addr, email, reg_date)
VALUES (7, '고길동', 40, '010-1234-5679', 'gwangju, seo-gu', 'hong7@naver.com', SYSDATE);

-- 아이템 데이터 등록
-- 순서와 데이터의 갯수를 테이블 정의 그대로 지켜서 입력!
SELECT SYSDATE
FROM dual;  -- 오늘 날짜 정보를 조회 : 22/11/15

INSERT INTO itemTBL
VALUES (0001, 1, '따끈따끈 군고구마 1박스', 100, 15000, TO_DATE('2022/10/15','RRRR/MM/DD HH:MI:SS'));
INSERT INTO itemTBL
VALUES (0002, 2, '온열 손난로', 10, 20000, TO_DATE('2022/10/20 10:05:00','RRRR/MM/DD HH:MI:SS'));
INSERT INTO itemTBL
VALUES (0003, 3, '캠핑은 먹는 재미지, 이베리코 삼겹살', 20, 30000, TO_DATE('2022/11/10 09:55:44','RRRR/MM/DD HH:MI:SS'));

-- 3. 테이블 내의 데이터 조회 : SELECT
SELECT * FROM userTBL; -- 한줄로 쓰는건 잠깐,..
SELECT * FROM itemTBL; -- 한줄로 쓰는건 잠깐,..

-- 4. 테이블 내의 데이터중 조건에 맞는 데이터만 조회 : SELECT
SELECT * 
FROM userTBL 
WHERE age = 20;  -- = : 같다 (equal, 비교 연산자)

SELECT * 
FROM itemTBL 
WHERE buyer = 2;

-- 5. 테이블의 구조(=정의, 명세)를 조회 : desc, describe (=묘사하다, 서술하다)
DESC userTBL;
/* userTBL 구조
이름       널? 유형           
-------- -- ------------ 
ID          NUMBER       
NAME        VARCHAR2(20) 
AGE         NUMBER       
PHONE       CHAR(13)     
ADDR        VARCHAR2(50) 
EMAIL       VARCHAR2(30) 
REG_DATE    DATE 
*/

DESC itemTBL;
/* itemTBL의 명세(=구조)
이름        널? 유형           
--------- -- ------------ 
ID           NUMBER       
BUYER        NUMBER       
TITLE        VARCHAR2(50) 
QTY          NUMBER       
PRICE        NUMBER       
SELL_DATE    VARCHAR2(20)
*/

--6. 상품 테이블에 상품 데이터를 삽입
INSERT INTO itemTBL
VALUES (0001, 1, 'TV 고출력 30W 스피커', 1, 20000, SYSDATE); --SYSDATE 함수 : 시스템의 날자를 입력해줌
INSERT INTO itemTBL
VALUES (0002, 2, 'Java 개발자용 컴퓨터', 1, 2000000, SYSDATE); --SYSDATE 함수 : 시스템의 날자를 입력해줌
INSERT INTO itemTBL
VALUES (0003, 3, '야근시 유용한 기모 슬리퍼', 1, 10000, SYSDATE); --SYSDATE 함수 : 시스템의 날자를 입력해줌
INSERT INTO itemTBL
VALUES (0004, 4, '상품사진 촬영용 DSLR카메라', 1, 1200000, SYSDATE); --SYSDATE 함수 : 시스템의 날자를 입력해줌
INSERT INTO itemTBL
VALUES (0005, 5, '노트북, 태블릿 수납형 백팩', 1, 100000, SYSDATE); --SYSDATE 함수 : 시스템의 날자를 입력해줌

-- 7. 상품 테이블 조회
SELECT ID, BUYER, PRICE
FROM itemTBL;

-- 8. 데이터베이스 객체 삭제
-- DROP TABLE 테이블명;      -- 데이터베이스 삭제(=데이터도 날아감) 
-- DELETE 테이블명 WHERE 조건; -- 조건에 맞는 데이터만 삭제(=테이블은 존재) 
-- TRUNCATE TABLE 테이블명;    -- 테이블은 존재, 데이터는 모두 삭제

--DROP TABLE userTBL;
--DROP TABLE itemTBL;

SELECT *
FROM userTBL;

-- 삽입 데이터를 물리적으로 실제 컴퓨터 저장소에 저장하는 명령
COMMIT;

















