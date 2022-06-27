<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <h2>사용자 추가</h2>
   <form action="/User/Write"  method="POST">
     <div>
       아이디<input type="text" name="userid" />
     </div> 
     <div>
       암호<input type="password" name="userpass" />
     </div> 
     <div>
       이름<input type="text" name="username" />
     </div>
     <div>
       <input type="submit" value="가입" />
     </div> 
   
   </form>
   
</body>
</html>