package com.shop.online.service;

import java.util.List;

import com.shop.online.exception.TransactionNotFound;
import com.shop.online.model.DailyTransaction;
import com.shop.online.model.UserDetail;


public interface TransactionService {
	public DailyTransaction create(DailyTransaction dailyTransaction);
	public DailyTransaction delete(int id) throws TransactionNotFound;
	public List<DailyTransaction> findAll();
	public DailyTransaction findById(int id);
	public List<DailyTransaction> findAllByUser(int id);
	
}
