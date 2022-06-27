package com.green.pds.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.green.menu.service.MenuService;
import com.green.menu.vo.MenuVo;
import com.green.pds.service.PdsService;
import com.green.pds.vo.FilesVo;
import com.green.pds.vo.PdsVo;

@Controller
public class PdsController {
	
	// IoC : Inversion Of Control - 제어의 역전
	// DI 를 구현 
	@Autowired
	private  MenuService  menuService;
	
	@Autowired
	private  PdsService   pdsService;
	
	// 페이징이가능한 리스트로 수정
	// <a href="/PDS/List?menu_id=MENU01&nowpage=1&pagecount=5&pagegrpnum=1">자료실</a><br>
	@RequestMapping("/PDS/List")
	public   ModelAndView    pdsList(
		@RequestParam  HashMap<String, Object> map	) {
		
		// map
		// menu_id     = MENU01,    
		// nowpage     = 1      -- 현재(뵤여줄) 페이지 정보
		// pagecount   = 5      -- 한 페이지 당 보여줄 LINE 수
		// pagegrpnum  = 1      -- 페이지 그룹 번호
		
		// 메뉴 목록
		List<MenuVo>  menuList    =   menuService.getMenuListSP(map); 
				
		// 자료목록 : pagecount 수만큼 조회된 자료 5개 만 온다, nowpage data 가		
		List<PdsVo>   pdsList     =   pdsService.getPdsList(map);
		
		  // 조회후  map 에 돌아온 결과( + pagePdsVo)를 처리
		PdsVo          pagePdsVo   =  (PdsVo) map.get("pagePdsVo");  
		
		String         menu_id     =  (String) map.get("menu_id");
		
		ModelAndView    mv         =  new ModelAndView();
		mv.addObject("menu_id",    menu_id);
		mv.addObject("menuList",   menuList);
		mv.addObject("pdsList",    pdsList);
		
		mv.addObject("pagePdsVo",  pagePdsVo);  //paging.jsp
		
		mv.setViewName("pds/list");
		return          mv;
		
	}
	
	/*
	@RequestMapping("/PDS/List")
	public   ModelAndView    pdsList(
		@RequestParam  HashMap<String, Object> map	) {
		// "/PDS/List?menu_id=MENU01&nowpage=1&pagecount=5&pagegrpnum=1"
		// {  menu_id=MENU01,
		//    nowpage=1,       // 현재 보여줄 페이지
		//    pagecount=5,     // 한 페이지당 보여룾 LIne 수
		//    pagegrpnum=1 }   //  페이지 그룹 번호
		
		String        menu_id    = (String) map.get("menu_id");
		String        menu_name  = "JAVA";
		
		// 메뉴목록 menus_pds.jsp
		List<MenuVo>  menuList   =  menuService.getMenuListSP( map );
		//System.out.println("pdsList() menuList:" + menuList);
		
		// 자료실 게시물 목록 조회 : MBOARD 
		List<PdsVo>   pdsList    =  pdsService.getPdsList( map );    
					
		PdsVo         pagePdsVo  =  (PdsVo) map.get("pagePdsVo"); 
		
		ModelAndView  mv  = new ModelAndView();
		
		mv.addObject("menu_id",    menu_id);
		mv.addObject("menu_name",  menu_name);
		mv.addObject("menuList",   menuList);
		mv.addObject("pdsList",    pdsList);
		
		mv.addObject("pagePdsVo",  pagePdsVo);  // ?
		
		mv.setViewName("pds/list");
		return   mv;
	}
	*/
	
	@RequestMapping("/PDS/WriteForm")
	public   ModelAndView   writeForm(
		@RequestParam  HashMap<String, Object> map	) {
		
		// map 
		// http://localhost:9090/PDS/WriteForm
		// ?menu_id=MENU01, &bnum=0,  &lvl=0, &step=0, &nref=0
		// &nowpage=1 ,  &pagecount=5,  &pagegrpnum=1 
		
		// 메뉴리스트
		List<MenuVo>  menuList = menuService.getMenuListSP(map);
		
		// 페이지 이동
		ModelAndView   mv  =  new ModelAndView();
		mv.addObject("menuList", menuList);
		mv.addObject("map",      map);		
		mv.setViewName("pds/write");
		return  mv;		
	}
	
