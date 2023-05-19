package com.green.airline.dto;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;
@Data
public class ProductPaging<T> {

	private List<T> list = new ArrayList<>();
    private ProductPagination productPagination;
    public ProductPaging(List<T> list, ProductPagination pagination) {
        this.list.addAll(list);
        this.productPagination = pagination;
    }
}
