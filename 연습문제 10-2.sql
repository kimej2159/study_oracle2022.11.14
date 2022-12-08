연습문제 10장 -2
1. CHARACTERS 테이블의 EMAIL 컬럼에서 이메일 정보가 없는 배역들의 모든 정보를 조회하는 쿼리문을 작성한다
SELECT *
FROM CHARACTERS
WHERE email is null;

2.characters 테이블에서 역할이 시스에 해당하는 등장인물을 조회하는 쿼리문 작성
select *
from characters
where role_id = 1002;
-- 2-1. roles 테이블에서 '시스'에 해당하는 role_id를 조회
select *
from characters
where email like '%sith%';
-- 2-2. 
select character_name
from characters
where role_id = (   select role_id
                    from roles
                    where role_name = '시스' )        --4줄

-- 3. 에피소드 4에 출연한 배우들의 실제 이름을 조회하는 쿼리문 작성
-- 3-1. desc casting;
-- 3-2.테이블 정의만 하고, 실제 데이터는 입력하지 않음, 우리가 직접 인터넷에서 찾아봐야 함
select real_name
from casting
where episode_id =  4;


TRUNCATE TABLE casting;

INSERT INTO casting
values(4, 1,'마크 해밀');
INSERT INTO casting
values (4, 2,'해리슨 포드');
INSERT INTO casting
values (4, 3,'캐리 피셔');

INSERT INTO casting
values (5, 4,'앨릭 기니스');
INSERT INTO casting
values (5, 5,'데이비드 프로스');
INSERT INTO casting
values (5,6,'제임스 얼 존스');

INSERT INTO casting
values (6, 7,'앤서니 대니얼스');
INSERT INTO casting
values (6, 8,'케니 베이커');
INSERT INTO casting
values (6, 9,'피터 메이휴');

INSERT INTO casting
values (1, 10,'빌리 디 윌리엄스');
INSERT INTO casting
values (1, 11,'프랭크 오즈');
INSERT INTO casting
values (1, 12,'이언 맥더미드');

INSERT INTO casting
values (2, 13,'헤이든 크리스텐슨');
INSERT INTO casting
values (2, 14,' 리엄 니즌');
INSERT INTO casting
values (2, 15,'나탈리 포드만');
INSERT INTO casting
values (3, 16,'페르닐라 오거스트');
INSERT INTO casting
values (3, 17,'아메드 베스트');
INSERT INTO casting
values (3, 18,'레이 파크');
INSERT INTO casting
values (3, 19,'테뮤라 모리슨');
INSERT INTO casting
values (3, 20,'세뮤얼 L. 잭슨');
INSERT INTO casting
values (3, 21,'크리스토퍼 리');

select *
from casting;

--4. 에피소드5 출연한 배우들의 배역 이름, 실제 이름을 조회하시오
-- 4.1 오라클 JOIN
select  character_name,
        real_name
from characters ch, casting ca 
where ch.character_id = ca.character_id;

-- 4.2 ANSI JOIN
select  ch.character_name,
        ca.real_name
from characters ch INNER JOIN casting ca 
ON ch.character_id = ca.character_id;

-- 연습문제 10-2 3번에서 중복테이터 입력 문제 발생 --> 제약 조건을 다시 확인

-- 5.주어진 오라클 조인문을 ANSI 조인으로 변경하시오
-- ANSI JOIN : 여러개 테이블이 있다면, 2개 테이블의 JOIN 결과와 다시 INNER JOIN / OUTER JOIN 하는 방식
-- 기본 조회 코딩
SELECT c.character_name, p.real_name, r.role_name
FROM characters c, casting p, roles r
where c.character_id = p.character_id
AND c.role_id = r.role_id(+)
AND p.episode_id = 2;

-- ANSI JOIN 사용 시 코딩
SELECT c.character_name, p.real_name, r.role_name
FROM characters c INNER JOIN casting p
USING (character_id)
LEFT OUTER JOIN roles r
USING (role_id)
where p.episode_id = 2;

SELECT c.character_name, p.real_name, r.role_name
FROM characters c INNER JOIN casting p
ON c.character_id = p.character_id
LEFT OUTER JOIN roles r
USING (role_id)
where p.episode_id = 2;

-- 6.characters 테이블에서 배역이름, 이메일, 이메일 아이디를 조회하는 쿼리문을작성하시오
--단, 이메일이 id@jedai.com일 때를 참고하시오
select character_name,
        email,
        (SUBSTR(email,1,INSTR(email, '@')-1)) email_id
from characters;

select 'characrer_name@jedai.com',
        SUBSTR('characrer_name@jedai.com', 1, INSTR('characrer_name@jedai.com', '@')-1)id
FROM dual;


-- 7. 역할이 제다이에 해당하는 배역들의 배역이름, 그의 마스터 이름을 조회하는 쿼리를 작성하시오
-- 셀프조인 / 아우터 처리 : 오라클JOIN(+) vs ANSI JOIN : [LEFT|RIGHT|FULL] OUTER JOIN
-- NULL 처리 : NVL, NVL2, COALESCE
-- 오라클 IF ~ ELSE IF : DECODE, CASE WHEN~
SELECT ch.character_name, 
        ca.character_name masters
FROM characters ch, characters ca
where ch.master_id = ca.character_id    -- 셀프 조인식
AND ch.role_id = 1001; -- 알면, 모르면 서브쿼리



-- 연습문제 10-1, 10-2 트랜잭션 처리!
COMMIT;











