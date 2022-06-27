package com.green.pds.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.green.pds.dao.PdsDao;
import com.green.pds.vo.FilesVo;
import com.green.pds.vo.PdsVo;

@Repository("pdsDao")
public class PdsDaoImpl implements PdsDao {

	@Autowired
	private  SqlSession  sqlSession;
	
	// 페이징용 수정 
	// getPdsList()
	@Override
	public List<PdsVo> getPdsList(HashMap<String, Object> map) {
		
		sqlSession.selectList("PDS.PdsPagingList", map);		
		
		List<PdsVo> pdsList = (List<PdsVo>) map.get("result");
		return   pdsList;
	}
	
	// 기존 getPdsList()
	/*
	@Override
	public List<PdsVo> getPdsList(HashMap<String, Object> map) {
		
		sqlSession.selectList("PDS.PdsList", map);		
		
		List<PdsVo> pdsList = (List<PdsVo>) map.get("result");
		return   pdsList;
	}
	*/

	// setWrite()
	@Override
	public void setWrite(HashMap<String, Object> map) {
	//	System.out.println("실행전 map:" +  map ); // stored procedure 실행하기전의 map 정보		
		sqlSession.insert("PDS.PdsWrite", map);
	//	System.out.println("실행후 map:" + map ); // stored procedure 실행한 후의 map 정보		
		
	}

	// getPdsView()
	@Override
	public PdsVo getPdsView(HashMap<String, Object> map) {
		
		// CURSOR 사용
		sqlSession.selectList("PDS.PdsView", map);
		
		List<PdsVo>   pdsList  =  (List<PdsVo>) map.get("result");
		PdsVo         pdsVo    =   pdsList.get(0);
		 
		return  pdsVo;
	}

	// getFileList()
	@Override
	public List<FilesVo> getFileList(HashMap<String, Object> map) {
		
		sqlSession.selectList("PDS.FileList", map);
		
		List<FilesVo>  filesList    =  (List<FilesVo>) map.get("result");
		
		return         filesList;
	}

	// 수정  setUpdate()
	@Override
	public void setUpdate(HashMap<String, Object> map) {
		
		sqlSession.update("PDS.PdsUpdate", map);
		
	}

	//  deleteUploadFile
	@Override
	public void deleteUploadFile(HashMap<String, Object> map) {
		
		sqlSession.delete("PDS.PdsUpFileDelete", map);
		
	}

	// 자료실 삭제
	@Override
	public void setDelete(HashMap<String, Object> map) {
		
		sqlSession.delete("PDS.PdsDelete", map);
		
	}

}






