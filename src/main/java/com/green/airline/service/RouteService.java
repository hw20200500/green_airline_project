package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.dto.response.DestinationCountDto;
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

		// flightTime을 잘라서 변수에 담아서
		// Route모델에서 시간만 갖고 와서
		// String[] result = flightTime.split("시간");
		Route routeEntity = routeRepository.selectByDestAndDepa(destination, departure);
		// 결과값이 null 아직 예외가 아니야 코드에 결과야 민정씨야!

		// null 나는 예외로 치부해서 spring 제공하는 Advice 동작을 활용해서 흐름을 만들꺼야
		// 객체.메서드, 변수 (예외가 발생( )
		// RestExceptionHandler 고민 --> RunTimeException 활용해보기
		// 원래 자바에서 제공하는 예외 클래스들이 존재하고 있다.
		// 존재하는 예외 클래스를 상속 받아서 재정의 할 수 있다. ABC 이름으로 만들어 버리면
//			throw new ABC()  <-- 민정아 이렇게 던질 수 있어 !!! 
//			throw new RestExceptionHandler();

		String flightTime = routeEntity.getFlightTime();
		String[] result = flightTime.split("시간");

		List<InFlightServiceResponseDto> flightHours = inFlightServiceRepository
				.selectAvailableServiceByFlightHours(result[0]);

		return flightHours;

	}
	
	/**
	 * 이용객 수가 많은 노선 상위 N개 반환
	 */
	public List<DestinationCountDto> readGroupByDestinationLimitN(Integer limitCount) {
		return routeRepository.selectGroupByDestinationLimitN(limitCount);
	}

}
