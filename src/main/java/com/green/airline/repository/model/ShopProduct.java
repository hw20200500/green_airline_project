package com.green.airline.repository.model;

import org.springframework.web.multipart.MultipartFile;

import com.green.airline.utils.NumberUtil;

import lombok.Data;

@Data
public class ShopProduct {
	private int id;
	private String brand;
	private String name;
	private Long price;
	private int count;
	private String productImage;
	private String gifticonImage;
	private MultipartFile file;
	private String originFileName;
	private MultipartFile file2;
	private String originFileName2;
	public String priceNumber() {
		return NumberUtil.numberFormat(price);
	}
}
