package com.ggm.goguma.service.order;

import java.util.List;

import com.ggm.goguma.dto.cart.CartItemDTO;
import com.ggm.goguma.dto.cart.CartOrderListDTO;
import com.ggm.goguma.dto.cart.TransactionDTO;
import com.ggm.goguma.dto.coupon.MemberCouponOrderDTO;

public interface OrderService {

	List<CartItemDTO> getOrderList(List<CartOrderListDTO> dtoList) throws Exception;

	List<MemberCouponOrderDTO> getMemberCoupon(long memberId) throws Exception;

	void paytransaction(TransactionDTO transactionDTO, long memberId) throws Exception;

	List<CartItemDTO> getOrder(List<CartOrderListDTO> dtoList) throws Exception;
	
}
