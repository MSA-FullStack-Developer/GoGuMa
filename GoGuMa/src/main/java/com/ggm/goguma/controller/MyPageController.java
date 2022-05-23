package com.ggm.goguma.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
		log.info("ㅍㅇㅈ ㅈㄱ ㅌㅅㅌ");
		return "mypage/main";
	}
	
	@RequestMapping(value="/manageAddress/{memberid}", method=RequestMethod.GET)
	public String getDeliveryAddressList(@PathVariable("memberid") int memberid) {
		log.info("페이지 접근 테스트");
		try {
			List<DeliveryAddressDTO> list = service.getDeliveryAddressList(memberid);
			for(DeliveryAddressDTO dto : list) {
				log.info(dto.nickName+" "+dto.recipient+" "+dto.address+" "+dto.contact);
			}
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return "mypage/manageAddress";
	}
}
