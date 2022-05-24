package com.ggm.goguma.controller.order;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ggm.goguma.controller.cart.CartController;
import com.ggm.goguma.dto.cart.CartItemDTO;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("order")
public class OrderController {

	@GetMapping("/")
	public void showOrderList(Model model) throws Exception{
		try {
			log.info("하하");
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@PostMapping("/orderResult")
	public String ReceiveFormData()throws Exception {
		
		return "redirect:/";
	}
	
}
