package com.green.airline.dto.request;

import java.sql.Date;

import lombok.Data;

@Data
public class ScheduleSelectDto {

	private String airport1;
	private String airport2;
	private Date flightDate1;
	private Date flightDate2;
	
}
