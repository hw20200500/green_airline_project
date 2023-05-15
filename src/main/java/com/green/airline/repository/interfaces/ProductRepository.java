package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.ShopProduct;

@Mapper
public interface ProductRepository {

	public int insert(ShopProduct shopProduct);
	public List<ShopProduct> selectProductList();
	public ShopProduct selectById(int id);
	public int updateProduct(ShopProduct shopProduct);
	public int deleteProduct(int id);
}
