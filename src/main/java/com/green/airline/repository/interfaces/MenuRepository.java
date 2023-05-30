package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.response.MenuDto;

/**
 * @author 서영
 *
 */
@Mapper
public interface MenuRepository {

	public MenuDto selectBySubMenuAndType(@Param("subMenu") String subMenu, @Param("type") String type);
	
	public List<MenuDto> selectByMainId(Integer mainId);
	
}
