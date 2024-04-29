
-- 일반 사용자 계정을 생성하는 구문(오직 관리자 계정에서만 가능하다)
-- [표현법] CREATE USER 계정명 IDENTIFIED BY 비밀번호;
--ID는 대소문자 구분하지 않지만 ,PW는 구분함
CREATE USER JDBC IDENTIFIED BY JDBC;

-- 위에서 생성된 일반 사용자계정에 최소한의 권한(접속, 데이터관리) 부여
-- [표현법] CREANT 권한1, 권한2... TO 계정명;
GRANT RESOURCE, CONNECT TO JDBC;
