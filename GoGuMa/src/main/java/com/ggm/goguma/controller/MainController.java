package com.ggm.goguma.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.coupon.MemberCouponDTO;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.exception.CouponCreateException;
import com.ggm.goguma.service.member.MemberService;
import com.ggm.goguma.service.memberCoupon.MemberCouponService;
import com.ggm.goguma.service.product.CategoryService;



import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/")
@RequiredArgsConstructor
@Log4j
public class MainController {

	private final CategoryService categoryService;

	private final MemberCouponService memberCouponService;

	private final MemberService memberService;

	@GetMapping("/")
	public String toMain() {
		return "redirect:/main.do";
	}

	@GetMapping("/main.do")
	public String main(Model model) throws Exception {
		List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
		List<CategoryDTO> categoryList = this.categoryService.getMdsCategoryParentList();

		model.addAttribute("parentCategory", parentCategory);
		model.addAttribute("categoryList", categoryList);
		return "main/index";
	}

	@GetMapping("/event/event1.do")
	public String event(@RequestParam(required = false) String message, Model model) throws Exception {
		
		List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
		model.addAttribute("parentCategory", parentCategory);
		if(message != null) {
			model.addAttribute("message", message);
		}
		return "main/event1";
	}

	@PostMapping("/coupon/create.do/{couponId}")
	public String createCupon(@PathVariable int couponId, @RequestParam String redirectUrl, Principal principal,
			RedirectAttributes ra) throws Exception {

		// 1. ????????? ??????????????? ??????
		if (principal == null) {
			ra.addAttribute("message", "????????? ??? ??????????????????.");
		} else {
			try {
				MemberCouponDTO memberCouponDTO = new MemberCouponDTO();
				MemberDTO member = this.memberService.getMember(principal.getName());

				memberCouponDTO.setMemberId(member.getId());
				memberCouponDTO.setCouponId(couponId);

				this.memberCouponService.createMemberCoupon(memberCouponDTO);
				ra.addAttribute("message", "????????? ?????????????????????. ????????? ???????????????.");
			} catch (CouponCreateException e) {
				ra.addAttribute("message", e.getMessage());
			}
		}

		// 2. ????????? ???????????? ??????
		// 3. ?????? ???????????? ??????
		// 4. ?????? ??????
		// 5. ??? 1,2,3,4 ???????????? ?????? redirectUrl??? redirect ??????

		return "redirect:/" + redirectUrl;
	}
}
