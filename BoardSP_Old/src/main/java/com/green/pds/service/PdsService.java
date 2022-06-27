package com.green.pds.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.green.pds.vo.FilesVo;
import com.green.pds.vo.PdsVo;

public interface PdsService {

	List<PdsVo> getPdsList(HashMap<String, Object> map);

	void setWrite(HashMap<String, Object> map, HttpServletRequest request);

	PdsVo getPdsView(HashMap<String, Object> map);

	List<FilesVo> getFileList(HashMap<String, Object> map);

	void setUpdate(HashMap<String, Object> map, HttpServletRequest request);

	void deleteUploadFile(HashMap<String, Object> map);

	void setDelete(HashMap<String, Object> map);

}
