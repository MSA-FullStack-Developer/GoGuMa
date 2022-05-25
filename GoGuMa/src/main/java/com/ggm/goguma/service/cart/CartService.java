package com.ggm.goguma.service.cart;

import java.util.List;

import com.ggm.goguma.dto.cart.CartItemDTO;

public interface CartService {

	List<CartItemDTO> getCartList(long memberId) throws Exception;

	void addCartCount(long cartId) throws Exception;

	void minusCartCount(long cartId) throws Exception;

	void deleteCart(long cartid) throws Exception;

	void insertCart(long productId, int cartAmount) throws Exception;

}
