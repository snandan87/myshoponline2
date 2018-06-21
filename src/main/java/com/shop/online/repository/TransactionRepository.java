package com.shop.online.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.shop.online.model.DailyTransaction;
import com.shop.online.model.UserDetail;

public interface TransactionRepository extends JpaRepository<DailyTransaction, Integer> {

	//@Query("select c from Cult c join c.part p join p.sau s join s.farm f where f.idFarm = ?1")
	@Query("SELECT d FROM DailyTransaction d where d.userDetail = ?1")
	public List<DailyTransaction> findAllTransactionOfUser(UserDetail userDetail);
	}
