package com.green.airline.enums;

public enum MealDetail {
	BABYMEAL("2"), VEGANMEAL("3"), LOWFATMEAL("4"), RELIGIONMEAL("5"), ETCMEAL("6");

	private String mealId;

	private MealDetail(String mealId) {
		this.mealId = mealId;
	}

	public String getMealId() {
		return this.mealId;
	}
}
