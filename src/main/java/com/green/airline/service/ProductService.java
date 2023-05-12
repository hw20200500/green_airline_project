package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.repository.interfaces.ProductRepository;
import com.green.airline.repository.model.ShopProduct;

@Service
public class ProductService {

	
	@Autowired
	private ProductRepository productRepository; 
	
	public void productRegistration(ShopProduct shopProduct) {
		productRepository.insert(shopProduct);
	}
	
	public List<ShopProduct> productList(){
		
		List<ShopProduct> list = productRepository.selectProductList();
		return list;
	}
	public ShopProduct productDetail(int id) {
		ShopProduct shopProduct = productRepository.selectById(id);
		return shopProduct;
	}
}
