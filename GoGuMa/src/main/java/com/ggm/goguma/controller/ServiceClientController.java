package com.ggm.goguma.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.ReceiptDTO;
import com.ggm.goguma.dto.ServiceClientDTO;
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
			
			// 사용자가 로그인 한 경우
			if(authentication != null) {
				UserDetails user = (UserDetails)authentication.getPrincipal();
				// 사용자 이메일정보를 가져온다.
				memberEmail = user.getUsername();
				// 사용자 정보 가져오기
				MemberDTO memberDTO = memberService.getMember(memberEmail);
				log.info("고객센터에서 사용될 사용자 정보: " + memberDTO);
				
				model.addAttribute("memberDTO", memberDTO);
				model.addAttribute("parentCategory", parentCategory);
			}
			// 로그인을 하지 않은 경우
			else {
				
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
				// 사용자 이메일정보를 가져온다.
				memberEmail = user.getUsername();
				// 사용자 정보 가져오기
				MemberDTO memberDTO = memberService.getMember(memberEmail);
				
				// 카테고리 문의 유형 가져오기
				List<ServiceCategoryDTO> scDtoList = new ArrayList<ServiceCategoryDTO>();
				scDtoList = serviceClientService.getSCategory();
				log.info("고객센터 카테고리 리스트" + scDtoList);
				model.addAttribute("memberDTO", memberDTO);
				model.addAttribute("scDtoList", scDtoList);
				
				// 주문내역조회
				// List<ReceiptDTO> rcpt = myPageService.getReceiptList(memberDTO.getId(), 1); //회원ID로 결제정보DTO를 모두 불러오기
				long mp = myPageService.getReceiptCount(memberDTO.getId());
				// 최대 필요한 페이지 수
				int maxPages = (int) ((mp / 10) + 1);
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
			// 사용자 이메일정보를 가져온다.
			memberEmail = user.getUsername();
			// 사용자 정보 가져오기
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
			// 사용자 이메일정보를 가져온다.
			memberEmail = user.getUsername();
			// 사용자 정보 가져오기
			MemberDTO memberDTO = memberService.getMember(memberEmail);
			long memberId = memberDTO.getId();
			serviceClientDTO.setMemberID(memberId);
			log.info(serviceClientDTO);
			serviceClientService.insertQna(serviceClientDTO);
		} catch (Exception e) {
			e.printStackTrace();
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
				long recordCount = serviceClientService.getQnaCount(memberDTO.getId());
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
	
	/* *
	 * 작성자 : 경민영
	 * 작성일 : 2022.06.11
	 * 수정자 : 문석호
	 * 수정내용 : 자주묻는 질문 검색기능 추가
	 * */
	// 자주 묻는 질문
	@GetMapping("/faqList/{pg}")
	public String faqList(@PathVariable long pg, @RequestParam(value="keyword", required=false, defaultValue="") String keyword, Model model, Authentication authentication)throws Exception{
		try {
			String memberEmail = "";
			if (authentication != null){
				UserDetails user = (UserDetails) authentication.getPrincipal();
				memberEmail = user.getUsername();
				
				MemberDTO memberDTO = memberService.getMember(memberEmail);
				model.addAttribute("memberDTO", memberDTO);
			}
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			long recordCount = 0;
			List<ServiceClientDTO> faqList;
			// 검색한 경우
			if(keyword != "") {
				log.info(keyword);
				// 키워드에 맞는 질문 갯수를 리턴
				recordCount = serviceClientService.keywordCount(keyword);
				// 키워드에 맞는 리스트를 가져온다.
				faqList = serviceClientService.searchKeyword(keyword, pg);
			}else {	// 검색하지 않은 경우
				// 페이징을 위한 갯수
				recordCount = serviceClientService.getFaqCount();
				// 자주 묻는 질문 내역 불러오기
				faqList = serviceClientService.getFaqList(pg);
			}
			long pageCount = recordCount / pageSize; // 총 페이지 수
			if (recordCount % pageSize != 0) pageCount++;
			
			// 하단부에 보여줄 페이지 번호
			long startPage = (pg - 1) / blockSize * blockSize + 1;
			long endPage = startPage + blockSize - 1 ; 
			if (endPage > pageCount) endPage = pageCount;
			
			model.addAttribute("faqKeyword", keyword);
			model.addAttribute("parentCategory", parentCategory);
			model.addAttribute("faqList", faqList);
			model.addAttribute("pg", pg);
			model.addAttribute("recordCount", recordCount);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);

			return "servicecnsl/faqList";
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@PostMapping("chatbot")
	public void chatbot() {
		log.info("챗봇 포스트 로그! : ");
	}
	
}