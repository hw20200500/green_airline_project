package com.green.airline.dto.request;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class SocialJoinFormDto {

		@NotBlank(message = "아이디를 입력해주세요.")
		@NotNull
		@Size(min = 8, max = 20, message = "아이디는 8~20자 사이여야 합니다.")
		private String id;
		private String password;
		@Pattern(regexp = "^[가-힣]{2,5}$", message = "한글 이름을 입력해주세요.")
		@NotBlank(message = "한글 이름을 입력해주세요.")
		@NotNull
		private String korName;
		@NotBlank(message = "영어 이름을 입력해주세요.")
		@NotNull
		private String engName;
		@NotNull
		@NotBlank(message = "생년월일을 입력해주세요.")
		private String birthDate;
		@NotNull
		@NotBlank(message = "성별을 선택해주세요.")
		private String gender;
		@NotNull
		@NotBlank(message = "이메일을 입력해주세요.")
		private String email;
		@NotNull
		@Pattern(regexp = "^\\d{2,3}-\\d{3,4}-\\d{4}$", message = "010-0000-0000 형식으로 입력해야 합니다.")
		@NotBlank(message = "휴대전화를 입력해주세요.")
		private String phoneNumber;
		@NotNull
		private String detailAddress;
		@NotBlank(message = "주소를 입력해주세요.")
		private String address;
		@NotNull
		@NotBlank(message = "국적을 입력해주세요.")
		private String nationality;
		private String grade;


}
