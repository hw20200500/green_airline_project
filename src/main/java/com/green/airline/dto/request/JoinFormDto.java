package com.green.airline.dto.request;

import java.sql.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class JoinFormDto {

	@Pattern(regexp = "[a-zA-Z1-9]{7,20}", message = "아이디는 영문자, 숫자 포함 7~20자 사이여야 합니다.")
	@NotBlank(message = "아이디를 입력해주세요.")
	@Size(min = 7, max = 20, message = "아이디는 7~20자 사이여야 합니다.")
	private String id;
	@Pattern(regexp = "[a-zA-Z1-9]{7,20}", message="비밀번호는 7~20자리여야 합니다.")
	@NotBlank(message = "비밀번호는 7~20자 사이여야 합니다.")
	@Size(min = 7, max = 20, message = "비밀번호는 7~20자 사이여야 합니다.")
	private String password;
	@Pattern(regexp = "^[가-힣]{2,5}$", message = "한글 이름을 입력해주세요.")
	@NotBlank(message = "한글 이름을 입력해주세요.")
	private String korName;
	@NotBlank(message = "영어 이름을 입력해주세요.")
	private String engName;
	@Past(message = "오늘 날짜 이후는 선택할 수 없습니다.")
	private Date birthDate;
	@NotBlank(message = "성별을 선택해주세요.")
	private String gender;
	@NotBlank(message = "이메일을 입력해주세요.")
	private String email;
	@Pattern(regexp = "^\\d{2,3}-\\d{3,4}-\\d{4}$", message = "010-0000-0000 형식으로 입력해야 합니다.")
	@NotBlank(message = "휴대전화를 입력해주세요.")
	private String phoneNumber;
	private String postcode;
	private String detailAddress;
	@NotBlank(message = "주소를 입력해주세요.")
	private String address;
	@NotBlank(message = "국적을 입력해주세요.")
	private String nationality;
	private String grade;

}
