package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.GifticonDto;
import com.green.airline.dto.ShopProductDto;
import com.green.airline.repository.interfaces.ProductRepository;
import com.green.airline.repository.model.Mileage;
import com.green.airline.repository.model.ShopOrder;
import com.green.airline.repository.model.ShopProduct;
import com.green.airline.repository.model.User;

@Service
public class ProductService {

	
	@Autowired
	private ProductRepository productRepository; 
	
	
	// 상품 등록
	public void productRegistration(ShopProduct shopProduct) {
		productRepository.insert(shopProduct);
	}
	
	// 상품 리스트 조회
	public List<ShopProduct> productList(){
		
		List<ShopProduct> list = productRepository.selectProductList();
		return list;
	}
	// 상품 상세 조회
	public ShopProduct productDetail(int id) {
		ShopProduct shopProduct = productRepository.selectById(id);
		return shopProduct;
	}
	// 상품 정보 수정
	public int productUpdate(ShopProduct shopProduct) {
		int update = productRepository.updateProduct(shopProduct);
		return update;
	}
	// 상품 삭제
	public int productDelete(int id) {
		int delete = productRepository.deleteProduct(id);
		return delete;
	}
	
	// 
	public void buyProduct(ShopOrder shopOrder) {
		 productRepository.buyProduct(shopOrder);
	}
	
	
	public int createByUserId(ShopProductDto productDto) {
		int resultRowCount = productRepository.insertShopProductDto(productDto);
		return resultRowCount;
	}
	// 기프티콘 테이블 insert
	public int createGifticon(GifticonDto gifticonDto) {
		int result = productRepository.insertGifticonDto(gifticonDto);
		return result;
	}
	
	// 사용자 id로 구매목록 조회
	public ShopOrder readShopOrder(String memberId) {
		ShopOrder shopOrder = productRepository.selectShopOrder(memberId);
		return shopOrder;
	}
	// 마일리지 테이블 조회
	public Mileage readMileage(String memberId) {
		Mileage mileage = productRepository.selectMileage(memberId);
		return mileage;
	}
}
