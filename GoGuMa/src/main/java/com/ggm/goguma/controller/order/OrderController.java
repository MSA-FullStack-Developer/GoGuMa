package com.ggm.goguma.controller.order;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ggm.goguma.controller.cart.CartController;
import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.DeliveryAddressDTO;
import com.ggm.goguma.dto.cart.CartItemDTO;
import com.ggm.goguma.dto.cart.CartOrderDTO;
import com.ggm.goguma.dto.cart.CartOrderListDTO;
import com.ggm.goguma.dto.cart.TransactionDTO;
import com.ggm.goguma.dto.coupon.MemberCouponOrderDTO;
import com.ggm.goguma.dto.member.IamportCertificateTokenRspDTO.Response;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.service.cart.CartService;
import com.ggm.goguma.service.member.MemberService;
import com.ggm.goguma.service.mypage.MyPageService;
import com.ggm.goguma.service.order.OrderService;
import com.ggm.goguma.service.product.CategoryService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

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
	
	@Autowired
	private CategoryService categoryService;
	
	@RequestMapping(value="/", method = {RequestMethod.POST, RequestMethod.GET})
	public String showOrderList(@ModelAttribute CartOrderDTO cartOrderDTO, Model model, Authentication authentication, BindingResult errors) throws Exception{
		if (errors.hasErrors()) {
			log.info(errors.getAllErrors());
		}
		
		List<CategoryDTO> parentCategory = categoryService.showCategoryMenu();
		model.addAttribute("parentCategory", parentCategory);
		
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
				
				//장바구니를 거치지 않고 상품 구매하는경우
				if(cartOrderDTO.getCartOrderListDTO() == null) {
					 List<CartOrderListDTO> dtoList = new ArrayList<CartOrderListDTO>();
					 dtoList.add(cartOrderDTO.getProductOrder());
					 
					 log.info("오더에서 카트오더 DTO : " + cartOrderDTO); log.info("오더에서 dtoList: " +
					 dtoList);
					 
					 List<CartItemDTO> list = orderService.getOrder(dtoList); //주문할 상품을 불러온다.
					 list.get(0).setCartAmount(cartOrderDTO.getProductOrder().getOrdQty());
					 log.info("단일상품 구매 리스트: " + list); // 기본 배송지와 저장된 배송지를 불러온다.
					 DeliveryAddressDTO defaultAddress = myPageService.getDefaultAddress(memberId); 
					 List<DeliveryAddressDTO> addressList = myPageService.getAddressList(memberId); // 회원이 가진 포인트 조회한다. int
					 int point = myPageService.getMemberPoint(memberId);
					 
					 model.addAttribute("list", list); model.addAttribute("dtoList", dtoList);
					 model.addAttribute("memberDTO", memberDTO); // 회원 정보를 저장한다.
					 model.addAttribute("point", point); //회원이 가진 포인트를 저장한다.
					 model.addAttribute("defaultAddress", defaultAddress);
					 model.addAttribute("addressList", addressList); 
					 return "order";
					 
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
				DeliveryAddressDTO defaultAddress = myPageService.getDefaultAddress(memberId);
				List<DeliveryAddressDTO> addressList = myPageService.getAddressList(memberId);
				System.out.println("리스트 : " + list);
				// 회원이 가진 포인트 조회한다.
				int point = myPageService.getMemberPoint(memberId);
				
				model.addAttribute("point", point);	 //회원이 가진 포인트를 저장한다.
				model.addAttribute("list", list); // 회원이 담은 카트나 단품 상품 정보를 저장한다.
				//총 판매 금액
				//총 멤버십 할인 금액
				model.addAttribute("memberDTO", memberDTO); // 회원 정보를 저장한다.
				model.addAttribute("dtoList", dtoList);
				System.out.println("장바구니에서 선택한 상품 구매를 누른 경우 담기는 상품 리스트: " + dtoList);
				
				model.addAttribute("defaultAddress", defaultAddress);
				model.addAttribute("addressList", addressList);
				
				System.out.println("회원의 정보 : " + memberDTO);
				System.out.println("주문할 상품들의 정보 : " + list);
				
				log.info("기본 배송지 정보" + defaultAddress);
				log.info("전체 배송지 정보" + addressList);
				return "order";
			} else {
				return "redirect:/";
			}
	}
	
	
	//회원 쿠폰 조회
	@PostMapping("api/getMemberCoupon")
	@ResponseBody
	public List<MemberCouponOrderDTO> getMemberCounpon(Authentication authentication, Model model) throws Exception {
		try {
			String memberEmail = "";
				
			UserDetails user = (UserDetails)authentication.getPrincipal();
			//사용자 이메일정보를 가져온다.
			memberEmail = user.getUsername();
			//사용자 정보 가져오기
			MemberDTO memberDTO = memberService.getMember(memberEmail);
			log.info("장바구니에서 사용될 사용자 정보: " + memberDTO);
			long memberId = memberDTO.getId();
			
			List<MemberCouponOrderDTO> couponList = orderService.getMemberCoupon(memberId);
			log.info("조회한 쿠폰 로그: " + couponList);
			
			model.addAttribute("couponList", couponList);
			return couponList;
			
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	private IamportClient api;
	
	@Value("${iamport.restKeyPay}")
	private String payKey;
	@Value("${iamport.secretPay}")
	private String paySecretKey;
	
	//아임포트 결제 검증, 결제 내역 조회
	@ResponseBody
	@RequestMapping(value="api/verifyIamport/{imp_uid}")
	public IamportResponse<Payment> paymentByImpUid(Model model, Locale locale, HttpSession session, @PathVariable(value="imp_uid") String imp_uid) throws IamportResponseException, IOException{
		System.out.println("결제 검증중");
		api = new IamportClient(payKey, paySecretKey);
		
		//imp_uid에 해당하는 거래내역이 있는지 확인한다.
		return api.paymentByImpUid(imp_uid);
	}
	
	@ResponseBody
	@PostMapping("api/paytransaction")
	public void paytransaction(@RequestBody TransactionDTO transactionDTO, Authentication authentication) throws Exception {
		String memberEmail = "";
		UserDetails user = (UserDetails)authentication.getPrincipal();
		//사용자 이메일정보를 가져온다.
		memberEmail = user.getUsername();
		//사용자 정보 가져오기
		MemberDTO memberDTO = memberService.getMember(memberEmail);
		long memberId = memberDTO.getId();
		
		String impUid = transactionDTO.getImpUid();
		log.info("주문 컨트롤러에서 아임포트 결제 번호 : " + impUid);
		// 상품 결제 완료 후 DB에서 필요한 작업 실행
		log.info("주문에서 카트 정보 리스트: " +transactionDTO);
		orderService.paytransaction(transactionDTO, memberId);
		log.info("컨트롤러에서 모든 결제 트랜잭션 처리가 완료됨");
	}
	
	//아임포트 웹훅 url
	@ResponseBody
	@PostMapping("nobankcomplete")
	public void noBankComplete(@RequestBody HashMap<String, Object> webhook_param, HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info("리퀘스트 확인");
		log.info(webhook_param);
		if(webhook_param.get("status").equals("paid")) {
			System.out.println("입금이 확인 되었습니다.");
			//결제 예정이었던 orderdetail의 상품 상태를 N으로 돌려 둔다.
			String impUid = (String)webhook_param.get("imp_uid");
			orderService.checkOrderDetail(impUid);
		}
	}
	
	/*
	 * @PostMapping("/orderResult") public String ReceiveFormData()throws Exception
	 * { return "redirect:/"; }
	 */
	
	@PostMapping("receipt")
	public String receipt(@RequestParam(value="ipUid") String ipUid, Model model) throws IamportResponseException, IOException {

		//결제 번호
		String uid = ipUid.substring(4);
		model.addAttribute("uid", uid);
		
		api = new IamportClient(payKey, paySecretKey);
		
		IamportResponse<Payment> res = api.paymentByImpUid(ipUid);
		Payment p = res.getResponse();
		model.addAttribute("resp", p); 
		
		return "receipt";
	}
}
