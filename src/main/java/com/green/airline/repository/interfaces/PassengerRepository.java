package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.Passenger;

@Mapper
public interface PassengerRepository {

	public Integer insert(Passenger passenger);
}
