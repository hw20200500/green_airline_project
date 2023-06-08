package com.green.airline.handler;

import java.net.BindException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.multipart.MaxUploadSizeExceededException;

import com.green.airline.handler.exception.ApiErrorResponse;
import com.green.airline.handler.exception.CustomPathException;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.handler.exception.ExceptionFieldMessage;
import com.green.airline.handler.exception.UnAuthException;
import com.mysql.cj.jdbc.exceptions.MysqlDataTruncation;

@RestControllerAdvice // 예외클래스를 받아 주는 녀석으로 동작하는 녀석
public class RestfullExceptionHandler {

	// ABC 라고 오는 녀석을 잡아 낼 수 있어 !!

	// 사용자 정의 예외 클래스 활용
	@ExceptionHandler(CustomRestfullException.class)
	public String basicException(CustomRestfullException e) {
		System.out.println(e.getCause());
		// code : 1 / - 1
		// message : 뭐가 잘못는지 설계
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

	// 파일업로드 초과 예외처리
	@ExceptionHandler(MaxUploadSizeExceededException.class)
	public String handleMaxSizeException(MaxUploadSizeExceededException e) {

		StringBuffer sb = new StringBuffer();
		sb.append("<script>");
		sb.append("alert('" + "파일용량이 너무 큽니다." + "');");
		sb.append("history.back();");
		sb.append("</script>");

		return sb.toString();
	}

	// 글작성시 내용이 너무 길때 예외처리
	@ExceptionHandler(MysqlDataTruncation.class)
	public String handleMysqlDataTruncation(MysqlDataTruncation e) {

		StringBuffer sb = new StringBuffer();
		sb.append("<script>");
		sb.append("alert('" + "글자 수 제한(제목 또는 내용이 너무 깁니다.)" + "');");
		sb.append("history.back();");
		sb.append("</script>");

		return sb.toString();
	}

	// BindException
	@ExceptionHandler(BindException.class)
	public String bindException(BindException e) {
		System.out.println("11111");

		return "test";
	}
	
	@ExceptionHandler(UnAuthException.class)
	public String unAuthorizedException(UnAuthException e) {
		StringBuffer sb = new StringBuffer();
		sb.append("<script>");
		sb.append("alert('"+ e.getMessage() +"');"); 
		sb.append("location.href='/login';");
		sb.append("</script>");
		return sb.toString();
	}
}
