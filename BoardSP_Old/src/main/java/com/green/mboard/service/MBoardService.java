package com.green.mboard.service;

import java.util.HashMap;
import java.util.List;

import com.green.mboard.vo.BoardVo;

public interface MBoardService {

	void insertBoard(BoardVo vo);

	List<BoardVo> getBoardList(HashMap<String, Object> map);

	BoardVo getView(HashMap<String, Object> map);

	void updateBoard(HashMap<String, Object> map);

	void deleteBoard(HashMap<String, Object> map);

}
