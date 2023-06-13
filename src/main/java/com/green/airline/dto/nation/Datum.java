package com.green.airline.dto.nation;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.Data;

@Data
@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class)
public class Datum {

//	public String countryEngNm;
//	public String countryIsoAlp2;
	public String countryNm;
//	public String isoAlp3;
//	public String isoNum;

}
