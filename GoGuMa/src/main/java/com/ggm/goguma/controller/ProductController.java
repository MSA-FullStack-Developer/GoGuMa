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
@RequestMapping("/category/{pg}/")
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private CategoryService categoryService;
	
	private long pageSize = 1;
	private long blockSize = 4;
	
	@GetMapping(value = {"/{categoryID}", "/"})
	public String list(@PathVariable long pg, @PathVariable long categoryID, Model model) throws Exception {
		try {
			// 페이징
			long recordCount = productService.getProductCount(categoryID); // 카테고리에 해당하는 상품의 개수
			long pageCount = recordCount / pageSize; // 총 페이지 수 (쪽 수) 
			if (recordCount % pageSize != 0) pageCount ++;
			
			// 하단부에 보여줄 페이지 번호
			long startPage = (pg - 1) / blockSize * blockSize + 1;
			long endPage = startPage + blockSize - 1; 
			
			if (endPage > pageCount) { // 마지막 페이지인 경우
				endPage = pageCount;
			}
			
			// 카테고리 메뉴
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
			
			// 자식 카테고리 (카테고리별 상품)
			String categoryName = categoryService.getCategoryName(categoryID); // 목록 화면 상단에 보여줄 카테고리 이름
			
			List<ProductDTO> list = productService.getProductList(pg, categoryID); // 카테고리에 해당하는 상품의 목록
			
			model.addAttribute("categoryID", categoryID);
			model.addAttribute("categoryName", categoryName);

			model.addAttribute("list", list);
			model.addAttribute("recordCount", recordCount);
			
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("pg", pg);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageSize", pageSize);
			
			return "list";
		} catch (Exception e) {
			model.addAttribute("msg", "list 출력 에러");
			e.printStackTrace();
			return "list"; // return "redirect:경로";
		}
	}
	
	@GetMapping("/{categoryID}/detail/{productID}")
	public String detail(@PathVariable long categoryID, @PathVariable long productID, Model model) throws Exception {
		try {
			// 카테고리 메뉴
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