package com.green.airline.controller;

import java.io.File;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;
import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.green.airline.dto.GifticonDto;
import com.green.airline.dto.PagingVO;
import com.green.airline.dto.ProductCountDto;
import com.green.airline.dto.ShopOrderDto;
import com.green.airline.dto.ShopProductDto;
import com.green.airline.dto.UseMileageDto;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.model.Mileage;
import com.green.airline.repository.model.ShopProduct;
import com.green.airline.repository.model.User;
import com.green.airline.service.EmailService;
import com.green.airline.service.MileageService;
import com.green.airline.service.ProductService;
import com.green.airline.service.UserService;
import com.green.airline.utils.Define;

@Controller
@MultipartConfig
@RequestMapping("/product")
public class ProductController {

	@Autowired
	private ProductService productService;

	@Autowired
	private HttpSession session;

	@Autowired
	private MileageService mileageService;
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private UserService userService;

	/**
	 * 정다운 메인 페이지에 상품 리스트 출력
	 * 
	 * @param model
	 * @return 메인페이지
	 */

	@GetMapping("/productMain/{searchOrder}")
	public String productMainPage(Model model, @ModelAttribute("paging") PagingVO paging,
			ProductCountDto productCountDto,@PathVariable(value = "searchOrder") String searchOrder) {
		int totalRowCount = productService.getTotalRowCount(paging);
		paging.setTotalRowCount(totalRowCount);
		paging.pageSetting();
	
		//List<ShopProduct> productList = productService.ProductListTest(paging);
		List<ShopProduct> productList = productService.productList(searchOrder,paging);
		model.addAttribute("productList", productList);
		model.addAttribute("searchOrder", searchOrder);
		return "/mileage/productMainPage";
	}
	// 데이터 받을꺼
		@ResponseBody
		@GetMapping("/list/{searchOrder}")
		public List<ShopProduct> productList(@PathVariable(value = "searchOrder") String searchOrder, 
				@ModelAttribute("paging") PagingVO paging,Model model) {
			int totalRowCount = productService.getTotalRowCount(paging);
			paging.setTotalRowCount(totalRowCount);
			paging.pageSetting();
			List<ShopProduct> productList = productService.productList(searchOrder,paging);
			model.addAttribute("productList", productList);
			return productList;
		}
	@GetMapping("/productSearch")
	public String producSearch(Model model,
			@RequestParam String searchOption,@RequestParam String searchProduct,@ModelAttribute("paging") PagingVO paging) {
			List<ShopProduct> productList = productService.readProductByName(searchProduct,searchOption,paging);
			int totalRowCount = productService.getSearchTotalRowCount(paging, searchProduct, searchOption);
			paging.setTotalRowCount(totalRowCount);
			paging.pageSetting();
			model.addAttribute("productList",productList);
		System.out.println(paging);
		return "/mileage/productMainPage";
	}

	

	/**
	 * 정다운
	 * 
	 * @return 상품 등록 페이지 이동
	 */
	@GetMapping("/registration")
	public String productRegistrationPage() {

		return "/mileage/registrationPage";
	}

