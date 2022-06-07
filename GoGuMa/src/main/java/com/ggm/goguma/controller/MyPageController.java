package com.ggm.goguma.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.DeliveryAddressDTO;
import com.ggm.goguma.dto.ImageAttachDTO;
import com.ggm.goguma.dto.PointDTO;
import com.ggm.goguma.dto.ProductDTO;
import com.ggm.goguma.dto.ReceiptDTO;
import com.ggm.goguma.dto.ReviewDTO;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.service.MyPageService;
import com.ggm.goguma.service.member.MemberService;
import com.ggm.goguma.service.product.CategoryService;
import com.ggm.goguma.service.product.ImageAttachService;
import com.ggm.goguma.service.product.ProductService;
import com.ggm.goguma.service.product.ReviewService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/mypage")
public class MyPageController {
	
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
	
	@RequestMapping(value="", method=RequestMethod.GET)
	public String getMainPage() {
		log.info("페이지 접근 테스트");
		return "mypage/main";
	}
	
	@RequestMapping(value="/orderHistory", method=RequestMethod.GET)
	public String getOrderHistory(Model model) {
		try {
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			List<ReceiptDTO> receiptHistory = service.getReceiptHistory(1); // 회원ID로 결제정보DTO를 모두 불러오기
			for(ReceiptDTO dto : receiptHistory) {
				log.info(dto);
			}
			model.addAttribute("parentCategory", parentCategory);
			model.addAttribute("receiptHistory", receiptHistory);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/orderHistory";
	}
	
	@RequestMapping(value="/orderHistory/{receiptId}", method=RequestMethod.GET)
	public String getOrderDetail(@PathVariable("receiptId") long receiptId, Model model) {
		try {
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			ReceiptDTO receiptDTO = service.getReceiptDetail(receiptId); // 결제상세 가져오기
			PointDTO pointDTO = service.getEarnedPoint(receiptId);
			model.addAttribute("parentCategory", parentCategory);
			model.addAttribute("receiptDTO", receiptDTO);
			model.addAttribute("pointDTO", pointDTO);
			log.info(receiptDTO);
			log.info(pointDTO);
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/orderDetail";
	}
	
	@ResponseBody
	@RequestMapping(value="/orderHistory/updateOrderStatus", method=RequestMethod.POST)
	public String updateOrderStatus(@RequestParam("orderId") long orderId, @RequestParam("status") String status) {
		try {
			log.info(orderId+" "+status);
			service.updateOrderStatus(orderId, status);
		} catch (Exception e) {
			log.info(e.getMessage());
			return "2";
		}
		return "1";
	}
	
	@RequestMapping(value="/manageAddress", method=RequestMethod.GET)
	public String getAddressList(Model model) {
		try {
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			DeliveryAddressDTO defaultAddress = service.getDefaultAddress(1);
			log.info(defaultAddress);
			List<DeliveryAddressDTO> addressList = service.getAddressList(1);
			for(DeliveryAddressDTO dto : addressList) {
				log.info(dto);
			}
			model.addAttribute("parentCategory", parentCategory);
			model.addAttribute("defaultAddress", defaultAddress);
			model.addAttribute("addressList", addressList);
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/manageAddress";
	}
	
	@ResponseBody
	@RequestMapping(value="/manageAddress/addAddress", method=RequestMethod.POST, consumes=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String addAddress(@RequestBody DeliveryAddressDTO dto) throws Exception {
		try {
			log.info(dto);
			dto.setMemberId(1);
			service.addAddress(dto);
		} catch(Exception e) {
			log.info(e.getMessage());
			return "2";
		}
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value="/manageAddress/updateAddress", method=RequestMethod.POST, consumes=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String updateAddress(@RequestBody DeliveryAddressDTO dto) throws Exception {
		try {
			log.info("테스트 : " +dto);
			dto.setMemberId(1);
			service.updateAddress(dto);
		} catch (Exception e) {
			return "2";
		}
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value="/manageAddress/deleteAddress", method=RequestMethod.POST, consumes=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String deleteAddress(@RequestBody List<Integer> list) throws Exception {
		try {
			log.info(list);
			for(long addressId : list) {
				service.deleteAddress(1, addressId);
			}
		} catch (Exception e) {
			log.info(e.getMessage());
			return "2";
		}
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value="/manageAddress/setDefault", method=RequestMethod.POST)
	public String setDefault(@RequestParam long addressId) throws Exception {
		try {
			log.info(addressId);
			service.setDefault(1, addressId);
		} catch(Exception e) {
			log.info(e.getMessage());
			return "2";
		}
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value="/manageAddress/cancelDefault", method=RequestMethod.POST)
	public String cancelDefault(@RequestParam long addressId) throws Exception {
		try {
			log.info(addressId);
			service.cancelDefault(1);			
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
	public String getMyReview(Model model, Authentication authentication) throws Exception {
		try {
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			model.addAttribute("parentCategory", parentCategory);
			
			if (authentication != null) {
				UserDetails user = (UserDetails) authentication.getPrincipal();
				MemberDTO memberDTO = memberService.getMember(user.getUsername());
				model.addAttribute("memberDTO", memberDTO);
				
				// 로그인한 회원 아이디로 내가 작성한 상품평 불러오기
				List<ReviewDTO> reviewList = reviewService.getMyReviewList(memberDTO.getId());
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
				
				model.addAttribute("reviewList", reviewList);
			}
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
	public String getWriteableReview(Model model, Authentication authentication) throws Exception {
		try {
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			model.addAttribute("parentCategory", parentCategory);
			
			if (authentication != null) {
				UserDetails user = (UserDetails) authentication.getPrincipal();
				MemberDTO memberDTO = memberService.getMember(user.getUsername());
				model.addAttribute("memberDTO", memberDTO);
				
				// 작성 가능한 상품평 목록 불러오기
				List<ProductDTO> writeableList = reviewService.getWriteableReview(memberDTO.getId());
				long writeableCount = writeableList.size();
				
				model.addAttribute("writeableList", writeableList);
				model.addAttribute("writeableCount", writeableCount);
			}
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/writeableReview";
	}
	
}