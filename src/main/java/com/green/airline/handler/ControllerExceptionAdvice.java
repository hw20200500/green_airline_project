package com.green.airline.handler;

import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice// 예외클래스를 받아 주는 녀석으로 동작하는 녀석
public class ControllerExceptionAdvice {

//	@ExceptionHandler(Exception.class)
//	public void exception(Exception e) {
//		System.out.println("------------------");
//		System.out.println("clsss " + e.getClass().getName());
//		System.out.println("------------------");
//	}
	
//	@ExceptionHandler(BindException.class)
//	@ResponseBody
//	public String bindException(BindException e) {
//		StringBuilder builder = new StringBuilder();
//		e.getAllErrors().forEach(el -> {
//			builder.append(el.getDefaultMessage());
//		});
//		StringBuffer sb = new StringBuffer();
//		sb.append("<script>");
//		sb.append("alert('"+builder.toString()+"');");
//		sb.append("history.back();");
//		sb.append("</script>");
//		return sb.toString();
//		
//	}
	

}

