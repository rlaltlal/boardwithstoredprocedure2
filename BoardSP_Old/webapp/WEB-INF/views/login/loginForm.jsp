<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery3.6.0.min.js"></script>
<script>
   $( function() {
	  $('form').on('submit', function() {
		  if( $('[name=userid]') ).val().trim() == '' ) {
		      $('#msg1').html( '<b class="red">아이디를 입력하세요</b>'  )
		  	  return  false;
	  	  }
		  if( $('[name=userpass]') ).val().trim() == '' ) {
		      $('#msg2').html( '<b class="red">암호를 입력하세요</b>'  )
		  	  return  false;
	  	  }
   	      $('[id^=msg]').empty();
   		  return true;
	  }) 
   })

</script>
</head>
<body>
   <form  action="/loginProcess" method="POST">
     <div>
        아이디:<input type="text"  name="userid"  />
        <span id="msg1"></span>
     </div>
     <div>
        암호:<input type="password"  name="userpass"  />
        <span id="msg2"></span>
     </div>
     <div>
       <input type="submit"  value="로그인"  />
     </div>
   </form>
</body>
</html>