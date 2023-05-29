package com.green.airline.utils;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

// Timestamp 타입 관련 유틸

public class TimestampUtil {

	/**
	 * @author 서영
	 * Timestamp 타입을 'yyyy-MM-dd HH:mm'으로 변환함
	 */
	public static String dateTimeToString(Timestamp timestamp) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		return sdf.format(timestamp);
	}
	
	/**
	 * @author 서영
	 * Timestamp 타입을 'yyyy년 MM월 dd일 HH시 mm분'으로 변환함 (type2)
	 */
	public static String dateTimeToStringType2(Timestamp timestamp) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
		return sdf.format(timestamp);
	}
	
	/**
	 * @author 서영
	 * Timestamp 타입을 'yyyy-MM-dd HH:mm:ss'으로 변환함
	 */
	public static String dateTimeToStringType3(Timestamp timestamp) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(timestamp);
	}
	
	/**
	 * @author 서영
	 * Timestamp 타입을 날짜로 변경함
	 */
	public static String dateToString(Timestamp timestamp) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(timestamp);
	}
	
	/**
	 * @author 서영
	 * Timestamp 타입을 날짜로 변경함 (type2)
	 */
	public static String dateToStringType2(Timestamp timestamp) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		return sdf.format(timestamp);
	}
	
	/**
	 * @author 서영
	 * Timestamp 타입을 시간으로 변경함
	 */
	public static String timeToString(Timestamp timestamp) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		return sdf.format(timestamp);
	}
	
}
