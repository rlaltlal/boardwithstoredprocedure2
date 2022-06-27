package com.green.menu.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.menu.dao.MenuDao;
import com.green.menu.service.MenuService;
import com.green.menu.vo.MenuVo;

@Service("menuService")
public class MenuServiceImpl implements MenuService {

	@Autowired
	private  MenuDao  menuDao;
	
	@Override
	public List<MenuVo> getMenuList() {		
		List<MenuVo> menulist = menuDao.getMenuList();		
		return menulist;
	}

	@Override
	public List<MenuVo> getMenuListSP(HashMap<String, Object> map) {		
		List<MenuVo> menulist = menuDao.getMenuListSP( map );
		return menulist;
	}

	@Override
	public void insertMenu(HashMap<String, Object> map) {
		
		menuDao.insertMenu( map );
		
	}

}









