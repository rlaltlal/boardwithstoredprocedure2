package com.green.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor  extends  HandlerInterceptorAdapter {

	// spring-servlet.xml 에서 설정추가해야 한다
	//   <mvc:interceptors>  추가
	    
	// preHandle() : controller  보다 먼저 실행되는 메소드
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler)
			throws Exception {
		
		// session 객체를 가져옴
		HttpSession  session = request.getSession();
		
		// login 처리를 담당하는 사용자 정보를 담고 있는 객체를 가져옴
		
		//--------------------------------------
		// exclude-mapping  대신에 요청된 url을 체크헤서
		// 주소가 "\login' 일때는 컨트롤러 이동하여 로그인하도록 한다
		String  requestUrl = request.getRequestURL().toString();	
		// 하단의 Url 체크를 통해, login 페이지는 예외처리를
	    //   해주어야만 무한 리다이렉션을 벗어날수 있다( 회원가입도 추가필요)  
		if( requestUrl.contains("/login")) {
			return true;
		}
		// ------------------------------
		
		// 모든 요청에서 session("login')로그인을 체크한다
		Object  obj = session.getAttribute("login"); 
		if( obj == null  ) {
			// 로그인 되어잇지 않다면 /login으로 이동하시오
			response.sendRedirect("/login");
			return   false; // 더 이상 컨트롤러 요청으로 가지 않도록 false 를 리턴함
		}		
		
		return super.preHandle(request, response, handler);
		
		// preHandle 의 return은 컨트롤러 요청 uri 로 가도 되냐 안되냐을 허가하는 의미
		// 따라서 true면 컨트롤러 uri 로 가게된다
	}

	// postHandle() : controller 가 실행되고 (view 로이동하기전) 화면이 보여지기 
	//               직전에 수행되는 메소드
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}
	
}
