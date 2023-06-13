package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.Memo;

/**
 * @author 서영
 */
@Mapper
public interface MemoRepository {

	public Integer insert(Memo memo);
	
	public Memo selectByManagerId(String managerId);
	
	public Integer update(Memo memo);
	
}
