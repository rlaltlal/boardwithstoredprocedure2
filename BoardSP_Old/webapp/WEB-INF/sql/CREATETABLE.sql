--------------------------------------
CREATE TABLE MENUS
(
     MENU_ID    VARCHAR2(6)   NOT NULL PRIMARY KEY
   , MENU_NAME  VARCHAR2(100) NOT NULL
   , MENU_SEQ   NUMBER(5, 0)  NOT NULL
);

INSERT INTO  MENUS ( MENU_ID, MENU_NAME, MENU_SEQ) 
  VALUES   ( 'MENU01', 'JAVA', '1');
COMMIT;  
------------------------------------------
-- 게시물 목록
CREATE  TABLE   MBOARD
(
      IDX         NUMBER(5, 0)   PRIMARY KEY
    , MENU_ID     VARCHAR2(6)    NOT NULL
    , TITLE       VARCHAR2(200)  NOT NULL
    , CONT        VARCHAR2(4000) 
    , WRITER      VARCHAR2(50)   NOT NULL
    , REGDATE     DATE           DEFAULT  SYSDATE
    , READCOUNT   NUMBER(6, 0)   DEFAULT  0
    
    , BNUM        NUMBER(5, 0)   DEFAULT 0
    , LVL         NUMBER(5, 0)   DEFAULT 0
    , STEP        NUMBER(5, 0)   DEFAULT 0
    , NREF        NUMBER(5, 0)   DEFAULT 0
    
);

-- 자료실 PKG_PDS
 -- MBOARD 에 칼럼 추가 delnum   0 / 1 ( 삭제 ) 
  ALTER  TABLE  MBOARD
    ADD   (  DELNUM   NUMBER(1, 0) DEFAULT 0  );   -- 기존 TAT NULL 
    
  -- 추가된 칼럼에 초기값 설정 : 0
  UPDATE  MBOARD
    SET   DELNUM = 0; 
  COMMIT;   
  
  -- 게시글(MBOARD) 와 관련된 파일목록 : 파일이름만 저장
  CREATE  TABLE   FILES
  (
      FILE_NUM    NUMBER(5, 0)   NOT NULL
     , IDX        NUMBER(5, 0)   NOT NULL
     , FILENAME   VARCHAR2(300)  NOT NULL
     , FILEEXT    VARCHAR2(30)   NOT NULL
     , SFILENAME  VARCHAR2(300)  NOT NULL
     , CONSTRAINT  FILES_PK   PRIMARY KEY
       ( 
           FILE_NUM,
           IDX
       )
     , CONSTRAINT  FK_MBAORD_FILES_IDX
       FOREIGN KEY (IDX)
       REFERENCES  MBOARD(IDX)
       -- ON  DELETE CASCADE
  ) 
  
  ----------------------------------------
  CREATE  TABLE   USERS
(
      USERID     VARCHAR2(20)  NOT NULL      PRIMARY KEY
    , USERPASS   VARCHAR2(20)  NOT NULL 
    , USERNAME   VARCHAR2(60)  NOT NULL 
    , USERPOINT  NUMBER( 8, 0 ) DEFAULT 0
);

INSERT INTO  USERS  ( USERID, USERPASS, USERNAME, USERPOINT  )
 VALUES   (  'sky', '1234' , '노제', 1000  );
 
INSERT INTO  USERS  ( USERID, USERPASS, USERNAME, USERPOINT  )
 VALUES   (  'sea', '1234' , '관리자', 90000000 ); 
 
commit; 
 
  
  
  
  
  
  





