package com.ggm.goguma.controller;

import java.util.List;
import java.io.IOException;
import java.util.ArrayList;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;

import com.ggm.goguma.amazons3.AmazonS3Utils;
import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.ImageAttachDTO;
import com.ggm.goguma.dto.ProductDTO;
import com.ggm.goguma.dto.ReviewDTO;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.service.member.MemberService;
import com.ggm.goguma.service.product.CategoryService;
import com.ggm.goguma.service.product.ImageAttachService;
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
	
	private final ImageAttachService attachService;
	
	private final MemberService memberService;
	
	private final AmazonS3Utils amazonService;
	
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
	public String detail(@PathVariable long categoryID, @PathVariable long productID, Model model, Authentication authentication) throws Exception {
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
			
			// 상품평 목록 이미지 불러오기
			reviewList.forEach(review -> {
				try {
					List<ImageAttachDTO> attachList = attachService.attachListByReviewID(review.getReviewID());
					review.setAttachList(attachList);
				} catch (Exception e) {
					e.printStackTrace();
				}
			});
			
			if (authentication != null) {
				UserDetails user = (UserDetails) authentication.getPrincipal();
				MemberDTO memberDTO = memberService.getMember(user.getUsername());
				model.addAttribute("memberDTO", memberDTO);
			}
	
			model.addAttribute("parentCategory", parentCategory);
			model.addAttribute("categoryID", categoryID);
			model.addAttribute("categoryName", categoryName);
			model.addAttribute("productInfo", productInfo);
			model.addAttribute("optionList", optionList);
			model.addAttribute("optionCount", optionCount);
			model.addAttribute("reviewList", reviewList);
			model.addAttribute("productID", productID);
			return "product";
		} catch (Exception e) {
			e.printStackTrace();
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
	@ResponseBody
	@PostMapping(value="/insertReview", consumes=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String insertReview(@RequestBody ReviewDTO reviewDTO, Authentication authentication) throws Exception{
		try {
			if (authentication != null) {
				log.info("상품평 이미지 목록 : " + reviewDTO.getAttachList());
				
				if (reviewDTO.getAttachList() != null) {
					reviewDTO.getAttachList().forEach(attach -> log.info(attach));
				}
				
				reviewService.insertReview(reviewDTO);
				
				return "1";
			}
			
			return "2";
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	// 상품평 삭제
	@PostMapping("/deleteReview")
	@ResponseBody
	public Boolean deleteReview(@RequestParam("reviewID") long reviewID, Authentication authentication) throws Exception {
		try {
			if (authentication != null) {
				// 상품평 이미지 삭제
				List<ImageAttachDTO> attachList = attachService.attachListByReviewID(reviewID);
				attachList.forEach(review -> {
					try {
						amazonService.deleteFile(review.getImageName());
					} catch (Exception e) {
						e.printStackTrace();
					}
				});
				
				// 상품평 삭제
				reviewService.deleteReview(reviewID);
				
				return true;
			}
			return false;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload Ajax");
	}
	
	@PostMapping(value = "uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<ImageAttachDTO>> uploadAjaxPost(MultipartFile[] uploadFile) throws IOException{
		List<ImageAttachDTO> list = new ArrayList<>();
		
		for (MultipartFile multipartFile : uploadFile) {
			// 파일 업로드
			String[] uploadResult = amazonService.uploadFile("upload", multipartFile);

			ImageAttachDTO attachDTO = new ImageAttachDTO();
			attachDTO.setImageName(uploadResult[0]);
			attachDTO.setImagePath(uploadResult[1]);
			
			list.add(attachDTO);
		}
		
		log.info(list);
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@PostMapping("deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String imageName) {
		amazonService.deleteFile(imageName);
		
		return new ResponseEntity<String>("deleted",HttpStatus.OK);
	}
	
}