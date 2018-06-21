package com.shop.online.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.online.exception.TransactionNotFound;
import com.shop.online.exception.UserDetailExist;
import com.shop.online.exception.UserDetailNotFound;
import com.shop.online.model.DailyTransaction;
import com.shop.online.model.UserDetail;
import com.shop.online.repository.TransactionRepository;
import com.shop.online.repository.UserDetailRepository;
@Service
public class TransactionServiceImpl implements TransactionService {

	
	@Resource
	private TransactionRepository transactionRepository;
	@Resource
	private UserDetailRepository userDetailRepository;
	
	
	
	
	@Override
	@Transactional
	public DailyTransaction create(DailyTransaction dailyTransaction) {
		DailyTransaction createdTransaction;
		createdTransaction=transactionRepository.save(dailyTransaction);
		return createdTransaction;
	}

	@Override
	@Transactional
	public List<DailyTransaction> findAll() {
	return transactionRepository.findAll();
	}

	@Override
	@Transactional
	public DailyTransaction findById(int id) {
		return transactionRepository.findOne(id);
	}

	@Override
	@Transactional(rollbackFor=TransactionNotFound.class)
	public DailyTransaction delete(int id) throws TransactionNotFound {
		DailyTransaction deleted=transactionRepository.findOne(id);
		if(deleted!=null){
		transactionRepository.delete(deleted);
		return deleted;
		}else{
			throw new TransactionNotFound();
		}
			
	}

	@Override
	@Transactional
	public List<DailyTransaction> findAllByUser(int id) {
		UserDetail user=userDetailRepository.findOne(id);
		return transactionRepository.findAllTransactionOfUser(user);
	}

}
