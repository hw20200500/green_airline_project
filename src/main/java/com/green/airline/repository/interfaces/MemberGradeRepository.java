package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.MemberGrade;

/**
 * @author 서영
 *
 */
@Mapper
public interface MemberGradeRepository {

	public List<MemberGrade> selectAll();
	
}
