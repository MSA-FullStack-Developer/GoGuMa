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
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.ProductDTO;
import com.ggm.goguma.dto.ReviewDTO;
import com.ggm.goguma.service.product.CategoryService;
import com.ggm.goguma.service.product.ProductService;
import com.ggm.goguma.service.product.ReviewService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/category/{pg}")
@RequiredArgsConstructor
public class ProductController {
	
	private final ProductService productService;
	
	private final CategoryService categoryService;
	
	private final ReviewService reviewService;
	
	private long pageSize  = 12; 
	private long blockSize = 10;
	
	@GetMapping("/{categoryID}")
	public String list(@PathVariable long pg, @PathVariable long categoryID, @RequestParam(defaultValue="recent") String sortType, Model model) throws Exception {
		try {
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			
			// 페이징
			long recordCount = productService.getProductCount(categoryID); // 카테고리별 상품 개수
			long pageCount = recordCount / pageSize; // 총 페이지 수
			if (recordCount % pageSize != 0) pageCount ++;
			
			// 하단부에 보여줄 페이지 번호
			long startPage = (pg - 1) / blockSize * blockSize + 1;
			long endPage = startPage + blockSize - 1; 
			if (endPage > pageCount) endPage = pageCount;
			
			String categoryName = categoryService.getCategoryName(categoryID); // 카테고리 이름
			List<ProductDTO> list = productService.getProductList(pg, categoryID, sortType); // 카테고리별 상품 목록

			model.addAttribute("parentCategory", parentCategory);
			model.addAttribute("keyword", ""); // 검색 키워드를 빈 문자열로 지정
			model.addAttribute("categoryID", categoryID);
			model.addAttribute("categoryName", categoryName);
			model.addAttribute("pg", pg);
			model.addAttribute("recordCount", recordCount);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("list", list);
			model.addAttribute("sortType", sortType);
			model.addAttribute("isSearch", false);
			
			return "list";
		} catch (Exception e) {
			model.addAttribute("msg", "list 출력 에러");
			return "list";
		}
	}
	
	@GetMapping("/{categoryID}/detail/{productID}")
	public String detail(@PathVariable long categoryID, @PathVariable long productID, Model model) throws Exception {
		try {
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();

			// 상품 상세 정보 불러오기
			String categoryName = categoryService.getCategoryName(categoryID); // 카테고리 이름
			ProductDTO productInfo = productService.getProductInfo(productID); // 상품 정보
			List<ProductDTO> optionList = productService.getOptionList(productID); // 상품 옵션 목록
			long optionCount = productService.getOptionCount(productID); // 상품 옵션 개수
			
			// 상품평 불러오기
			List<ReviewDTO> reviewList = reviewService.getReviewList(productID);
			log.info(reviewList);
			
			// 상품평을 작성할 수 있는 조건 (= 상품평 쓰기 버튼이 보이는 조건)
			// 1. 사용자가 권한이 있고,								: memberService.getMember(user.getUsername()) != null
			// 2. 해당 상품을 '구매확정'한 경우						:
			// 2. 이전에 해당 상품의 상품평을 작성한 적이 없는 경우 : reviewService.isExistReview(memberDTO.getId(), productID) < 1
			
			model.addAttribute("parentCategory", parentCategory);
			model.addAttribute("categoryID", categoryID);
			model.addAttribute("categoryName", categoryName);
			model.addAttribute("productInfo", productInfo);
			model.addAttribute("optionList", optionList);
			model.addAttribute("optionCount", optionCount);
			model.addAttribute("reviewList", reviewList);
			
			return "product";
		} catch (Exception e) {
			model.addAttribute("msg", "상품 상세 화면 출력 에러");
			return "product";
		}
	}
	
	@GetMapping("/search/")
	public String search(@RequestParam(defaultValue="") String keyword, @RequestParam(defaultValue="recent") String sortType, Model model) throws Exception {
		try {
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			
			List<ProductDTO> list = productService.getSearchList(keyword, sortType);
			long searchCount = productService.getSearchCount(keyword);

			model.addAttribute("parentCategory", parentCategory);
			model.addAttribute("keyword", keyword);
			model.addAttribute("list", list);
			model.addAttribute("recordCount", searchCount);
			model.addAttribute("pg", 1);
			model.addAttribute("sortType", sortType);
			model.addAttribute("isSearch", true);
			
			return "list";
		} catch (Exception e) {
			model.addAttribute("msg", "list 출력 에러");
			return "list";
		}
	}
	
	// 상품평 작성
	@PostMapping("/insertReview")
	@ResponseBody
	public Boolean insertReview(@RequestParam("productID") long productID, @RequestParam("memberID") long memberID, @RequestParam("content") String content, Authentication authentication) throws Exception{
		try {
			if (authentication != null) {
				reviewService.insertReview(productID, memberID, content);
				return true;
			}
			
			return false;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
}