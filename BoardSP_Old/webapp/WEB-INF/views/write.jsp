<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/common.css" />
<style>
  #board .td1 { width:180px; text-align: center; }
  #board .td2 { width:620px; text-align: left; }

  #board [type=text] { width:580px;  }
  #board textarea    { width:580px; height: 300px; }

</style>
</head>
<body>
  
   <!-- 메뉴 리스트 -->
   <%@ include file="/WEB-INF/include/menus.jsp" %>
  
  <form action="/MBoard/Write" method="POST">
  <input type="hidden"  name="menu_id" value="${ menu_id  }" />
  <input type="hidden"  name="bnum"    value="${ board.bnum     }" />
  <input type="hidden"  name="lvl"     value="${ board.lvl      }" />
  <input type="hidden"  name="step"    value="${ board.step     }" />
  <input type="hidden"  name="nref"    value="${ board.nref     }" />
    <table id="board">
      <caption><h2>게시물 등록</h2></caption>
      <tr>
        <td class="td1">제목</td>
        <td class="td2"><input type="text" name="title" /></td>
      </tr>
      <tr>
        <td class="td1">글쓴이</td>
        <td class="td2"><input type="text" name="writer" /></td>
      </tr>
      <tr>
        <td class="td1">내용</td>
        <td class="td2"><textarea name="cont"></textarea></td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="submit" value="저장" />
        </td>
      </tr>
    </table>
  </form>
  
</body>
</html>











