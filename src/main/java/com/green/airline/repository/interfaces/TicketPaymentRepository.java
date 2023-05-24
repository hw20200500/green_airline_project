package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.repository.model.TicketPayment;

/**
 * @author 서영
 *
 */
@Mapper
public interface TicketPaymentRepository {

	public Integer insert(TicketPayment ticketPayment);
	
	public Integer updateStatus(@Param("ticketId") String ticketId, @Param("status1") Integer status1, @Param("status2") Integer status2);
	
	public TicketPayment selectByTicketId(String ticketId);
	
}
