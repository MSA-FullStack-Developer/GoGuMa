package com.ggm.goguma.controller.order;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ggm.goguma.controller.cart.CartController;
import com.ggm.goguma.dto.cart.CartItemDTO;
import com.ggm.goguma.dto.cart.CartOrderDTO;
import com.ggm.goguma.dto.cart.CartOrderListDTO;
import com.ggm.goguma.dto.cart.CartOrderListDTOInfo;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("order")
public class OrderController {

	@RequestMapping(value="/", method = {RequestMethod.POST, RequestMethod.GET})
	public void showOrderList(@ModelAttribute CartOrderDTO cartOrderDTO, Model model) throws Exception{
		try {
			List<CartOrderListDTO> dtoList = new ArrayList<CartOrderListDTO>();
			
			//상품 주문 dto에서 선택한 상품만 추려내기 위한 작업
			for(int i = 0; i < cartOrderDTO.getCartOrderListDTO().size(); i++) {
				log.info(i);
				if(cartOrderDTO.getCartOrderListDTO().get(i).getItemSelect() != 0) {
					CartOrderListDTO nListDTO = new CartOrderListDTO();
					nListDTO.setCartId(cartOrderDTO.getCartOrderListDTO().get(i).getCartId());
					nListDTO.setItemSelect(cartOrderDTO.getCartOrderListDTO().get(i).getItemSelect());
					nListDTO.setOrdQty(cartOrderDTO.getCartOrderListDTO().get(i).getOrdQty());
					nListDTO.setProductSock(cartOrderDTO.getCartOrderListDTO().get(i).getProductSock());
					nListDTO.setNrmOriPrc(cartOrderDTO.getCartOrderListDTO().get(i).getNrmOriPrc());
					nListDTO.setDisOriPrc(cartOrderDTO.getCartOrderListDTO().get(i).getDisOriPrc());
					nListDTO.setTotOriPrc(cartOrderDTO.getCartOrderListDTO().get(i).getTotOriPrc());
					dtoList.add(nListDTO);
				}
			}
			System.out.println("잉? : " + dtoList);
			
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
