package com.shop.online.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.shop.online.model.UserDetail;


public interface UserDetailRepository extends JpaRepository<UserDetail, Integer> {

	//@Query("select c from Cult c join c.part p join p.sau s join s.farm f where f.idFarm = ?1")
	@Query("SELECT distinct u.fName FROM UserDetail u")
	public List<String> findAllUnicqueFname();
	
	@Query("SELECT distinct u.lName FROM UserDetail u")
	public List<String> findAllUnicqueLname();
	
	@Query("SELECT distinct u.location FROM UserDetail u")
	public List<String> findAllUnicqueLocation();
	
	@Query("SELECT u FROM UserDetail u Where u.fName like %?1")
	public List<UserDetail> findByLikeFname(String fName);
	
	@Query("SELECT u FROM UserDetail u Where u.fName = ?1 and u.lName = ?2 and u.location = ?3")
	public List<UserDetail> findUncqueByFnameLnameLocation(String fName,String lName,String location);
}
