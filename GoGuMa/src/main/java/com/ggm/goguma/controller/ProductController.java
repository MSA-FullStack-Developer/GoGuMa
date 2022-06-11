package com.ggm.goguma.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
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
	
	/*
	 * @작성자 : 송진호
	 * @작업내용 : 쿠키에 존재하는 값들을 불러오는 기능 구현
	 * @작성일자 : 2022.06.09
	 */
	public List<String> getSeenProductList(HttpServletRequest request) throws UnsupportedEncodingException {
		// 기존에 존재하는 쿠키들을 가져옴
		Cookie[] cookies = request.getCookies();
		
		// 최근에 본 상품 리스트 선언
		List<String> list = null;
		
		// 쿠키가 하나라도 존재하면
		if(cookies != null) {
			// 가져온 쿠키 중에서
			for(Cookie cookie : cookies) {
				// 이름이 'latelySeenProducts'인 쿠키를 찾으면
				if(cookie.getName().equals("seenProducts")) {
					// 쿠키의 값을 쉼표로 구분해서 리스트 형식으로 저장
					String[] arr = (URLDecoder.decode(cookie.getValue(), "utf-8")).split(",");
					list = new ArrayList<>(Arrays.asList(arr));
				}
			}
		}
		
		return list;
	}
	
	/*
	 * @작성자 : 송진호
	 * @작업내용 : 불러온 값들을 쿠키에 넣어주는 기능 구현
	 * @작성일자 : 2022.06.09
	 */
	public void setCookie(String productId, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		// 리스트에 있는 값들을 문자열로 연결시켜주기 위한 변수
		String value = "";
		
		// 쿠키에 존재하는 최근 본 상품 리스트를 불러옴
		List<String> list = getSeenProductList(request);
		
		// 쿠키를 통해서 불러온 최근 본 상품 리스트에 값이 없다면
		if(list == null) value += productId;
		else {
			// 리스트에 productId 값을 새로 추가
			if(!list.contains(productId)) list.add(productId);
			// 리스트에 있는 값들을 문자열로 연결
			for(String item : list) {
				value += item+",";
			}
		}
		
		// 쿠키에 값들을 문자열로 연결해서 만든 value 값을 저장
		if(!value.equals("")) {
			Cookie cookie = new Cookie("seenProducts", URLEncoder.encode(value, "utf-8"));
			cookie.setPath(request.getContextPath());
			cookie.setMaxAge(-1);
			response.addCookie(cookie);
		}
	}
	
	@GetMapping("/{categoryID}")
	public String list(@PathVariable long pg, @PathVariable long categoryID, @RequestParam(defaultValue="recent") String sortType, Model model) throws Exception {
		try {
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			
			// 페이징
			long recordCount = productService.getProductCount(categoryID); // 카테고리별 상품 개수
			long pageCount = recordCount / pageSize; // 총 페이지 수
			if (recordCount % pageSize != 0) pageCount++;
			
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
	public String detail(@PathVariable long categoryID, @PathVariable long productID, HttpServletRequest request,
		HttpServletResponse response, Model model, Authentication authentication) throws Exception {
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
			
			/**
			 * @작성자 : 송진호
			 * @작업내용 : productID를 매개변수로 받아서 쿠키에 값 추가
			 * @작성일자 : 2022.06.09
			 */
			setCookie(Long.toString(productID), request, response);
	
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
	public String search(@RequestParam(defaultValue="") String keyword, 
							@RequestParam(defaultValue="recent") String sortType, 
							HttpServletRequest request, Model model) throws Exception {
		try {
			List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
			
			List<ProductDTO> list = productService.getSearchList(keyword, sortType);
			long searchCount = productService.getSearchCount(keyword);
			
			if (searchCount == 0) { // 검색결과가 없는 경우
				// 최근 본 상품과 관련된 카테고리 상품 최신순으로 추천해주기
				List<ProductDTO> recommendList = new ArrayList<>();
				Cookie[] cookies = request.getCookies();
				if (cookies != null) {
					for (Cookie cookie : cookies) {
						if(cookie.getName().equals("latelySeenProducts")) {
							String[] productIdArr = (URLDecoder.decode(cookie.getValue(), "utf-8")).split(",");
							long parentCID = categoryService.getCategoryId(Long.parseLong(productIdArr[productIdArr.length-1])); // 최근 본 상품의 부모 카테고리 번호
							recommendList = productService.getSameParentCategoryProductList(parentCID); // 추천 상품 목록
						}
					}
				}
				
				model.addAttribute("recommendList", recommendList);
			}
			
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
	@PostMapping(value="api/insertReview", consumes=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String insertReview(@RequestBody ReviewDTO reviewDTO) throws Exception{
		try {
			log.info("상품평 이미지 목록 : " + reviewDTO.getAttachList());
			
			if (reviewDTO.getAttachList() != null) {
				reviewDTO.getAttachList().forEach(attach -> log.info(attach));
			}
			
			reviewService.insertReview(reviewDTO);
			
			return "1";
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	// 상품평 삭제
	@PostMapping("api/deleteReview")
	@ResponseBody
	public Boolean deleteReview(@RequestParam("reviewID") long reviewID) throws Exception {
		try {
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
	
	
	// 상품평 이미지 불러오기
	@GetMapping(value="getAttachList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<ImageAttachDTO>> getAttachList(long reviewID) throws Exception {
		List<ImageAttachDTO> attachList = attachService.attachListByReviewID(reviewID);
		log.info(attachList);
		
		return new ResponseEntity<>(attachList, HttpStatus.OK);
	}
	
	// 상품평 수정하기
	@ResponseBody
	@PostMapping(value="api/update", consumes=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String updateBoard(@RequestBody ReviewDTO reviewDTO) throws Exception {
		try {
			log.info("상품평 이미지 목록 : " + reviewDTO.getAttachList());
			
			if (reviewDTO.getAttachList() != null) {
				reviewDTO.getAttachList().forEach(attach -> log.info(attach));
			}
			
			reviewService.updateReview(reviewDTO);
			
			return "1";
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
}