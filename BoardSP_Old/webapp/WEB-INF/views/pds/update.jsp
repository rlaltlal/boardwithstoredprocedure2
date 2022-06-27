<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/common.css" />
<style>
   .tdcont  { height: 300px; vertical-align: top;    }
   .tdfile  { height: 100px; vertical-align: top;    }
   
   #pdsUpdate  input[type=text]  { width:600px;  }
   #pdsUpdate  textarea          { width:600px; height: 300px;  }
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  // 입력항목 체크
  $( function() {
	 // btnAdd Click
	 var num  =  0;
	 $('#btnAddFile').on('click', function() {
		 //alert('Click')
		 var html   = '<input type="file" ';
		 html      += ' name = "upload' + num + '" ';  // ' name="upload1" ' 
		 html      += ' id   = "upload' + num + '" ';  // ' id  ="upload1" ' 
		 html      += ' /><br>';    
		 $('#tdfile').append( html );
		 num++;
	 });
	 
     // delete file click - ajax
     $('#deleteFile').on('click', function( e ) {
    	// e.preventDefault();   //js
    	// e.stopProgation();    //js
    	// alert('click');
    	var aDelete  =  e.target;  // 클릭한 a tag
    	var href     =  aDelete.href ; // /deleteFile?file_num=13
    	$.ajax( {
    		url : href,
    		success : function( json ) {
    			var name = $(aDelete).next().html(); // .next() : 다음 element
    			alert( name + '삭제완료');
    			// 부모 element(div) 를 삭제
    			$(aDelete).parent().remove();
    		}
    	} )
    	return false;    // jquery (e.preventDefault() + e.stopProgation() ) 
     })
     
     // submit 처리
     $('form').eq(0).on('submit', function() {
    	 // 제목
    	 if( $('#writer').value() == '' ) {
    		 alert('제목을 입력하세요');
    		 $('#writer').focus();
    		 return false;
    	 }
    	 // 내용
    	 if( $('#cont').value() == '' ) {
    		 alert('제목을 입력하세요');
    		 $('#cont').focus();
    		 return false;
    	 }
    	 return true;
     })
	  
  } );
</script>

</head>
<body>
  
  <!--  메뉴목록 -->
  <%@include file="/WEB-INF/include/menus_pds.jsp" %>
  
  <form  action="/PDS/Update"  method="POST"
       enctype="multipart/form-data" >  
  <input type="hidden"  name="idx"         value="${ pdsVo.idx    }" />     
  <input type="hidden"  name="menu_id"     value="${ map.menu_id    }" />     
  <input type="hidden"  name="nowpage"     value="${ map.nowpage    }" />     
  <input type="hidden"  name="pagecount"   value="${ map.pagecount  }" />     
  <input type="hidden"  name="pagegrpnum"  value="${ map.pagegrpnum }" />     
  
  <table  id="pdsUpdate">
    <caption><h2>수정하기</h2></caption>
    <tr>
      <td>작성자</td>
      <td>${ pdsVo.writer }</td>
      <td>작성일</td>
      <td>${ pdsVo.regdate }</td>
    </tr>
    <tr>
      <td>글번호</td>
      <td>${ pdsVo.idx }</td>
      <td>조회수</td>
      <td>${ pdsVo.readcount }</td>
    </tr>
    <tr>
      <td>글제목</td>
      <td colspan="3">
      <input type="text" name="title" id="title"
        value="${ pdsVo.title }" />
      </td>
    </tr>
  
    <tr>
      <td>글내용</td>
      <td colspan="3" class="tdfile">
       <textarea name="cont" id="cont">${ pdsVo.cont }</textarea>
      </td>
    </tr>
    
    <tr>
      <td>파일</td>
      <td colspan="3" class="tdfile" id="tdfile">
       <!-- 기존파일정보 -->
       <c:forEach var="file"  items="${ filesList }">
        <div>
        <a href="/deleteFile?file_num=${file.file_num}&sfilename=${file.sfilename}" id="deleteFile">x</a>&nbsp;&nbsp;
        <a href="/download/external/${ file.sfilename }">
         ${ file.filename }
        </a>
        </div>
       </c:forEach>
       
       <!-- 추가될 파일 정보 -->
       <input type="button" value="Add file" id="btnAddFile" /> <br />
       <input type="file" name="upfile" id="upfile" /><br />
      </td>
    </tr>
    
    <tr>
      <td  colspan="4">
        <input type="submit" value="수정" />
      
      </td>
    </tr>
  
  </table>
  
  </form>
  
</body>
</html>





