package com.ggm.goguma.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.PointDTO;
import com.ggm.goguma.dto.cart.CartItemDTO;
import com.ggm.goguma.dto.cart.CartOrderListDTO;
import com.ggm.goguma.dto.cart.ProductOrderDTO;
import com.ggm.goguma.dto.cart.TransactionDTO;
import com.ggm.goguma.dto.coupon.MemberCouponOrderDTO;

public interface OrderMapper {

	List<CartItemDTO> getOrderList(List<CartOrderListDTO> dtoList) throws Exception;

	List<MemberCouponOrderDTO> getMemberCoupon(long memberId) throws Exception;

	void saveReceipt(@Param("transactionDTO") TransactionDTO transactionDTO, @Param("memberId")long memberId) throws Exception;

	void saveOrderDetail(HashMap<String, Object> map)throws Exception;

	// 포인트 적립예정인 주문 리스트
	List<PointDTO> getBeforePoint(@Param("memberId")long memberId,  @Param("receiptKey")long receiptKey)throws Exception;

	//포인트 적립하기
	void savePointEvent(List<PointDTO> pointList)throws Exception;

	//포인트를 사용한 경우 타입이 usage인 포인트 저장
	void minusPointEvent(@Param("memberId")long memberId, @Param("receiptKey")long receiptKey, @Param("point")int point) throws Exception;

	//상품 재고량 감소
	void minusProductStock(HashMap<String, Object> map)throws Exception;

	void usageCoupon(@Param("memberId")long memberId, @Param("couponId")long couponId)throws Exception;

	List<CartItemDTO> getOrder(List<CartOrderListDTO> dtoList)throws Exception;

	void deleteCartOrder(@Param("cartId") long cartId)throws Exception;

	void saveOrderDetailVbank(HashMap<String, Object> map)throws Exception;

	void checkOrderDetail(@Param("impUid") String impUid)throws Exception;

}
