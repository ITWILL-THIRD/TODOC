package com.todoc.user;

public interface UserService {
	UserVO getUser(UserVO vo);
	void insertUser(UserVO vo);
	int email(String email);
}
