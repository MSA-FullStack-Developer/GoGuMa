package com.ggm.goguma.service.order;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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
	public void paytransaction(TransactionDTO transactionDTO, long memberId) throws Exception {
		
		//1. 결제 상세 테이블에 구매정보가 저장된다.
		orderMapper.saveReceipt(transactionDTO, memberId);
		
		// 결제 상세 번호 가져오기
		long receiptKey = transactionDTO.getReceiptId();
		log.info("receiptKey: " + receiptKey);
		
		//2. 생성된 결제 상세 테이블의 번호로 상품, 상품 수량을 주문 상세에 저장한다. (여러개 가능)
		List<ProductOrderDTO> productOrderList = transactionDTO.getProducts();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("productOrderList", productOrderList);
		map.put("receiptKey", receiptKey);
		
		log.info(map);
		orderMapper.saveOrderDetail(map);
		//2-1. 포인트 이벤트에 주문 상세 번호 별로 적립된 포인트가 적립예정인 상태로 저장된다.
			//주문 상세에서 포인트 적입 예정인 상품들을 담는다.
		List<PointDTO> pointList = orderMapper.getBeforePoint(memberId, receiptKey);
		orderMapper.savePointEvent(pointList);
		//2-2. 포인트를 사용한 경우 포인트 이벤트에 주문상세번호 없이 차감 데이터를 저장한다.
		if(transactionDTO.getUsagePoint() != 0) {
			log.info("포인트를 사용한 경우");
			orderMapper.minusPointEvent(memberId, receiptKey, transactionDTO.getUsagePoint());
		}
		//3. 구매한 상품 수량만큼 상품 수량이 감소 업데이트 된다.
		orderMapper.minusProductStock(map);
		//4. 쿠폰을 사용한 경우 결제 상세테이블에서 회원 ID와 사용한 쿠폰ID로 쿠폰을 사용처리한다.
		
		//5. 장바구니에서 구매한 구매한 상품의 경우 장바구니 목록에서 삭제된다.
		
		//모든 결제 과정 완료
	}

}
