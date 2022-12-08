--[연습문제 10-1]
--다음의 테이블을 생성하시오
-- 1. STAR_WARS (영화정보)
--1-1. 접속 창에서 HANUL > 테이블 : 우클릭... 새 테이블
--1-2. DDL을 직접 작성 
CREATE TABLE star_wars (
    episode_id NUMBER(5),    --PRIMARY KEY / 컬럼 레벨
    episode_name VARCHAR2(50),
    open_year   NUMBER(4),
    CONSTRAINT character_id_pk PRIMARY KEY ( episode_id) -- 테이블 레벨 : 제약조건을 간단 명료하게
);

-- 2. CHARACTERS(등장인물)
CREATE TABLE characters (
    character_id NUMBER(5), --PRIMARY KEY --컬럼 레벨 : 제약조건명 SYS_CXXXX 형태
    character_name VARCHAR2(30),
    master_id NUMBER(5),
    role_id   NUMBER(4),
    email VARCHAR(40),
    CONSTRAINT character_id_pk PRIMARY KEY (character_id) -- 테이블 레벨 : 제약조건명을 간단명료하게~
);

-- 3. CASTING(등장인물-실제 배우 정보)
CREATE TABLE casting (
    episode_id NUMBER(5),    --PRIMARY KEY / 컬럼 레벨
    character_id NUMBER(5),
    real_name NUMBER(30),
    CONSTRAINT character_id_pk PRIMARY KEY ( episode_id) -- 테이블 레벨 : 제약조건을 간단 명료하게
);

CREATE TABLE casting (
    episode_id NUMBER(5), --PRIMARY KEY --컬럼 레벨 : 제약조건명 SYS_CXXXX 형태
    character_id NUMBER(5),
    real_name   VARCHAR2(30)
);

-- 4. STAR_WARS 테이블에 교재 88쪽, 데이터를 입력하시오
-- DML + COMMIT / ROLLBACK;
INSERT INTO star_wars  
VALUES(4, '새로운 희망(A NEW HOPE)', 1977);
INSERT INTO star_wars
VALUES(5, '제국의 역습(THE EMPIRE STRIKES BACK', 1980);
INSERT INTO star_wars
VALUES(6, '제다이의 귀환(RETURN OF THE JEDI)', 1983);
INSERT INTO star_wars
VALUES(1, '보이지 않는 위험(THE PHANTOM MENACE)',1999);
INSERT INTO star_wars
VALUES(2, '클론의 습격(ATTACK OF THE CLONES)', 2002);
INSERT INTO star_wars
VALUES(3, 'TLTMDML QHRTN(REVENGE OG THE SITH)', 2005);

SELECT *
FROM STAR_WARS

