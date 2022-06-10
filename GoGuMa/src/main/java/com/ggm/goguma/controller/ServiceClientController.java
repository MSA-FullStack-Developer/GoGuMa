package com.ggm.goguma.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ggm.goguma.constant.Role;
import com.ggm.goguma.controller.cart.CartController;
import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.cart.CartItemDTO;
import com.ggm.goguma.dto.cart.CartOrderListDTO;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.dto.serviceClient.ServiceCategoryDTO;
import com.ggm.goguma.service.member.MemberService;
import com.ggm.goguma.service.serviceClient.ServiceClientService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("serviceclient")
public class ServiceClientController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ServiceClientService serviceClientService;
	
	@GetMapping("/")
	public String cartList(Model model, Authentication authentication) throws Exception {
		try {
			String memberEmail = "";
			//사용자가 로그인 한 경우
			if(authentication != null) {
				UserDetails user = (UserDetails)authentication.getPrincipal();
				//사용자 이메일정보를 가져온다.
				memberEmail = user.getUsername();
				//사용자 정보 가져오기
				MemberDTO memberDTO = memberService.getMember(memberEmail);
				log.info("고객센터에서 사용될 사용자 정보: " + memberDTO);
				
				model.addAttribute("memberDTO", memberDTO);
			}
			//로그인을 하지 않은 경우
			else {
				
			}
			return "servicecnsl/serviceclient";
		}
		catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@GetMapping("oneCnslPup")
	public String oneCnslPup(Model model, Authentication authentication)throws Exception{
		try {
			String memberEmail = "";
			// 사용자가 권한이 있는 경우
			if (authentication != null){
				UserDetails user = (UserDetails)authentication.getPrincipal();
				//사용자 이메일정보를 가져온다.
				memberEmail = user.getUsername();
				//사용자 정보 가져오기
				MemberDTO memberDTO = memberService.getMember(memberEmail);
				
				//카테고리 문의 유형 가져오기
				List<ServiceCategoryDTO> scDtoList = new ArrayList<ServiceCategoryDTO>();
				scDtoList = serviceClientService.getSCategory();
				log.info("고객센터 카테고리 리스트" + scDtoList);
				model.addAttribute("memberDTO", memberDTO);
				model.addAttribute("scDtoList", scDtoList);
				
				return "servicecnsl/oneCnslPup";
			}else {
				// 로그인 안된 상태라면 사용자 로그인 창으로 이동
				return "redirect:../member/login.do";
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw e;
		}
	}
}
