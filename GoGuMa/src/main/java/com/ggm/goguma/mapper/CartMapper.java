package com.ggm.goguma.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.cart.CartItemDTO;

public interface CartMapper {

	// 회원이 장바구니에 담은 상품 불러오기
	List<CartItemDTO> getCartList(@Param("memberId") long memberId) throws Exception;

	// 카트 수량 증가
	void addCartCount(@Param("cartId") long cartId) throws Exception;
}
