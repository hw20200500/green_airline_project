package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.Manager;

@Mapper
public interface ManagerRepository {

	public Manager selectById(String id);

	/**
	 * @author 서영
	 * @return 전체 관리자 목록
	 */
	public List<Manager> selectManagerListAll();
	
	/**
	 * @author 서영
	 * @return 전체 관리자 목록 (페이징용) 20개씩
	 */
	public List<Manager> selectManagerListAllLimit(Integer index);
	
	/**
	 * @author 서영
	 * @return 관리자 검색
	 */
	public List<Manager> selectManagerListSearch(String search);
	
	/**
	 * @author 서영
	 * @return 관리자 등록
	 */
	public Integer insert(Manager manager);
	
	
}
