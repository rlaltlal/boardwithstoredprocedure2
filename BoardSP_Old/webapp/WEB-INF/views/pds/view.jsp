<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/common.css" />
<style>
   .tdcont  { height: 300px; vertical-align: top;    }
   .tdfile  { height: 100px; vertical-align: top;    }
</style>
</head>
<body>
  
  <!--  메뉴목록 -->
  <%@include file="/WEB-INF/include/menus_pds.jsp" %>
  
  <table  id="pdsView">
    <caption><h2>내용 보기</h2></caption>
    <tr>
      <td>작성자</td>
      <td>${ pdsVo.writter }</td>
      <td>작성일</td>
      <td>${ pdsVo.regdate }</td>
    </tr>
    <tr>
      <td>글번호</td>
      <td>${ pdsVo.idx }</td>
      <td>조회수</td>
      <td>${ pdsVo.readcount }</td>
    </tr>
    <tr>
      <td>글제목</td>
      <td colspan="3">${ pdsVo.title }</td>
    </tr>
  
   <%--   
     ${fn:replace( pdsVo.cont, "\n", "<br />" ) } // 에러
      "\n" 은 오류발생시킨다
     해결책) pageContext 영역 - 한 페이지(현재페이지) 영역 변수생성 
      pageContext.setAttribute( "newLine", "\n");  // newLine = "\n"
      ${fn:replace( pdsVo.cont, newLine, "<br />" ) }  
   --%>
   <% pageContext.setAttribute( "newLine", "\n"); %>
    
    <tr>
      <td>글내용</td>
      <td colspan="3" class="tdfile">
       ${fn:replace( pdsVo.cont, newLine, "<br />" ) }
      </td>
    </tr>
    
    <tr>
      <td>파일</td>
      <td colspan="3" class="tdfile">
       <c:forEach var="file"  items="${ filesList }">
        <div>
        <a href="<c:out value="/download/external/${ file.sfilename }" />">
         ${ file.filename }
        </a>
        </div>
       </c:forEach>
      </td>
    </tr>
    
    <tr>
      <td  colspan="4">
        <a href="/PDS/List?menu_id=${ pdsVo.menu_id }&nowpage=${ map.nowpage }&pagecount=${ map.pagecount }&pagegrpnum=${ map.pagegrpnum }">[목록]</a>
        <a href="/PDS/WriteForm?menu_id=${ pdsVo.menu_id }&bnum=0&lvl=0&step=0&nref=0&nowpage=${ map.nowpage }&pagecount=${ map.pagecount }&pagegrpnum=${ map.pagegrpnum }">[새글 쓰기]</a>
        <a href="/PDS/WriteForm?menu_id=${ pdsVo.menu_id }&bnum=${ pdsVo.bnum }&lvl=${ pdsVo.lvl }&step=${ pdsVo.step }&nref=${ pdsVo.nref }&nowpage=${ map.nowpage }&pagecount=${ map.pagecount }&pagegrpnum=${ map.pagegrpnum }">[답글 쓰기]</a>
        <a href="/PDS/UpdateForm?menu_id=${ pdsVo.menu_id }&idx=${ pdsVo.idx }&nowpage=${ map.nowpage }&pagecount=${ map.pagecount }&pagegrpnum=${ map.pagegrpnum }">[수정]</a>
        <a href="/PDS/Delete?menu_id=${ pdsVo.menu_id }&idx=${ pdsVo.idx }&nowpage=${ map.nowpage }&pagecount=${ map.pagecount }&pagegrpnum=${ map.pagegrpnum }">[삭제]</a>
      
      </td>
    </tr>
  
  </table>
  
  
  
</body>
</html>