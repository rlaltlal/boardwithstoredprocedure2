create or replace PACKAGE  PKG_PDS2 AS
    
    -- 자료실 목록 조회
    PROCEDURE   PROC_PDS_LIST(
        IN_MENU_ID     IN     VARCHAR2,
        O_CUR          OUT    SYS_REFCURSOR 
    );
    
    -- 새글 쓰기, 답글 쓰기
    PROCEDURE   PROC_PDS_INSERT(
        IN_MENU_ID     IN    VARCHAR2,
        IN_TITLE       IN    VARCHAR2,
        IN_CONT        IN    VARCHAR2,
        IN_WRITER      IN    VARCHAR2,
        IN_BNUM        IN    INTEGER,
        IN_LVL         IN    INTEGER,
        IN_STEP        IN    INTEGER,
        IN_NREF        IN    INTEGER,
        
        -- 파일 업로드에 대한 추가 항목
        IN_FILENAME    IN     FILE_ARRAY,
        IN_FILEEXT     IN     FILE_ARRAY,
        IN_SFILENAME   IN     FILE_ARRAY
    );
    
    PROCEDURE    PROC_PDS_VIEW (
        IN_IDX        IN      NUMBER,
        O_CUR         OUT     SYS_REFCURSOR
    );
    
    PROCEDURE   PROC_PDS_FILELIST (
        IN_IDX        IN      NUMBER,
        O_CUR         OUT     SYS_REFCURSOR
    );
    
    -- PROC_PDS_PAGINGLIST
    PROCEDURE   PROC_PDS_PAGINGLIST(
       IN_MENU_ID       IN     VARCHAR2,
       
       IN_NOWPAGE       IN     NUMBER,
       IN_PAGECOUNT     IN     NUMBER,
       
       OUT_TOTALCOUNT   OUT    NUMBER,
       
       O_CUR            OUT    SYS_REFCURSOR
    
    );
    
    -- 수정 PROC_PDS_UPDATE
    PROCEDURE    PROC_PDS_UPDATE(
        IN_IDX         IN      NUMBER,
        IN_TITLE       IN      VARCHAR2,
        IN_CONT        IN      VARCHAR2,
        
        IN_FILENAME    IN      FILE_ARRAY,
        IN_FILEEXT     IN      FILE_ARRAY,
        IN_SFILENAME   IN      FILE_ARRAY
    );
    
    -- 자료실 삭제
    PROCEDURE     PROC_PDS_DELETE(
        IN_IDX         IN      NUMBER,
        IN_NREF        IN      NUMBER,
        IN_LVL         IN      NUMBER,
        IN_STEP        IN      NUMBER    
    );  

END PKG_PDS2;