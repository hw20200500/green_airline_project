package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.request.LoginFormDto;
import com.green.airline.dto.request.PasswordCheckDto;
import com.green.airline.dto.response.CountByYearAndMonthDto;
import com.green.airline.enums.UserRole;
import com.green.airline.repository.model.User;

@Mapper
public interface UserRepository {

	// 로그인 기능
	public User selectByIdAndPassword(LoginFormDto loginFormDto);

	// 암호화 처리에 사용
	public User selectById(LoginFormDto loginFormDto);
	
	// 아이디 찾기
	public User selectById(String id);
	// user_tb에 넣을 값 (kakao login api에 사용)
	public int insertByUser(@Param("id") String id, @Param("password") String password,
			@Param("userRole") UserRole userRole);

	// 소셜 회원가입에 사용
	public User selectSocialDtoById(String id);

	public int updateUserPwById(@Param("password") String password, @Param("userId") String userId);

	public int updateGradeByMemberId(@Param("memberId") String memberId, @Param("grade") String grade);

	public User selectUserById(String id);

	// id 기반 유저 탈퇴 상태값 변경
	int updateUserByStatus(@Param("id") String id, @Param("status") Integer status);

	// 소셜 회원가입시 회원 정보 삭제
	int deleteSocialUserById(String id);

	// 비밀번호 확인 기능
	int updateUserById(PasswordCheckDto passwordCheckDto);

	/**
	 * @author 서영 해당 월의 신규 회원 수
	 */
	public CountByYearAndMonthDto selectNewUserCountByMonth(@Param("year") Integer year, @Param("month") Integer month);

	/**
	 * @author 서영 해당 월의 탈퇴 회원 수
	 */
	public CountByYearAndMonthDto selectWithdrawUserCountByMonth(@Param("year") Integer year,
			@Param("month") Integer month);

	/**
	 * @author 서영
	 */
	public Integer insert(User user);
	
}