	/**
	 * 정다운
	 * 
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
				String fileName = uuid + "_" + file.getOriginalFilename();
				String fileName2 = uuid + "_" + file2.getOriginalFilename();
				// 전체 경로를 지정
				String uploadPath = Define.UPLOAD_DIRECTORY + File.separator + fileName;
				String uploadPath2 = Define.UPLOAD_DIRECTORY + File.separator + fileName2;
				File destination = new File(uploadPath);
				File destination2 = new File(uploadPath2);

				// 좀 더 간편한 방법 사용해 보기
				file.transferTo(destination);
				file2.transferTo(destination2);

				// 객체 상태 변경(dto)
				shopProduct.setOriginFileName("/uploadImage/" + fileName);
				shopProduct.setOriginFileName2("/uploadImage/" + fileName2);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (shopProduct.getBrand() == null || shopProduct.getBrand().isEmpty()) {
			throw new CustomRestfullException("브랜드 입력하세요", HttpStatus.BAD_REQUEST);
		}
		if (shopProduct.getName() == null || shopProduct.getName().isEmpty()) {
			throw new CustomRestfullException("제품명을 입력하세요", HttpStatus.BAD_REQUEST);
		}
		if (shopProduct.getPrice() <= 0) {
			throw new CustomRestfullException("가격이 0원이 될 수는 없습니다", HttpStatus.BAD_REQUEST);
		}
		if (shopProduct.getCount() <= 0) {
			throw new CustomRestfullException("수량이 0원이 될 수는 없습니다", HttpStatus.BAD_REQUEST);
		}
		if (shopProduct.getOriginFileName() == null || shopProduct.getOriginFileName().isEmpty()) {
			throw new CustomRestfullException("제품 이미지를 선택하세요", HttpStatus.BAD_REQUEST);
		}
		if (shopProduct.getOriginFileName2() == null || shopProduct.getOriginFileName2().isEmpty()) {
			throw new CustomRestfullException("기프티콘 이미지를 선택하세요", HttpStatus.BAD_REQUEST);
		}

		productService.productRegistration(shopProduct);
		return "redirect:/product/productMain/clasic";
	}

	/**
	 * 정다운 마일리지 상품 수정
	 * 
	 * @param shopProduct
	 * @return
	 */
	@PostMapping("/update")
	public String productUpdate(ShopProduct shopProduct) {
		if (shopProduct.getBrand() == null || shopProduct.getBrand().isEmpty()) {
			throw new CustomRestfullException("브랜드 입력하세요", HttpStatus.BAD_REQUEST);
		}
		if (shopProduct.getName() == null || shopProduct.getName().isEmpty()) {
			throw new CustomRestfullException("제품명을 입력하세요", HttpStatus.BAD_REQUEST);
		}
		if (shopProduct.getPrice() == 0) {
			throw new CustomRestfullException("가격이 0원이 될 수는 없습니다", HttpStatus.BAD_REQUEST);
		}
		if (shopProduct.getCount() == 0) {
			throw new CustomRestfullException("수량이 0원이 될 수는 없습니다", HttpStatus.BAD_REQUEST);
		}

		/*
		 * if (shopProduct.getProductImage() == null ||
		 * shopProduct.getProductImage().isEmpty()) { throw new
		 * CustomRestfullException("제품 이미지를 선택하세요", HttpStatus.BAD_REQUEST); } if
		 * (shopProduct.getGifticonImage() == null ||
		 * shopProduct.getGifticonImage().isEmpty()) { throw new
		 * CustomRestfullException("기프티콘 이미지를 선택하세요", HttpStatus.BAD_REQUEST); }
		 */

//		MultipartFile file = shopProduct.getFile();
//		MultipartFile file2 = shopProduct.getFile2();
//		if (file.isEmpty() == false) {
//
//			try {
//				// 파일 저장 기능 구현 - 업로드 파일은 HOST 컴퓨터 다른 폴더로 관리
//				String saveDirectory = Define.UPLOAD_DIRECTORY;
//				// 폴더가 없다면 오류 발생 (파일 생성 시)
//				File dir = new File(saveDirectory);
//				if (dir.exists() == false) {
//					dir.mkdirs(); // 폴더가 없으면 폴더 생성
//				}
//				String fileName = file.getOriginalFilename();
//				String fileName2 = file2.getOriginalFilename();
//				// 전체 경로를 지정
//				String uploadPath = Define.UPLOAD_DIRECTORY + File.separator + fileName;
//				String uploadPath2 = Define.UPLOAD_DIRECTORY + File.separator + fileName2;
//				File destination = new File(uploadPath);
//				File destination2 = new File(uploadPath2);
//
//				// 좀 더 간편한 방법 사용해 보기
//				file.transferTo(destination);
//				file2.transferTo(destination2);
//
//				// 객체 상태 변경(dto)
//				shopProduct.setProductImage(file.getOriginalFilename());
//				shopProduct.setGifticonImage(file2.getOriginalFilename());
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
		productService.productUpdate(shopProduct);
		return "redirect:/product/productMain/clasic";
	}

	@GetMapping("/delete/{id}")
	public String productDelete(@PathVariable int id) {
		productService.productDelete(id);
		return "redirect:/product/productMain/clasic";
	}

	/**
	 * 정다운 상품 디테일 페이지
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@GetMapping("/productdetail/{id}")
	public String productDetailPage(@PathVariable int id, Model model) {
		Mileage mileage = new Mileage();
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		
		ShopProduct shopProduct = productService.productDetail(id);
		model.addAttribute(shopProduct);
		
		if (principal != null && principal.getUserRole().equals("관리자") == false) {
			mileage = productService.readMileage(principal.getId());
			if (mileage != null) {
				model.addAttribute(mileage);
			}
			String email = userService.readById(principal.getId()).getEmail();
			model.addAttribute("email", email);
		}
		
		return "/mileage/detailPage";
	}
	
	/**
	 * 정다운 마일리지상품 구매 시 상품 구매내역 + 기프티콘 + 마일리지 사용 insert
	 * 
	 * @param shopOrderDto
	 * @return
	 */
	@PostMapping("/buyProduct")
	public String buyProductProc(ShopOrderDto shopOrderDto, Mileage mileage, ShopProductDto shopProductDto,
			@RequestParam("email") String email, @RequestParam("gifticonImageName") String gifticonImageName,UseMileageDto useMileageDto) {
		GifticonDto gifticonDto = new GifticonDto();
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		String memberId = principal.getId();
		String code;
		try {
			code = emailService.sendSimpleMessage(email, gifticonImageName);
			System.out.println("email : " + email);
			System.out.println("인증코드 : " + code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		shopOrderDto.setMemberId(principal.getId());
		// 구매 내역
		mileage.setMemberId(principal.getId());
		mileage.setBalance(productService.readMileage(principal.getId()).getBalance());
		
		productService.createByUserId(shopOrderDto);
		
		gifticonDto.setOrderId(productService.readShopOrder(principal.getId()).getId());
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, +365);
		Timestamp date = new Timestamp(cal.getTimeInMillis());
		gifticonDto.setEndDate(date);
		productService.createGifticon(gifticonDto);
		
		int totalPrice = shopProductDto.getProductPrice();
		
		
		useMileageDto.setUseMileage(totalPrice);
		useMileageDto.setMemberId(memberId);
		productService.createUseMileage(useMileageDto);

		int productId = shopOrderDto.getProductId();
		mileageService.readNowMileage(memberId, totalPrice,productId);
		productService.updateByProductId(shopProductDto);
		if (email == null || email.isEmpty()) {
			throw new CustomRestfullException("이메일을 입력하세요", HttpStatus.BAD_REQUEST);
		}
		System.out.println("email : " + email);
		// 기프티콘 이메일 전송
		
		
		
		return "redirect:/gifticon/list";
	}
}
