package com.green.airline.enums;

public enum UserRole {
	
	// 사용할 이름("실제로 db에 들어가는 값") 
	DEFAULT("회원"), SOCIAL("소셜회원"), ADMIN("관리자");
	
	// 멤버변수 만들어주기 -> xml파일에 #{.userRole} 해주기
	private String userRole;
	
	// 생성자 만들어주기
	private UserRole(String userRole) {
		this.userRole = userRole;
	}
	
	// get 메서드 생성해주기
	public String getUserRole() {
		return this.userRole;
	}
	
}
