package com.green.airline.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.green.airline.dto.response.MenuDto;
import com.green.airline.dto.response.ResponseDto;
import com.green.airline.repository.model.User;
import com.green.airline.service.MenuService;
import com.green.airline.utils.Define;

@RestController
public class MenuApiController {

	@Autowired
	private HttpSession session;
	
	@Autowired
	private MenuService menuService;
	
	/**
	 * 메인 메뉴를 공유하는 서브 메뉴 리스트 반환
	 */
	@GetMapping("/subMenuList/{name}")
	public ResponseDto<List<MenuDto>> subMenuListData(@PathVariable String name) {
		
		User user = (User) session.getAttribute(Define.PRINCIPAL);
		List<MenuDto> data = null;
		
		if (user != null) {
			if ("관리자".equals(user.getUserRole())) {
				data = menuService.readBySubMenuAndType(name, "관리자");
			} else {
				data = menuService.readBySubMenuAndType(name, "회원");
			}
			
		} else {
			data = menuService.readBySubMenuAndType(name, "회원");
		}
		
		
		ResponseDto<List<MenuDto>> response 
			= new ResponseDto<List<MenuDto>>(HttpStatus.OK.value(), 
					Define.CODE_SUCCESS, "서브 메뉴 조회", Define.RESULT_CODE_SUCCESS, data);
		
		return response;
	}
	
}
