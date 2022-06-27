package com.green.menu.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.green.menu.service.MenuService;
import com.green.menu.vo.MenuVo;

@Controller
@RequestMapping("/Menus")
public class MenuController {
	
	@Autowired
	private  MenuService  menuService;
		
	// 일반 SELECT  처리 가능, UserVo, List<UserVo> 처리
	@RequestMapping("/List")   // "/Menus/List"
	public   String   menuList( Model model ) {
		
		List<MenuVo> menulist =  menuService.getMenuList(); 
		model.addAttribute("menulist", menulist );
		
		return "menus/menulist";  //  menulist.jsp
	} 
	
	// STORED PROCEDURE 처리 GetList
	@RequestMapping("/ListSP")  // "/Menus/ListSP"
	public   ModelAndView  menuListSP() {
		
		// map 파라미터 역할 : oracle inout 파라미터 역할 수행
		// 1. input - 값을 넣어서 getMenuListSP( map ) 로 잔달
		// 2. output - cursor 값을 돌려받는 역할 
		HashMap<String, Object> map = new HashMap<String, Object>();
		// map.put("menu_id", "MENU01");
		List<MenuVo> menulist = menuService.getMenuListSP( map );
		System.out.println("menuListSP():" + menulist);
		
		ModelAndView  mv =  new ModelAndView();
		mv.setViewName("menus/menulist");     // view
		mv.addObject("menulist", menulist);   // model
		return    mv;
		
	} 
	
	@RequestMapping("/WriteForm")   // "/menus/WriteForm"
	public  String   menuWriteForm() {
		return  "menus/menuwrite";
	}
	
	@RequestMapping("/Write")   // "/menus/Write"
	public  String   menuWrite( MenuVo menuVo  ) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("menu_name", menuVo.getMenu_name() );
		
		menuService.insertMenu( map );
		
		return  "redirect:/Menus/List";
	}

	/*
	@RequestMapping("/MenuDelete/{menu_id}")
	public   String   menuDelete(
			@PathVariable String menu_id ) {
		
		menuService.deleteMenu( menu_id );
		
		return  "redirect:/Menus/List";
	}
	*/
}