	// 파일정보를 받으려면 HttpServletRequest request 추가 필요 - 파일받으려고
	@RequestMapping("/PDS/Write")
	public   ModelAndView   write(
		@RequestParam  HashMap<String, Object>  map,
		HttpServletRequest request) {
		
		// System.out.println("write() map:" + map);  // 뱐수값 만 전달
		// map 
		// ?menu_id=MENU01,
        // 새글 &bnum=0,  &lvl=0, &step=0, &nref=0
		// &nowpage=1 ,  &pagecount=5,  &pagegrpnum=1
		// writer=, title= ,  cont=,   upfile=, upfile1 , ....
		
		// 새글 저장 : MBoard       - 게시글  저장 
		//             Files        - 첨부파일 목록
		//             c:\\upload\\ - 첨부파일 저장
			
		String menu_id   =  (String) map.get("menu_id");
		
		pdsService.setWrite(map, request);
				
		int  nowpage     =  Integer.parseInt((String) map.get("nowpage"));
		int  pagecount   =  Integer.parseInt((String) map.get("pagecount"));
		int  pagegrpnum  =  Integer.parseInt((String) map.get("pagegrpnum"));
		String  loc = "redirect:/PDS/List?menu_id=" + menu_id;
		loc        += "&nowpage="    + nowpage;
		loc        += "&pagecount="  + pagecount;
		loc        += "&pagegrpnum=" + pagegrpnum;
		ModelAndView  mv  = new ModelAndView();
		mv.addObject("map", map);
		mv.setViewName( loc );
		return mv;
		
	}
	
	// /PDS/View - 내용보기
	@RequestMapping("/PDS/View")
	public   ModelAndView    view (
		@RequestParam  HashMap<String, Object>  map) {
		// <a href="/PDS/View
		// ?idx=7&menu_id=MENU01
		// &nowpage=1&pagecount=5&pagegrpnum=1"> 
		
		// 메뉴 목록
		List<MenuVo>   menuList   =  menuService.getMenuListSP(map);
		
		// idx 로 조회된  pdsVo : 게시글 정보
		PdsVo          pdsVp      =  pdsService.getPdsView( map );
		
		// idx 로 조회된  filesVo : 게시글의 첨부파일 정보
		List<FilesVo>  filesList  =  pdsService.getFileList( map );
		
		ModelAndView   mv = new ModelAndView();
		mv.addObject("menuList",     menuList   );  
		mv.addObject("pdsVo",        pdsVp      );   // MBOARD   
		mv.addObject("filesList",    filesList  );   // LISt<FilesVo> 
		mv.addObject("map",          map        );   // LISt<FilesVo> 
		
		mv.setViewName("pds/view"); 
		return mv;		
	}
	
	// ---------------------------------------
	// /download/external/파일명.확장자
	// {sfile}    : .jpg 와 같은 .포함 문자는 무시한다
	// {sfile:.+} : 정규식 문법 . 문자가 한개이상(+) 있을대
	@RequestMapping(value="/download/{type}/{sfile:.+}",
			method = RequestMethod.GET )
	public  void  downloadFile (
		HttpServletResponse  response,
		@PathVariable("type")  String type,
		@PathVariable("sfile") String sfile) 
				throws IOException {
		
		System.out.println("sfile:" +  sfile );
		
		String   INTERNAL_FILE        =   sfile;
		String   EXTERNAL_FILE_PATH   =   "d:\\upload\\" + sfile;
		
		File     file  = null;
		if ( type.equalsIgnoreCase("internal") ) {
			ClassLoader    classLoader = 
				Thread.currentThread().getContextClassLoader();
			file  = new File(classLoader.getResource(INTERNAL_FILE).getFile() );
		} else {
			file  = new File( EXTERNAL_FILE_PATH );			
		}
		
		// String.getBytes()  : 문자열 -> Byte 배열로 변환된다
		// html 에서는 모든 data 를 바이트data(ISO 8859-1 인코딩) 로 처리한다
		if( !file.exists() ) {
			String errorMessage = "죄송합니다.파일이 없습니다";
			System.out.println( errorMessage ); // console 에 출력
			// 브라우저 출력
			OutputStream  outputStream  = response.getOutputStream();
			outputStream.write( errorMessage.getBytes( Charset.forName("UTF-8") ) );
			outputStream.close();
			return;
		}
		
		String  mimeType = URLConnection.guessContentTypeFromName(file.getName());
		mimeType         = "application/octet-stream";  // 무조건 다운로드, 바이러니 data
		
		System.out.println( "file.getname():" + file.getName());
		
		// chrome 에서 한글파일명 깨짐 해결
		String filename = 
			 new String(file.getName().getBytes("UTF-8"), "ISO-8859-1");
		
		response.setContentType(mimeType);
		response.setHeader("Content-Disposition", 
			String.format("inline; filename=\"" + filename + "\"") );
		
		response.setContentLength( (int) file.length());
		
		InputStream  inputStream = new BufferedInputStream(
			 new FileInputStream(file)	);
		
		FileCopyUtils.copy(inputStream, response.getOutputStream());
			
		inputStream.close();
		
	}
	
