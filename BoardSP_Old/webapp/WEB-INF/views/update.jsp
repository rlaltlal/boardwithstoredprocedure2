<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/common.css" />
<style>
   .td1 {  width:200px; text-align: center;  }
   .td2 {  width:200px; text-align: left;  }
   .td3 {  width:200px; text-align: center;  }
   .td4 {  width:200px; text-align: left;  }
   
   .tdcol {  width:600px; text-align: left;  }
   #cont  {  height: 300px;  }
   
   [type=text] { width:580px; }
   textarea		 { width:580px; height:300px; }
</style>

<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
   $(document).ready(function() {
	 	$('form').on('submit',function(){
	 		if($('[name=title]').val().trim() == '' ){
	 			var msg = '<br><b class="red">아이디를 입력하세요</b>';
	 	        $('[name=title]').after(msg) 
	 			return false;
	 		}
	 		return true;
	 	})
	 	$('#btnList').on('click',function(){
	 		location.href='/MBoard/List?menu_id=${menu_id}';
	 	});
   })
</script>

</head>
<body>
   <!-- 메뉴 리스트 -->
   <%@ include file="/WEB-INF/include/menus.jsp" %>
   
   <!-- 게시물 수정 -->
   <form action="/MBoard/Update" method="POST">
   <input type="hidden" name="idx"      value="${ board.idx }" />
   <input type="hidden" name="menu_id"  value="${ menu_id }" />
   <table>
     <caption><h2>${ menu_id } 게시물 수정</h2></caption>
     <tr>
       <td class="td1">메뉴 아이디</td>
       <td class="tdcol" colspan="3">${ board.menu_id }</td>
     </tr>
     <tr>
       <td class="td1">번호</td>
       <td class="td2">${ board.idx }</td>
       <td class="td3">날짜</td>
       <td class="td4">${ board.regdate }</td>
     </tr>
     <tr>
       <td class="td1">글쓴이</td>
       <td class="td2">${ board.writer }</td>
       <td class="td3">조회수</td>
       <td class="td4">${ board.readcount }</td>
     </tr>
     <tr>
       <td class="td1">제목</td>
       <td class="tdcol" colspan="3">
        <input type="text" name="title" value="${ board.title }" />
       </td>
     </tr>
     <tr>
       <td class="td1">내용</td>
       <td class="tdcol" colspan="3" id="cont">
         <textarea  name="cont">${ board.cont }</textarea>       
       </td>
     </tr>
     <tr>
       <td  colspan="4" >
         <input type="submit" value="수정"  />
         <input type="button" value="글 목록" id="btnList" />        
       </td>
     </tr>
   </table>
   </form>
</body>
</html>










