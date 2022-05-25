package com.ggm.goguma.controller.cart;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggm.goguma.dto.cart.CartDTO;
import com.ggm.goguma.dto.cart.CartItemDTO;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.mapper.CartMapper;
import com.ggm.goguma.service.cart.CartService;
import com.ggm.goguma.service.member.MemberService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("cart")
public class CartController {

	@Autowired
	private CartService cartService;
	
	@Autowired
	private MemberService memberService;

	/*
	 * public CartController(CartService cartService) { this.cartService =
	 * cartService; }
	 */

	@GetMapping("/")
	public String cartList(Model model, Authentication authentication) throws Exception {
		try {
			String memberEmail = "";
			// 사용자가 권한이 있는 경우
			if (authentication != null){
				UserDetails user = (UserDetails)authentication.getPrincipal();
				//사용자 이메일정보를 가져온다.
				memberEmail = user.getUsername();
				//사용자 정보 가져오기
				MemberDTO memberDTO = memberService.getMember(memberEmail);
				log.info("장바구니에서 사용될 사용자 정보: " + memberDTO);
				// 회원이 담은 카트 리스트를 불러온다.
				long memberId = memberDTO.getId();
				List<CartItemDTO> list = cartService.getCartList(memberId);
				
				model.addAttribute("list", list); // 회원이 담은 카트 정보를 저장한다.
				model.addAttribute("memberDTO", memberDTO); // 회원이 담은 카트 정보를 저장한다.
				//출력 테스트
				list.forEach(c -> System.out.println(c));
			}	
			
			return "cartList";
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@GetMapping("goToOrder")
	public String order() throws Exception {
		return "redirect:/order/";
	}

	@PostMapping("addCartCount")
	@ResponseBody
	public void addCartCount(@RequestParam("cartId") String cartId) throws Exception {
		try {
			log.info("컨트롤러 장바구니 수량 증가 카트 아이디:" + cartId);
			long cartid = Long.parseLong(cartId);
			cartService.addCartCount(cartid);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@PostMapping("minusCartCount")
	@ResponseBody
	public void minusCartCount(@RequestParam("cartId") String cartId) throws Exception {
		try {
			log.info("컨트롤러 장바구니 수량 감소 카트아이디:" + cartId);
			long cartid = Long.parseLong(cartId);
			cartService.minusCartCount(cartid);

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@PostMapping("delete")
	@ResponseBody
	public void delete(@RequestParam("cartId") String cartId) throws Exception {
		try {
			log.info("컨트롤러 장바구니 삭제할 카트 아이디:" + cartId);
			long cartid = Long.parseLong(cartId);
			cartService.deleteCart(cartid);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	// 장바구니 담기
	@PostMapping("insertCart")
	@ResponseBody
	public void insertCart(@RequestParam("productId") long productId, @RequestParam("cartAmount") int cartAmount)throws Exception{
		try {
			cartService.insertCart(productId, cartAmount);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
