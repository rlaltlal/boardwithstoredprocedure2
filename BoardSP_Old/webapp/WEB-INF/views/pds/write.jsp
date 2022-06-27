<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link  rel="stylesheet"  href="/css/common.css" />
<style>
  input[type=text] { width:550px; }
  textarea         { width:550px; height: 300px; }
</style>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $( function() {
	  var num = 1;
	  $('#btnAddFile').on("click", function() {
		 var  html   =  '<input type="file" ';
		 html       +=  ' name= "upfile' + num + '" ';
		 html       +=  ' id  = "upfile' + num + '" /><br>';
		 $('#tdfile').append(html);
		 num++;
	  });
  } );
</script>
</head>
<body>
  <!-- 메뉴 목록 -->
  <%@include file="/WEB-INF/include/menus_pds.jsp" %>
  
  <!-- 새글쓰기(자료실) -->
  <form  action="/PDS/Write"  method="POST" id="form1"
      enctype="multipart/form-data"  >
   <input type="hidden"  name="menu_id"  value="${ map.menu_id }" /> 
   <input type="hidden"  name="bnum"     value="${ map.bnum  }" /> 
   <input type="hidden"  name="lvl"      value="${ map.lvl  }" /> 
   <input type="hidden"  name="step"     value="${ map.step  }" /> 
   <input type="hidden"  name="nref"     value="${ map.nref  }" />
    
   <input type="hidden"  name="nowpage"     value="${ map.nowpage  }" /> 
   <input type="hidden"  name="pagecount"   value="${ map.pagecount  }" /> 
   <input type="hidden"  name="pagegrpnum"  value="${ map.pagegrpnum  }" /> 
  
  <table id="writeTable">
    <caption><h2>새 글쓰기</h2></caption>
    <tr>
      <td>작성자</td>
      <td><input type="text" name="writer" id="writer"
          value="${ sessionScope.id }" /></td>
    </tr>
    <tr>
      <td>글제목</td>
      <td><input type="text" name="title" id="title" /></td>
    </tr>
    <tr>
      <td>글내용</td>
      <td><textarea name="cont" id="cont"></textarea></td>
    </tr>
    <tr>
      <td>파일</td>
      <td id="tdfile">
        <input type="button" id="btnAddFile" value="Add File" /><br>
        <input type="file" name="upfile" id="upfile" /><br>
      </td>
    </tr>
    <tr>
      <td colspan="2">
        <input type="submit" value="쓰기" />
      </td>
    </tr>
  </table>
  
  </form>
</body>
</html>









