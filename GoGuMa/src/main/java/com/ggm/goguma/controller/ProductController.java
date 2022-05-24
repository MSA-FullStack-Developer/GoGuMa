package com.ggm.goguma.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.ProductDTO;
import com.ggm.goguma.service.CategoryService;
import com.ggm.goguma.service.ProductService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/category/{pg}")
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Value("${pageSize}")
	private long pageSize;
	
	@Value("${blockSize}")
	private long blockSize;
	
	@GetMapping("/{categoryID}")
	public String list(@PathVariable long pg, @PathVariable long categoryID, Model model) throws Exception {
		try {
			showCategoryMenu(categoryID, model);
			
			// 페이징
			long recordCount = productService.getProductCount(categoryID); // 카테고리별 상품 개수
			long pageCount = recordCount / pageSize; // 총 페이지 수
			if (recordCount % pageSize != 0) pageCount ++;
			
			// 하단부에 보여줄 페이지 번호
			long startPage = (pg - 1) / blockSize * blockSize + 1;
			long endPage = startPage + blockSize - 1; 
			if (endPage > pageCount) endPage = pageCount;
			
			List<ProductDTO> list = productService.getProductList(pg, categoryID); // 카테고리별 상품 목록

			model.addAttribute("pg", pg);
			model.addAttribute("recordCount", recordCount);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("list", list);
			
			return "list";
		} catch (Exception e) {
			model.addAttribute("msg", "list 출력 에러");
			return "list";
		}
	}
	
	@GetMapping("/{categoryID}/detail/{productID}")
	public String detail(@PathVariable long categoryID, @PathVariable long productID, Model model) throws Exception {
		try {
			showCategoryMenu(categoryID, model);
			
			ProductDTO productInfo = productService.getProductInfo(productID); // 상품 정보
			List<ProductDTO> option = productService.getOptionList(productID); // 상품 옵션 목록
			long optionCount = productService.getOptionCount(productID); // 상품 옵션 개수

			model.addAttribute("productInfo", productInfo);
			model.addAttribute("option", option);
			model.addAttribute("optionCount", optionCount);
			
			return "product";
		} catch (Exception e) {
			model.addAttribute("msg", "상품 상세 화면 출력 에러");
			return "product";
		}
	}
	
	// 카테고리 메뉴
	public void showCategoryMenu(long categoryID, Model model) throws Exception {
		String categoryName = categoryService.getCategoryName(categoryID);
		List<CategoryDTO> parentCategory = categoryService.getCategoryParentList(); // 부모 카테고리 목록
		
		parentCategory.forEach(cate -> {
			try {
				List<CategoryDTO> categoryList = categoryService.getCategoryList(cate.getCategoryID());
				cate.setCategoryList(categoryList);
				
				log.info(cate);
				log.info(categoryList);
			} catch (Exception e) {
				e.printStackTrace();
			}
		});

		model.addAttribute("categoryID", categoryID);
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("parentCategory", parentCategory);
	}
	
}