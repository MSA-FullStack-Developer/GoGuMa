package com.ggm.goguma.controller;

import java.util.List;
import java.util.Map;
import java.util.Arrays;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.ggm.goguma.dto.member.ContractDTO;
import com.ggm.goguma.dto.member.CreateMemberDTO;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.exception.CreateMemberFailException;
import com.ggm.goguma.exception.NoCertificationException;
import com.ggm.goguma.exception.NotFoundMemberExcption;
import com.ggm.goguma.service.contract.ContractService;
import com.ggm.goguma.service.member.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
@Log4j
public class MemberController {

	private final MemberService memberService;

	private final ContractService contractService;

	@Value("${iamport.code}")
	private String iamportCode;

	@GetMapping("/join/start.do")
	public String joinStart(Model model) {

		UUID uuid = UUID.randomUUID();
		String merchantUid = uuid.toString();
		model.addAttribute("code", this.iamportCode);
		model.addAttribute("merchantUid", merchantUid);

		return "member/joinStart";
	}

	@GetMapping("/join/already.do")
	public String joinAlready(HttpServletRequest request, Model model) {

		Map<String, ?> redirectMap = RequestContextUtils.getInputFlashMap(request);
		MemberDTO member = null;
		if (redirectMap != null) {
			member = (MemberDTO) redirectMap.get("member"); // 오브젝트 타입이라 캐스팅해줌

		}
		log.info(member);
		if (member == null)
			throw new NoCertificationException();

		model.addAttribute("email", member.getEmail());
		model.addAttribute("name", member.getName());
		model.addAttribute("joinDate", member.getJoinDate());
		
		return "member/joinAlready";
	}

	@PostMapping("/join/form.do")
	public String joinForm(@RequestParam("impUid") String impUid, RedirectAttributes ra, Model model) {

		MemberDTO member = this.memberService.getMemberInfoFromIamport(impUid);

		try {

			MemberDTO savedMember = this.memberService.getMember(member.getName(), member.getPhone());

			log.info("[certificateMember] savedMember : " + savedMember);

			ra.addFlashAttribute("member", savedMember);

			return "redirect:/member/join/already.do";

		} catch (NotFoundMemberExcption e) {

			List<ContractDTO> contracts = this.contractService.getAllContracts();

			model.addAttribute("member", member);
			model.addAttribute("contracts", contracts);

			return "member/joinForm";
		}

	}

	@PostMapping("/join/create.do")
	public String createMember(@Valid CreateMemberDTO input, BindingResult br,
			@RequestParam("agreement") String agreements, Model model) throws CreateMemberFailException {

		log.info("[createMember] input : " + input);
		log.info("[createMember] agreements : " + agreements);

		if (br.hasErrors()) {
			model.addAttribute("error", br.getErrorCount());
			return "member/joinForm";
		}

		input.setAgreements(Arrays.stream(agreements.split(",")).mapToInt(Integer::parseInt).toArray());

		this.memberService.createMember(input);

		return "member/joinResult";
	}
}
