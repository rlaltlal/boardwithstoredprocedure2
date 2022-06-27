package com.green.pds.service.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.pds.dao.PdsDao;
import com.green.pds.service.PdsService;
import com.green.pds.vo.FilesVo;
import com.green.pds.vo.PdsVo;

@Service("pdsService")
public class PdsServiceImpl implements PdsService {

	@Autowired
	private   PdsDao   pdsDao;
	
	// 페이징을 위해 getPdsList() 수정
	@Override
	public List<PdsVo> getPdsList(HashMap<String, Object> map) {
		// map
		// menu_id, nowpage, pagecount, pagegrpnum, (menuList)
		
		// db 조회 = paging data
		List<PdsVo>  pdsList =  pdsDao.getPdsList( map );
		// pagecount(5) 수 만큼 반환
		
		// 페이징을 위한 내용 추가
		
		// 한페이지에 보여줄 페이지 번호의 갯수
		// 1 2 3 4 5  6 7 8 9 10  : 10개 - pagetotalcount
		int  pagetotalcount =  10;
		
		// 한 페이지에 보여줄 라인수 : 조회된 결과의레코드수
		int  pagecount  =  
			Integer.parseInt( String.valueOf(map.get("pagecount")));   
		
		// 현재 페이지 정보
		int  nowpage     =  
			Integer.parseInt( String.valueOf(map.get("nowpage")));
		
		// pagegrpnum
		int  pagegrpnum  = 
			Integer.parseInt( String.valueOf(map.get("pagegrpnum")));
		
		// 전체 자료수 : 조회된 레코드수 - storeprocedure out 파라미터
		int totalcount   = 
			Integer.parseInt( String.valueOf(map.get("totalcount")));
		
		// paging.jsp 에서 사용할 변수값들을 생성한다
		BoardPaging   bp =  new BoardPaging(
			nowpage, pagecount, totalcount,
			pagetotalcount, pagegrpnum );  
		
		PdsVo       pdsVo    = bp.getPdsPagingInfo();
		
		pdsVo.setMenu_id( (String) map.get("menu_id") ); 
		
		map.put("pagePdsVo", pdsVo);   // map 에 추가
		
		return       pdsList;
		
	}
	
	// 기존 getPdsList()
	/*
	@Override
	public List<PdsVo> getPdsList(HashMap<String, Object> map) {
		
		List<PdsVo>  pdsList =  pdsDao.getPdsList( map );
		return       pdsList;
	}
	*/
	
	// setWrite()
	@Override
	public void setWrite(HashMap<String, Object> map, HttpServletRequest request) {
		
		System.out.println("pdsServiceImpl setWrite() map:" + map);
		
		// db 관련 없는 로직 처리 
		// 1.request 처리 - 넘어온 파일 처리  D:\\upload\\
		// 폴더 생성 D:\\UPLOAD\\ 
		// 파일저장을 휘한 라리브러리 추기
		// commons-io 2.0.1 추가
		// commons-fileupload  1.2.2 추가
		PdsFile.save(map, request);  // map +( filenames, fileexts, sfilenames)
		
		// 2.넘어온 정보(map data) db 저장 - dao 
		pdsDao.setWrite( map );   // Mboard, Files
		
	}

	// getPdsView() 
	@Override
	public PdsVo getPdsView(HashMap<String, Object> map) {
		
		PdsVo   pdsVo   =   pdsDao.getPdsView( map );  
		return  pdsVo;
		
	}

	// getFileList()
	@Override
	public List<FilesVo> getFileList(HashMap<String, Object> map) {
		
		List<FilesVo>  filesList = pdsDao.getFileList( map );
		
		return         filesList;
	}

	// 수정 setUpdate
	@Override
	public void setUpdate(HashMap<String, Object> map,
			HttpServletRequest request) {
		
		// 수정파일처리 : request (file)
		PdsFile.save(map,  request);
		
		// 수정 정보 처리 : map
		pdsDao.setUpdate(map);
		
	}

	// deleteUploadFile
	@Override
	public void deleteUploadFile(HashMap<String, Object> map) {
		
		// 1. d:\\upload\\  의 파일을 찾아서 삭제
		String  sfilename  =  (String) map.get("sfilename");
		String  filePath   =  "d:\\upload\\";
		String  fileName   =  sfilename;
		File    file       =  new File( filePath + fileName  );
		
		if(file.exists())
			file.delete();
		
		// 2. Files 테이블에 file_num 에 해당되는 file 정보 삭제
		pdsDao.deleteUploadFile( map );
	}
	
	// 자료실 삭제
	@Override
	public void setDelete(HashMap<String, Object> map) {
		
		pdsDao.setDelete( map );
		
	}

}





