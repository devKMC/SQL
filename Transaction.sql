USE practice_sql;

# Transaction : SQL로 작업하는 작업 단위  
#               조회말고 삽입 삭제 수정 작업등을 트랜젝션 작업을 해줘야함

# Transaction의 4가지 특성 (회원가입으로 생각하면 좋음)
# Atomicity (원자성) : 트랜잭션은 모두 성공하거나 모두 실패해야 한다.
# Consistencey (일관성) : 트랜젝션의 작업 결과는 항상 일관성이 있어야 한다.
# isolation (독립성) : 트랜젝션은 모두 독립적이어야 한다.
# Durablitiy (영구성) : 트랜젝션이 성공적으로 완료되면 영구히 반영되야 한다.

# 회원가입 : user - email_authentication
# 사용자는 아이디를 입력하고 중복 확인을 함       
# 만약 입력한 아이디가 중복된 아이디가 아니라면
# 비밀번호 , 비밀번호 확인, 이메일을 입력하고
# 이메일로 인증 번호를 전송
# 사용자는 이메일에 전송된 인증 번호를 확인 후 입력하여 
# 이메일 인증을 진행함
# 이메일 인증을 완료한 후에 회원가입 버튼을 눌러서 회원가입을 마무리함

CREATE TABLE user (
	id VARCHAR(100) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE email_authentication(           #삽입이상
	email VARCHAR(255) PRIMARY KEY,
    authentication_code VARCHAR(4) NOT NULL
);

# 사용자가 아이디를 'idddd'로 입력했다.

# 1. 아이디 중복확인

SELECT * 
  FROM user 
 WHERE id = 'idddd';
 
#  사용자가 비밀번호를 'P!ssw0rd' , 비밀번호 확인 'p!ssw0rd',
#  이메일을 'email@email.com', 서버가 생성한 코드는 'OCMD'이다.

# 2. 이메일 인증
INSERT email_authentication VALUES ('email@email.com', 'OCMD');

#    서버가 지정한 이메일로 인증코드를 전송하고 
#	 사용자는 그 코드를 확인한 후 인증코드를 입력하여 인증함

SELECT * 
  FROM email_authentication;

SELECT *
  FROM email_authentication
 WHERE email = 'email@email.com' 
   AND authentication_code = 'OCMD';
 
# 4. 회원 가입 처리
INSERT USER VALUES('idddd', 'P!ssw0rd', 'email@email.com' );

SHOW variables LIKE '%commit%';

#트랜젝션 자동을 0으로 변경
SET AUTOCOMMIT = 0;
###########여기까지가 회원가입이라고 하는 트랜젝션임 ###########################

########### 새롭게 작성 ###########################

#  트랜젝션 시작
START TRANSACTION;


SELECT * 
  FROM user 
 WHERE id = 'idddd2';
 
#  사용자가 비밀번호를 'P!ssw0rd' , 비밀번호 확인 'p!ssw0rd',
#  이메일을 'email@email.com', 서버가 생성한 코드는 'OCMD'이다.

# 2. 이메일 인증
INSERT email_authentication VALUES ('email2@email.com', 'OCMD');

#    서버가 지정한 이메일로 인증코드를 전송하고 
#	 사용자는 그 코드를 확인한 후 인증코드를 입력하여 인증함

SELECT * 
  FROM email_authentication;

SELECT *
  FROM email_authentication
 WHERE email = 'email2@email.com' 
   AND authentication_code = 'OCMD';
 
# 4. 회원 가입 처리
INSERT USER VALUES('idddd2', 'P!ssw0rd', 'email2@email.com' );

# 트랜젝션 성공 처리
COMMIT;

SELECT *
  FROM USER;

