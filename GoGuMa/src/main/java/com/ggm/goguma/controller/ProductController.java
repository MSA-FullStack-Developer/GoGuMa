package com.ggm.goguma.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ggm.goguma.dto.ProductDTO;
import com.ggm.goguma.service.ProductService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/category")
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@GetMapping("/")
	public String list(Model model) throws Exception {
		try {
			List<ProductDTO> list = productService.getProductList();
			long count = productService.getProductCount();
			
			model.addAttribute("list", list); // 상품 목록
			model.addAttribute("count", count); // 상품 총 개수
			
			System.out.println(count);
			return "category";
		} catch (Exception e) {
			model.addAttribute("msg", "list 출력 에러");
			return "category";
		}
	}
	
}