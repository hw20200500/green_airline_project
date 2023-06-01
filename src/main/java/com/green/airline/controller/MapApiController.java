package com.green.airline.controller;

import java.text.DecimalFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.airline.repository.model.Airport;
import com.green.airline.service.MapApiService;
import com.green.airline.utils.NumberUtil;

@Controller
public class MapApiController {

	@Autowired
	private MapApiService mapApiService;

	// 공항 지역, 이름 찾기
	@GetMapping("/continent")
	@ResponseBody
	public List<Airport> continent(String region) {
		
		System.out.println(region);
		List<Airport> list = mapApiService.selectAllName(region);
		System.out.println(list);

		return list;
	}

	// 공항 좌표값 가져오기
	@GetMapping("/airportPosition")
	@ResponseBody
	public Airport airportPosition(String searchName) {

		List<Airport> list = mapApiService.airportSearch(searchName);
		
		return list.get(0);
	}

	@GetMapping("/map")
	public String map() {
		return "/board/mapApi";
	}
	/*
	 * @PostMapping("/map") public void mapApi(Airport airport) {
	 * System.out.println("mapAPI post controller 전"); System.out.println(airport);
	 * mapApiService.mapApiSerch(airport);
	 * System.out.println("mapAPI post controller 후");
	 * 
	 * }
	 */

}
