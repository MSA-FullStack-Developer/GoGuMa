package com.ggm.goguma.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ggm.goguma.dto.ProductDTO;
import com.ggm.goguma.service.product.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequiredArgsConstructor
@Log4j
@RequestMapping("/api/v1/product")
public class ProductRestController {

	private final ProductService productService;
	
	@GetMapping
	public List<ProductDTO> getProductsByCategoryId(@RequestParam int categoryId) {
		
		List<ProductDTO> list = this.productService.getSameParentCategoryProductList(categoryId);
		
		return list;
	}
	
}
