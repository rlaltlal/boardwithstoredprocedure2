package com.green.user.service;

import java.util.HashMap;
import java.util.List;

import com.green.user.vo.UserVo;

public interface UserService {

	List<UserVo> getUserList(HashMap<String, Object> map);

	void insertUser(HashMap<String, Object> map);

	UserVo login(HashMap<String, Object> map);
	
}
