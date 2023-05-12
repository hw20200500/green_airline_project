package com.green.airline.repository.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ShopProduct {

	private int id;
	private String brand;
	private String name;
	private int price;
	private int count;
	private String productImage;
	private String gifticonImage;
	private MultipartFile file;
	private String originFileName;
	private MultipartFile file2;
	private String originFileName2;
	
}
