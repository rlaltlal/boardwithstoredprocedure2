<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/common.css" />
<style>
   #board  tr:nth-of-type(2) {  text-align: center;  }
   #board  td:nth-of-type(1) {  width:80px; text-align: center;  }
   #board  td:nth-of-type(2) {  width:380px;  }
   #board  td:nth-of-type(3) {  width:70px;  text-align: center;  }
   #board  td:nth-of-type(4) {  width:100px; text-align: center;  }
   #board  td:nth-of-type(5) {  width:70px;  text-align: center;  }
</style>
</head>
<body>
   <!-- 메뉴 리스트 menuList -->
   <%@ include file="/WEB-INF/include/menus.jsp" %>

   <!--  게시판  -->
   <table  id="board">
     <caption><h2>게시판</h2></caption>
     <tr>
       <td colspan="5" class="right">
         <a href="/MBoard/WriteForm?menu_id=${ menu_id }&bnum=0&lvl=0&step=0&nref=0">새글쓰기</a>
       </td>
     </tr>
     <tr>
       <th>번호</th>
       <th>제목</th>
       <th>글쓴이</th>
       <th>날짜</th>
       <th>조회수</th>
     </tr>
     
    <c:forEach  var="board" items="${ boardList }">
     <tr>
       <td>${ board.idx }</td>
       <td>   
          <a href="/MBoard/View?idx=${ board.idx }&menu_id=${ menu_id }">
          ${ board.title }
          </a>
       </td>
       <td>${ board.writter }</td>
       <td>${ board.regdate }</td>
       <td>${ board.readcount }</td>
     </tr>
    </c:forEach> 
     
   </table>
</body>
</html>













