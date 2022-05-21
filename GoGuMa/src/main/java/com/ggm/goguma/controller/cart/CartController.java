package com.ggm.goguma.controller.cart;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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
import com.ggm.goguma.mapper.CartMapper;
import com.ggm.goguma.service.cart.CartService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("cart")
public class CartController {

	@Autowired
	private CartService cartService;
	

	public CartController(CartService cartService) {
		this.cartService = cartService;
	}
	
	
	@GetMapping("/")
	public String cartList( Model model) throws Exception{
		try {
			int memberId = 1;
			// 회원이 담은 카트 리스트를 불러온다.
			List<CartItemDTO> list = cartService.getCartList(memberId);
			model.addAttribute("list", list);
			
			// 로그인한 회원 정보를 가져온다.
			
			list.forEach(c -> System.out.println(c));
			return "cartList";
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	
	@PostMapping("addCartCount")
	@ResponseBody
	public void addCartCount(@RequestParam String cartId) throws Exception{
		try {
			log.info("컨트롤러 장바구니 수량 증가 카트 아이디:" + cartId);
			long cartid = Long.parseLong(cartId);
			cartService.addCartCount(cartid);
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@PostMapping("minusCartCount")
	@ResponseBody
	public void minusCartCount(@RequestParam String cartId) throws Exception{
		try {
			log.info("컨트롤러 장바구니 수량 감소 카트아이디:" + cartId);
			long cartid = Long.parseLong(cartId);
			cartService.minusCartCount(cartid);
			
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
