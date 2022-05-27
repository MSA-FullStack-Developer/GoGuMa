package com.ggm.goguma.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.cart.CartItemDTO;

public interface CartMapper {

	// 회원이 장바구니에 담은 상품 불러오기
	List<CartItemDTO> getCartList(@Param("memberId") long memberId) throws Exception;

	// 카트 수량 증가
	void addCartCount(@Param("cartId") long cartId) throws Exception;

	void minusCartCount(@Param("cartId") long cartId) throws Exception;

	void deleteCart(@Param("cartId") long cartId) throws Exception;

	void insertCart(@Param("productId") long productId, @Param("cartAmount") int cartAmount, @Param("memberId") long memberId) throws Exception;

	/**
	 * 작성자 : 경민영
	 * 작업일 : 22.05.27
	 **/
	// 장바구니에 존재하는 상품인지 확인
	long isExistCart(@Param("productId") long productId);
}