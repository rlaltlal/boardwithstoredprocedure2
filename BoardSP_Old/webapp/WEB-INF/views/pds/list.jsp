<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"  %>    
 <%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/common.css" />
<style>
  #pdsList td:nth-of-type(1) { width:48px; text-align:center; }
  #pdsList td:nth-of-type(2) { width:308px; }
  #pdsList td:nth-of-type(3) { width:78px; text-align:center; }
  #pdsList td:nth-of-type(4) { width:78px; text-align:center;}
  #pdsList td:nth-of-type(5) { width:68px; text-align:center; }
  #pdsList td:nth-of-type(6) { width:88px; text-align:center;}
  
</style>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
   $(function() {

   });
</script>
</head>
<body>
   <!-- 메뉴 목록  menuList -->
   <%@include file="/WEB-INF/include/menus_pds.jsp" %>
   
   <!-- 자료실 pdsList -->
   <table id="pdsList">
    <caption><h2>${ menu_name  } 자료실</h2></caption>
    <tr>
     <td>번호</td> 
     <td>제목</td> 
     <td>작성자</td> 
     <td>조회수</td> 
     <td>파일첨부</td> 
     <td>작성일</td>     
    </tr>
    
   <c:forEach var="pdsVo"  items="${ pdsList }">
     <tr>
      
      <!-- 번호 --> 
      <td>
       <c:choose>
         <c:when test="${ pdsVo.lvl eq 0 }">
		    ${ pdsVo.bnum }         
         </c:when>
         <c:otherwise>
            &nbsp;
         </c:otherwise>
       </c:choose>
      </td> 
      
      <!-- 제목 --> 
      <td> 
       <%-- 새글부분 --%>
       <c:choose>
        <c:when test="${ pdsVo.lvl == 0 }">
           <c:choose>
             <c:when test="${ pdsVo.delnum eq 0 }">
               <a href="/PDS/View?idx=${ pdsVo.idx }&menu_id=${ menu_id }&nowpage=${pagePdsVo.nowpage}&pagecount=${pagePdsVo.pagecount}&pagegrpnum=${pagePdsVo.pagegrpnum}"> 
                ${ pdsVo.title  }
               </a> 
             </c:when>
             <c:otherwise>
                <s>삭제된 글입니다</s>
             </c:otherwise>
           </c:choose>
        </c:when>  
        
       <%-- 답글 부분 --%>
        <c:otherwise> 
          <b style="display:inline-block;width:${pdsVo.lvl*20}px" ></b>        
          <c:choose> 
            <c:when test="${ pdsVo.delnum eq 0 }"> 
     <a href="/PDS/View?idx=${ pdsVo.idx }&menu_id=${ menu_id }&nowpage=${pagePdsVo.nowpage}&pagecount=${pagePdsVo.pagecount}&pagegrpnum=${pagePdsVo.pagegrpnum}"> 
              [답글] ${ pdsVo.title  }
              </a>
            </c:when>
            <c:otherwise>
              [답글] <s>삭제된 글입니다</s>
            </c:otherwise>
          </c:choose>  
        </c:otherwise>        
       </c:choose>     
      </td> 
      
      <!-- 작성자 --> 
      <td> ${ pdsVo.writter }</td> 
      
      <!-- 조회수 --> 
      <td> ${ pdsVo.readcount }</td> 
      
      <!-- 첨부(attach)된 파일 수 --> 
      <td>
        <c:choose>
          <c:when test="${ pdsVo.filescount eq 0 }">
            &nbsp;
          </c:when>
          <c:otherwise>
            ${ pdsVo.filescount } 개
          </c:otherwise>
        </c:choose> 
      </td> 
      
       <%-- 작성일 el 에서 substring 함수사용 fn tag 추가 
         <%@taglib prefix="fn"
             uri="http://java.sun.com/jsp/jstl/functions"%> 
       추가필요 
         containts, startsWith, endsWith, indexOf,
         split, join(+),length, replace, substring,
         toLowerCase, toUpperCase, 사용자정의함수 사용   
       --%>
       
      <td>${fn:substring(pdsVo.regdate, 0 , 10) }</td> 
      
     </tr>   
   </c:forEach> 
   
   <!-- 페이징 영역   -->
   <tr>
     <td  colspan="6">
       <%@ include  file="/WEB-INF/include/paging.jsp" %>
     </td>
   </tr>
   
   <!-- 새글 쓰기 -->
   <tr>
     <td colspan="6">
       <a href="/PDS/WriteForm?menu_id=${menu_id}&bnum=0&lvl=0&step=0&nref=0&nowpage=${pagePdsVo.nowpage}&pagecount=${pagePdsVo.pagecount}&pagegrpnum=${pagePdsVo.pagegrpnum}">새 글 쓰기</a> 
     </td>
   </tr>
   </table>
   
   
</body>
</html>