	// UpdateForm
	// http://localhost:9090/PDS/UpdateForm
	// ?menu_id=MENU01&idx=14&nowpage=1&pagecount=5&pagegrpnum=1
	@RequestMapping("/PDS/UpdateForm")
	public   ModelAndView    updateForm(
		@RequestParam  HashMap<String, Object> map	) {
		
		List<MenuVo>     menuList   =  menuService.getMenuList();
		PdsVo            pdsVo      =  pdsService.getPdsView( map );
		List<FilesVo>    filesList  =  pdsService.getFileList( map ); 
		
		ModelAndView  mv  = new ModelAndView();
		
		mv.addObject("menuList",   menuList);
		mv.addObject("pdsVo",      pdsVo);      // idx로 조회된 수정할 글정보
		mv.addObject("filesList",  filesList);  // idx로 조회된 수정할 첨부파일정보
		mv.addObject("map",        map);
		
		mv.setViewName("pds/update");
		return        mv;
	}
	
	// 수정 "/PDS/Update"
	@RequestMapping("/PDS/Update")
	public  ModelAndView   update(
		@RequestParam HashMap<String, Object>  map,
		HttpServletRequest  request ) {
		
		System.out.println("map1:" + map);
	    pdsService.setUpdate( map, request );  
	    System.out.println("map2:" + map);
	    
	    String   menu_id     = (String) map.get("menu_id");
	    int		 nowpage     = Integer.parseInt( 
	    		(String)map.get("nowpage") );
	    int		 pagecount   = Integer.parseInt( 
	    		(String)map.get("pagecount") );
	    int		 pagegrpnum  = Integer.parseInt( 
	    		(String)map.get("pagegrpnum") );	    
	    
		String   fmt  = "redirect:/PDS/List?menu_id=%s";
		fmt          += "&nowpage=%d&pagecount=%d&pagegrpnum=%d";
		String   loc  = String.format(fmt, 
			menu_id, nowpage, pagecount, pagegrpnum	);
		
		ModelAndView   mv  = new  ModelAndView();		
		mv.setViewName( loc ); 
		return         mv;
	}
	
	
	// 삭제 
	// <a href="/PDS/Delete?menu_id=MENU01
	// &idx=11&nowpage=1&pagecount=5&pagegrpnum=1">[삭제]</a>
	@RequestMapping("/PDS/Delete")
	public   ModelAndView    delete(
		@RequestParam  HashMap<String, Object>  map) {
		
		
		String  menu_id    = (String)  map.get("menu_id");
		int     nowpage    = Integer.parseInt( (String) map.get("nowpage") );
		int     pagecount  = Integer.parseInt( (String) map.get("pagecount") );
		int     pagegrpnum = Integer.parseInt( (String) map.get("pagegrpnum") );
		
		pdsService.setDelete( map );

		System.out.println("map0:" + map);
		
		String fmt         =  "redirect:/PDS/List?menu_id=%s";
		fmt               +=  "&nowpage=%d&pagecount=%d&pagegrpnum=%d";
		String loc         =  String.format(fmt, 
			menu_id, nowpage, pagecount, pagegrpnum	); 
		
		ModelAndView   mv  = new ModelAndView();
		mv.setViewName( loc );
		return    mv;
		
	}
	//로그인---------------------------------------------------------
		@RequestMapping("/loginProcess2")
		public  ModelAndView  loginProcess(
			HttpSession     session,
			@RequestParam   HashMap<String, Object> map) {
			ModelAndView mv=new ModelAndView();
			session.setAttribute("id","sky");
			mv.setViewName("redirect:/PDS/List?menu_id=MENU01&nowpage=1&pagecount=5&pagegrpnum=1");
			return mv;		
		}
		
		
		// 로그아웃
		@RequestMapping("/logoutProcess2") 
		public  String  logout(HttpSession session) {
			session.invalidate();
			return "redirect:/";  // 로그아웃시 이동할 주소 -> /login
		}
}








