package com.ggm.goguma.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.CouponDTO;
import com.ggm.goguma.dto.DeliveryAddressDTO;
import com.ggm.goguma.dto.ImageAttachDTO;
import com.ggm.goguma.dto.PointDTO;
import com.ggm.goguma.dto.ProductDTO;
import com.ggm.goguma.dto.ReceiptDTO;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.dto.ReviewDTO;
import com.ggm.goguma.service.member.MemberService;
import com.ggm.goguma.service.product.CategoryService;
import com.ggm.goguma.service.product.ImageAttachService;
import com.ggm.goguma.service.product.ReviewService;
import com.ggm.goguma.service.mypage.MyPageService;

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
	
//	@Value("${blockPerPage}")
	private int blockPerPage=10; // 한 페이지에 보여지는 페이지 블록의 개수
	
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
	public String getMyPageMain(Principal principal, Model model) throws Exception {
		MemberDTO memberDTO = memberService.getMember(principal.getName());
		model.addAttribute("memberDTO", memberDTO);
		return "mypage/main";
	}
	
	@RequestMapping(value="/orderHistory", method=RequestMethod.GET)
	public String getOrderHistory(Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			List<ReceiptDTO> receiptHistory = service.getReceiptHistory(memberDTO.getId()); // 회원ID로 결제정보DTO를 모두 불러오기
			for(ReceiptDTO dto : receiptHistory) {
				log.info(dto);
			}
			model.addAttribute("parentCategory", parentCategory);
			model.addAttribute("receiptHistory", receiptHistory);
			model.addAttribute("memberDTO", memberDTO);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/orderHistory";
	}
	
	@RequestMapping(value="/orderHistory/{receiptId}", method=RequestMethod.GET)
	public String getOrderDetail(@PathVariable("receiptId") long receiptId, Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			ReceiptDTO receiptDTO = service.getReceiptDetail(receiptId); // 결제상세 가져오기
			long earnablePoint = service.getEarnablePoint(receiptId);
			model.addAttribute("parentCategory", parentCategory);
			model.addAttribute("receiptDTO", receiptDTO);
			model.addAttribute("earnablePoint", earnablePoint);
			model.addAttribute("memberDTO", memberDTO);
			log.info(receiptDTO);
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/orderDetail";
	}

	@ResponseBody
	@RequestMapping(value="/orderHistory/updateOrderStatus", method=RequestMethod.POST)
	public String updateOrderStatus(@RequestParam("orderId") long orderId, @RequestParam("status") String status) throws Exception {
		try {
			log.info(orderId+" "+status);
			service.updateOrderStatus(orderId, status);
		} catch (Exception e) {
			log.info(e.getMessage());
			return "2";
		}
		return "1";
	}
	
	@RequestMapping(value="/pointHistory/{type}", method=RequestMethod.GET)
	public String getPointHistory(@PathVariable("type") String type, @RequestParam("page") long page,
		@RequestParam(value="startDate", required=false) String startDate,
		@RequestParam(value="endDate", required=false) String endDate,
		Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			// 특정 포인트 내역의 개수
			long historyCount = service.getPointHistoryCount(memberDTO.getId(), type, startDate, endDate);
			// 전체 페이지 개수 = 전체 페이지 개수 / 한 페이지에 보여지는 내역의 수
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
			model.addAttribute("parentCategory", parentCategory);
			model.addAttribute("pointHistory", pointHistory);
			model.addAttribute("type", type);
			model.addAttribute("page", page);
			model.addAttribute("startDate", startDate);
			model.addAttribute("endDate", endDate);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("historyCount", historyCount);
			model.addAttribute("contentPerPage", contentPerPage);
			model.addAttribute("memberDTO", memberDTO);
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/pointHistory";
	}
	
	@RequestMapping(value="/couponHistory/{type}", method=RequestMethod.GET)
	public String getCouponHistory(@PathVariable("type") String type, @RequestParam("page") long page, Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			// 특정 쿠폰의 개수
			long couponCount = service.getCouponCount(memberDTO.getId(), type);
			// 전체 페이지 개수 = 전체 페이지 개수 / 한 페이지에 보여지는 내역의 수
			long pageCount = couponCount / contentPerPage;
			// 예를 들어, 내역이 101개인 경우, 11개의 페이지가 필요하므로 총 페이지 개수를 증가시켜준다.
			if(couponCount % contentPerPage != 0) pageCount++;
			
			// 시작 페이지 = (현재 페이지-1) / 페이지 블록 크기 * 페이지 블록 크기 + 1
			long startPage = (page-1) / blockPerPage * blockPerPage + 1;
			// 마지막 페이지 (현재 페이지-1) / 페이지 블록 크기 * 페이지 블록 크기 + 페이지 블록 크기
			long endPage = (page-1) / blockPerPage * blockPerPage + blockPerPage;
			// 마지막 페이지 개수가 전체 페이지 개수보다 많은 경우, 마지막 페이지를 전체 페이지 개수로 맞춰준다.
			if(endPage > pageCount) endPage = pageCount;
			
			List<CouponDTO> couponList = service.getCouponHistory(memberDTO.getId(), type, page);
			model.addAttribute("parentCategory", parentCategory);
			model.addAttribute("couponList", couponList);
			model.addAttribute("type", type);
			model.addAttribute("page", page);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("historyCount", couponCount);
			model.addAttribute("contentPerPage", contentPerPage);
			model.addAttribute("memberDTO", memberDTO);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/couponHistory";
	}
	
	@RequestMapping(value="/manageAddress", method=RequestMethod.GET)
	public String getAddressList(Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			DeliveryAddressDTO defaultAddress = service.getDefaultAddress(memberDTO.getId());
			List<DeliveryAddressDTO> addressList = service.getAddressList(memberDTO.getId());
			for(DeliveryAddressDTO dto : addressList) {
				log.info(dto);
			}
			model.addAttribute("parentCategory", parentCategory);
			model.addAttribute("defaultAddress", defaultAddress);
			model.addAttribute("addressList", addressList);
			model.addAttribute("memberDTO", memberDTO);
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
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			model.addAttribute("parentCategory", parentCategory);
			
			MemberDTO memberDTO = memberService.getMember(principal.getName());
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
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			model.addAttribute("parentCategory", parentCategory);
			
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			model.addAttribute("memberDTO", memberDTO);
			
			// 작성 가능한 상품평 목록 불러오기
			List<ProductDTO> writeableList = reviewService.getWriteableReview(memberDTO.getId());
			long writeableCount = writeableList.size();
			
			model.addAttribute("writeableList", writeableList);
			model.addAttribute("writeableCount", writeableCount);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/writeableReview";
	}
	
	
	@RequestMapping(value="/confirmPassword/{type}", method=RequestMethod.GET)
	public String getConfirmForm(@PathVariable("type") String type, Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			model.addAttribute("parentCategory", parentCategory);
			model.addAttribute("type", type);
			model.addAttribute("memberDTO", memberDTO);
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
			if(service.confirmPassword(userPassword, memberDTO.getPassword())) {
				if(type.equals("changeInfo")) {
					String[] birthdate = memberDTO.getBirthDate().split("-");
					model.addAttribute("memberDTO", memberDTO);
					model.addAttribute("birthYear", birthdate[0]);
					model.addAttribute("birthMonth", birthdate[1]);
					model.addAttribute("birthDay", birthdate[2]);
					model.addAttribute("phoneNum", phoneNum);
				}
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
		@RequestParam("newPassword") String newPassword, Principal principal) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			if(service.changePassword(curPassword, newPassword, memberDTO)) return "1";
			return "2";
		} catch(Exception e) {
			log.info(e.getMessage());
			return "3";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/changeInfo", method=RequestMethod.POST)
	public String changeInfo(@RequestParam("birthDate") String birthDate, @RequestParam("gender") String gender,
		@RequestParam("userPassword") String userPassword, Principal principal) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			if(service.changeInfo(birthDate, gender, userPassword, memberDTO)) return "1";
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
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/resignMember";
	}
	
	@RequestMapping(value="/resignMember", method=RequestMethod.POST)
	public String resignMember(@RequestParam("resignDetail") String resignDetail,
		@RequestParam("userPassword") String userPassword, Principal principal, Model model) throws Exception {
		try {
			MemberDTO memberDTO = memberService.getMember(principal.getName());
			if(service.resignMember(resignDetail, userPassword, memberDTO)) {
				model.addAttribute("memberDTO", memberDTO);
				return "mypage/resignResult";
			}
			return "redirect:/mypage/resignMember";
		} catch(Exception e) {
			log.info(e.getMessage());
			return "redirect:/mypage/resignMember";
		}
	}
}