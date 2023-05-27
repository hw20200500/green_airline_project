package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.repository.interfaces.AirportRepository;
import com.green.airline.repository.model.Airport;

@Service
public class AirportService {

	@Autowired
	private AirportRepository airportRepository;
	
	// 모든 공항 리스트
	public List<Airport> readAll() {
		List<Airport> airportEntityList = airportRepository.selectAll();
		return airportEntityList;
	}
	
	// 자동 완성에 사용할 검색된 공항 리스트
	public List<Airport> readByLikeName(String searchName) {
		List<Airport> airportEntityList = airportRepository.selectByLikeName(searchName);
		return airportEntityList;
	}
	
	// 모든 지역 리스트
	public List<Airport> readRegion() {
		List<Airport> airportEntityList = airportRepository.selectRegion();
		return airportEntityList;
	}
	
	// 지역에 해당하는 공항 리스트
	public List<Airport> readByRegion(String region) {
		List<Airport> airportEntityList = airportRepository.selectByRegion(region);
		return airportEntityList;
	}

}
