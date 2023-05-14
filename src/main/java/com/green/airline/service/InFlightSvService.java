package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.repository.interfaces.InFlightServiceRepository;
import com.green.airline.repository.model.InFlightService;

@Service
public class InFlightSvService {

	@Autowired
	private InFlightServiceRepository inFlightServiceRepository;
	
	public List<InFlightService> readInFlightService(){
		List<InFlightService> inFlightServices = inFlightServiceRepository.selectInFlightService();
		
		return inFlightServices;
	}
	
	public List<InFlightService> readInFlightServiceByName(String keyword){
		keyword = "%" + keyword + "%";
		List<InFlightService> inFlightServices = inFlightServiceRepository.selectInFlightServiceByName(keyword);
		return inFlightServices; 
	}
	
}
