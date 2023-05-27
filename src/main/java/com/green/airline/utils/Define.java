package com.green.airline.utils;

public class Define {

	public final static String PRINCIPAL = "principal";
	
	// 소아 티켓 가격 비율 (기준 : 성인)
	public final static double CHILD_PRICE_RATE = 0.75;
	
	// 유아 티켓 가격 비율 (기준 : 성인)
	public final static double INFANT_PRICE_RATE = 0.1;
	
	// 국제선은 국내선보다 가격 1.5배
	public final static double INTERNATIONAL_RATE = 1.5;
	

	/**
	 * 상품 이미지 입력시 사용 
	 */
	//public static final String UPLOAD_DIRECTORY = "C:\\Users\\GGG\\Desktop\\image";
	public static final int MAX_FILE_SIZE = 1024 * 1024 * 20; // 최대 20MB


	// 이미지 처리 관련
	public final static String UPLOAD_DIRECTORY = "C:\\upload";
}
