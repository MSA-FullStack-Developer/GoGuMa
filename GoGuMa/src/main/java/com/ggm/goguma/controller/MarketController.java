package com.ggm.goguma.controller;

import java.security.Principal;
import java.util.List;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ggm.goguma.amazons3.AmazonS3Utils;
import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.DefaultResponseDTO;
import com.ggm.goguma.dto.ImageAttachDTO;
import com.ggm.goguma.dto.PaginationDTO;
import com.ggm.goguma.dto.market.ArticleProudctDTO;
import com.ggm.goguma.dto.market.CreateArticleDTO;
import com.ggm.goguma.dto.market.CreateMarketDTO;
import com.ggm.goguma.dto.market.EditArticleDTO;
import com.ggm.goguma.dto.market.FollowMarketDTO;
import com.ggm.goguma.dto.market.MarketArticleDTO;
import com.ggm.goguma.dto.market.MarketDTO;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.exception.UploadFileFailException;
import com.ggm.goguma.service.market.MarketService;
import com.ggm.goguma.service.member.MemberService;
import com.ggm.goguma.service.product.CategoryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/market")
@Log4j
public class MarketController {

	private final CategoryService categoryService;

	private final MarketService marketService;

	private final MemberService memberService;
	
	private final AmazonS3Utils amazonService;

	@GetMapping("/main.do")
	public String main() {
		return "market/main";
	}

	@GetMapping("/write.do")
	public String createMarketForm(@RequestParam(required = false) String error, Model model) throws Exception {

		List<CategoryDTO> categoryList = this.categoryService.getCategoryParentList();

		log.info(categoryList);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("error", error);
		return "market/createMarket";
	}

	@GetMapping("/show.do")
	public String showMarket(@RequestParam long marketNum, @RequestParam(defaultValue = "1") long pg, Model model, Principal principal) throws Exception {

		MarketDTO market = this.marketService.getMarket(marketNum);
		log.info("[showMarket] market : " + market);
		boolean isMine = false;
		boolean isAlreadyFollow = false;

		if (principal != null) {
			MemberDTO member = this.memberService.getMember(principal.getName());
			if (member.getId() == market.getMemberId()) {
				isMine = true;
			}
			FollowMarketDTO followMarket = new FollowMarketDTO();
			followMarket.setMarketId(marketNum);
			followMarket.setMemberId(member.getId());
			isAlreadyFollow = this.marketService.isAlreadyFollowMarket(followMarket);
		}

		PaginationDTO<MarketArticleDTO> paginationDTO = this.marketService.getMarketArticles(marketNum, pg);
		
		log.info(paginationDTO);
		
		model.addAttribute("isAlreadyFollow", isAlreadyFollow);
		model.addAttribute("isMine", isMine);
		model.addAttribute("market", market);
		model.addAttribute("pagination", paginationDTO);
		return "market/showMarket";
	}

	@GetMapping("/article/{articleId}/show.do")
	public String showArticle(@PathVariable long articleId, Principal principal, Model model) {

		MarketArticleDTO article = this.marketService.getMarketArticle(articleId);
		
		log.info(article);
		
		boolean isMyArticle = false;
		if(principal != null) {
			MemberDTO member = this.memberService.getMember(principal.getName());
			
			isMyArticle = this.marketService.isMyArticle(article.getMarket().getMarketId(), member.getId(), articleId);
		
		}
		
		
		model.addAttribute("article", article);
		model.addAttribute("isMyArticle", isMyArticle);
		
		return "market/showArticle";
	}

	@GetMapping("/{marketId}/article/write.do")
	public String createArticleForm(@PathVariable long marketId, @RequestParam(required = false) String error, Model model, Principal principal) {
		
		MemberDTO member = this.memberService.getMember(principal.getName());
		
		if(!this.marketService.isMyMarket(marketId, member.getId())) {
			return "error/error403";
		}
		
		if(error != null) model.addAttribute("error", error);
		model.addAttribute("marketId", marketId);
		return "market/createArticle";
	}
	
