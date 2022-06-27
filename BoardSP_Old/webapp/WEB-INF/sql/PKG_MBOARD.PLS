create or replace PACKAGE PKG_MBOARD AS
   ---- MENU   
   PROCEDURE  PROC_MENU_LIST(
       O_CUR         OUT  SYS_REFCURSOR
   ); 

   PROCEDURE  PROC_MENU_INSERT(
       IN_MENU_NAME   IN  VARCHAR2 
   );
   
   -- Board
   PROCEDURE  PROC_MBOARD_INSERT(
       IN_MENU_ID    IN   VARCHAR2,
       IN_TITLE      IN   VARCHAR2,
       IN_CONT       IN   VARCHAR2,
       IN_WRITER     IN   VARCHAR2,
       IN_BNUM       IN   NUMBER,
       IN_LVL        IN   NUMBER,
       IN_STEP       IN   NUMBER,
       IN_NREF       IN   NUMBER
   );
   
   -- MBOARD_LIST
   PROCEDURE  PROC_MBOARD_LIST(
       IN_MENU_ID    IN   VARCHAR2,
       O_CUR         OUT  SYS_REFcURSOR
   );
   
   -- MBOARD_VIEW
   PROCEDURE   PROC_MBOARD_VIEW(
       IN_IDX       IN   NUMBER,
       O_CUR        OUT  SYS_REFCURSOR
   );
   
   -- MBOARD_UPDATE
   PROCEDURE  PROC_MBOARD_UPDATE(
       IN_IDX      IN   NUMBER,
       IN_TITLE    IN   VARCHAR2,
       IN_CONT     IN   VARCHAR2
   );
   
   -- PROC_MBOARD_DELETE
   PROCEDURE PROC_MBOARD_DELETE(
       IN_IDX     IN   NUMBER
   );

END  PKG_MBOARD;










