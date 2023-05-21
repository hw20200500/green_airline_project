package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.repository.interfaces.AirplaneRepository;
import com.green.airline.repository.model.Airplane;

/**
 * @author 서영
 *
 */
@Service
public class AirplaneService {
	
	@Autowired
	private AirplaneRepository airplaneRepository;

	public List<Airplane> readAll() {
		List<Airplane> entityList = airplaneRepository.selectAll();
		return entityList;
	}
	
}
