package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.repository.interfaces.ManagerRepository;
import com.green.airline.repository.model.Manager;

/**
 * @author 서영
 *
 */
@Service
public class ManagerService {

	@Autowired
	private ManagerRepository managerRepository;
	
	public Manager readById(String id) {
		return managerRepository.selectById(id); 
	}
	
	/**
	 * @return 전체 관리자 목록
	 */
	public List<Manager> readManagerListAll() {
		return managerRepository.selectManagerListAll();
	}
	
	/**
	 * @return 전체 관리자 목록 (페이징용)
	 */
	public List<Manager> readManagerListAllLimit(Integer index) {
		return managerRepository.selectManagerListAllLimit(index);
	}
	
	/**
	 * @return 관리자 검색
	 */
	public List<Manager> readManagerListSearch(String search) {
		return managerRepository.selectManagerListSearch(search);
	}
	
	/**
	 * 관리자 등록
	 */
	@Transactional
	public void createManager(Manager manager) {
		managerRepository.insert(manager);
	}
}
