package com.green.airline.service;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.green.airline.dto.EmailDto;
import com.green.airline.dto.GifticonDto;
import com.green.airline.dto.MileageDto;
import com.green.airline.dto.ProductCountDto;
import com.green.airline.dto.ProductPagination;
import com.green.airline.dto.ProductPaging;
import com.green.airline.dto.ShopOrderDto;
import com.green.airline.dto.ShopProductDto;
import com.green.airline.repository.interfaces.ProductRepository;
import com.green.airline.repository.model.Mileage;
import com.green.airline.repository.model.ShopOrder;
import com.green.airline.repository.model.ShopProduct;
import com.green.airline.repository.model.User;

@Service
@Component
public class ProductService {

	@Autowired
	private ProductRepository productRepository;

	@Autowired
	private JavaMailSender MailSender;

	// 상품 등록
	public void productRegistration(ShopProduct shopProduct) {
		productRepository.insert(shopProduct);
	}

	// 상품 리스트 조회
	public List<ShopProduct> productList(String searchOrder) {

		List<ShopProduct> list = productRepository.selectProductList(searchOrder);
		return list;
	}

	public List<ShopProduct> productList() {

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
	public int createUseMileage(MileageDto mileageDto) {
		int result = productRepository.insertMileage(mileageDto);
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
	
	
	
	// 상품 페이징 처리 테스트
	public ProductPaging<ShopProduct>listtest(ProductCountDto productCountDto) {
		// 조건에 해당하는 데이터가 없는 경우, 응답 데이터에 비어있는 리스트와 null을 담아 반환
        int count = productRepository.countListTest(productCountDto);
        if (count < 1) {
            return new ProductPaging<>(Collections.emptyList(), null);
        }

        // Pagination 객체를 생성해서 페이지 정보 계산 후 SearchDto 타입의 객체인 params에 계산된 페이지 정보 저장
        ProductPagination pagination = new ProductPagination(count, productCountDto);
        productCountDto.setProductPagination(pagination);

        // 계산된 페이지 정보의 일부(limitStart, recordSize)를 기준으로 리스트 데이터 조회 후 응답 데이터 반환
		List<ShopProduct> list = productRepository.ProductListTest(productCountDto);
		return new ProductPaging<>(list, pagination);
	}
	
	
	
	
	
	
}
