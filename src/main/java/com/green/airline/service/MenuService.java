package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.response.MenuDto;
import com.green.airline.repository.interfaces.MenuRepository;

@Service
public class MenuService {

	@Autowired
	private MenuRepository menuRepository;
	
	/**
	 * 서브 메뉴 + 타입을 받으면 해당 서브 메뉴와 같은 메인 메뉴를 공유하는 서브 메뉴들 반환
	 */
	public List<MenuDto> readBySubMenuAndType(String subMenu, String type) {
		
		MenuDto menuDto = menuRepository.selectBySubMenuAndType(subMenu, type);
		Integer mainId = menuDto.getMainId();
		
		return menuRepository.selectByMainId(mainId);
	}
	
}
