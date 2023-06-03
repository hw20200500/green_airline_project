package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.kakao.SocialDto;
import com.green.airline.dto.request.JoinFormDto;
import com.green.airline.dto.request.SocialJoinFormDto;
import com.green.airline.dto.response.MemberInfoDto;
import com.green.airline.repository.model.Member;

@Mapper
public interface MemberRepository {

	public MemberInfoDto selectById(String id);

	// 카카오 로그인 api에 쓸 것
	public SocialDto selectBySocialUserInfo(String id);

	// 일반 회원가입 처리
	public int insertMember(JoinFormDto joinFormDto);

	// 소셜 회원가입 처리
	public int insertSocialMember(SocialJoinFormDto socialJoinFormDto);

	// 소셜 회원가입 필수값 처리
	public int insertBySocialDto(@Param("id") String id, @Param("nickname") String nickname,
			@Param("email") String email, @Param("gender") String gender);

	// 아이디 중복 확인
	public Member existsById(String id);

	// 회원 정보 수정
	public int updateMemberById(@Param("id") String id, @Param("member") Member member);
	
	// 소셜 회원가입시 회원 정보 삭제
	public int deleteSocialMemberById(String id);
	
	public Member selectByKorNameandEmailAndBirthDate(Member member);
	
	/**
	 * @author 서영
	 * @return 전체 회원 목록
	 */
	public List<Member> selectMemberListAll();
	
	/**
	 * @author 서영
	 * @return 전체 회원 목록 (페이징용) 20개씩
	 */
	public List<MemberInfoDto> selectMemberListAllLimit(Integer index);
	
	/**
	 * @author 서영
	 * @return 회원 검색
	 */
	public List<MemberInfoDto> selectMemberListSearch(String search);
	
	
}
