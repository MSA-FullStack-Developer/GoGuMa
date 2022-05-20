package com.ggm.goguma.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.ProductDTO;
import com.ggm.goguma.service.CategoryService;
import com.ggm.goguma.service.ProductService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/category")
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private CategoryService categoryService;
	
	@GetMapping(value = {"/list/{categoryID}", "/list"})
	public String list(@PathVariable int categoryID, Model model) throws Exception {
		try {
			List<CategoryDTO> parentCategory = categoryService.getCategoryParentList();
			
			parentCategory.forEach(cate -> {
				try {
					List<CategoryDTO> categoryList = categoryService.getCategoryList(cate.getCategoryID());
					cate.setCategoryList(categoryList);
					
					log.info(cate);
					log.info("----------");
					log.info(categoryList);
				} catch (Exception e) {
					e.printStackTrace();
				}
			});
			
			model.addAttribute("parentCategory", parentCategory); // 부모 카테고리 목록
			
			String categoryName = categoryService.getCategoryName(categoryID);
			
			List<ProductDTO> list = productService.getProductList(categoryID);
			long count = productService.getProductCount(categoryID);
			
			model.addAttribute("categoryID", categoryID);
			model.addAttribute("categoryName", categoryName);
			
			model.addAttribute("list", list); // 상품 목록
			model.addAttribute("count", count); // 상품 총 개수
			
			return "list";
		} catch (Exception e) {
			model.addAttribute("msg", "list 출력 에러");
			e.printStackTrace();
			return "list";
		}
	}
	
	@GetMapping("/list/{categoryID}/detail/{productID}")
	public String detail(@PathVariable int categoryID, @PathVariable int productID, Model model) throws Exception {
		try {
			List<CategoryDTO> parentCategory = categoryService.getCategoryParentList();
			
			parentCategory.forEach(cate -> {
				try {
					List<CategoryDTO> categoryList = categoryService.getCategoryList(cate.getCategoryID());
					cate.setCategoryList(categoryList);
					
					log.info(cate);
					log.info("----------");
					log.info(categoryList);
				} catch (Exception e) {
					e.printStackTrace();
				}
			});
			
			model.addAttribute("parentCategory", parentCategory); // 부모 카테고리 목록
			
			String categoryName = categoryService.getCategoryName(categoryID);
			
			model.addAttribute("categoryID", categoryID);
			model.addAttribute("categoryName", categoryName);
			
			ProductDTO productInfo = productService.getProductInfo(productID); // 상품 정보
			model.addAttribute("productInfo", productInfo);
			
			List<ProductDTO> option = productService.getOptionList(productID); // 상품 옵션 목록
			model.addAttribute("option", option);
			
			return "product";
		} catch (Exception e) {
			model.addAttribute("msg", "상품 상세 화면 출력 에러");
			e.printStackTrace();
			return "list";
		}
	}
	
}