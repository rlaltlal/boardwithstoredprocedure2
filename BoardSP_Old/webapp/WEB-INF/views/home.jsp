<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <h2>Welcome Home</h2>
   <a href="/MBoard/List?menu_id=MENU01">게시판</a><br>
   <a href="/MBoard/WriteForm?menu_id=MENU01&bnum=0&lvl=0&step=0&nref=0">새 글 쓰기</a><br>
   
   <br />
   
   <a href="/Menus/List">메뉴 관리</a><br>
   <a href="/Menus/ListSP">메뉴 관리(Stored Procedure)</a><br>
   
   <br />
      
   <a href="/PDS/List?menu_id=MENU01&nowpage=1&pagecount=5&pagegrpnum=1">자료실</a><br>
   
   <a href="/User/List">사용자목록</a><br>
   <a href="/User/WriteForm">사용자추가</a><br>
   
   <hr />
   
   <a href="/login">로그인 테스트</a><br>
   
   ${ sessionScope.login.userid } 님 환영합니다.<br />   
   당신의 포인트는 ${ login.userpoint } 점 입니다.<br />   
   <a href="/logout">로그아웃</a>   
</body>
</html>






