package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.dto.response.InFlightServiceResponseDto;
import com.green.airline.repository.interfaces.InFlightServiceRepository;
import com.green.airline.repository.interfaces.RouteRepository;
import com.green.airline.repository.model.Route;

@Service
public class RouteService {

	@Autowired
	private RouteRepository routeRepository;

	@Autowired
	private InFlightServiceRepository inFlightServiceRepository;

	@Transactional
	public List<InFlightServiceResponseDto> readByDestAndDepa(String destination, String departure) {
		Route routeEntity = routeRepository.selectByDestAndDepa(destination, departure);
		// flightTime을 잘라서 변수에 담아서
		// Route모델에서 시간만 갖고 와서
		// String[] result = flightTime.split("시간");
		String flightTime = routeEntity.getFlightTime();
		String[] result = flightTime.split("시간");
		
		List<InFlightServiceResponseDto> flightHours = inFlightServiceRepository.selectAvailableServiceByFlightHours(result[0]);

		return flightHours;
	}

}
