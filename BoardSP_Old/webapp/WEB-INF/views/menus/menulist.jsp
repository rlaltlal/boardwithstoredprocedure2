<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
  <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h2>메뉴 리스트</h2>
  
  <c:forEach var="menu" items="${ menulist }">
    <div>
      ${ menu.menu_id } - ${ menu.menu_name } - ${ menu.menu_seq }
      <a href="/Menus/MenuDelete/${ menu.menu_id }" >삭제</a> 
      <a href="/Menus/MenuUpdate/${ menu.menu_id }" >수정</a>       
    </div>
  </c:forEach>
  
  <div>
  <br>
    <a href="/Menus/WriteForm">메뉴 추가</a>
  </div>
</body>
</html>