-- 5. CHARACTERS 테이블에 교재 89쪽 데이터를 입력하시오
INSERT INTO characters (character_id, character_name, email)
VALUES (1, '루크 스카이워커', 'luke@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (2, '한 솔로', 'solo@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (3, '레이아 공주', 'leia@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (4, '오비완 케노비', 'Obi-Wan@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (5, '다쓰 베이더', 'vader@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (6, '다쓰 베이더(목소리)', 'vader_voice@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (7, 'C-3PO', 'c3po@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (8, 'R2-D2', 'r2d2@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (9, '츄바카', 'Chewbacca@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (10, '랜도 칼리시안', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (11, '요다', 'yoda@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (12, '다쓰 시디어스', 'sidious@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (13, '아나킨 스카이워커', 'Anakin@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (14, '콰이곤 진', '');
INSERT INTO characters (character_id, character_name, email)
VALUES (15, '아미달라 여왕', '');
INSERT INTO characters (character_id, character_name, email)
VALUES (16, '아나킨 어머니', '');
INSERT INTO characters (character_id, character_name, email)
VALUES (17, '자자빙크스(목소리)', '');
INSERT INTO characters (character_id, character_name, email)
VALUES (18, '다쓰 몰', 'maul@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (19, '장고 펫', '');
INSERT INTO characters (character_id, character_name, email)
VALUES (20, '마스터 윈두', 'windu@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (21, '두쿠 백작', 'dooku@jedai.com');

SELECT *
FROM    characters;


6.ROLES 테이블 생성, 89쪽 데이터 삽입
CREATE TABLE roles (
    role_id NUMBER(4),
    role_name varchar(9)
);

INSERT INTO roles VALUES(1001, '제다이');
INSERT INTO roles VALUES(1002, '시스');
INSERT INTO roles VALUES(1003, '반란군');

SELECT *
FROM roles;

7. CHARACTERS 테이블의 ROLE_ID 컬럼의 데이터가 ROLES 테이블의
    ROLE_ID 컬럼의 데이터를 참조하도록 CHARACTERS 테이블에 참조키를 생성한다.

--7-1. ROLES 테이블의 ROLE_ID를 PK로 지정
ALTER TABLE roles
ADD CONSTRAINT roles_id_pk PRIMARY KEY (role_id);

SELECT constraint_name, constraint_type
from user_constraints
where table_name = 'ROLES';         --대문자로 'ROLES'

-- 7-2. characters 테이블의 role_id 테이블의 role_id를 참조하도록
ALTER TABLE characters
ADD CONSTRAINT role_id_fk FOREIGN KEY (role_id) REFERENCES roles(role_id);
                        -- characters 컬럼(fk)
-- pk : unique + not null
-- fk : null 허용 (unique도 허용)

--8. 참조키를 생성했으면 CHARACTERS 테이블의 ROLE_ID 값을 변경한다
--이메일이 sith면 1002, 
--이메일이 alliance면 1003,
--이메일이 jedai면 1001

UPDATE characters
SET role_id = 1002
WHERE email LIKE '%sith%';

UPDATE characters
SET role_id = 1003
WHERE email LIKE '%alliance%';

UPDATE characters
SET role_id = 1001
WHERE email LIKE '%jedai%';

-- 콰이곤 진 : 이메일이 없음 (jedai)
UPDATE characters
SET role_id = 1001
WHERE character_name LIKE '콰이곤 진';

select *
from characters;            -- 21줄

9. characters 테이블의 MASTER_ID컬럼은 EMPLOYEES 테이블의 MANAGER_ID와 같은 역할을 한다 
-- CHARACTER_ID 값을 찾아 MASTER_ID 컬럼을 변경

UPDATE characters
SET master_id = (   SELECT character_id
                    from characters
                    where character_name = '오비완 케노비')
WHERE character_name IN ('아나킨 스카이워커', '루크 스카이워커');

UPDATE characters
SET master_id = ( SELECT character_id
                    from characters
                    where character_name = '요다')
where character_name IN ('마스터 윈두', '두쿠 백작');

UPDATE characters
SET master_id = ( SELECT character_id
                    from characters
                    where character_name = '다쓰 시디어스')
where character_name IN ('다쓰 베이더', '다쓰 몰');

UPDATE characters
SET master_id = ( SELECT character_id
                    from characters
                    where character_name = '콰이곤 진')
where character_name IN ('오비완 케노비');


UPDATE characters
SET master_id = ( SELECT character_id
                    from characters
                    where character_name = '두쿠 백작')
where character_name IN ('콰이곤 진');

SELECT *
FROM characters;

10.CASTING 테이블의  기본키는 EPISODE_ID와 CHARACTER_ID에 각각
-- STAR_WARS, CHARACTERS 테이블의 ID를참조하는 외래키를지정하시오
-- 2. (이미 만들어진 테이블에 ) 외래키 제약 조건을 추기
ALTER TABLE casting 
ADD CONSTRAINT episode_id_fk FOREIGN KEY (episode_id) REFERENCES star_wars (episode_id);
-- 제약 조건 추가            [이름]     [제약조건]      [해당컬럼]  참조 사항 [테이블] [컬럼]
ALTER TABLE casting
ADD CONSTRAINT character_id_fk FOREIGN KEY (character_id) REFERENCES CHARACTERS(character_id);

select constraint_name, constraint_type, owner
from user_cOnstraints
where table_name = 'CASTING';

/* 제약조건
    -- 데이터의 무결성을 보장하기 위한 --> 컬럼에 잘못된
    -- NOT NULL, CHECK, UNIQUE, PRIMARY KEY, FOREIGN KEY
    -- DEFAULT : 제약조건은 아님
    1. 테이블 생성시 컬럼 레벨 OR 테이블 레벨 정의 [CREATE]
    CREATE TABLE 테이블명 (
    컬럼명1 데이터 타입1 제약조건1, -- 컬럼 레벨
    컬럼명2 데이터 타입2,
    CONTSTRAINT 제약조건 이름 제약 조건 (해당컬럼)  --테이블 레벨
    )
    2. 테이블 생성 후 해당 컬럼에 제약조건 추기 [ALTER]
    ALTER TABLE 테이블명
    ADD CONSTRANINT 제약조건 이름 제약 조건 (해당컬럼);
*/












