package com.ggm.goguma.controller.order;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
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
import com.ggm.goguma.dto.DeliveryAddressDTO;
import com.ggm.goguma.dto.cart.CartItemDTO;
import com.ggm.goguma.dto.cart.CartOrderDTO;
import com.ggm.goguma.dto.cart.CartOrderListDTO;
import com.ggm.goguma.dto.cart.CartOrderListDTOInfo;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.service.MyPageService;
import com.ggm.goguma.service.cart.CartService;
import com.ggm.goguma.service.member.MemberService;
import com.ggm.goguma.service.order.OrderService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("order")
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MyPageService myPageService;
	
	@RequestMapping(value="/", method = {RequestMethod.POST, RequestMethod.GET})
	public String showOrderList(@ModelAttribute CartOrderDTO cartOrderDTO, Model model, Authentication authentication) throws Exception{
			String memberEmail = "";
			// 사용자가 권한이 있는 경우
			if (authentication != null){
				UserDetails user = (UserDetails)authentication.getPrincipal();
				//사용자 이메일정보를 가져온다.
				memberEmail = user.getUsername();
				//사용자 정보 가져오기
				MemberDTO memberDTO = memberService.getMember(memberEmail);
				log.info("상품 주문에서 사용될 사용자 정보: " + memberDTO);
				// 회원이 담은 카트 리스트를 불러온다.
				long memberId = memberDTO.getId();
				
				if(cartOrderDTO.getCartOrderListDTO() == null) {
					return "redirect:/";
				}
				List<CartOrderListDTO> dtoList = new ArrayList<CartOrderListDTO>();
				//상품 주문 dto에서 선택한 상품만 추려내기 위한 작업
				for(int i = 0; i < cartOrderDTO.getCartOrderListDTO().size(); i++) {
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
				List<CartItemDTO> list = orderService.getOrderList(dtoList);	//주문할 상품을 불러온다.
				
				// 기본 배송지와 저장된 배송지를 불러온다.
				DeliveryAddressDTO defaultAddress = myPageService.getDefaultAddress(1);
				List<DeliveryAddressDTO> addressList = myPageService.getAddressList(1);
				
				model.addAttribute("list", list); // 회원이 담은 카트 정보를 저장한다.
				model.addAttribute("memberDTO", memberDTO); // 회원 정보를 저장한다.
				model.addAttribute("dtoList", dtoList);
				
				model.addAttribute("defaultAddress", defaultAddress);
				model.addAttribute("addressList", addressList);
				
				System.out.println("회원의 정보 : " + memberDTO);
				System.out.println("주문할 상품들의 정보 : " + list);
				System.out.println("주문할 상품 리스트 dtoList : " + dtoList);
				
				log.info("기본 배송지 정보" + defaultAddress);
				log.info("전체 배송지 정보" + addressList);
				return "order";
			}else {
				return "redirect:/";
			}
	}
	
	@RequestMapping(value="/getAllAddressList", method=RequestMethod.POST)
	public void getAllAddressList(Model model) {
		try {
			DeliveryAddressDTO defaultAddress = myPageService.getDefaultAddress(1);
			log.info(defaultAddress);
			List<DeliveryAddressDTO> addressList = myPageService.getAddressList(1);
			for(DeliveryAddressDTO dto : addressList) {
				log.info(dto);
			}
			model.addAttribute("defaultAddress", defaultAddress);
			model.addAttribute("addressList", addressList);
		} catch (Exception e) {
			log.info(e.getMessage());
		}
	}
	
	@PostMapping("/orderResult")
	public String ReceiveFormData()throws Exception {
		
		return "redirect:/";
	}
}
