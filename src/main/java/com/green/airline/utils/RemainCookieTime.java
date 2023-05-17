package com.green.airline.utils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneOffset;

public class RemainCookieTime {
	// 현재 하루의 종료 시간, YYYY-MM-DDT23:59:59.9999999
	LocalDateTime todayEndTime = LocalDate.now().atTime(LocalTime.MAX); 

	// 현재 시간, YYYY-MM-DDT19:39:10.936
	LocalDateTime currentTime = LocalDateTime.now();

	// 하루 종료 시간을 시간초로 변환
	long todayEndSecond = todayEndTime.toEpochSecond(ZoneOffset.UTC);

	// 현재 시간을 시간초로 변환
	long currentSecond = currentTime.toEpochSecond(ZoneOffset.UTC);

	// 하루 종료까지 남은 시간초
	long remainingTime = todayEndSecond - currentSecond;
}
