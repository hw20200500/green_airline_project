package com.green.airline.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.annotation.MultipartConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.green.airline.repository.model.ShopProduct;
import com.green.airline.service.ProductService;
import com.green.airline.utils.Define;

@Controller
@MultipartConfig
@RequestMapping("/product")
public class ProductController {

	@Autowired
	private ProductService productService;
	
	/**
	 * 정다운
	 * @param model
	 * @return 메인페이지
	 */
	@GetMapping("/productMain")
	public String productMainPage(Model model) {
		List<ShopProduct> productList = productService.productList();
		model.addAttribute("productList",productList);
		System.out.println(productList.toString());
		return "/mileage/productMainPage";
		
	}
	
	
	
	
	/**
	 * 정다운
	 * @return 상품 등록 페이지 이동
	 */
	@GetMapping("/registration")
	public String productRegistrationPage() {
		
		return "/mileage/registrationPage";
	}
	
	
	/**
	 * 정다운
	 * @return 상품 등록 + productMainPage 이동
	 */
	@PostMapping("/insert")
	public String Registration(ShopProduct shopProduct) {
		// 사용자 프로필 이미지는 옵션 값으로 설정 할 예정
				MultipartFile file = shopProduct.getFile();
				MultipartFile file2 = shopProduct.getFile2();
				if (file.isEmpty() == false) {
				
					try {
						// 파일 저장 기능 구현 - 업로드 파일은 HOST 컴퓨터 다른 폴더로 관리
						String saveDirectory = Define.UPLOAD_DIRECTORY;
						// 폴더가 없다면 오류 발생 (파일 생성 시)
						File dir = new File(saveDirectory);
						if (dir.exists() == false) {
							dir.mkdirs(); // 폴더가 없으면 폴더 생성
						}
						UUID uuid = UUID.randomUUID();
						String fileName =file.getOriginalFilename();
						// 전체 경로를 지정
						String uploadPath = Define.UPLOAD_DIRECTORY + File.separator + fileName;
						File destination = new File(uploadPath);
						
						// 좀 더 간편한 방법 사용해 보기 
						file.transferTo(destination);
						
						// 객체 상태 변경(dto) 
						shopProduct.setOriginFileName(file.getOriginalFilename());
						shopProduct.setOriginFileName2(file2.getOriginalFilename());
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				productService.productRegistration(shopProduct);
		return "redirect:/product/productMain";
	}
	
	/**
	 * 정다운
	 * 마일리지 상품 수정
	 * @param shopProduct
	 * @return
	 */
	@PostMapping("/update")
	public String productUpdate(ShopProduct shopProduct) {
		productService.productUpdate(shopProduct);
		
		return "redirect:/product/productMain";
	}
	@GetMapping("/delete/{id}")
	public String productDelete(@PathVariable int id) {
		System.out.println(id);
		productService.productDelete(id);
		return "redirect:/product/productMain";
	}
	/**
	 * 정다운
	 * 상품 디테일 페이지
	 * @param id
	 * @param model
	 * @return
	 */
	@GetMapping("/productdetail/{id}")
	public String productDetailPage(@PathVariable int id,Model model) {
		ShopProduct shopProduct = productService.productDetail(id);
		 model.addAttribute(shopProduct);
		return "/mileage/detailPage";
	}
	
}

