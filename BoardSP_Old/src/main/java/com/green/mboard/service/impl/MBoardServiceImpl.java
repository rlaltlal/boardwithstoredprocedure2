package com.green.mboard.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.mboard.dao.BoardDao;
import com.green.mboard.service.MBoardService;
import com.green.mboard.vo.BoardVo;

@Service("boardService")
public class MBoardServiceImpl  implements MBoardService {

	@Autowired
	private  BoardDao  boardDao;
	
	@Override
	public void insertBoard(BoardVo vo) {
		
		boardDao.insertBoard( vo );
		
	}

	@Override
	public List<BoardVo> getBoardList(HashMap<String, Object> map) {
		
		List<BoardVo> boardList =  boardDao.getBoardList( map );
		
		// 답글 공백처리 " " -> "&nbsp;"
		// 날짜 가공 (2021-12-23 12:00:00)
		for (int i = 0; i < boardList.size(); i++) {
			BoardVo boardVo = boardList.get(i);
			
			String  title   = boardVo.getTitle().replace(" ", "&nbsp;");
			boardList.get(i).setTitle(title);
			
			String  regdate = boardVo.getRegdate().substring(0, 10);
			boardList.get(i).setRegdate(regdate);		;
		}
		
		
		return    boardList;
	}

	@Override
	public BoardVo getView(HashMap<String, Object> map) {
		
		BoardVo  boardVo  =  boardDao.getView( map );  
		
		return   boardVo;
	}

	@Override
	public void updateBoard(HashMap<String, Object> map) {
		
		boardDao.updateBoard( map );
		
	}

	@Override
	public void deleteBoard(HashMap<String, Object> map) {
		
		boardDao.deleteBoard( map );
		
	}
	
}





