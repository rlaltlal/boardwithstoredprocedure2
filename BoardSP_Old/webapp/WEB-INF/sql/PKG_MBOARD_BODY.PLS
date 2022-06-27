create or replace PACKAGE BODY PKG_MBOARD AS
  
  ---------------------------------------
  -- MENU
  PROCEDURE  PROC_MENU_LIST(
       O_CUR         OUT  SYS_REFCURSOR
   ) AS
  BEGIN
       OPEN O_CUR FOR 
         SELECT     MENU_ID, MENU_NAME, MENU_SEQ
          FROM      MENUS
          ORDER BY  MENU_SEQ ASC; 
     
  END PROC_MENU_LIST;

  PROCEDURE  PROC_MENU_INSERT(
       IN_MENU_NAME   IN  VARCHAR2 
   ) AS
       V_MENU_ID    VARCHAR2(6);
       V_MENU_SEQ   NUMBER(5, 0);
  BEGIN
    
      SELECT  'MENU'  ||  
              TRIM( TO_CHAR( TO_NUMBER( SUBSTR( NVL( MAX(MENU_ID), 'MENU00'), 5, 2 ) ) +1 , '00' ))
       INTO   V_MENU_ID
       FROM   MENUS;
       
     SELECT   NVL( MAX(MENU_SEQ), 0 ) + 1
       INTO   V_MENU_SEQ
       FROM   MENUS;
       
       INSERT  INTO  MENUS ( MENU_ID, MENU_NAME, MENU_SEQ )  
         VALUES  (  V_MENU_ID, IN_MENU_NAME, V_MENU_SEQ   );
       commit;
       
  END PROC_MENU_INSERT;

  -----------------------------------------------------
  -- BOARD INSERT

  PROCEDURE  PROC_MBOARD_INSERT(
       IN_MENU_ID    IN   VARCHAR2,
       IN_TITLE      IN   VARCHAR2,
       IN_CONT       IN   VARCHAR2,
       IN_WRITER     IN   VARCHAR2,
       IN_BNUM       IN   NUMBER,
       IN_LVL        IN   NUMBER,
       IN_STEP       IN   NUMBER,
       IN_NREF       IN   NUMBER
   ) AS
       V_IDX         NUMBER(5, 0);
       V_BNUM        NUMBER(5, 0);
       V_LVL         NUMBER(5, 0);
       V_STEP        NUMBER(5, 0);
       V_NREF        NUMBER(5, 0);
  BEGIN
      
      -- DIX: 전체글의 번호
     SELECT  NVL(MAX(IDX), 0) + 1
      INTO   V_IDX
      FROM   MBOARD;
      
     IF  IN_BNUM  = 0  THEN  
       -- 새글
       -- 해당 메뉴의 글번호
       SELECT  NVL(MAX(BNUM), 0) + 1
        INTO   V_BNUM 
        FROM   MBOARD
        WHERE  MENU_ID = IN_MENU_ID;
       
       V_LVL  := 0;
       
       V_STEP := 0;
       
       SELECT  NVL(MAX(NREF), 0) + 1
        INTO   V_NREF 
        FROM   MBOARD
        WHERE  MENU_ID = IN_MENU_ID;   
     
     ELSE         
       -- 답글 처리
       V_BNUM := IN_BNUM;
       V_LVL  := IN_LVL + 1;
       V_STEP := IN_STEP + 1;
       
       UPDATE   MBOARD
        SET     STEP     =  STEP + 1
        WHERE   MENU_ID  =  IN_MENU_ID
         AND    NREF     =  IN_NREF
         AND    STEP     >  IN_STEP; 
              
       V_NREF := IN_NREF;
        
     END IF;
      
     INSERT INTO MBOARD (
        IDX,
        MENU_ID,
        TITLE,
        CONT,
        WRITER,
        REGDATE,
        READCOUNT,
        BNUM,
        LVL,
        STEP,
        NREF
    ) values (
        V_IDX,
        IN_MENU_ID,
        IN_TITLE,
        IN_CONT,
        IN_WRITER,
        SYSDATE,
        0,
        V_BNUM,
        V_LVL,
        V_STEP,
        V_NREF
    );
      
  END PROC_MBOARD_INSERT;

  -- BOARD LIST
  PROCEDURE  PROC_MBOARD_LIST(
       IN_MENU_ID    IN   VARCHAR2,
       O_CUR         OUT  SYS_REFcURSOR
   ) AS
  BEGIN
      
    OPEN  O_CUR  FOR
     SELECT        IDX,   MENU_ID,
        
        LPAD(' ', LVL * 2 ) || DECODE( LVL, 0, '', '[Re]' ) ||
           TITLE  AS TITLE,        
        
        WRITER,    
        REGDATE, 
    --    TO_CHAR(REGDATE, 'YYYY-MM-DD') AS  REGDATE,   
       
        READCOUNT,
        BNUM,       LVL,        STEP,       NREF
    FROM
        MBOARD
    WHERE  
        MENU_ID = IN_MENU_ID
    ORDER BY
         NREF   DESC,  STEP  ASC; 
      
      
      
  END PROC_MBOARD_LIST;

  -- PROC_MBOARD_VIEW
  PROCEDURE   PROC_MBOARD_VIEW(
       IN_IDX       IN   NUMBER,
       O_CUR        OUT  SYS_REFCURSOR
   ) AS
  BEGIN
       
      OPEN O_CUR FOR
        SELECT
            IDX,
            MENU_ID,
            TITLE,
            CONT,
            WRITER,
            REGDATE,
            READCOUNT,
            BNUM,
            LVL,
            STEP,
            NREF
         FROM
            MBOARD
         WHERE   
            IDX  = IN_IDX;
            
       
  END PROC_MBOARD_VIEW;

  --  PROC_MBOARD_UPDATE
  PROCEDURE  PROC_MBOARD_UPDATE(
       IN_IDX      IN   NUMBER,
       IN_TITLE    IN   VARCHAR2,
       IN_CONT     IN   VARCHAR2
   ) AS
  BEGIN
      
      UPDATE   MBOARD
       SET     TITLE  =  IN_TITLE,
               CONT   =  IN_CONT
       WHERE   IDX    =  IN_IDX;        
      COMMIT;
      
  END PROC_MBOARD_UPDATE;

  PROCEDURE PROC_MBOARD_DELETE(
       IN_IDX     IN   NUMBER
   ) AS
      V_NREF   NUMBER(5, 0); 
      V_LVL    NUMBER(5, 0);
      V_STEP   NUMBER(5, 0);
  BEGIN
    
       SELECT  NREF, LVL, STEP
        INTO   V_NREF, V_LVL, V_STEP
        FROM   MBOARD
		WHERE   IDX    =  IN_IDX
    
       DELETE  FROM   MBOARD
        WHERE  IDX IN
         (
             SELECT   IDX  FROM  MBOARD
              WHERE   NREF  = V_NREF
              AND     LVL   >= V_LVL
              AND     STEP  >= V_STEP
         );
    
    
  END PROC_MBOARD_DELETE;

END PKG_MBOARD;






