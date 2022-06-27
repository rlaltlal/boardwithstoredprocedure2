package com.green.mboard.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.green.mboard.service.MBoardService;
import com.green.mboard.vo.BoardVo;
import com.green.menu.service.MenuService;
import com.green.menu.vo.MenuVo;

@Controller
public class MBoardController {
	
	@Autowired
	private  MenuService   menuService;
	
	@Autowired
	private  MBoardService  boardService;
	
	@RequestMapping("/")
	public  String  home() {
		return "home";
	}
	
	// /MBoard/List?menu_id=MENU01
	@RequestMapping("/MBoard/List")
	public   ModelAndView   list( String  menu_id  ) {
		System.out.println("1:" + menu_id);
		
		// 메뉴목록 조회 : menus.jsp menuList
		List<MenuVo>  menuList   = menuService.getMenuList();
		
		// 게시물 목록 조회 : list.jsp boardList
		// map : inout 
		// in  : menu_id
		// out : cursor -> boardList
		HashMap<String, Object>  map = new HashMap<String, Object>();
		map.put("menu_id", menu_id);   // 조회할 menu_id
		
		List<BoardVo>  boardList = boardService.getBoardList( map );
		System.out.println("MBoardController(boardList):" + boardList);
				
		ModelAndView  mv = new ModelAndView();
		mv.setViewName("list");  //list.jsp
		mv.addObject("menu_id", menu_id );
		mv.addObject("menuList", menuList);
		mv.addObject("boardList", boardList);
		return        mv;
	}
	
	// /MBoard/WriteForm?menu_id=MENU01&bnum=0&lvl=0&step=0&nref=0
	@RequestMapping("/MBoard/WriteForm")
	public   ModelAndView   writeForm( BoardVo vo ) {
//	public   ModelAndView   writeForm( 
//		 String menu_id, int bnum,int lvl,int step,int nref  ) {
		
		// 메뉴목록 조회
		List<MenuVo> menuList = menuService.getMenuList();
		
		ModelAndView  mv = new ModelAndView();
		mv.addObject("menu_id",  vo.getMenu_id() );
		mv.addObject("menuList", menuList);
		mv.addObject("board", vo);  // menu_id, bnum, lvl, step, nref
		mv.setViewName("write");
		return        mv;
	}
		
	@RequestMapping("/MBoard/Write")
	public   String   write( BoardVo vo) {
		
	    // title, writer, cont, menu_id, bnum, lvl, step, nref
		// 글쓰기
		boardService.insertBoard( vo );
		
		//  게시판으로 이동
		String    menu_id  = vo.getMenu_id(); 
		return    "redirect:/MBoard/List?menu_id=" + menu_id;
	}
	
	@RequestMapping("/MBoard/View")
	public    ModelAndView  view(
		@RequestParam  HashMap<String, Object> map	) {
		// http://localhost:9090/MBoard/View?idx=6&menu_id=MENU01
		// map {  idx:6,  menu_id:MENU01  }
		
		String  menu_id  = (String) map.get("menu_id"); 
		
		List<MenuVo> menuList = menuService.getMenuListSP(map);
		// map {  idx:6,  menu_id:MENU01 , menuList }
		
		BoardVo boardVo = boardService.getView(map);
		// map {  idx:6,  menu_id:MENU01 , menuList, boardVo }
		
		ModelAndView   mv  =  new  ModelAndView();
		mv.addObject("menu_id",  menu_id );  // 현재 메뉴 번호
		mv.addObject("menuList", menuList );  // 메뉴 목록
		mv.addObject("board",    boardVo );      // idx 로 조회한 세시물 
		mv.setViewName("view");    // view.jsp
		return         mv;
	}
	
	// update
	@RequestMapping("/MBoard/UpdateForm")
	public   ModelAndView   updateForm(
		@RequestParam  HashMap<String, Object>  map ) {
		// /MBoard/UpdateForm?menu_id=MENU01&idx=6
		String        menu_id  = (String) map.get("menu_id");  // 현재 메뉴정보
		List<MenuVo>  menuList = menuService.getMenuListSP( map );
		System.out.println("map:" + map);
		// 수정할 자료 검색 - idx 로 검색된
		BoardVo       boardVo  = boardService.getView( map );
		
		ModelAndView  mv = new ModelAndView();
		mv.addObject("menu_id",  menu_id);
		mv.addObject("menuList", menuList);
		mv.addObject("board",    boardVo);
		mv.setViewName("update");   // update.jsp
		return       mv;		
	}
	
	@RequestMapping("/MBoard/Update")
	public  ModelAndView   update(
		@RequestParam  HashMap<String, Object> map	) {
		
		String menu_id = (String) map.get("menu_id");
		
		boardService.updateBoard( map );
				
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/MBoard/List?menu_id=" + menu_id);
		return       mv;
	}
	
	// /MBoard/Delete
	@RequestMapping("/MBoard/Delete")
	public   ModelAndView   delete(
		@RequestParam   HashMap<String, Object> map	) {
		
		String  menu_id = (String) map.get("menu_id");
		
		boardService.deleteBoard( map );
		
		ModelAndView  mv  = new  ModelAndView();
		mv.setViewName("redirect:/MBoard/List?menu_id=" + menu_id);		
		return mv;
	}
}








