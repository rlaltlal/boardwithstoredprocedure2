package com.green.user.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.user.dao.UserDao;
import com.green.user.service.UserService;
import com.green.user.vo.UserVo;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired
	private   UserDao    userDao;
	
	@Override
	public List<UserVo> getUserList(HashMap<String, Object> map) {
		
		List<UserVo>  userList  = userDao.getUserList( map );  
		
		return userList;
	}

	@Override
	public void insertUser(HashMap<String, Object> map) {
		
		userDao.insertUser( map );
		
	}

	@Override
	public UserVo login(HashMap<String, Object> map) {
		
		UserVo   vo   =   userDao.login( map );
		
		return   vo;
	}

}






