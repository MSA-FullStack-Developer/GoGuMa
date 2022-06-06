package com.ggm.goguma.controller;

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

import com.ggm.goguma.dto.CouponDTO;
import com.ggm.goguma.dto.DeliveryAddressDTO;
import com.ggm.goguma.dto.PointDTO;
import com.ggm.goguma.dto.ReceiptDTO;
import com.ggm.goguma.service.mypage.MyPageService;

import lombok.extern.log4j.Log4j;

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
	
	@RequestMapping(value="", method=RequestMethod.GET)
	public String getMainPage() {
		log.info("페이지 접근 테스트");
		return "mypage/main";
	}
	
	@RequestMapping(value="/orderHistory", method=RequestMethod.GET)
	public String getOrderHistory(Model model) throws Exception {
		try {
			List<ReceiptDTO> receiptHistory = service.getReceiptHistory(1); // 회원ID로 결제정보DTO를 모두 불러오기
			for(ReceiptDTO dto : receiptHistory) {
				log.info(dto);
			}
			model.addAttribute("receiptHistory", receiptHistory);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/orderHistory";
	}
	
	@RequestMapping(value="/orderHistory/{receiptId}", method=RequestMethod.GET)
	public String getOrderDetail(@PathVariable("receiptId") long receiptId, Model model) throws Exception {
		try {
			ReceiptDTO receiptDTO = service.getReceiptDetail(receiptId); // 결제상세 가져오기
			long earnablePoint = service.getEarnablePoint(receiptId);
			model.addAttribute("receiptDTO", receiptDTO);
			model.addAttribute("earnablePoint", earnablePoint);
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
			Model model) throws Exception {
		try {
			// 특정 포인트 내역의 개수
			long historyCount = service.getPointHistoryCount(1, type, startDate, endDate);
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
			
			List<PointDTO> pointHistory = service.getPointHistory(1, type, page, startDate, endDate);
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
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/pointHistory";
	}
	
	@RequestMapping(value="/couponHistory/{type}", method=RequestMethod.GET)
	public String getCouponHistory(@PathVariable("type") String type, @RequestParam("page") long page, Model model) throws Exception {
		try {
			// 특정 쿠폰의 개수
			long couponCount = service.getCouponCount(1, type);
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
			
			List<CouponDTO> couponList = service.getCouponHistory(1, type, page);
			model.addAttribute("couponList", couponList);
			model.addAttribute("type", type);
			model.addAttribute("page", page);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("historyCount", couponCount);
			model.addAttribute("contentPerPage", contentPerPage);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/couponHistory";
	}
	
	@RequestMapping(value="/manageAddress", method=RequestMethod.GET)
	public String getAddressList(Model model) throws Exception {
		try {
			DeliveryAddressDTO defaultAddress = service.getDefaultAddress(1);
			log.info(defaultAddress);
			List<DeliveryAddressDTO> addressList = service.getAddressList(1);
			for(DeliveryAddressDTO dto : addressList) {
				log.info(dto);
			}
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
	
	@RequestMapping(value="/confirmPassword/{type}", method=RequestMethod.GET)
	public String getConfirmForm(@PathVariable("type") String type, Model model) throws Exception {
		try {
			log.info("비밀번호확인 페이지");
			model.addAttribute("type", type);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/confirmPassword";
	}
}