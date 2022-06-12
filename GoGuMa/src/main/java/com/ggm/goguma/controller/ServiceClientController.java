package com.ggm.goguma.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggm.goguma.constant.Role;
import com.ggm.goguma.controller.cart.CartController;
import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.ReceiptDTO;
import com.ggm.goguma.dto.ServiceClientDTO;
import com.ggm.goguma.dto.cart.CartItemDTO;
import com.ggm.goguma.dto.cart.CartOrderListDTO;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.dto.serviceClient.ServiceCategoryDTO;
import com.ggm.goguma.service.member.MemberService;
import com.ggm.goguma.service.mypage.MyPageService;
import com.ggm.goguma.service.product.CategoryService;
import com.ggm.goguma.service.serviceClient.ServiceClientService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("serviceclient")
public class ServiceClientController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private ServiceClientService serviceClientService;
	
	@Autowired
	private MyPageService myPageService;
	
	private long pageSize  = 10; 
	private long blockSize = 10;
	
	@GetMapping("/")
	public String cartList(Model model, Authentication authentication) throws Exception {
		try {
			String memberEmail = "";
			
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			model.addAttribute("parentCategory", parentCategory);
			
			//사용자가 로그인 한 경우
			if(authentication != null) {
				UserDetails user = (UserDetails)authentication.getPrincipal();
				//사용자 이메일정보를 가져온다.
				memberEmail = user.getUsername();
				//사용자 정보 가져오기
				MemberDTO memberDTO = memberService.getMember(memberEmail);
				log.info("고객센터에서 사용될 사용자 정보: " + memberDTO);
				
				model.addAttribute("memberDTO", memberDTO);
				model.addAttribute("parentCategory", parentCategory);
			}
			//로그인을 하지 않은 경우
			else {
				return "redirect:../../member/login.do";
			}
			return "servicecnsl/serviceclient";
		}
		catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@RequestMapping(value="oneCnslPup", method={RequestMethod.GET})
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
				
				//주문내역조회
				List<ReceiptDTO> rcpt = myPageService.getReceiptList(memberDTO.getId()); //회원ID로 결제정보DTO를 모두 불러오기
				
				//최대 필요한 페이지 수
				int maxPages = (rcpt.size() / 10) + 1;
				model.addAttribute("maxPages", maxPages);
				
				List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
				model.addAttribute("parentCategory", parentCategory);
				
				return "servicecnsl/oneCnslPup";
			}else {
				// 로그인 안된 상태라면 사용자 로그인 창으로 이동
				return "redirect:../../member/login.do";
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw e;
		}
	}
	
	@PostMapping("api/oneCnslPup")
	@ResponseBody
	public List<ReceiptDTO> receiptHis(@RequestParam(value="pages") int pages, Authentication authentication)throws Exception{
		try {
			String memberEmail = "";
			// 사용자가 권한이 있는 경우
			UserDetails user = (UserDetails)authentication.getPrincipal();
			//사용자 이메일정보를 가져온다.
			memberEmail = user.getUsername();
			//사용자 정보 가져오기
			MemberDTO memberDTO = memberService.getMember(memberEmail);
			
			List<ReceiptDTO> receiptHistory = myPageService.getReceiptHistoryPages(memberDTO.getId(), pages); //페이지와 회원ID로 결제정보DTO를 모두 불러오기
			return receiptHistory;
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	@PostMapping("api/inquiry")
	@ResponseBody
	public void inquiry(ServiceClientDTO serviceClientDTO, Authentication authentication)throws Exception{
		try {
			String memberEmail = "";
			// 사용자가 권한이 있는 경우
			UserDetails user = (UserDetails)authentication.getPrincipal();
			//사용자 이메일정보를 가져온다.
			memberEmail = user.getUsername();
			//사용자 정보 가져오기
			MemberDTO memberDTO = memberService.getMember(memberEmail);
			long memberId = memberDTO.getId();
			serviceClientDTO.setMemberID(memberId);
			log.info(serviceClientDTO);
			serviceClientService.insertQna(serviceClientDTO);
		}catch (Exception e) {
			// TODO: handle exception
		}
	}
	/* *
	 * 작성자 : 경민영
	 * 작성일 : 2022.06.11
	 * */
	// 내 상담내역 조회
	@GetMapping("/myService/{pg}")
	public String myService(@PathVariable long pg, Model model, Authentication authentication)throws Exception{
		try {
			String memberEmail = "";
			if (authentication != null){
				UserDetails user = (UserDetails) authentication.getPrincipal();
				memberEmail = user.getUsername();
				
				MemberDTO memberDTO = memberService.getMember(memberEmail);
				List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
				
				// 내 상담내역 불러오기
				List<ServiceClientDTO> myQnaList = serviceClientService.getQnaList(pg, memberDTO.getId());
				log.info(myQnaList);
				
				// 페이징
				long recordCount = serviceClientService.getQnaCount(memberDTO.getId()); // 카테고리별 상품 개수
				long pageCount = recordCount / pageSize; // 총 페이지 수
				if (recordCount % pageSize != 0) pageCount++;
				
				// 하단부에 보여줄 페이지 번호
				long startPage = (pg - 1) / blockSize * blockSize + 1;
				long endPage = startPage + blockSize - 1; 
				if (endPage > pageCount) endPage = pageCount;
				
				model.addAttribute("memberDTO", memberDTO);
				model.addAttribute("parentCategory", parentCategory);
				model.addAttribute("myQnaList", myQnaList);
				model.addAttribute("pg", pg);
				model.addAttribute("recordCount", recordCount);
				model.addAttribute("pageSize", pageSize);
				model.addAttribute("pageCount", pageCount);
				model.addAttribute("startPage", startPage);
				model.addAttribute("endPage", endPage);
				
				return "servicecnsl/myService";
			} else {
				return "redirect:../../member/login.do"; // 로그인 화면으로 이동
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
