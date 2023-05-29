package com.green.airline.utils;

import org.springframework.http.HttpStatus;

import com.green.airline.handler.exception.CustomRestfullException;

public class PhoneNumberUtil {

	/**
	 * @author 서영
	 * @param phoneNumber
	 * 전화번호 형식 확인 후 xxx-xxxx-xxxx 형식으로 반환
	 */
	public static String checkPhoneNumber(String phoneNumber) {
		String result = phoneNumber;
		// 01011112222 형식으로 입력했다면 010-1111-2222 형식으로 반환
		if (result.length() == 11) {
			String num1 = phoneNumber.substring(0, 3);
			String num2 = phoneNumber.substring(3, 7);
			String num3 = phoneNumber.substring(7, 11);
			result = num1 + "-" + num2 + "-" + num3;
		}
		
		// 전화번호 형식에 맞지 않다면 실행 X (result == 3)
		// '-'가 인덱스 3번, 8번에 나와야 하고, 총 길이가 13이어야 함
		if (result.indexOf("-") != 3 
			|| result.lastIndexOf("-") != 8
			|| result.length() != 13 
			|| result.replaceAll("-", "").length() != 11) {
			throw new CustomRestfullException("전화번호 형식이 잘못되었습니다.", HttpStatus.BAD_REQUEST);
		}
		
		return result;
	}
	
}
