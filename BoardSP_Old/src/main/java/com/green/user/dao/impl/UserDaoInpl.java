package com.green.user.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.green.user.dao.UserDao;
import com.green.user.vo.UserVo;

@Repository("userDao")
public class UserDaoInpl  implements  UserDao {

	@Autowired
	private  SqlSession  sqlSession;
	
	@Override
	public List<UserVo> getUserList(HashMap<String, Object> map) {
		
		List<UserVo> userList = sqlSession.selectList("User.UserList", map);
		
		return       userList;
	}

	@Override
	public void insertUser(HashMap<String, Object> map) {
		
		//System.out.println("user map" + map);
		// user map{userid=wind, userpass=1234, username=바람}
		String    userid    = (String) map.get("userid");
		String    userpass  = (String) map.get("userpass");
		String    username  = (String) map.get("username");
		UserVo    vo        =  new UserVo(userid, userpass, username, 1000);
	    sqlSession.insert("User.InsertUser", vo );
		
	}

	@Override
	public UserVo login(HashMap<String, Object> map) {
		
		UserVo   vo   =  sqlSession.selectOne( "User.Login", map );   
		
		return   vo;
	}

}





