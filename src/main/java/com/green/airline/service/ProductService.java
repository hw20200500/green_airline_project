package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.green.airline.dto.EmailDto;
import com.green.airline.dto.GifticonDto;
import com.green.airline.dto.PagingVO;
import com.green.airline.dto.ShopOrderDto;
import com.green.airline.dto.ShopProductDto;
import com.green.airline.dto.UseMileageDto;
import com.green.airline.dto.response.ProductBrandOrderAmountDto;
import com.green.airline.repository.interfaces.ProductRepository;
import com.green.airline.repository.model.Mileage;
import com.green.airline.repository.model.ShopOrder;
import com.green.airline.repository.model.ShopProduct;

@Service
@Component
public class ProductService {

	@Autowired
	private ProductRepository productRepository;
	


	// 상품 등록
	public void productRegistration(ShopProduct shopProduct) {
		productRepository.insert(shopProduct);
	}

	// 상품 리스트 조회
	public List<ShopProduct> productList(String searchOrder,PagingVO paging) {

		List<ShopProduct> list = productRepository.selectProductList(searchOrder,paging);
		return list;
	}

	public List<ShopProduct> productList() {

		List<ShopProduct> list = productRepository.selectProductList();
		return list;
	}
	
	public List<ShopProduct> readProductByName(String searchProduct, String searchOption,PagingVO paging){
		List<ShopProduct> list = productRepository.selectProductByName(searchProduct,searchOption,paging);
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

	public int createByUserId(ShopOrderDto productDto) {
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

	// 마일리지 사용 insert
	public int createUseMileage( UseMileageDto useMileageDto ) {
		int result = productRepository.insertMileage(useMileageDto);
		return result;
	}

	// 재고 수량 수정
	public int updateByProductId(ShopProductDto shopProductDto) {
		int result = productRepository.updateShopProductDto(shopProductDto);
		return result;
	}

	// 기프티콘 메일 전송
	public void sendMail(EmailDto mail) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(mail.getAddress());
//        message.setFrom(""); from 값을 설정하지 않으면 application.yml의 username값이 설정됩니다.
		message.setSubject(mail.getTitle());
		message.setText(mail.getMessage());
		System.out.println(mail.toString());
	}
	
	public int getTotalRowCount(PagingVO paging) {
		int result = productRepository.getTotalRowCount(paging);
		return result;
	}
	public int getSearchTotalRowCount(PagingVO paging,String searchProduct,String searchOption) {
		int result = productRepository.getSerchTotalRowCount(searchProduct, searchOption, paging);
		return result;
	}
	
	public List<ShopProduct> ProductListTest(PagingVO paging) {
		List<ShopProduct> list = productRepository.ProductListTest(paging);
		return list;
	}
	
	/**
	 * @author 서영
	 * 구매량이 많은 상위 n개 브랜드
	 */
	public List<ProductBrandOrderAmountDto> readTopNBrand(Integer limitCount) {
		return productRepository.selectSumAmountGroupByProductLimitN(limitCount);
	}
	
	
	
}