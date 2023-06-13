package com.green.airline.utils;

import java.text.DecimalFormat;

public class NumberUtil {

	/**
	 * @author 서영
	 * 숫자를 1,000,000와 같은 형태로 변환함
	 * 메서드 오버로딩
	 */
	public static String numberFormat(Long number) {
		
		DecimalFormat df = new DecimalFormat("#,###");
		return df.format(number);
	}
	
	public static String numberFormat(Integer number) {
		
		DecimalFormat df = new DecimalFormat("#,###");
		return df.format(number);
	}
	
}
