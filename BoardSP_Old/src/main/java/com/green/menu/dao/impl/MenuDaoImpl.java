package com.green.menu.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.green.menu.dao.MenuDao;
import com.green.menu.vo.MenuVo;

@Repository("menuDao")
public class MenuDaoImpl implements MenuDao {

	@Autowired
	private SqlSession sqlSession;   // mybatis 사용
	
	@Override
	public List<MenuVo> getMenuList() {		
		List<MenuVo> menulist = sqlSession.selectList("Menus.MenuList");
		return  menulist;
	}

	@Override
	public List<MenuVo> getMenuListSP(HashMap<String, Object> map) {
		
		// map 은 inout 역할 : cursor 값을 map 으로 돌려받는 호출
		sqlSession.selectList("Menus.MenuListSP", map);
		
		List<MenuVo>  menulist = (List<MenuVo>) map.get("result");
	//	System.out.println("menuDao:" + menulist);
		
		return  menulist;
		
	}

	@Override
	public void insertMenu(HashMap<String, Object> map) {
		
		//sqlSession.insert("Menus.MenuInsert", map);
		sqlSession.insert("Menus.MenuWrite2", map);
		
	}

}







