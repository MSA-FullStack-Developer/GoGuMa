package com.ggm.goguma.dto.cart;

import lombok.Data;

@Data
public class CartDTO {
	private long cartId;
	private long productId;
	private long userId;
	private int cartAmount;
	private int cartPrice;
}
