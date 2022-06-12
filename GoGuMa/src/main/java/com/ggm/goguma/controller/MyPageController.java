package com.ggm.goguma.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggm.goguma.dto.CancelPayDTO;
import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.CouponDTO;
import com.ggm.goguma.dto.DeliveryAddressDTO;
import com.ggm.goguma.dto.ImageAttachDTO;
import com.ggm.goguma.dto.PointDTO;
import com.ggm.goguma.dto.ProductDTO;
import com.ggm.goguma.dto.ReceiptDTO;
import com.ggm.goguma.dto.ReviewDTO;
import com.ggm.goguma.dto.UpdateMemberDTO;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.service.member.MemberService;
import com.ggm.goguma.service.mypage.MyPageService;
import com.ggm.goguma.service.product.CategoryService;
import com.ggm.goguma.service.product.ImageAttachService;
import com.ggm.goguma.service.product.ProductService;
import com.ggm.goguma.service.product.ReviewService;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;

import lombok.extern.log4j.Log4j;

/**
 * @작성자 : 송진호
 * @시작일자 : 2022.05.04
 * @완료일자 : 2022.06.10
 */
@Log4j
@Controller
@RequestMapping("/mypage")
public class MyPageController {
//	@Value("${contentPerPage}")
	private int contentPerPage=10; // 한 페이지에 보여지는 게시물의 개수
	
//	@Value("${productPerPage}")
	private int productPerPage=8; // 한 페이지에 보여지는 최근 본 상품의 개수
	
//	@Value("${blockPerPage}")
	private int blockPerPage=5; // 한 페이지에 보여지는 페이지 블록의 개수
	
	@Autowired
	private MyPageService service;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private ImageAttachService attachService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private ProductService productService;
	