	@GetMapping("/{marketId}/article/{articleId}/edit.do")
	public String editArticleForm(@PathVariable long marketId, @PathVariable long articleId, Model model, Principal principal) {
		
		MemberDTO member = this.memberService.getMember(principal.getName());
		
		MarketArticleDTO article = this.marketService.getMarketArticle(articleId);
		
		if(!this.marketService.isMyArticle(marketId, member.getId(), articleId)) {
			return "error/error403";
		}
		
		model.addAttribute("article", article);
		return "market/editArticle";
	}

	@GetMapping("/article/searchProudct.do")
	public String searchProduct(@RequestParam(required = false) String keyword, Model model, Principal principal) {

		if (keyword == null) {
			model.addAttribute("keyword", keyword);
			model.addAttribute("products", null);
			return "market/searchMyProduct";
		}

		//String email = "msh1273@gmail.com"; // only for test!!
		String email = principal.getName();

		MemberDTO member = this.memberService.getMember(email);
		List<ArticleProudctDTO> result = this.marketService.getArticleProducts(keyword, member.getId());

		log.info("[searchProduct] result : " + result);
		model.addAttribute("keyword", keyword);
		
		if(result.size() == 0) result = null;
		model.addAttribute("products", result);

		return "market/searchMyProduct";
	}
	
	@PostMapping(value = "/createMarket.do", consumes = { MediaType.MULTIPART_FORM_DATA_VALUE })
	public String createMarket(CreateMarketDTO data, Principal principal, RedirectAttributes ra) throws Exception {

		log.info("[createMarket] CreateMarketDTO : " + data);
		MemberDTO member = this.memberService.getMember(principal.getName());
		data.setMemberId(member.getId());

		try {
			MarketDTO market = this.marketService.createMarket(data);
			log.debug("[createMarket] market : " + market);
			// 만들어진 마켓으로 리다이렉트 하기
			return "redirect:/market/show.do?marketNum=" + market.getMarketId();
		} catch (UploadFileFailException e) {

			e.printStackTrace();
			ra.addAttribute("error", e.getMessage());
			return "redirect:/market/writeForm.do";
		}

	}
	
	@PostMapping(value= "/article/createArticle.do", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public String createArticle(CreateArticleDTO article, Principal principal) throws Exception {
		
		log.info(article);
		MemberDTO member = this.memberService.getMember(principal.getName());
		
		if(!this.marketService.isMyMarket(article.getMarketId(), member.getId())) {
			return "error/error403";
		}
		
		this.marketService.createMarketArticle(article);
		
		return "redirect:/market/show.do?marketNum="+article.getMarketId();
	}
	
	@PostMapping(value= "/article/editArticle.do", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public String editArticle(EditArticleDTO article, Principal principal) throws Exception {
		
		MemberDTO member = this.memberService.getMember(principal.getName());
	
		
		if(!this.marketService.isMyArticle(article.getMarketId(), member.getId(), article.getArticleId())) {
			return "error/error403";
		}
		
		this.marketService.editMarketArticle(article);
		
		return "redirect:/market/article/" + article.getArticleId() + "/show.do";
	}

	@PostMapping(value = "/api/updateFollow.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public DefaultResponseDTO updateFollowMarket(@RequestParam long marketId, Principal principal) {

		log.info("[updateFollowMarket] marketId : " + marketId);

		MemberDTO member = this.memberService.getMember(principal.getName());

		FollowMarketDTO followMarket = new FollowMarketDTO();
		followMarket.setMarketId(marketId);
		followMarket.setMemberId(member.getId());

		boolean isCreated = this.marketService.createOrDeleteFollowMarket(followMarket);

		String message = isCreated ? "follow" : "cancel";

		return DefaultResponseDTO.builder().status(200).message(message).build();

	}
	

	
	@PostMapping(value = "/api/uploadArticleImage.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<ImageAttachDTO> uploadImage(MultipartFile file) throws Exception {
		String[] uploadResult = this.amazonService.uploadFile("upload", file);
		
		ImageAttachDTO attachDTO = new ImageAttachDTO();
		attachDTO.setImageName(uploadResult[0]);
		attachDTO.setImagePath(uploadResult[1]);
		
		
		return new ResponseEntity<>(attachDTO, HttpStatus.CREATED);
	}

}
