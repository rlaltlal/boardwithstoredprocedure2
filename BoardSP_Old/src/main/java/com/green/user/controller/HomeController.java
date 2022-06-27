package com.green.user.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.green.user.service.UserService;
import com.green.user.vo.UserVo;

@Controller
public class HomeController {
	
	@Autowired
	private  UserService  userService;
	
	//--------------------------------------
	// 로그인
	// 로그인 폼을 띄우는 부분
	@RequestMapping( value="/login", method = RequestMethod.GET )
	public   String     loginForm() {
		return   "login/loginForm";
	} 
	
	//  로그인 처리하는 부분 = 로그인처리 : session 처리, cookie
	@RequestMapping(value="/loginProcess", method=RequestMethod.POST ) 
	public   String  loginProcess(
		HttpSession    session,	
		@RequestParam  HashMap<String, Object> map	) {
		
		String   returnURL = "";
		if( session.getAttribute("login") != null ) {
			// 기존의 login 세션값이 존재한다면
			session.removeAttribute( "login" );			
		}
		
		// 로그인체크
	    UserVo  vo  =  userService.login( map  );
	    if( vo != null  ) {
	    	session.setAttribute( "login", vo );  // 세션 "login" <- vo
	    	returnURL  =  "redirect:/";   // root 로 이동, home.jsp
	    } else {
	    	returnURL  =  "redirect:/login";   // 로그인실패시 로그인폼으로 	    	
	    }
		
		return   returnURL;
	}
	
	// 로그이웃처리
	@RequestMapping("/logout")
	public   String   logout( HttpSession session ) {
		session.invalidate();  // 세션 전체를 날려버림
		return "redirect:/";   
	}
	
	//--------------------------------------
	// user 
	@RequestMapping("/User/List")
	public   ModelAndView   list(
		@RequestParam  HashMap<String, Object> map	) {
		
		List<UserVo> userList  =   userService.getUserList( map ); 
		
		ModelAndView  mv = new ModelAndView();
		mv.addObject("userList", userList);
		mv.setViewName("user/list");
		return  mv;
	}
	
	@RequestMapping("/User/WriteForm")
	public   ModelAndView   writeForm(
		@RequestParam HashMap<String, Object> map ) {
		
		ModelAndView   mv  = new ModelAndView();
		mv.setViewName("user/write");		
		return  mv;
	}
	
	@RequestMapping("/User/Write")
	public   ModelAndView   write(
			@RequestParam HashMap<String, Object> map ) {
		
		userService.insertUser( map );
		
		ModelAndView   mv  = new ModelAndView();
		mv.setViewName("redirect:/User/List");		
		return  mv;
	}
		
}











