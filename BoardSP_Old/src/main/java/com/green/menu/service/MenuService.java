package com.green.menu.service;

import java.util.HashMap;
import java.util.List;

import com.green.menu.vo.MenuVo;

public interface MenuService {

	List<MenuVo> getMenuList();

	List<MenuVo> getMenuListSP(HashMap<String, Object> map);

	void insertMenu(HashMap<String, Object> map);

}
