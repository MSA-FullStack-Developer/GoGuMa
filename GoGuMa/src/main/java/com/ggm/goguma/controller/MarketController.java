package com.ggm.goguma.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.market.CreateMarketDTO;
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
	public String showMarket(@RequestParam long marketNum, Model model, Principal principal) throws Exception {
		
		MarketDTO market = this.marketService.getMarket(marketNum);
		log.info("[showMarket] market : " + market);
		boolean isMine = false;
		
		if(principal != null) {
			MemberDTO member = this.memberService.getMember(principal.getName());
			if(member.getId() == market.getMemberId()) {
				isMine = true;
			}
		}
		model.addAttribute("isMine", isMine);
		model.addAttribute("market", market);
	
		return "market/showMarket";
	}

	@PostMapping(path =  "/createMarket.do" , consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
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

}
