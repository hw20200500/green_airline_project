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
	public final static String UPLOAD_DIRECTORY = "/images/upload/";
	
	// 성인 나이 기준
	public final static int MIN_ADULT_AGE = 12;
	
	// 고객의 말씀 최대 작성 가능 byte 수
	public final static int MAX_TEXTAREA_LENGTH = 2000;
	
	public static int childPriceRate() {
		return (int) (CHILD_PRICE_RATE * 100);
	}
	
	
	// ResponseDto의 resultCode에 사용할 상수
	public final static String RESULT_CODE_SUCCESS = "success";
	public final static String RESULT_CODE_FAIL = "fail";
	
	public final static int CODE_SUCCESS = 1;
	public final static int CODE_FAIL = -1;
	
	// 마일리지 결제 시 마일리지 금액은 기존 금액의 0.02
	public final static double MILES_TICKET_RATE = 0.005;
	
	// 서영 : 192.168.0.187
	// 민정 : 192.168.0.126 / 192.168.0.2
	public final static String IP_ADDRESS = "192.168.0.187";
	
	// 인터셉터
	// 로그인이 필요한 경로
	public final static String[] PATHS = {"/userMain", "/ticket/selectSeat/**", "/ticket/payment/**", "/ticket/list/**",
			"/inFlightService/inFlightSpecialReq", "/baggage/myBaggageReq", "/gifticon/list", "/voc/**", "/manager/**"
			, "/product/registration"};
	// 매니저만 접근 가능한 경로
	public final static String[] MANAGER_PATHS = {"/manager/**", "/product/registration"};
	
}
