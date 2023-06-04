package com.green.airline.enums;

public enum BaggageSection {
	
	DOMESTIC_SECTION("국내선 구간"), INTERNATIONAL_SECTION("국제선 구간 (미주/브라질 구간 제외)");
	
	private String section;
	
	private BaggageSection(String section) {
		this.section = section;
	}
	
	public String getBaggageSection() {
		return this.section;
	}
	
}
