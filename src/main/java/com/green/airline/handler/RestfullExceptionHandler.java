package com.green.airline.handler;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.green.airline.handler.exception.CustomPathException;
import com.green.airline.handler.exception.CustomRestfullException;

@RestControllerAdvice
public class RestfullExceptionHandler {

	
	// 사용자 정의 예외 클래스 활용
	@ExceptionHandler(CustomRestfullException.class)
	public String basicException(CustomRestfullException e) {
		StringBuffer sb = new StringBuffer();
		sb.append("<script>");
		sb.append("alert('"+ e.getMessage() +"');"); 
		sb.append("history.back();");
		sb.append("</script>");
		return sb.toString();
	}
	
	/**
	 * @author 서영
	 * 경로를 지정해서 던지는 예외 클래스 활용
	 */
	@ExceptionHandler(CustomPathException.class)
	public String customPathException(CustomPathException e) {
		StringBuffer sb = new StringBuffer();
		sb.append("<script>");
		sb.append("alert('"+ e.getMessage() +"');");
		sb.append("location.href='" + e.getPath() + "';");
		sb.append("</script>");
		return sb.toString();
	}
	
	
}
