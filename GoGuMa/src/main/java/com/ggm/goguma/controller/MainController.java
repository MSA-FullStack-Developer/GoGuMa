package com.ggm.goguma.controller;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.service.CategoryService;
import com.ggm.goguma.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/")
@RequiredArgsConstructor
@Log4j
public class MainController {
	
	private final CategoryService categoryService;
	
	@GetMapping("/")
	public String toMain() {
		return "redirect:/main.do";
	}
	
	@GetMapping("/main.do")
	public String main(Model model) throws Exception {
		List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
		List<CategoryDTO> categoryList = this.categoryService.getMdsCategoryParentList();
		
		model.addAttribute("parentCategory", parentCategory);
		model.addAttribute("categoryList", categoryList);
		return "main/index";
	}
	
	@GetMapping("/event/event1.do")
	public String event(Model model) {
		return "main/event1";
	}
	
	@PostMapping("/coupon/create.do/{couponId}")
	public String createCupon(@PathVariable int cuponId, @RequestParam String redirectUrl, Authentication authentication, RedirectAttributes ra) {
	
		
		//1. 인증된 사용자인지 확인
		
		//2. 유효한 쿠폰인지 확인
		//3. 발급 받았는지 확인
		//4. 쿠폰 발급
		//5. 각 1,2,3,4 메시지와 함께 redirectUrl로 redirect 하기
		return "";
	}
}
