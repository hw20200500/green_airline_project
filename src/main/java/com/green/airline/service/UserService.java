package com.green.airline.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;

import com.green.airline.dto.kakao.SocialDto;
import com.green.airline.dto.request.JoinFormDto;
import com.green.airline.dto.request.LoginFormDto;
import com.green.airline.dto.request.PasswordCheckDto;
import com.green.airline.dto.request.SocialJoinFormDto;
import com.green.airline.dto.response.CountByYearAndMonthDto;
import com.green.airline.dto.response.MemberInfoDto;
import com.green.airline.enums.UserRole;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.handler.exception.UnAuthException;
import com.green.airline.repository.interfaces.MemberGradeRepository;
import com.green.airline.repository.interfaces.MemberRepository;
import com.green.airline.repository.interfaces.MileageRepository;
import com.green.airline.repository.interfaces.UserRepository;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.MemberGrade;
import com.green.airline.repository.model.User;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private MemberRepository memberRepository;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Value("${green.key}")
	private String greenKey;

	@Autowired
	private MileageRepository mileageRepository;
	
	@Autowired
	private MemberGradeRepository memberGradeRepository;

	/**
	 * 로그인
	 */
	@Transactional
	public User readUserByIdAndPassword(LoginFormDto loginFormDto) {
		User userEntity = userRepository.selectById(loginFormDto);
		if (userEntity == null) {
			throw new CustomRestfullException("아이디가 존재하지 않습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		// 암호화 처리
		boolean isPwdMatched = passwordEncoder.matches(loginFormDto.getPassword(), userEntity.getPassword());

		if (isPwdMatched == false) {
			throw new CustomRestfullException("비밀번호가 틀렸습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		// 로그인 할 때 마일리지 조회 해서 등급 결정
		if	(userEntity.getUserRole().equals("관리자") == false) {
			String memberId = userEntity.getId();
			String grade = "";
			Long sumSaveMileage = mileageRepository.selectSumSaveMileageByMemberId(memberId);
			/*
			 * if (sumSaveMileage < 100000 || sumSaveMileage == 0) { grade = "Silver";
			 * userRepository.updateGradeByMemberId(memberId, grade);
			 * }
			 */
			
			if (sumSaveMileage != null) {
				if (sumSaveMileage >= 100000 && sumSaveMileage < 500000) {
					grade = "Gold";
					userRepository.updateGradeByMemberId(memberId, grade);
				} else if (sumSaveMileage >= 500000 && sumSaveMileage < 1000000) {
					grade = "Platinum";
					userRepository.updateGradeByMemberId(memberId, grade);
				} else if (sumSaveMileage >= 1000000) {
					grade = "Diamond";
					userRepository.updateGradeByMemberId(memberId, grade);
				}
			}
		
		}

		return userEntity;
	}

	/**
	 * @author 서영
	 * @return 회원 정보
	 */
	@Transactional
	public MemberInfoDto readMemberById(String id) {
		MemberInfoDto memberEntity = memberRepository.selectById(id);
		return memberEntity;
	}

	// 일반 회원가입 처리
	@Transactional
	public void createMember(JoinFormDto joinFormDto) {

		int result = memberRepository.insertMember(joinFormDto);
		String rawPwd = joinFormDto.getPassword();
		String hashPwd = passwordEncoder.encode(rawPwd);
		joinFormDto.setPassword(hashPwd); // 암호화 처리

		int result2 = userRepository.insertByUser(joinFormDto.getId(), joinFormDto.getPassword(), UserRole.DEFAULT);
		if (result == 1 && result2 == 1) {
			System.out.println("회원가입 성공");
		}
	}

	// 소셜 회원가입 처리
	@Transactional
	public void createSocialMember(SocialJoinFormDto socialJoinFormDto) {

		// update 처리로 바꾸기
		int result = memberRepository.insertSocialMember(socialJoinFormDto);
		// 소셜 회원가입 (email, gender, id 중 하나라도 동의하지 않은 경우)
		int result2 = userRepository.insertByUser(socialJoinFormDto.getId(), greenKey, UserRole.SOCIAL);
		if (result == 1 && result2 == 1) {
			System.out.println("회원가입 성공");
		}
	}

	@Transactional
	public SocialDto readBySocialUserInfo(String id) {
		SocialDto socialMember = memberRepository.selectBySocialUserInfo(id);

		return socialMember;
	}

	// 소셜회원 회원가입 (email, gender, id 모두 동의한 경우, 회원가입 페이지를 거치지 않고 카카오 로그인 동의하기 누르자마자
	// 회원가입이 된 경우)
	@Transactional
	public void createByUser(SocialDto socialDto) {

		if ("male".equals(socialDto.getKakaoAccount().getGender())) {
			socialDto.getKakaoAccount().setGender("M");
		} else {
			socialDto.getKakaoAccount().setGender("F");
		}

		// member_tb에 저장
		int result = memberRepository.insertBySocialDto(socialDto.getId(), socialDto.getProperties().getNickname(),
				socialDto.getKakaoAccount().getEmail(), socialDto.getKakaoAccount().getGender());

		// user_tb에 저장
		int result2 = userRepository.insertByUser(socialDto.getId(), greenKey, UserRole.SOCIAL);
		if (result == 1 && result2 == 1) {
			System.out.println("insert 성공");
		}

	}

	@Transactional
	public User readSocialDtoById(String id) {
		// 본인 데이터 베이스에 조회
		User userEntity = userRepository.selectSocialDtoById(id);
		return userEntity;
	}

	// 회원가입 시 에러메세지 내려주기
	@Transactional
	public Map<String, String> validateHandler(Errors errors) {
		// 회원가입 실패시 message 값들을 모델에 매핑해서 View로 전달
		Map<String, String> validateResult = new HashMap<>();

		for (FieldError error : errors.getFieldErrors()) { // 유효성 검사에 실패한 필드 목록
			String validKeyName = error.getField() + "Valid"; // 유효성 검사에 실패한 필드명
			validateResult.put(validKeyName, error.getDefaultMessage()); // 유효성 검사에 실패한 필드에 정의된 메세지
		}

		return validateResult;
	}

	// 아이디 중복 확인
	@Transactional
	public Member readById(String id) {
		Member memberEntity = memberRepository.existsById(id);
		return memberEntity;
	}

	/**
	 * @author 서영 해당 월의 신규 회원 수
	 */
	public CountByYearAndMonthDto readNewUserCount(Integer year, Integer month) {
		return userRepository.selectNewUserCountByMonth(year, month);
	}

	/**
	 * @author 서영 해당 월의 탈퇴 회원 수
	 */
	public CountByYearAndMonthDto readWithdrawUserCount(Integer year, Integer month) {
		return userRepository.selectWithdrawUserCountByMonth(year, month);
	}

	/**
	 * 정다운 아이디 찾기
	 * 
	 * @return
	 */
	public Member readByKorNameandEmailAndBirthDate(Member member) {
		Member memberEntity = memberRepository.selectByKorNameandEmailAndBirthDate(member);
		return memberEntity;
	}

	// 머지할때 변경으로 수정 해야함
	public User readByid(String id) {
		User user = userRepository.selectById(id);
		return user;
	}

	public int updateyPassword(String password, String userId) {
		String isPwdMatched = passwordEncoder.encode(password);
		int result = userRepository.updateUserPwById(isPwdMatched, userId);
		return result;
	}

	public User readUserById(String id) {
		User userEntity = userRepository.selectUserById(id);

		return userEntity;
	}

	// 회원 정보 수정 기능
	public void updateMemberById(String id, Member member) {
		int resultCnt = memberRepository.updateMemberById(id, member);
		if (resultCnt == 1) {
			System.out.println("수정 성공");
		}
	}

	// id 기반 user 상태값 변경
	public Boolean updateUserByStatus(String id, Integer status) {
		int resultCnt = userRepository.updateUserByStatus(id, status);
		if (resultCnt == 1) {
			return true;
		} else {
			return false;
		}
	}

	// 소셜 회원가입 시 회원 정보 삭제
	public void deleteUserAndMemberById(SocialDto socialDto) {
		int resultCnt = userRepository.deleteSocialUserById(socialDto.getId());
		int resultCnt2 = memberRepository.deleteSocialMemberById(socialDto.getId());

		if (resultCnt == 1 && resultCnt2 == 1) {
			System.out.println("삭제 성공");
		}

	}

	// 비밀번호 변경 기능
	public void updateUserById(PasswordCheckDto passwordCheckDto) {
		int resultCnt = userRepository.updateUserById(passwordCheckDto);
		if (resultCnt == 1) {
			System.out.println("수정 성공");
		}
	}

	/**
	 * @author 서영
	 * @return 모든 회원 목록 (가입상태-탈퇴상태 순)
	 */
	public List<Member> readMemberListAll() {
		return memberRepository.selectMemberListAll();
	}
	
	// 페이징용
	public List<MemberInfoDto> readMemberListAllLimit(Integer index) {
		return memberRepository.selectMemberListAllLimit(index);
	}

	/**
	 * @author 서영
	 * @return 회원 검색
	 */
	public List<MemberInfoDto> readMemberListSearch(String search) {
		return memberRepository.selectMemberListSearch(search);
	}
	
	/**
	 * @author 서영
	 * User 모델을 이용한 User 등록
	 */
	@Transactional
	public void createUser(User user) {
		String rawPwd = user.getPassword();
		String hashPwd = passwordEncoder.encode(rawPwd);
		user.setPassword(hashPwd); // 암호화 처리
		userRepository.insert(user);
	}

	/**
	 * @author 서영
	 * @return 회원 등급 리스트
	 */
	public List<MemberGrade> readMemberGradeList() {
		return memberGradeRepository.selectAll();
	}
	

}
