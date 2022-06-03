package com.ggm.goguma.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

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

}
