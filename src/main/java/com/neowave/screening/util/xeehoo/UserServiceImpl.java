package com.neowave.screening.util.xeehoo;

import java.util.Date;

import com.neowave.screening.util.User;

public class UserServiceImpl implements UserService{
	public User getUser(Integer id){
		User u = new User();
		u.setAge(42);
		u.setName("wangzh");
		u.setBirth(new Date());
		
		return u;
	}
}
