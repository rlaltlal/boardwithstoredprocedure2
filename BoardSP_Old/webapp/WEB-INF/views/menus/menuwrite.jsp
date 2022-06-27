<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <h2>메뉴 추가</h2>
   <div>
      <form action="/Menus/Write"  method="POST">
        <div>
          메뉴이름: <input type="text" name="menu_name" />
        </div>
        <div>
          <input type="submit" value="추가" />
        </div>
      </form>
   </div>
</body>
</html>




