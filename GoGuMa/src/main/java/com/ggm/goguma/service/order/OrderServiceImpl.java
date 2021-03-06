package com.ggm.goguma.service.order;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ggm.goguma.dto.PointDTO;
import com.ggm.goguma.dto.cart.CartItemDTO;
import com.ggm.goguma.dto.cart.CartOrderListDTO;
import com.ggm.goguma.dto.cart.ProductOrderDTO;
import com.ggm.goguma.dto.cart.TransactionDTO;
import com.ggm.goguma.dto.coupon.MemberCouponOrderDTO;
import com.ggm.goguma.mapper.OrderMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Override
	public List<CartItemDTO> getOrderList(List<CartOrderListDTO> dtoList) throws Exception {
		return orderMapper.getOrderList(dtoList);
	}

	@Override
	public List<MemberCouponOrderDTO> getMemberCoupon(long memberId) throws Exception {
		return orderMapper.getMemberCoupon(memberId);
	}

	@Transactional
	@Override
	public void paytransaction(TransactionDTO transactionDTO, long memberId , int pointPercent) throws Exception {
		log.info("transactionDTO : " + transactionDTO);
		
		//1. 결제 상세 테이블에 구매정보가 저장된다.
		orderMapper.saveReceipt(transactionDTO, memberId);
		
		// 결제 상세 번호 가져오기
		long receiptKey = transactionDTO.getReceiptId();
		
		//2. 생성된 결제 상세 테이블의 번호로 상품, 상품 수량을 주문 상세에 저장한다. (여러개 가능)
		List<ProductOrderDTO> productOrderList = transactionDTO.getProducts();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("productOrderList", productOrderList);
		map.put("receiptKey", receiptKey);
		
		log.info(map);
		//주문 완료 상태라면 N으로 저장
		System.out.println("서비스 로직에서 보는 현재 결제 상태 : " + transactionDTO.getStatus());
		if(transactionDTO.getStatus().equals("paid")) {
			log.info("정상적으로 paid상태이고, orderDetail에 저장합니다.");
			orderMapper.saveOrderDetail(map);
		}else {
			//주문 완료가 아니라면 (ready 상태) V로 저장
			log.info("현재 무통장이라서 여기서 보여요");
			orderMapper.saveOrderDetailVbank(map);
		}
		
		//2-1. 포인트 이벤트에 주문 상세 번호 별로 적립된 포인트가 적립예정인 상태로 저장된다.
		//주문 상세에서 포인트 적입 예정인 상품들을 담는다.
		List<PointDTO> pointList = orderMapper.getBeforePoint(memberId, receiptKey);
		//포인트 적립률이 0%가 아니라면 저장한다.
		if(pointPercent != 0) {
			orderMapper.savePointEvent(pointList);
		}
		//2-2. 포인트를 사용한 경우 포인트 이벤트에 주문상세번호 없이 차감 데이터를 저장한다.
		if(transactionDTO.getUsagePoint() != 0) {
			log.info("포인트를 사용한 경우");
			orderMapper.minusPointEvent(memberId, receiptKey, transactionDTO.getUsagePoint());
		}
		//3. 구매한 상품 수량만큼 상품 수량이 감소 업데이트 된다.
		orderMapper.minusProductStock(map);
		
		//4. 쿠폰을 사용한 경우 결제 상세테이블에서 회원 ID와 사용한 쿠폰ID로 쿠폰을 사용처리한다.
		 if(transactionDTO.getCouponId() != 0){
			 log.info("쿠폰을 사용한 경우");
			 orderMapper.usageCoupon(memberId, transactionDTO.getCouponId());
		 }
		//5. 장바구니에서 구매한 구매한 상품의 경우 장바구니 목록에서 삭제된다.
		log.info("오더서비스에서 상품 정보 : " + transactionDTO.getProducts());
		for(int i=0; i<transactionDTO.getProducts().size(); i++) {
			if(transactionDTO.getProducts().get(i).getCartId() != 0) {
				log.info("결제완료후 장바구니 삭제");
				long cartId = transactionDTO.getProducts().get(i).getCartId();
				orderMapper.deleteCartOrder(cartId);
			}
		}
		//모든 결제 과정 완료
	}

	
	//단일 상품 바로 구매
	@Override
	public List<CartItemDTO> getOrder(List<CartOrderListDTO> dtoList) throws Exception {
		return orderMapper.getOrder(dtoList);
	}

	@Override
	public void checkOrderDetail(String impUid) throws Exception {
		orderMapper.checkOrderDetail(impUid);
	}

}
