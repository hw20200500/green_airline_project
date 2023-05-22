package com.green.airline.dto;

import lombok.Data;

@Data
public class ProductCountDto {

	private int page;
	private int recordSize;
	private int pageSize;
	private ProductPagination productPagination;
	public ProductCountDto() {
		this.page = 1;
		this.recordSize = 10;
		this.pageSize = 10;
	}
	public int getOffset() {
		return (page -1) * recordSize;
	}
}
