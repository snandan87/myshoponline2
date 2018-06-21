package com.shop.online.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.dao.IncorrectUpdateSemanticsDataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.online.exception.UserDetailExist;
import com.shop.online.exception.UserDetailNotFound;
import com.shop.online.model.UserDetail;
import com.shop.online.repository.UserDetailRepository;


@Service
public class UserDetailServiceImpl implements UserDetailService {
	
	@Resource
	private UserDetailRepository userDetailRepository;

	@Override
	@Transactional
	public UserDetail create(UserDetail UserDetail) throws UserDetailExist {
		UserDetail createdUserDetail;
		if(isUserExist(UserDetail))
			throw new UserDetailExist();
		else
			createdUserDetail = userDetailRepository.save(UserDetail);
			
		return createdUserDetail;
	}
	
	@Override
	@Transactional
	public UserDetail findById(int id) {
		return userDetailRepository.findOne(id);
	}

	@Override
	@Transactional(rollbackFor=UserDetailNotFound.class)
	public UserDetail delete(int id) throws UserDetailNotFound {
		UserDetail deletedUserDetail = userDetailRepository.findOne(id);
		
		if (deletedUserDetail == null)
			throw new UserDetailNotFound();
		
		userDetailRepository.delete(deletedUserDetail);
		return deletedUserDetail;
	}

	@Override
	@Transactional
	public List<UserDetail> findAll() {
		return userDetailRepository.findAll();
	}
	

	@Override
	@Transactional
	public List<String> findAllUnicqueFname(){
		return userDetailRepository.findAllUnicqueFname();
	}

	@Override
	@Transactional(rollbackFor=UserDetailNotFound.class)
	public UserDetail update(UserDetail UserDetail) throws UserDetailNotFound {
		UserDetail updatedUserDetail = userDetailRepository.findOne(UserDetail.getId());
		
		if (updatedUserDetail == null)
			throw new UserDetailNotFound();
		
		updatedUserDetail.setLName(UserDetail.getLName());
		updatedUserDetail.setFName(UserDetail.getFName());
		updatedUserDetail.setLocation(UserDetail.getLocation());
		updatedUserDetail.setPhone(UserDetail.getPhone());
		return updatedUserDetail;
	}

	@Override
	public boolean isUserExist(UserDetail UserDetail) {
		if(userDetailRepository.findUncqueByFnameLnameLocation(UserDetail.getFName(), UserDetail.getLName(), UserDetail.getLocation()).isEmpty()){
			System.out.println("No Existing record found");
		return false;
		}else{
			System.out.println(" Existing record found");
		return true;
		}
	}

	@Override
	public List<String> findAllLikeFname(String fname) {
		List<String> fnameList=new ArrayList<String>();
		 for(UserDetail user:userDetailRepository.findByLikeFname(fname)){
			 fnameList.add(user.getFName());
		 }
		 return fnameList;
	}

	@Override
	public List<String> findAllUnicqueLname() {
		return userDetailRepository.findAllUnicqueLname();
	}

	@Override
	public List<String> findAllUnicqueLocation() {
		return userDetailRepository.findAllUnicqueLocation();
	}

}
