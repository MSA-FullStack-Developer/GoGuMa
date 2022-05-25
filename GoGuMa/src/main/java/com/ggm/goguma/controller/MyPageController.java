package com.ggm.goguma.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggm.goguma.dto.DeliveryAddressDTO;
import com.ggm.goguma.service.MyPageService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/mypage")
public class MyPageController {
	@Autowired
	private MyPageService service;
	
	@RequestMapping(value="", method=RequestMethod.GET)
	public String getMainPage() {
		log.info("페이지 접근 테스트");
		return "mypage/main";
	}
	
	@RequestMapping(value="/manageAddress/{memberid}", method=RequestMethod.GET)
	public String getAddressList(@PathVariable("memberid") int memberid, Model model) {
		try {
			DeliveryAddressDTO defaultAddress = service.getDefaultAddress(memberid);
			log.info(defaultAddress);
			List<DeliveryAddressDTO> addressList = service.getAddressList(memberid);
			for(DeliveryAddressDTO dto : addressList) {
				log.info(dto.getAddressId()+" "+dto.getNickName()+" "+dto.getRecipient()+" "+dto.getAddress()+" "+dto.getContact());
			}
			model.addAttribute("addressList", addressList);
			model.addAttribute("defaultAddress", defaultAddress);
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/manageAddress";
	}
	
	@ResponseBody
	@RequestMapping(value="/manageAddress/{memberId}", method=RequestMethod.POST,
		consumes=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String getDeleteAddressId(@PathVariable("memberId") int memberId, 
		@RequestBody List<Integer> list, Model model) throws Exception {
		try {
			log.info(list);
			for(int addressId : list) {
				service.deleteAddress(addressId);
			}
		} catch (Exception e) {
			log.info(e.getMessage());
			return "2";
		}
		return "1";
	}
}