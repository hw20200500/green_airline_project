package com.green.airline.utils;

import java.text.DecimalFormat;

/**
 * @author 치승
 * 소수점 8자리까지 표기
 */

public class DecimalPoint {
	
	public static String formatDouble(double value) {
        DecimalFormat df = new DecimalFormat("#.00000000");
        return df.format(value);
    }

}
