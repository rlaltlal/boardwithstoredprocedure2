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
</style>

<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
   $(document).ready(function() {
	   $('[type=button]').on('click', function( e ) {
		   var  btn  = e.target;
		   var  href = '';
		   switch( btn.id ) {
		   case 'btnWrite':    // 새글쓰기
			   href  = '/MBoard/WriteForm?menu_id=${menu_id}';
			   href += '&bnum=0';
			   href += '&lvl=0';
			   href += '&step=0';
			   href += '&nref=0';
			   break;	 
		   case 'btnReplyWrite':    // 답글쓰기
			   href  = '/MBoard/WriteForm?menu_id=${menu_id}';
			   href += '&bnum=${ board.bnum }';
			   href += '&lvl=${ board.lvl }';
			   href += '&step=${ board.step }';
			   href += '&nref=${ board.nref }';
			   break;	 
		   case 'btnList':    // 목록
			   href  = '/MBoard/List?menu_id=${menu_id}';
			   break;	 
		   case 'btnUpdate':    // 수정
			   href  = '/MBoard/UpdateForm?menu_id=${menu_id}';
			   href += '&idx=${ board.idx }'; 
			   break;	 
		   case 'btnDelete':    // 삭제
			   href  = '/MBoard/Delete?menu_id=${menu_id}';
			   href += '&idx=${ board.idx }'; 
			   break;	  
		   case 'btnBack':    // 삭제
			   history.go(-1); 
			   break;	  
		   }
		   alert( href );
		   location.href = href;
	   })
   })
</script>

</head>
<body>
   <!-- 메뉴 리스트 -->
   <%@ include file="/WEB-INF/include/menus.jsp" %>
   
   <!-- 게시물 조회 -->
   <table>
     <caption><h2>${ menu_id } 게시물 조회</h2></caption>
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
       <td class="tdcol" colspan="3">${ board.title }</td>
     </tr>
     <tr>
       <td class="td1">내용</td>
       <td class="tdcol" colspan="3" id="cont">${ board.cont }</td>
     </tr>
     <tr>
       <td  colspan="4" >
         <input type="button" value="새글쓰기" id="btnWrite" />
         <input type="button" value="답글쓰기" id="btnReplyWrite" />
         <input type="button" value="글 수정"  id="btnUpdate" />
         <input type="button" value="글 삭제"  id="btnDelete" />
         <input type="button" value="글 목록"  id="btnList" />
         <input type="button" value="이전으로" id="btnBack" />
       </td>
     </tr>
   </table>
</body>
</html>











