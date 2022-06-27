<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
   ul { 
      border:1px solid black;
      border-radius: 20px;
      width : 400px; float:left;
      margin : 20px; padding:20px;
   } 
</style>
</head>
<body>
  <h2>목록</h2>
  <c:forEach var="user" items="${ userList }">
  <ul>
     <li>아이디 : ${ user.userid }</li>
     <li>암호   : ${ user.userpass }</li>
     <li>이름   : ${ user.username }</li>
     <li>포인트 : ${ user.userpoint }</li>
  </ul>
  </c:forEach>
</body>
</html>






