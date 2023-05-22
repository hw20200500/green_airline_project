package com.green.airline.dto.request;

import java.sql.Date;

import lombok.Data;

/**
 * @author 서영
 * 단일 탑승객 정보를 담음
 */
@Data
public class PassengerInfoDto {

	private String ageType;
	private String gender;
	private String name;
	private Date birth;
	
}