	// 쿠키에 저장된 상품ID의 개수를 반환하는 메소드
	public int getSeenProductCount(HttpServletRequest request) throws UnsupportedEncodingException {
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				// 이름이 'seenProducts'인 쿠키를 찾으면
				if(cookie.getName().equals("seenProducts")) {
					// 쿠키에 저장된 상품ID 값을 쉼표로 구분해서 배열 형식으로 저장
					String[] productIdArr = (URLDecoder.decode(cookie.getValue(), "utf-8")).split(",");
					return productIdArr.length;
				}
			}
		}
		return 0;
	}
	
	// 쿠키에 저장된 상품ID들을 리스트에 각각 저장하는 메소드
	public List<ProductDTO> setSeenProducts(long page, long productCount, HttpServletRequest request) throws NumberFormatException, Exception {
		List<ProductDTO> productList = new ArrayList<>();
		
		long startNum = (page-1) * productPerPage;
		long endNum = page * productPerPage - 1;
		if(endNum >= productCount) endNum = productCount - 1; // endNum이 productCount 보다 커지는 것을 방지
		
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				// 이름이 'seenProducts'인 쿠키를 찾으면
				if(cookie.getName().equals("seenProducts")) {
					// 쿠키에 저장된 상품ID 값을 쉼표로 구분해서 배열 형식으로 저장
					String[] productIdArr = (URLDecoder.decode(cookie.getValue(), "utf-8")).split(",");
					// 상품ID들을 통해서 가져온 ProductInfo들을 productList에 각각 저장
					for(int i=(int)startNum; i<=endNum; i++) {
						productList.add(productService.getProductInfo(Long.parseLong(productIdArr[i])));
					}
				}
			}
		}
		return productList;
	}
	
	@RequestMapping(value="", method=RequestMethod.GET)
	public String getMyPageMain(@RequestParam(value="page", defaultValue="1") long page,
		HttpServletRequest request, Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			model.addAttribute("memberDTO", memberDTO);
			
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			model.addAttribute("parentCategory", parentCategory);
			
			long memberPoint = service.getMemberPoint(memberDTO.getId());
			model.addAttribute("memberPoint", memberPoint);
			
			long couponCount = service.getCouponCount(memberDTO.getId(), "available");
			model.addAttribute("couponCount", couponCount);

			// 작성 가능한 상품평 개수 불러오기
			List<ProductDTO> writeableList = reviewService.getWriteableReview(memberDTO.getId());
			model.addAttribute("writeableList", writeableList);
			model.addAttribute("writeableCount", writeableList.size());
			
			// 최근 본 상품의 개수
			long productCount = getSeenProductCount(request);
			// 전체 페이지 개수 = 최근 본 상품의 개수 / 한 페이지에 보여지는 최근 본 상품의 개수
			long pageCount = productCount / productPerPage;
			// 예를 들어, 최근 본 상품의 개수가 101개인 경우, 11개의 페이지가 필요하므로 총 페이지의 개수를 증가시켜준다.
			if(productCount % productPerPage != 0) pageCount++;
			
			// 시작 페이지 = (현재 페이지-1) / 페이지 블록 크기 * 페이지 블록 크기 + 1
			long startPage = (page-1) / blockPerPage * blockPerPage + 1;
			// 마지막 페이지 (현재 페이지-1) / 페이지 블록 크기 * 페이지 블록 크기 + 페이지 블록 크기
			long endPage = (page-1) / blockPerPage * blockPerPage + blockPerPage;
			// 마지막 페이지 개수가 전체 페이지 개수보다 많은 경우, 마지막 페이지를 전체 페이지 개수로 맞춰준다.
			if(endPage > pageCount) endPage = pageCount;
			
			List<ProductDTO> productList = setSeenProducts(page, productCount, request);
			model.addAttribute("productList", productList);
			model.addAttribute("page", page);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("productCount", productCount);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/main";
	}
	
	@RequestMapping(value="/orderHistory", method=RequestMethod.GET)
	public String getOrderHistory(Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			model.addAttribute("memberDTO", memberDTO);
			
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			model.addAttribute("parentCategory", parentCategory);
			
			long memberPoint = service.getMemberPoint(memberDTO.getId());
			model.addAttribute("memberPoint", memberPoint);
			
			long couponCount = service.getCouponCount(memberDTO.getId(), "available");
			model.addAttribute("couponCount", couponCount);
			
			// 작성 가능한 상품평 개수 불러오기
			List<ProductDTO> writeableList = reviewService.getWriteableReview(memberDTO.getId());
			model.addAttribute("writeableList", writeableList);
			model.addAttribute("writeableCount", writeableList.size());
			
			List<ReceiptDTO> receiptHistory = service.getReceiptHistory(memberDTO.getId()); // 회원ID로 결제정보DTO를 모두 불러오기
			model.addAttribute("receiptHistory", receiptHistory);
			for(ReceiptDTO dto : receiptHistory) {
				log.info(dto);
			}
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/orderHistory";
	}
	
	@RequestMapping(value="/orderHistory/{receiptId}", method=RequestMethod.GET)
	public String getOrderDetail(@PathVariable("receiptId") long receiptId, Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			model.addAttribute("memberDTO", memberDTO);
			
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			model.addAttribute("parentCategory", parentCategory);
			
			long memberPoint = service.getMemberPoint(memberDTO.getId());
			model.addAttribute("memberPoint", memberPoint);
			
			long couponCount = service.getCouponCount(memberDTO.getId(), "available");
			model.addAttribute("couponCount", couponCount);
			
			// 작성 가능한 상품평 개수 불러오기
			List<ProductDTO> writeableList = reviewService.getWriteableReview(memberDTO.getId());
			model.addAttribute("writeableList", writeableList);
			model.addAttribute("writeableCount", writeableList.size());
			
			ReceiptDTO receiptDTO = service.getReceiptDetail(receiptId); // 결제상세 가져오기
			model.addAttribute("receiptDTO", receiptDTO);
			
			int estimatedPoints = service.getEstimatedPoint(receiptId);
			model.addAttribute("estimatedPoints", estimatedPoints);
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/orderDetail";
	}

	@ResponseBody
	@RequestMapping(value="/orderHistory/updateOrderStatus", method=RequestMethod.POST)
	public String updateOrderStatus(@RequestParam("orderId") long orderId, @RequestParam("status") String status) throws Exception {
		try {
			service.updateOrderStatus(orderId, status);
		} catch (Exception e) {
			log.info(e.getMessage());
			return "2";
		}
		return "1";
	}
	
	/*
	 * @작성자: Moon Seokho
	 * @Date: 2022. 6. 7.
	 * @프로그램설명: 환불요청을 받을 URL
	 * @변경이력: 
	 */
	private IamportClient api;
	
	@Value("${iamport.restKeyPay}")
	private String payKey;
	@Value("${iamport.secretPay}")
	private String paySecretKey;
	
	//사용자가 구매 취소를 한 경우 상품 금액만큼 결제 취소한다.
	@ResponseBody
	@PostMapping("api/payment/cancel")
	public void cancelPay(CancelPayDTO cancelPayDTO) throws IamportResponseException, IOException {
		api = new IamportClient(payKey, paySecretKey);
		System.out.println(cancelPayDTO.getUid() + " " + cancelPayDTO.getCancelAmount());
		CancelData cancel_data = new CancelData(cancelPayDTO.getUid(), true, BigDecimal.valueOf(cancelPayDTO.getCancelAmount()));
		
		api.cancelPaymentByImpUid(cancel_data);
		log.info("환불 로그");
	}
	
	@RequestMapping(value="/pointHistory/{type}", method=RequestMethod.GET)
	public String getPointHistory(@PathVariable("type") String type, @RequestParam("page") long page,
		@RequestParam(value="startDate", required=false) String startDate,
		@RequestParam(value="endDate", required=false) String endDate,
		Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			model.addAttribute("memberDTO", memberDTO);
			
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			model.addAttribute("parentCategory", parentCategory);
			
			long memberPoint = service.getMemberPoint(memberDTO.getId());
			model.addAttribute("memberPoint", memberPoint);
			
			long couponCount = service.getCouponCount(memberDTO.getId(), "available");
			model.addAttribute("couponCount", couponCount);
			
			// 작성 가능한 상품평 개수 불러오기
			List<ProductDTO> writeableList = reviewService.getWriteableReview(memberDTO.getId());
			model.addAttribute("writeableList", writeableList);
			model.addAttribute("writeableCount", writeableList.size());
			
			// 포인트 내역의 개수
			long historyCount = service.getPointHistoryCount(memberDTO.getId(), type, startDate, endDate);
			// 전체 페이지 개수 = 포인트 내역의 개수 / 한 페이지에 보여지는 내역의 수
			long pageCount = historyCount / contentPerPage;
			// 예를 들어, 내역이 101개인 경우, 11개의 페이지가 필요하므로 총 페이지 개수를 증가시켜준다.
			if(historyCount % contentPerPage != 0) pageCount++;
			
			// 시작 페이지 = (현재 페이지-1) / 페이지 블록 크기 * 페이지 블록 크기 + 1
			long startPage = (page-1) / blockPerPage * blockPerPage + 1;
			// 마지막 페이지 (현재 페이지-1) / 페이지 블록 크기 * 페이지 블록 크기 + 페이지 블록 크기
			long endPage = (page-1) / blockPerPage * blockPerPage + blockPerPage;
			// 마지막 페이지 개수가 전체 페이지 개수보다 많은 경우, 마지막 페이지를 전체 페이지 개수로 맞춰준다.
			if(endPage > pageCount) endPage = pageCount;

			List<PointDTO> pointHistory = service.getPointHistory(memberDTO.getId(), type, page, startDate, endDate);
			model.addAttribute("pointHistory", pointHistory);
			model.addAttribute("type", type);
			model.addAttribute("page", page);
			model.addAttribute("startDate", startDate);
			model.addAttribute("endDate", endDate);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageCount", pageCount);
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/pointHistory";
	}
	
	@RequestMapping(value="/couponHistory/{type}", method=RequestMethod.GET)
	public String getCouponHistory(@PathVariable("type") String type, @RequestParam("page") long page, Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			model.addAttribute("memberDTO", memberDTO);
			
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			model.addAttribute("parentCategory", parentCategory);
			
			long memberPoint = service.getMemberPoint(memberDTO.getId());
			model.addAttribute("memberPoint", memberPoint);
			
			long couponCount = service.getCouponCount(memberDTO.getId(), "available");
			model.addAttribute("couponCount", couponCount);
			
			// 작성 가능한 상품평 개수 불러오기
			List<ProductDTO> writeableList = reviewService.getWriteableReview(memberDTO.getId());
			model.addAttribute("writeableList", writeableList);
			model.addAttribute("writeableCount", writeableList.size());
			
			// 쿠폰의 개수
			long historyCount = service.getCouponCount(memberDTO.getId(), type);
			// 전체 페이지 개수 = 쿠폰의 개수 / 한 페이지에 보여지는 쿠폰의 개수
			long pageCount = historyCount / contentPerPage;
			// 예를 들어, 내역이 101개인 경우, 11개의 페이지가 필요하므로 총 페이지 개수를 증가시켜준다.
			if(historyCount % contentPerPage != 0) pageCount++;
			
			// 시작 페이지 = (현재 페이지-1) / 페이지 블록 크기 * 페이지 블록 크기 + 1
			long startPage = (page-1) / blockPerPage * blockPerPage + 1;
			// 마지막 페이지 (현재 페이지-1) / 페이지 블록 크기 * 페이지 블록 크기 + 페이지 블록 크기
			long endPage = (page-1) / blockPerPage * blockPerPage + blockPerPage;
			// 마지막 페이지 개수가 전체 페이지 개수보다 많은 경우, 마지막 페이지를 전체 페이지 개수로 맞춰준다.
			if(endPage > pageCount) endPage = pageCount;
			
			log.info(startPage+" "+endPage);
			
			List<CouponDTO> couponList = service.getCouponHistory(memberDTO.getId(), type, page);
			model.addAttribute("couponList", couponList);
			model.addAttribute("type", type);
			model.addAttribute("page", page);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageCount", pageCount);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/couponHistory";
	}
	
	@RequestMapping(value="/manageAddress", method=RequestMethod.GET)
	public String getAddressList(Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			model.addAttribute("memberDTO", memberDTO);
			
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			model.addAttribute("parentCategory", parentCategory);
			
			long memberPoint = service.getMemberPoint(memberDTO.getId());
			model.addAttribute("memberPoint", memberPoint);
			
			long couponCount = service.getCouponCount(memberDTO.getId(), "available");
			model.addAttribute("couponCount", couponCount);
			
			// 작성 가능한 상품평 개수 불러오기
			List<ProductDTO> writeableList = reviewService.getWriteableReview(memberDTO.getId());
			model.addAttribute("writeableList", writeableList);
			model.addAttribute("writeableCount", writeableList.size());
			
			DeliveryAddressDTO defaultAddress = service.getDefaultAddress(memberDTO.getId());
			model.addAttribute("defaultAddress", defaultAddress);
			
			List<DeliveryAddressDTO> addressList = service.getAddressList(memberDTO.getId());
			model.addAttribute("addressList", addressList);
			for(DeliveryAddressDTO dto : addressList) {
				log.info(dto);
			}
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/manageAddress";
	}
	
	@ResponseBody
	@RequestMapping(value="/manageAddress/addAddress", method=RequestMethod.POST, consumes=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String addAddress(@RequestBody DeliveryAddressDTO dto, Principal principal) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			dto.setMemberId(memberDTO.getId());
			service.addAddress(dto);
		} catch(Exception e) {
			log.info(e.getMessage());
			return "2";
		}
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value="/manageAddress/updateAddress", method=RequestMethod.POST, consumes=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String updateAddress(@RequestBody DeliveryAddressDTO dto, Principal principal) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			dto.setMemberId(memberDTO.getId());
			service.updateAddress(dto);
		} catch (Exception e) {
			return "2";
		}
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value="/manageAddress/deleteAddress", method=RequestMethod.POST, consumes=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String deleteAddress(@RequestBody List<Integer> list, Principal principal) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			for(long addressId : list) {
				service.deleteAddress(memberDTO.getId(), addressId);
			}
		} catch (Exception e) {
			log.info(e.getMessage());
			return "2";
		}
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value="/manageAddress/setDefault", method=RequestMethod.POST)
	public String setDefault(@RequestParam long addressId, Principal principal) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			service.setDefault(memberDTO.getId(), addressId);
		} catch(Exception e) {
			log.info(e.getMessage());
			return "2";
		}
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value="/manageAddress/cancelDefault", method=RequestMethod.POST)
	public String cancelDefault(@RequestParam long addressId, Principal principal) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			service.cancelDefault(memberDTO.getId());			
		} catch(Exception e) {
			log.info(e.getMessage());
			return "2";
		}
		return "1";
	}
	
	/* *
	 * 작성자 : 경민영
	 * 작업일 : 22.06.04
	 * */
	// 내가 작성한 상품평
	@RequestMapping(value="/myReview", method=RequestMethod.GET)
	public String getMyReview(Model model, Principal principal) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			model.addAttribute("memberDTO", memberDTO);
			
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			model.addAttribute("parentCategory", parentCategory);
			
			long memberPoint = service.getMemberPoint(memberDTO.getId());
			model.addAttribute("memberPoint", memberPoint);
			
			long couponCount = service.getCouponCount(memberDTO.getId(), "available");
			model.addAttribute("couponCount", couponCount);
			
			// 작성 가능한 상품평 개수 불러오기
			List<ProductDTO> writeableList = reviewService.getWriteableReview(memberDTO.getId());
			model.addAttribute("writeableList", writeableList);
			model.addAttribute("writeableCount", writeableList.size());
			
			// 로그인한 회원 아이디로 내가 작성한 상품평 불러오기
			List<ReviewDTO> reviewList = reviewService.getMyReviewList(memberDTO.getId());
			model.addAttribute("reviewList", reviewList);
			log.info(reviewList);
			
			// 상품평 이미지 불러오기
			reviewList.forEach(review -> {
				try {
					List<ImageAttachDTO> attachList = attachService.attachListByReviewID(review.getReviewID());
					review.setAttachList(attachList);
					review.setCategoryID(review.getCategoryID()); // 카테고리 번호
				} catch (Exception e) {
					e.printStackTrace();
				}
			});
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/myReview";
	}
	
	/* *
	 * 작성자 : 경민영
	 * 작업일 : 22.06.05
	 * */
	// 작성 가능한 상품평
	@RequestMapping(value="/writeableReview", method=RequestMethod.GET)
	public String getWriteableReview(Model model, Principal principal) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			model.addAttribute("memberDTO", memberDTO);
			
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			model.addAttribute("parentCategory", parentCategory);
			
			long memberPoint = service.getMemberPoint(memberDTO.getId());
			model.addAttribute("memberPoint", memberPoint);
			
			long couponCount = service.getCouponCount(memberDTO.getId(), "available");
			model.addAttribute("couponCount", couponCount);
			
			// 작성 가능한 상품평 개수 불러오기
			List<ProductDTO> writeableList = reviewService.getWriteableReview(memberDTO.getId());
			model.addAttribute("writeableList", writeableList);
			model.addAttribute("writeableCount", writeableList.size());
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/writeableReview";
	}
	
	@RequestMapping(value="/confirmPassword/{type}", method=RequestMethod.GET)
	public String getConfirmForm(@PathVariable("type") String type, Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			model.addAttribute("memberDTO", memberDTO);
			
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			model.addAttribute("parentCategory", parentCategory);
			
			long memberPoint = service.getMemberPoint(memberDTO.getId());
			model.addAttribute("memberPoint", memberPoint);
			
			long couponCount = service.getCouponCount(memberDTO.getId(), "available");
			model.addAttribute("couponCount", couponCount);
			
			// 작성 가능한 상품평 개수 불러오기
			List<ProductDTO> writeableList = reviewService.getWriteableReview(memberDTO.getId());
			model.addAttribute("writeableList", writeableList);
			model.addAttribute("writeableCount", writeableList.size());
			
			model.addAttribute("type", type);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/confirmPassword";
	}
	
	@RequestMapping(value="/confirmPassword/{type}", method=RequestMethod.POST)
	public String confirmPassword(@PathVariable("type") String type,
		@RequestParam("userPassword") String userPassword, Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			String phoneNum = memberDTO.getPhone().substring(0, 3) + "-"
				+ memberDTO.getPhone().substring(3, 7) + "-" + memberDTO.getPhone().substring(7);
			
			// 작성 가능한 상품평 개수 불러오기
			List<ProductDTO> writeableList = reviewService.getWriteableReview(memberDTO.getId());
			model.addAttribute("writeableList", writeableList);
			model.addAttribute("writeableCount", writeableList.size());
			
			if(service.confirmPassword(userPassword, memberDTO.getPassword())) {
				if(type.equals("changeInfo")) {
					String[] birthdate = memberDTO.getBirthDate().split("-");
					model.addAttribute("birthYear", birthdate[0]);
					model.addAttribute("birthMonth", birthdate[1]);
					model.addAttribute("birthDay", birthdate[2]);
					model.addAttribute("phoneNum", phoneNum);
				}
				model.addAttribute("memberDTO", memberDTO);
				return "mypage/"+type;
			}
			return "redirect:/mypage/confirmPassword/"+type;
		} catch(Exception e) {
			log.info(e.getMessage());
			return "redirect:/mypage/confirmPassword"+type;
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/changePassword", method=RequestMethod.POST)
	public String changePassword(@RequestParam("curPassword") String curPassword,
		@RequestParam("newPassword") String newPassword, Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			
			// 작성 가능한 상품평 개수 불러오기
			List<ProductDTO> writeableList = reviewService.getWriteableReview(memberDTO.getId());
			model.addAttribute("writeableList", writeableList);
			model.addAttribute("writeableCount", writeableList.size());
			
			if(service.changePassword(curPassword, newPassword, memberDTO)) {
				model.addAttribute("memberDTO", memberDTO);
				return "1";
			}
			return "2";
		} catch(Exception e) {
			log.info(e.getMessage());
			return "3";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/changeInfo", method=RequestMethod.POST)
	public String changeInfo(@ModelAttribute UpdateMemberDTO updateDTO, BindingResult result, Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			if(service.changeInfo(updateDTO, memberDTO)) {
				model.addAttribute("memberDTO", memberDTO);
				return "1";
			}
			return "2";
		} catch(Exception e) {
			log.info(e.getMessage());
			return "3";
		}
	}
	
	@RequestMapping(value="/resignMember", method=RequestMethod.GET)
	public String getResignForm(Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			model.addAttribute("memberDTO", memberDTO);
			
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			model.addAttribute("parentCategory", parentCategory);
			
			long memberPoint = service.getMemberPoint(memberDTO.getId());
			model.addAttribute("memberPoint", memberPoint);
			
			long couponCount = service.getCouponCount(memberDTO.getId(), "available");
			model.addAttribute("couponCount", couponCount);
			
			// 작성 가능한 상품평 개수 불러오기
			List<ProductDTO> writeableList = reviewService.getWriteableReview(memberDTO.getId());
			model.addAttribute("writeableList", writeableList);
			model.addAttribute("writeableCount", writeableList.size());
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/resignMember";
	}
	
	
	@RequestMapping(value="/resignMember", method=RequestMethod.POST)
	public String resignMember(@RequestParam("resignDetail") String resignDetail,
		@RequestParam("userPassword") String userPassword, HttpServletRequest request, HttpServletResponse response,  Authentication auth, Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			
			// 작성 가능한 상품평 개수 불러오기
			List<ProductDTO> writeableList = reviewService.getWriteableReview(memberDTO.getId());
			model.addAttribute("writeableList", writeableList);
			model.addAttribute("writeableCount", writeableList.size());
			
			if(service.resignMember(resignDetail, userPassword, memberDTO)) {
				model.addAttribute("memberDTO", memberDTO);
				new SecurityContextLogoutHandler().logout(request, response, auth);
				SecurityContextHolder.getContext().setAuthentication(null);
				
				return "mypage/resignResult";
			}
			return "redirect:/mypage/resignMember";
		} catch(Exception e) {
			log.info(e.getMessage());
			return "redirect:/mypage/resignMember";
		}
	}
	
	@RequestMapping(value="/membershipZone", method=RequestMethod.GET)
	public String loadMembershipZone(Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			model.addAttribute("memberDTO", memberDTO);
			
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			model.addAttribute("parentCategory", parentCategory);
			
			long memberPoint = service.getMemberPoint(memberDTO.getId());
			model.addAttribute("memberPoint", memberPoint);
			
			long couponCount = service.getCouponCount(memberDTO.getId(), "available");
			model.addAttribute("couponCount", couponCount);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/membershipZone";
	}
}