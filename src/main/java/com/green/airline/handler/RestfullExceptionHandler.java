package com.green.airline.handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.green.airline.handler.exception.ApiErrorResponse;
import com.green.airline.handler.exception.CustomPathException;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.handler.exception.ExceptionFieldMessage;

@RestControllerAdvice // 예외클래스를 받아 주는 녀석으로 동작하는 녀석
public class RestfullExceptionHandler {

	// ABC 라고 오는 녀석을 잡아 낼 수 있어 !!

	// 사용자 정의 예외 클래스 활용
	@ExceptionHandler(CustomRestfullException.class)
	public String basicException(CustomRestfullException e) {
		System.out.println(e.getCause());
		// code : 1 / - 1
		// mesage : 뭐가 잘못는지 설계
		// data : ---
		// 에러 발생시 에러 DTO 설계 - 통일 ( T data)
		StringBuffer sb = new StringBuffer();
		sb.append("<script>");
		sb.append("alert('" + e.getMessage() + "');");
		sb.append("history.back();");
		sb.append("</script>");
		return sb.toString();
	}

	/**
	 * @author 서영 경로를 지정해서 던지는 예외 클래스 활용
	 */
	@ExceptionHandler(CustomPathException.class)
	public String customPathException(CustomPathException e) {
		StringBuffer sb = new StringBuffer();
		sb.append("<script>");
		sb.append("alert('" + e.getMessage() + "');");
		sb.append("location.href='" + e.getPath() + "';");
		sb.append("</script>");
		return sb.toString();
	}

	// valid 처리 관련 예외처리
	@ExceptionHandler(value = NullPointerException.class)
	public ApiErrorResponse nullPointerException(NullPointerException e) {
		List<ExceptionFieldMessage> errorList = new ArrayList<>();

		return ApiErrorResponse.builder().statusCode(HttpStatus.BAD_REQUEST.value()).code("-1").resultCode("fail")
				.message("잘못된 요청입니다.").exceptionFieldMessages(errorList).build();
	}

}
