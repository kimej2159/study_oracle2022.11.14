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


--[2022-12-09]

SELECT c.character_name, NVL(c.character_name, '제다이 중의 제다이') masters
FROM characters c, characters d, roles r
where c.master_id = d.character_id(+)
and c.role_id = r.role_id    
and r.role_name = '제다이'
ORDER BY 1;                      -- 7줄

commit;


--8. 역할이 제다이에 해당하는 배역들의 배역이름, 이메일, 마스터의 이메일을 조회하여 
-- 제다이 기사의 이메일에는 제다이 기사의 이메일을, 없으면 마스터의 이메일을 사용하는 
-- EMAILS 라는 컬럼까지 추가하여 조회하는 쿼리문 작성
-- P.92 표를 참조
select *
from characters;

SELECT c.character_name, c.email JEDAI_EMAIL, m.email MASTER EMAIL
-- NVL(c.character_name, '제다이 중의 제다이') masters
FROM characters c, characters m, roles r
where c.master_id = m.character_id(+)
and c.role_id = r.role_id    
and r.role_name = '제다이'
ORDER BY 1;                 

SELECT  c.character_name, c.email JEDAI_EMAIL, m.email MASTER_EMAIL
--        NVL2(c.email, c.email, m.email) MASTER_EMAIL
FROM    characters c, characters m, roles r
WHERE   c.master_id = m.character_id(+)
AND     c.role_id = r.role_id
AND     r.role_name = '제다이'
ORDER BY 1;


select *
from characters;

-- 9. 스타워지 시리즈별로 출연한 배우의 수를 파악하고자 한다
-- 에피소드 이름, 출연 배우 수, 개봉년도 순으로 조회하는 쿼리문 작성
--      [select]           
-- star wars : 영화정보/ 에피소드 아이디, 영화 제목, 개봉 년도 
-- casting : 캐스팅 정보/ 에피소드 아이디, 캐릭터 아이디 , 실제 배우 이름

select s.episode_name, COUNT(*) cnt
from star_wars s, casting c
where s.episode_id = c.episode_id
group by s.episode_name, s.open_year
order by 1;



-- 10. 전체 시리즈에서 각 배우별 배역이름, 실제 이름, 출연횟수를 조회하는데 출연횟수가 
-- 많은 배역이름, 실제 이름 순으로 조회하는 쿼리문을 작성한다.
--characters : 배역이름
-- casting : 실제 이름
-- star_wars : 에피소드 명, 개봉 년도
select ch.character_name 배역이름, ca.real_name 실제이름, COUNT(*)
from characters ch, casting ca
where ch.character_id = ca.character_id
group by ch.character_name, ca.real_name;


-- 11.  10번을 참고하여 출연 횟수가 많은 상위 3명의 배역명, 실명, 출연횟수 출력
-- rownum : 쿼리 실행 순서대로~ (상위, 하위)
-- RANK() OVER (ORDER BY 절), DENSE_RANK() OVER(ORDER BY 절)
-- 1,2,3,4,5,6....           VS 1,2,3,4,5....
-- 동순위 다음 순위 건너 뜀           VS 동순위 다음 순위도 표현 
-- 그룹함수의 조건 : HAVING 표시 


select ch.character_name 배역이름, ca.real_name 실제이름, COUNT(*)
from characters ch, casting ca
where ch.character_id = ca.character_id
group by ch.character_name, ca.real_name;

-- 11-1. 교재에서 사용한 방법 : rownum

SELECT ROWNUM ranking, e.*
FROM ( select ch.character_name 배역이름, ca.real_name 실제이름, COUNT(*)
        from characters ch, casting ca
        where ch.character_id = ca.character_id
        group by ch.character_name, ca.real_name 
        ORDER BY 1 DESC) e -- 인라인 뷰 : 실제로는 존재하지 않는 가상의 임의의 테이블
where rownum <= 3;

-- 11-2. RANK() 또는 DENSE_RANK() 사용한 방법
SELECT  *
FROM    (   SELECT  DENSE_RANK() OVER(ORDER BY COUNT(*)) ranking, ch.character_name 배역이름, ca.real_name 실제이름, count(*) 출연횟수
            FROM    characters ch, casting ca
            WHERE   ch.character_id = ca.character_id
            GROUP BY ch.character_name, ca.real_name    )
WHERE   ROWNUM <= 3;  

-- 12. 시리즈별 몇명의 배우가 (=실제 배우) 출연했는지 조회하고자 한다
-- 에비소드 시리즈 번호, 에비폿드 이름, 출연배우수를 조회하는데 출연배우수가 많은 순으로 조회
SELECT s.episode_id, s.episode_name, count(*) actor_count
from star_wars s, casting c
where c.episode_id = s.episode_id
group by s.episode_id, s.episode_name
order by actor_count desc;      -order by 3 desc;

commit;













