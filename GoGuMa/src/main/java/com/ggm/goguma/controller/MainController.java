package com.ggm.goguma.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	private final ProductService productService;
	
	private final CategoryService categoryService;
	
	@GetMapping("/")
	public String toMain() {
		return "redirect:/main.do";
	}
	
	@GetMapping("/main.do")
	public String main(Model model) {
		
		List<CategoryDTO> categoryList = this.categoryService.getMdsCategoryParentList();
		
		model.addAttribute("categoryList", categoryList);
		return "main/index";
	}
}
