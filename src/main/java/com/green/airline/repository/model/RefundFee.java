package com.green.airline.repository.model;

import com.green.airline.utils.Define;
import com.green.airline.utils.NumberUtil;

import lombok.Data;

/**
 * @author 서영
 */
@Data
public class RefundFee {

	private Integer criterion;
	private Integer type;
	private Long fee;
	
	public String formatFee() {
		return NumberUtil.numberFormat(fee);
	}
	
	public String formatMilesFee() {
		return NumberUtil.numberFormat((long) Math.floor(fee * Define.MILES_TICKET_RATE));
	}
	
}
