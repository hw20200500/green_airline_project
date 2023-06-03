package com.green.airline.dto.response;

import java.sql.Timestamp;
import java.util.Date;

import com.green.airline.utils.DateUtil;
import com.green.airline.utils.TimestampUtil;

import lombok.Data;

/**
 * @author 서영
 */
@Data
public class MemberInfoDto {

	private String id;
	private String korName;
	private String engName;
	private String birthDate;
	private String gender;
	private String phoneNumber;
	private String email;
	private String address;
	private String nationality;
	private String grade;
	private Timestamp joinAt;
	private Timestamp withdrawAt;
	private Integer status;
	private String userRole;
	
	public String formatJoinAt() {
		return TimestampUtil.dateToString(joinAt);
	}
	
	public String formatWithdrawAt() {
		return TimestampUtil.dateToString(withdrawAt);
	}
	
}
