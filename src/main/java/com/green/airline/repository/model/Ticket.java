<<<<<<< HEAD
package com.green.airline.repository.model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 예약된 티켓
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Ticket {

	private String id;
	private Integer adultCount;
	private Integer childCount;
	private Integer infantCount;
	private String seatGrade;
	private String memberId;
	private Integer scheduleId;
	private Timestamp reservedDate;
	
	public Ticket(Integer adultCount, Integer childCount, Integer infantCount, String seatGrade,
			Integer scheduleId) {
		this.adultCount = adultCount;
		this.childCount = childCount;
		this.infantCount = infantCount;
		this.seatGrade = seatGrade;
		this.scheduleId = scheduleId;
	}
	
	
	
}
=======
package com.green.airline.repository.model;

import java.sql.Timestamp;

import lombok.Data;

// 예약된 티켓
@Data
public class Ticket {

	private Integer id;
	private Integer seatCount;
	private String memberId;
	private Integer scheduleId;
	private Timestamp reservedDate;
	
}
>>>>>>> feature/board
