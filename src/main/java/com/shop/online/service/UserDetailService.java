package com.shop.online.service;

import java.util.List;

import com.shop.online.exception.UserDetailExist;
import com.shop.online.exception.UserDetailNotFound;
import com.shop.online.model.UserDetail;


public interface UserDetailService {
	
	public UserDetail create(UserDetail UserDetail) throws UserDetailExist;
	public UserDetail delete(int id) throws UserDetailNotFound;
	public List<UserDetail> findAll();
	public UserDetail update(UserDetail UserDetail) throws UserDetailNotFound;
	public UserDetail findById(int id);
	public List<String> findAllUnicqueFname();
	public List<String> findAllUnicqueLname();
	public List<String> findAllUnicqueLocation();
	public List<String> findAllLikeFname(String fname);
	public boolean isUserExist(UserDetail userdetail);

}
