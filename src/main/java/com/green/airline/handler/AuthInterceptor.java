package com.green.airline.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.HandlerInterceptor;

import com.green.airline.handler.exception.UnAuthException;
import com.green.airline.repository.model.User;
import com.green.airline.utils.Define;

@RestControllerAdvice
public class AuthInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		if (principal == null) {
			throw new UnAuthException("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
		}

		return true;
	}
	
}
