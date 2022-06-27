package com.green.mboard.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.green.mboard.dao.BoardDao;
import com.green.mboard.vo.BoardVo;

@Repository("boardDao")
public class BoardDaoImpl implements BoardDao {

	@Autowired
	private  SqlSession  sqlSession;
	
	@Override
	public void insertBoard(BoardVo vo) {
		
		sqlSession.insert("MBoard.InsertBoard", vo);

	}

	@Override
	public List<BoardVo> getBoardList(HashMap<String, Object> map) {
		// stored Paocedure 코딩
		sqlSession.selectList("MBoard.BoardList", map);
		
		List<BoardVo>  boardList = (List<BoardVo>) map.get("result");
		
		return         boardList;
	}

	@Override
	public BoardVo getView(HashMap<String, Object> map) {
		// storeprocedure 헌게 조회하는 데 cursor 로 처리
		sqlSession.selectList("MBoard.BoardView", map);
		
		List<BoardVo>  boardList = (List<BoardVo>) map.get("result");
		BoardVo        boardVo   = boardList.get(0); 
				
		return     boardVo;
	}

	@Override
	public void updateBoard(HashMap<String, Object> map) {
		
		sqlSession.update("MBoard.UpdateBoard", map);
		
	}

	@Override
	public void deleteBoard(HashMap<String, Object> map) {
		
		sqlSession.delete("MBoard.DeleteBoard", map );
		
	}

}






